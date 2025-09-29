page 50280 "Leave Req Card Page"
{
    Caption = 'Leave Request Card';
    PageType = Card;
    SourceTable = "Leave Request";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = All;
                }
                field("Emp Id."; Rec."Emp Id.")
                {
                    ApplicationArea = All;
                    TableRelation = "Employ Table"."Emp Id.";
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                field("No.of days"; Rec."No.of days")
                {
                    ApplicationArea = All;
                    Editable = false; // system-calculated
                }
                field("Remaining Days"; Rec."Remaining Days")
                {
                    ApplicationArea = All;
                    Editable = false; // system-calculated
                }
                // ❌ Removed Status field from UI
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ApproveLeave)
            {
                Caption = 'Approve Leave';
                Image = Approve;
                ApplicationArea = All;

                trigger OnAction()
                var
                    LeaveMgt: Codeunit "Leave Management";
                begin
                    LeaveMgt.ApproveLeaveRequest(Rec);
                    Message('Leave Request %1 has been approved and logged.', Rec."Request No.");
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status := Rec.Status::Pending; // ✅ Set default status
    end;
}