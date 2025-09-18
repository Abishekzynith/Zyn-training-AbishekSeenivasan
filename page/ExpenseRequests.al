page 50299 "Expense Approval Requests"
{
    PageType = list;
    SourceTable = expenseClaim;
    Caption = 'Expense Requests';
    ApplicationArea = All;
    UsageCategory = Lists;


    SourceTableView = where(expenceStatus = const(Pending));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("EmpID"; rec."Emp ID") { ApplicationArea = All; }
                field("Claim"; rec."Claim Date") { ApplicationArea = All; }
                field("Limit"; rec."Bill")
                {
                    ApplicationArea = All;
                }
                field("BillDate"; rec."billdate") { ApplicationArea = All; }
                field("Status"; rec.expenceStatus) { ApplicationArea = All; Editable = false; }
            }
        }
        area(factboxes)
        {
           part(Attachments; "Bill Preview Factbox")
{
    ApplicationArea = All;
    SubPageLink = "ID" = field("ID");
        Visible = true;
        
        Caption = 'Bill Preview';
    

}

        }
       
    }
    

    actions
    {
        area(processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;

                trigger OnAction()
                var
                    RecRef: Record expenseClaim;
                begin
                    if Rec.expenceStatus <> Rec.expenceStatus::Pending then  //
                        Error('Only Pending requests can be approved.');
                    if (Rec.BillDate <> 0D) and (Rec."Claim Date" <> 0D) then
                        if Rec."Claim Date" > CalcDate('<+3M>', Rec.BillDate) then
                            Error('Cannot approve: Claim Date is more than 3 months after Bill Date.');

                    RecRef.SetRange("Category", Rec."Category");
                    RecRef.SetRange("Emp ID", Rec."Emp ID");
                    RecRef.SetRange("Subtype", Rec."Subtype");
                    RecRef.SetRange("Claim Date", Rec."Claim Date");
                    if RecRef.FindFirst() then begin
                        if (RecRef.ID <> Rec.ID) then
                            Error('An approval request already exists for Employee %1 with Code %2, Name %3, and Subtype %4.',
                                   Rec."Emp ID", Rec."Category", Rec."Subtype");
                    end;

                    Rec.expenceStatus := Rec.expenceStatus::Approved;
                    Rec.Modify();
                    Message('Request approved successfully.');
                end;
            }
            action(DownloadBill)
            {
                Caption = 'Download Bill (Downstream)';
                Image = Export;
                ApplicationArea = All;
                trigger OnAction()
                var
                    OutS: OutStream;
                    InS: InStream;
                    TempFile: Text;
                begin
                    if not Rec.Bill.HasValue then
                        Error('No file available.');

                    TempFile := 'ClaimBill_' + Format(Rec.ID) + '.pdf';
                    Rec.Bill.CreateInStream(InS);
                    DownloadFromStream(InS, '', '', '', TempFile);
                end;
            }
            action(ViewBillMedia)
            {
                Caption = 'Preview Bill';
                Image = View;
             trigger OnAction()
   var
       TempBlob: Codeunit "Temp Blob";
       FileURL: TextConst;
       InStream: InStream;
begin
    if Rec.Bill.HasValue then begin
        Rec.Bill.CreateInStream(InStream);
        
       
        Hyperlink(FileURL); 
    end else
        Message('No file uploaded to preview.');
end;
            }
            action(Reject)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Image = Cancel;

                trigger OnAction()
                begin
                    if Rec.expenceStatus <> Rec.expenceStatus::Pending then
                        Error('Only Pending requests can be rejected.');

                    Rec.expenceStatus := Rec.expenceStatus::Rejected;
                    Rec.Modify();
                    Message('Request rejected successfully.');
                end;
            }
        }
    }
    
    var
        CategoryRec: record "Expense Claim Category";
        TotalApproved: Decimal;
        TempBlob: Codeunit "Temp Blob";
        FileURL: Text;
}
