report 50190 "Budget vs Expense Report"
{
    Caption = 'Budget vs Expense Report';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
 
    dataset
    {
        dataitem(dummy;Integer)
        {
           
            DataItemTableView=sorting(Number)where(Number=const(1));
 
            trigger OnAfterGetRecord()
            var
                BudgetRec: Record "budget table";
                ExpenseRec: Record "expense table";
                incomerec:Record "income table";
                expencecat: Record "expense category";
                totalincome:decimal;

                MonthLoop: Integer;
                StartDate: Date;
                EndDate: Date;
                TotalBudget: Decimal;
                SpentBudget: Decimal;
                YearBudget: Decimal;
                YearSpent: Decimal;
                categoryspent:decimal;
                monthprint:Boolean;
                savings:decimal;
            begin
                YearBudget := 0;
                YearSpent := 0;
 
                for MonthLoop := 1 to 12 do begin
                    StartDate := DMY2Date(1, MonthLoop, YearFilter);
                    EndDate := CalcDate('<CM>-1D', StartDate); // <-- FIXED
 
                    TotalBudget := 0;
                    SpentBudget := 0;
 expencecat.Reset();
 if expencecat.FindSet()then
 repeat
               
                    // Budget lookup
                    BudgetRec.Reset();
                    BudgetRec.SetRange(Category, expencecat."category name");
                    BudgetRec.SetFilter(FromDate, '<=%1', EndDate);
                    BudgetRec.SetFilter(ToDate, '>=%1', StartDate);
                    if BudgetRec.FindFirst() then
                        TotalBudget := BudgetRec.Amount;
 
                    // Expenses lookup (exact month range)
                    ExpenseRec.Reset();
                    ExpenseRec.SetRange(Category, expencecat."category name");
                    ExpenseRec.SetRange(Date, StartDate, EndDate);
                    if ExpenseRec.FindSet() then
                        repeat
                            categoryspent += ExpenseRec.Amount;
                        until ExpenseRec.Next() = 0;
 
 
                    // Accumulate yearly totals
                    SpentBudget+=categoryspent;



                    ExcelBuf.NewRow();
                    if not monthprint then begin
                        ExcelBuf.AddColumn(Format(StartDate,0,'<month text>'),false,'',false,false,false,'',ExcelBuf."Cell Type"::text);
                        monthprint:=true;

                    end else
 
                    // Write month row
                  ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn(expencecat."category name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    
                    ExcelBuf.AddColumn(TotalBudget, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(categoryspent, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                      until expencecat.Next() = 0;
 
                    // --- Income (monthly total, not by category) ---
                    IncomeRec.Reset();
                    IncomeRec.SetRange(Date, StartDate, EndDate);
                    if IncomeRec.FindSet() then
                        repeat
                            TotalIncome += IncomeRec.Amount;
                        until IncomeRec.Next() = 0;
 
                    // --- Savings ---
                    Savings := TotalIncome - SpentBudget;
 
                    // --- Write Income Row ---
                    ExcelBuf.NewRow();
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Income', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(TotalIncome, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                   
 
                    // --- Write Savings Row ---
                    ExcelBuf.NewRow();
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Savings', false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(Savings, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
                end;
 
            end;
    
        }
    }
 
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(FilterGroup)
                {
                    field(YearFilter; YearFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Year';
                        ToolTip = 'Select a year for the report';
                    }
                }
            }
        }
    } 
 
    trigger OnPreReport()
    begin
        Clear(ExcelBuf);
        ExcelBuf.DeleteAll();
        ExcelBuf.AddColumn('Category', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Month', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(' Budget', false, '', true, false, true, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('expence Budget', false, '', true, false, true, '', ExcelBuf."Cell Type"::Number);
    end;
 
    trigger OnPostReport()
    begin
        ExcelBuf.CreateNewBook('Budget vs Expense');
        ExcelBuf.WriteSheet('Report', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;
 
    var
        ExcelBuf: Record "Excel Buffer" temporary;
        YearFilter: Integer;
}
 