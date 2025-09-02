page 50128 "Expense List Page"
{
    PageType = List;
    SourceTable = "expense table";
    ApplicationArea = ALL;
    Caption = 'Expense List';
    CardPageID = "Expense Card Page";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expense ID"; Rec.expenseid)
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec.amount)
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec.date)
                {
                    ApplicationArea = All;
                }
                field("Category n"; Rec."Category")
                {
                    ApplicationArea = All;


                }

            }
        }
         area(FactBoxes)
        {
            part("til"; "budgetfact")
            {
                ApplicationArea = all;
                
            
            }
            

        }
        
    }
    actions
    {
        area(Processing)
        {
            action(NewExpense)
            {
                ApplicationArea = All;
                Caption = 'category';
                Image = New;
                trigger OnAction()

                begin

                    Page.Run(Page::"Expense category list page");
                end;

            }
            action(new)
            {
                Image = Receipt;
                Caption = 'report';
                RunObject = report "Expense Export Report";
            }



        }
    }
}

page 50129 "Expense Card Page"
{
    PageType = Card;
    SourceTable = "expense table";
    ApplicationArea = ALL;
    Caption = 'Expense Card';

    layout
    {
        area(content)
        {
            group(general)
            {
                field("Expense ID"; Rec.expenseid)
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec.amount)
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec.date)
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec.category)
                {

                }

            }
        }
    }
}

page 50149 "Expense Category List Page"
{
    PageType = List;
    SourceTable = "expense category";
    ApplicationArea = ALL;
    Caption = 'Expense Category List';
    CardPageID = "Expense Category Card Page";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category ID"; Rec.categoryid)
                {
                    ApplicationArea = All;
                }
                field("Category Name"; Rec."category name")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }

            }



        }
        area(FactBoxes)
        {
            part("tile"; "Expense Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "category name" = field("category name");
            }
            part("tilee";"budget Factbox"){
                ApplicationArea=all;
                SubPageLink="category name"=field("category name");
            }

        }

    }
}

page 50131 "Expense Category Card Page"
{
    PageType = Card;
    SourceTable = "expense category";
    ApplicationArea = ALL;
    Caption = 'Expense Category Card';

    layout
    {
        area(content)
        {
            group(general)
            {
                field("Category ID"; Rec.categoryid)
                {
                    ApplicationArea = All;
                }
                field("Category Name"; Rec."category name")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
             

            }
        }
    }
}
report 50109 "Expense Export Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;



    dataset
    {
        dataitem(Expense; "Expense table")
        {

            trigger OnPreDataItem()
            begin
                if (FromDate <> 0D) and (ToDate <> 0D) then
                    SetRange("Date", FromDate, ToDate)
                else if (FromDate <> 0D) then
                    SetRange("Date", FromDate, DMY2Date(31, 12, 9999))
                else if (ToDate <> 0D) then
                    SetRange("Date", 0D, ToDate);
                if CategoryFilter <> '' then
                    SetRange(Category, CategoryFilter);
            end;

            trigger OnAfterGetRecord()

            begin
                // Write expense data to Excel buffer
                ExcelBuf.NewRow();
                ExcelBuf.AddColumn("ExpenseID", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Description, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Format(Amount), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
                ExcelBuf.AddColumn(Format(Date), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
                ExcelBuf.AddColumn(Category, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                TotalAmount += Amount;
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
                    field("From Date"; FromDate)
                    {
                        ApplicationArea = All;
                    }
                    field("To Date"; ToDate)
                    {
                        ApplicationArea = All;
                    }
                    field("Category"; CategoryFilter)
                    {
                        ApplicationArea = All;
                        TableRelation = "Expense Category"."category name";
                    }
                }
            }
        }
    }

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        FromDate: Date;
        ToDate: Date;
        CategoryFilter: Code[50];
        TotalAmount: Decimal;

    trigger OnPreReport()
    begin
        // Add Header Row
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('Expense ID', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Description', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Amount', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Date', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Category', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
    end;

    trigger OnPostReport()
    begin

        // Add Total Row
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('TOTAL', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(TotalAmount, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

        ExcelBuf.CreateNewBook('Expense Export');
        ExcelBuf.WriteSheet('Expenses', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;
}
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