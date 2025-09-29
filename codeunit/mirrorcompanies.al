codeunit 50244 "Zyn_companysyncing"
{

    var
        IsSyncing: Boolean;

    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnSystemCompanyInserted(var Rec: Record Company) //original this will copy to mirrorcompany
    var
        MyCompany: Record Zyn_Company;
    begin
        if IsSyncing then
            exit;
        IsSyncing := true;
        if not MyCompany.Get(Rec.Name) then begin
            MyCompany.Init();
            MyCompany.TransferFields(Rec);
            MyCompany.Insert();
        end;
        IsSyncing := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterModifyEvent', '', true, true)]
    local procedure OnSystemCompanyModified(var Rec: Record Company)//original this will copy to mirrorcompany
    var
        syscompany: Record Zyn_Company;
    begin
        if IsSyncing then
            exit;
        IsSyncing := false;
        if syscompany.Get(Rec.Name) then begin
            if (SysCompany."Display Name" <> rec."Display Name") or (SysCompany."Evaluation Company" <> rec."Evaluation Company") then begin
                SysCompany."Display Name" := rec."Display Name";
                SysCompany."Evaluation Company" := rec."Evaluation Company";
                syscompany.Modify();
            end;
        end;
        IsSyncing := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterDeleteEvent', '', true, true)]
    local procedure OnSystemCompanyDeleted(var Rec: Record Company)//original this will copy to mirrorcompany
    var
        mycompany: Record Zyn_Company;
    begin
        if IsSyncing then
            exit;
        IsSyncing := true;
        if MyCompany.Get(Rec.Name) then
            MyCompany.Delete();
        IsSyncing := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Zyn_Company, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnMyCompanyInserted(var Rec: Record Zyn_Company)//mirrorcompany this copy to original
    var
        SysCompany: Record Company;
    begin
        if IsSyncing then
            exit;
        IsSyncing := true;
        if not SysCompany.Get(Rec.Name) then begin
            SysCompany.Init();
            SysCompany.TransferFields(Rec);
            SysCompany.Insert();
        end;
        IsSyncing := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Zyn_Company, 'OnAfterModifyEvent', '', true, true)]
    local procedure OnMyCompanyModified(var Rec: Record Zyn_Company)//mirrorcompany this copy to original
    var
        SysCompany: Record Company;

    begin
        if IsSyncing then
            exit;
        IsSyncing := true;
        if SysCompany.Get(Rec.Name) then begin
            if (SysCompany."Display Name" <> rec."Display Name") or (SysCompany."Evaluation Company" <> rec."Evaluation Company") then begin
                SysCompany."Display Name" := rec."Display Name";
                SysCompany."Evaluation Company" := rec."Evaluation Company";
                syscompany.Modify();
            end;
        end;
        IsSyncing := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Zyn_Company, 'OnAfterDeleteEvent', '', true, true)]
    local procedure OnMyCompanyDeleted(var Rec: Record Zyn_Company)//mirrorcompany this copy to original
    var
        SysCompany: Record Company;
    begin
        if IsSyncing then
            exit;
        IsSyncing := false;
        if SysCompany.Get(Rec.Name) then
            SysCompany.Delete();
        IsSyncing := true;
    end;
}