
page 50138 "Expense Factbox"
{
    PageType = CardPart;
    SourceTable = "expense category";
    ApplicationArea = All;
    Caption = 'Category Expense Summary';

    layout
    {
        area(content)
        {
            cuegroup(Summary)
            {
                field(CurrentMonth; CurrMonthExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Current Month';

                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(1);
                    end;
                }
                field(CurrentQuarter; CurrQuarterExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Current Quarter';

                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(2);
                    end;
                }
                field(CurrentHalfYear; CurrHalfYearExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Current Half-Year';

                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(3);
                    end;
                }
                field(CurrentYear; CurrYearExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Current Year';

                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(4);
                    end;
                }
                field(PrevYear; PrevYearExpense)
                {
                    ApplicationArea = All;
                    Caption = 'Previous Year';

                    trigger OnDrillDown()
                    begin
                        OpenExpenseList(5);
                    end;
                }
                field(remainamount;remainbudget){
                    ApplicationArea=all;
                    Caption='remainamount';

                }
            }
        }
    }

    var
        ExpenseRec: Record "Expense Table";
        CurrMonthExpense: Decimal;
        CurrQuarterExpense: Decimal;
        CurrHalfYearExpense: Decimal;
        CurrYearExpense: Decimal;
        PrevYearExpense: Decimal;
        budgetrec:Record "budget table";
        remainbudget:decimal;

    trigger OnAfterGetRecord()
    var
        StartDate: Date;
        EndDate: Date;
        CurrMonth: Integer;
        CurrQuarter: Integer;
        CurrYear: Integer;
        WorkDt: Date;
        PrevYear: Integer;
    begin
        Clear(CurrMonthExpense);
        Clear(CurrQuarterExpense);
        Clear(CurrHalfYearExpense);
        Clear(CurrYearExpense);
        Clear(PrevYearExpense);
        Clear(remainbudget);

        WorkDt := WorkDate();
        CurrYear := Date2DMY(WorkDt, 3);
        CurrMonth := Date2DMY(WorkDt, 2);
        CurrQuarter := (CurrMonth - 1) div 3 + 1;
        PrevYear := CurrYear - 1;
        if budgetrec.GetBudgetForDate(rec."category name",WorkDt)then begin
            ExpenseRec.Reset();
            ExpenseRec.SetRange(category,rec."category name");
            ExpenseRec.SetRange(Date,budgetrec.fromdate,budgetrec.ToDate);
            ExpenseRec.CalcSums(amount);
            remainbudget :=budgetrec.amount-ExpenseRec.amount;
        end;

        //---Previous year---
        StartDate := DMY2Date(1, 1, PrevYear);
        EndDate := DMY2Date(31, 12, PrevYear);
        PrevYearExpense := GetExpenseTotal(Rec."category name", StartDate, EndDate);

        // --- Current Month ---
        StartDate := DMY2Date(1, CurrMonth, CurrYear);
        EndDate := CalcDate('<CM>', StartDate);
        CurrMonthExpense := GetExpenseTotal(Rec."category name", StartDate, EndDate);

        // --- Current Quarter ---
        StartDate := DMY2Date(1, (CurrQuarter - 1) * 3 + 1, CurrYear);
        EndDate := CalcDate('<CQ>', StartDate);
        CurrQuarterExpense := GetExpenseTotal(Rec."category name", StartDate, EndDate);

        // --- Current Half-Year ---
        if CurrMonth <= 6 then
            StartDate := DMY2Date(1, 1, CurrYear)
        else
            StartDate := DMY2Date(1, 7, CurrYear);

        if CurrMonth <= 6 then
            EndDate := DMY2Date(30, 6, CurrYear)
        else
            EndDate := DMY2Date(31, 12, CurrYear);

        CurrHalfYearExpense := GetExpenseTotal(Rec."category name", StartDate, EndDate);

        // --- Current Year ---
        StartDate := DMY2Date(1, 1, CurrYear);
        EndDate := DMY2Date(31, 12, CurrYear);
        CurrYearExpense := GetExpenseTotal(Rec."category name", StartDate, EndDate);
    end;

    local procedure GetExpenseTotal(CategoryName: Code[100]; StartDate: Date; EndDate: Date): Decimal
    begin
        ExpenseRec.Reset();
        ExpenseRec.SetRange("Category", CategoryName);
        ExpenseRec.SetRange(Date, StartDate, EndDate);
        ExpenseRec.CalcSums(Amount);
        exit(ExpenseRec.Amount);
    end;

    local procedure OpenExpenseList(PeriodType: Integer)
    var
        ExpenseList: Page "Expense List Page"; // Replace with your actual Expense List page ID/name
        StartDate: Date;
        EndDate: Date;
        CurrMonth: Integer;
        CurrQuarter: Integer;
        CurrYear: Integer;
        PrevYear: Integer;
        WorkDt: Date;
    begin
        WorkDt := WorkDate();
        CurrYear := Date2DMY(WorkDt, 3);
        CurrMonth := Date2DMY(WorkDt, 2);
        CurrQuarter := (CurrMonth - 1) div 3 + 1;
        PrevYear := CurrYear - 1;

        case PeriodType of
            1:
                begin // Current Month
                    StartDate := DMY2Date(1, CurrMonth, CurrYear);
                    EndDate := CalcDate('<CM>', StartDate);
                end;
            2:
                begin // Current Quarter
                    StartDate := DMY2Date(1, (CurrQuarter - 1) * 3 + 1, CurrYear);
                    EndDate := CalcDate('<CQ>', StartDate);
                end;
            3:
                begin // Current Half-Year
                    if CurrMonth <= 6 then begin
                        StartDate := DMY2Date(1, 1, CurrYear);
                        EndDate := DMY2Date(30, 6, CurrYear);
                    end else begin
                        StartDate := DMY2Date(1, 7, CurrYear);
                        EndDate := DMY2Date(31, 12, CurrYear);
                    end;
                end;
            4:
                begin // Current Year
                    StartDate := DMY2Date(1, 1, CurrYear);
                    EndDate := DMY2Date(31, 12, CurrYear);
                end;
            5:
                begin // Previous Year
                    StartDate := DMY2Date(1, 1, PrevYear);
                    EndDate := DMY2Date(31, 12, PrevYear);
                end;
        end;

        ExpenseRec.Reset();
        ExpenseRec.SetRange("Category", Rec."category name");
        ExpenseRec.SetRange(Date, StartDate, EndDate);

        ExpenseList.SetTableView(ExpenseRec);
        ExpenseList.Run();
    end;
}