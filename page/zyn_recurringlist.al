page 50238 Recurringpage
{
    PageType = List;
    SourceTable = "Recurring Expense";
    ApplicationArea = All;
    Caption = 'Recurring List';
    UsageCategory = "Lists";
    InsertAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Recurring ID"; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("From date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("next cycle date"; Rec."Next Cycle date")
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec.category)
                {
                    ApplicationArea = All;
                }
                field("Recurrence Pattern"; Rec."Recurrence Pattern")
                {
                    ApplicationArea = All;
                }
            }

        }

    }
}