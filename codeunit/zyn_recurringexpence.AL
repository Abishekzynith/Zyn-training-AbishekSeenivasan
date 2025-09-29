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
        ExpenseList: Record "Expense Table"; 
    begin
        RecurringExp.Reset();
        if RecurringExp.FindSet() then begin
            repeat
              
                if (RecurringExp."Next Cycle date" <> 0D) and (RecurringExp."Next Cycle date" <= WorkDate()) then begin
                  
                    ExpenseList.Init();
                    ExpenseList."expenseID" := GetNextEntryNo();                   
                    ExpenseList."Category" := RecurringExp.Category;
                    ExpenseList.Amount := RecurringExp.Amount;
                    ExpenseList."Date" := RecurringExp."Next Cycle date";
                    ExpenseList.Insert(true);
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
