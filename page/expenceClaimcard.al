page 50209 "Expense Claim Card"
{
    PageType = Card;
    SourceTable = expenseClaim;
    Caption = 'Claim Card';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ID"; rec."ID") { ApplicationArea = All; Editable = false; }
                field("Emp ID"; rec."Emp ID") { ApplicationArea = All; }
                field("Claim Date"; rec."Claim Date") { ApplicationArea = All; }
                field("Amount"; rec."Amount") { ApplicationArea = All; }
                field("Status"; rec."expenceStatus") { ApplicationArea = All; }
                field("Category"; rec."category") { ApplicationArea = All; }
                field("Bill Date"; rec."billdate") { ApplicationArea = All; }
                field("Bill"; rec."Bill")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Uploaded bill stored as BLOB';
                }
                field("ClaimedAmount"; rec."ClaimedAmount")
                 { ApplicationArea = All; 
                 }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(UploadBill)
            {
                Caption = 'Upload Bill (Upstream)';
                Image = Import;
                ApplicationArea = All;
              trigger OnAction()
var
    FileName: Text;
    InS: InStream;
    OutS: OutStream;
begin
    if UploadIntoStream('Select file', '', '', FileName, InS) then begin
        Clear(Rec.Bill);
        Rec.Bill.CreateOutStream(OutS);
        CopyStream(OutS, InS);
        Rec.Modify();
        Message('File %1 uploaded successfully!', FileName);
    end;
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
        }
    }
}
