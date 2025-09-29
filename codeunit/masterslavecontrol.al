codeunit 50272 "ZYN_Contactsyncronization"
{
    var
        issync: Boolean;


    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeInsertEvent', '', true, true)]
    local procedure PreventSlaveContactInsert(var Rec: Record Contact; RunTrigger: Boolean)
    var
        mycompany: Record Zyn_Company;
    begin
        if not mycompany.Get(COMPANYNAME) then
            Error('Company not found.');

        if IsStandaloneCompany(mycompany) then
            exit;

        if not mycompany.IsMaster then
            Error(ContactcreateSlaveErr);
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnafterMasterContactInserted(var Rec: Record Contact)
    begin
        SyncMasterContact(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterModifyEvent', '', true, true)]
    local procedure ContactOnAfterModify(var Rec: Record Contact; var xRec: Record Contact; RunTrigger: Boolean)
    var
        MasterCompany: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        SlaveContact: Record Contact;
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        Field: FieldRef;
        SlaveField: FieldRef;
        i: Integer;
        IsDifferent: Boolean;
    begin
        if issync then
            exit;

        if not MasterCompany.Get(COMPANYNAME) then
            exit;


        if MasterCompany.IsMaster then begin// If current company is master allow to modify changes in slave companies
            SlaveCompany.SetRange(IsMaster, false);
            SlaveCompany.SetFilter(mastername, '%1', MasterCompany.Name);

            if SlaveCompany.FindSet() then
                repeat
                    SlaveContact.ChangeCompany(SlaveCompany.Name);
                    if SlaveContact.Get(Rec."No.") then begin
                        MasterRef.GetTable(Rec);
                        SlaveRef.GetTable(SlaveContact);
                        IsDifferent := false;

                        for i := 1 to MasterRef.FieldCount do begin
                            Field := MasterRef.FieldIndex(i);
                            if Field.Class <> FieldClass::Normal then
                                continue;


                            if Field.Number in [1] then
                                continue;

                            SlaveField := SlaveRef.Field(Field.Number);
                            if SlaveField.Value <> Field.Value then begin
                                IsDifferent := true;
                                break;
                            end;
                        end;

                        if IsDifferent then begin
                            issync := true;
                            SlaveContact.TransferFields(Rec, false);
                            SlaveContact."No." := Rec."No.";
                            SlaveContact.Modify(true);
                            issync := false;
                        end;
                    end;
                until SlaveCompany.Next() = 0;
        end else begin

            if not MasterCompany.IsMaster and (MasterCompany.mastername <> '') then begin // block modification in slave company

                if (UserId = '') or (UpperCase(UserId) = 'NT AUTHORITY\SYSTEM') then
                    exit;

                if not RunTrigger then
                    exit;

                Error(ModifySlaveErr);
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterDeleteEvent', '', true, true)]
    local procedure OnMasterContactDeleted(var Rec: Record Contact)
    begin
        if issync then
            exit;

        if not IsMasterCompany() then
            exit;

        issync := true;
        SyncDeleteContactToSlaves(Rec);
        issync := false;
    end;


    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeDeleteEvent', '', true, true)]
    local procedure ValidateBeforeMasterDelete(var Rec: Record Contact; RunTrigger: Boolean)
    begin
        if IsMasterCompany() then
            if not CanDeleteContactFromAllSlaves(Rec) then
                Error( DeleteSlaveErr,Rec."No.");
    end;


    local procedure SyncMasterContact(ContactRec: Record Contact)//insert logic for master slave 
    var
        mycompany: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        ContactCopy: Record Contact;
    begin
        if issync then
            exit;

        if not mycompany.Get(COMPANYNAME) then
            exit;

        if IsStandaloneCompany(mycompany) or not IsMasterCompany() then
            exit;

        issync := true;

        SlaveCompany.SetRange(IsMaster, false);
        SlaveCompany.SetFilter(mastername, '%1', mycompany.Name);

        if SlaveCompany.FindSet() then
            repeat
                ContactCopy.ChangeCompany(SlaveCompany.Name);

                if not ContactCopy.Get(ContactRec."No.") then begin
                    ContactCopy.Init();
                    ContactCopy."No." := ContactRec."No.";
                    ContactCopy.TransferFields(ContactRec, true);
                    ContactCopy.Insert(true);
                end else begin
                    ContactCopy.Reset();
                    ContactCopy.Get(ContactRec."No.");
                    ContactCopy.TransferFields(ContactRec, true);
                    ContactCopy.Modify(true);
                end;
            until SlaveCompany.Next() = 0;

        issync := false;
    end;

    // Deletion Sync Logic with Contact Business Relation cleanup
    local procedure SyncDeleteContactToSlaves(ContactRec: Record Contact)
    var
        mycompany: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        ContactCopy: Record Contact;
        Customer: Record Customer;
        Vendor: Record Vendor;
        ContactBusRel: Record "Contact Business Relation";
    begin
        if not mycompany.Get(COMPANYNAME) then
            exit;
        SlaveCompany.SetRange(IsMaster, false);
        SlaveCompany.SetFilter(MasterName, '%1', mycompany.MasterName);

        if SlaveCompany.FindSet() then
            repeat
                ContactCopy.ChangeCompany(SlaveCompany.Name);
                Customer.ChangeCompany(SlaveCompany.Name);
                Vendor.ChangeCompany(SlaveCompany.Name);
                ContactBusRel.ChangeCompany(SlaveCompany.Name);
                ContactBusRel.Reset();
                ContactBusRel.SetRange("Contact No.", ContactRec."No.");
                if ContactBusRel.FindSet() then
                    repeat
                        case ContactBusRel."Link to Table" of
                            ContactBusRel."Link to Table"::Customer:
                                if Customer.Get(ContactBusRel."No.") then
                                    Customer.Delete(true);

                            ContactBusRel."Link to Table"::Vendor:
                                if Vendor.Get(ContactBusRel."No.") then
                                    Vendor.Delete(true);
                        end;
                        ContactBusRel.Delete();
                    until ContactBusRel.Next() = 0;
                if ContactCopy.Get(ContactRec."No.") then
                    ContactCopy.Delete(true);

            until SlaveCompany.Next() = 0;
    end;


    local procedure CanDeleteContactFromAllSlaves(ContactRec: Record Contact): Boolean// Delete Syncing  Validation Logic
    var
        mycompany: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
    begin
        if not mycompany.Get(COMPANYNAME) then
            exit(false);

        if IsStandaloneCompany(mycompany) then
            exit(true);

        SlaveCompany.SetRange(IsMaster, false);
        SlaveCompany.SetFilter(mastername, '%1', mycompany.Name);

        if SlaveCompany.FindSet() then
            repeat
                SalesHeader.ChangeCompany(SlaveCompany.Name);
                PurchHeader.ChangeCompany(SlaveCompany.Name);

                SalesHeader.SetRange("Bill-to Contact No.", ContactRec."No.");
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                SalesHeader.SetFilter(Status, '%1|%2', SalesHeader.Status::Open, SalesHeader.Status::Released);//setting pipeline options
                if SalesHeader.FindFirst() then
                    exit(false);

                PurchHeader.SetRange("Buy-from Vendor No.", ContactRec."No.");
                PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Invoice);
                PurchHeader.SetFilter(Status, '%1|%2', PurchHeader.Status::Open, PurchHeader.Status::Released);
                if PurchHeader.FindFirst() then
                    exit(false);

            until SlaveCompany.Next() = 0;

        exit(true);
    end;


    local procedure IsMasterCompany(): Boolean  //check the modifying company is master
    var
        mycompany: Record Zyn_Company;
    begin
        if not mycompany.Get(COMPANYNAME) then
            exit(false);

        exit(mycompany.IsMaster);
    end;


    local procedure IsStandaloneCompany(var mycompany: Record Zyn_Company): Boolean
    begin
        exit(not mycompany.IsMaster and (mycompany.mastername = ''));
    end;

    var
        ContactcreateSlaveErr: Label 'You cannot create contacts in a slave company. Create the contact in the master company only.';
        ModifySlaveErr: Label 'You cannot modify contacts in a slave company. Modify contacts only in the master company.';
        DeleteSlaveErr: Label 'You cannot delete contacts in a slave company. Delete contacts only in the master company and check for any open invoices';
}