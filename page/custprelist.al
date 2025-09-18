page 50198 "Customer Visit Log List"
{
    PageType = List;
    SourceTable = "Customer Visit Log";
    CardPageId = "Customer Visit Log Card";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.") { ApplicationArea = All; }
                field("Customer No."; rec."Customer No.") { ApplicationArea = All; }
                field("Visit Date"; rec."Visit Date") { ApplicationArea = All; }
                field("Purpose"; rec."Purpose") { ApplicationArea = All; }
                field("Notes"; rec."Notes") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("New Log Entry")
            {
                Caption = 'New Log Entry';
                ApplicationArea = All;
                Image = NewDocument;

                trigger OnAction()
                var
                    NewLog: Record "Customer Visit Log";
                begin
                    NewLog.Init();
                    NewLog."Customer No." := Rec."Customer No.";
                    Page.RunModal(Page::"Customer Visit Log Card", NewLog);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

    end;
}
