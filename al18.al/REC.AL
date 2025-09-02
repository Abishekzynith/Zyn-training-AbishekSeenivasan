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
codeunit 50239 "Recurring Expense Mgt"
{
    Subtype = Normal;

    trigger OnRun()
    begin
        ProcessRecurringExpenses();
    end;

    procedure ProcessRecurringExpenses()
    var
        RecurringExp: Record "Recurring Expense";
        ExpenseList: Record "Expense Table"; // <-- Replace with your actual expense table name
                                             //NextDate: Date;
    begin
        RecurringExp.Reset();
        if RecurringExp.FindSet() then begin
            repeat
                // Check if Next Cycle Date is due or overdue
                if (RecurringExp."Next Cycle date" <> 0D) and (RecurringExp."Next Cycle date" <= WorkDate()) then begin
                    // Insert into Expense L
                    ExpenseList.Init();
                    ExpenseList."expenseID" := GetNextEntryNo();
                    //RecurringExp."Next Cycle date":=recurringExp."Start Date";
                    ExpenseList."Category" := RecurringExp.Category;
                    ExpenseList.Amount := RecurringExp.Amount;
                    ExpenseList."Date" := RecurringExp."Next Cycle date";
                    ExpenseList.Insert(true);


                    // Update Recurring Record
                    RecurringExp."Next Cycle date" := RecurringExp.getnextcycledate(RecurringExp."Next Cycle date", RecurringExp."Recurrence Pattern");
                    RecurringExp.Modify(true);
                end;
            until RecurringExp.Next() = 0;
        end;
    end;

    local procedure GetNextEntryNo(): Integer
    var
        ExpenseList: Record "Recurring Expense";
    begin
        if ExpenseList.FindLast() then
            exit(ExpenseList."Entry No." + 1)
        else
            exit(1);
    end;
}
