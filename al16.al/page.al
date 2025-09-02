page 50110 "Customer FactBox"
{
    PageType = CardPart;
    SourceTable = Customer;
    ApplicationArea = All;
    Caption = 'Customer FactBox';

    layout
    {
        area(content)
        {

            cuegroup(SalesDocuments)
            {
                Caption = 'Sales Documents';
                field("Open Orders"; OpenOrdersCount)
                {
                    ApplicationArea = All; 
                    Caption = 'Open Orders';
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SalesOrderList: Page "Sales Order List";
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
                        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
                        SalesOrderList.SetTableView(SalesHeader);
                        SalesOrderList.Run();
                    end;
                }
                field("Open Invoices"; OpenInvoicesCount)
                {
                    ApplicationArea = All;
                    Caption = 'Open Invoices';
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SalesInvoiceList: Page "Sales Invoice List";
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                        SalesHeader.SetRange(Status, SalesHeader.Status::Open);
                        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
                        SalesInvoiceList.SetTableView(SalesHeader);
                        SalesInvoiceList.Run();
                    end;
                }
            }
        }
    }



    var
        OpenOrdersCount: Integer;
        OpenInvoicesCount: Integer;
        contactno: Code[20];
        contactname: Code[100];
        contact:Record contact;
        hascontact:Boolean;

    trigger OnAfterGetRecord()
    var
        SalesHeader: Record "Sales Header";
        begin clear (contactno);
        clear(contactname);
        hascontact:=false;
        if Rec."primary contact no." <> '' then begin
            contact.SetRange("No.", Rec."No.");
            if contact.FindFirst() then begin
                contactno := contact."No.";
                contactname := contact.Name;
                hascontact := true;
            end;
        end;
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("status", SalesHeader.Status::Open);
        OpenOrdersCount := SalesHeader.Count();

        SalesHeader.Reset();
        SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange("status", SalesHeader.Status::Open);
        OpenInvoicesCount := SalesHeader.Count();
    end;
        end;
}
page 50105 "Customer Contact Factbox"
{
    PageType = CardPart;
    SourceTable = Contact;
    Caption = 'Customer Contact';


    layout
    {
        area(content)
        {
            group("Customer Contact")
            {
                Visible = HasContent;
                field("Contact No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Contact ID';
                    DrillDown = true;
                    Lookup = true;
                    trigger OnDrillDown()
                    var
                        ContactCard: Page "Contact Card";
                    begin
                        ContactCard.SetRecord(Rec);
                        ContactCard.Run();
                    end;
                }

                field("Contact Name"; rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Contact Name';
                    DrillDown = true;
                    Lookup = true;
                    trigger OnDrillDown()
                    var
                        ContactCard: Page "Contact Card";
                    begin
                        ContactCard.SetRecord(Rec);
                        ContactCard.Run();
                    end;
                }
            }
        }
    }
    var
        HasContent: Boolean;

    trigger OnAfterGetRecord()

    begin
        HasContent := (rec."No." <> '');
        HasContent := (rec.Name <> '');
    end;
}