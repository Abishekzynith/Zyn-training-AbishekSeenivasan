page 50152 "budget List Page"
{
    PageType = List;
    SourceTable = "budget table";
    ApplicationArea = ALL;
    Caption = 'budget List';
    CardPageID = "budget Card Page";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
              
               
                field("Amount"; Rec.amount)
                {
                    ApplicationArea = All;
                }
                field("fromDate"; Rec.fromdate)
                {
                    ApplicationArea = All;
                    Editable=false;
                }
                 field("toDate"; Rec.todate)
                {
                    ApplicationArea = All;
                    Editable=false;
                }
                field("Category n"; Rec."Category")
                {
                    ApplicationArea = All;


                }
                field("catname";rec."category name"){
                    ApplicationArea=all;
            }
                
        }}
        
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
     trigger OnNewRecord(BelowxRec: Boolean)
    var
        CurrYear: Integer;
        CurrMonth: Integer;
        StartDate: Date;
        EndDate: Date;
        WorkDt: Date;
    begin
        WorkDt := WorkDate();
        CurrYear := Date2DMY(WorkDt, 3);
        CurrMonth := Date2DMY(WorkDt, 2);
        StartDate := DMY2Date(1, CurrMonth, CurrYear);
        EndDate := CalcDate('<CM>', StartDate);
        Rec.FromDate := StartDate;
        Rec.ToDate := EndDate;
    end;
    
}
page 50158 budgetfact{
     PageType = Listpart;
    SourceTable = "budget table";
    ApplicationArea = ALL;
    Caption = 'budget List';
    CardPageID = "budget Card Page";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
              
               
                field("Amount"; Rec.amount)
                {
                    ApplicationArea = All;
                }
                field("fromDate"; Rec.fromdate)
                {
                    ApplicationArea = All;
                    Editable=false;
                }
                 field("toDate"; Rec.todate)
                {
                    ApplicationArea = All;
                    Editable=false;
                }
                field("Category n"; Rec."Category")
                {
                    ApplicationArea = All;


                }
            }
        }
    }
}


page 50153 "budget Card Page"
{
    PageType = Card;
    SourceTable = "budget table";
    ApplicationArea = ALL;
    Caption = 'budget Card';

    layout
    {
        area(content)
        {
            group(general)
            {
                field("Expense ID"; Rec.budgetid)
                {
                    ApplicationArea = All;
                }
                field("from"; Rec.fromdate)
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec.amount)
                {
                    ApplicationArea = All;
                }
               
                field("toDate"; Rec.ToDate)
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec.category)
                {

                }

            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec.fromdate := CalcDate('<-CM>',WorkDate());
        rec.ToDate:=CalcDate('<CM>',WorkDate());
    end;
}



page 50156 "budget Factbox"
{
    PageType = CardPart;
    SourceTable = "expense category";
    ApplicationArea = All;
    Caption = 'Category budget Summary';

    layout
    {
        area(content)
        {
            cuegroup(Summary)
            {
                field(CurrentMonth; CurrMonthbudget)
                {
                    ApplicationArea = All;
                    Caption = 'Current Month';

                    trigger OnDrillDown()
                    begin
                        OpenbudgetList(1);
                    end;
                }
                field(CurrentQuarter; CurrQuarterbudget)
                {
                    ApplicationArea = All;
                    Caption = 'Current Quarter';

                    trigger OnDrillDown()
                    begin
                        OpenbudgetList(2);
                    end;
                }
                field(CurrentHalfYear; CurrHalfYearbudget)
                {
                    ApplicationArea = All;
                    Caption = 'Current Half-Year';

                    trigger OnDrillDown()
                    begin
                        OpenbudgetList(3);
                    end;
                }
                field(CurrentYear; CurrYearbudget)
                {  ApplicationArea = All;
                    Caption = 'This Year';
                    DrillDown = true;
                    trigger OnDrillDown()
                    begin
                        OpenbudgetList(3);
                    end;
                    }
                field(PrevYear; PrevYearbudget)
                {
                    ApplicationArea = All;
                    Caption = 'Previous Year';

                    trigger OnDrillDown()
                    begin
                        OpenbudgetList(5);
                    end;
                }
               
            }
        }
    }

    var
    
        CurrMonthbudget: Decimal;
        CurrQuarterbudget: Decimal;
        CurrHalfYearbudget: Decimal;
        CurrYearbudget: Decimal;
        PrevYearbudget: Decimal;
        budgetrec:Record "budget table";
       

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
        Clear(CurrMonthbudget);
        Clear(CurrQuarterbudget);
        Clear(CurrHalfYearbudget);
        Clear(CurrYearbudget);
        Clear(PrevYearbudget);
       

        WorkDt := WorkDate();
        CurrYear := Date2DMY(WorkDt, 3);
        CurrMonth := Date2DMY(WorkDt, 2);
        CurrQuarter := (CurrMonth - 1) div 3 + 1;
        PrevYear := CurrYear - 1;
        

        //---Previous year---
        StartDate := DMY2Date(1, 1, PrevYear);
        EndDate := DMY2Date(31, 12, PrevYear);
        PrevYearbudget := GetbudgetTotal(Rec."category name", StartDate, EndDate);

        // --- Current Month ---
        StartDate := DMY2Date(1, CurrMonth, CurrYear);
        EndDate := CalcDate('<CM>', StartDate);
        CurrMonthbudget := GetbudgetTotal(Rec."category name", StartDate, EndDate);

        // --- Current Quarter ---
        StartDate := DMY2Date(1, (CurrQuarter - 1) * 3 + 1, CurrYear);
        EndDate := CalcDate('<CQ>', StartDate);
        CurrQuarterbudget := GetbudgetTotal(Rec."category name", StartDate, EndDate);

        // --- Current Half-Year ---
        if CurrMonth <= 6 then
            StartDate := DMY2Date(1, 1, CurrYear)
        else
            StartDate := DMY2Date(1, 7, CurrYear);

        if CurrMonth <= 6 then
            EndDate := DMY2Date(30, 6, CurrYear)
        else
            EndDate := DMY2Date(31, 12, CurrYear);

        CurrHalfYearbudget := GetbudgetTotal(Rec."category name", StartDate, EndDate);

        // --- Current Year ---
        StartDate := DMY2Date(1, 1, CurrYear);
        EndDate := DMY2Date(31, 12, CurrYear);
        CurrYearbudget := GetbudgetTotal(Rec."category name", StartDate, EndDate);
    end;

   local procedure GetBudgetTotal(CategoryName: Code[100]; StartDate: Date; EndDate: Date): Decimal
var
        TempBudget: Record "Budget table";
    begin
        TempBudget.Reset();
        TempBudget.SetRange(Category, CategoryName);
        TempBudget.SetFilter(FromDate, '<=%1', EndDate);
        TempBudget.SetFilter(ToDate, '>=%1', StartDate);
        TempBudget.CalcSums(Amount);
        exit(TempBudget.Amount);
    end;
 
    local procedure OpenBudgetList(d: Integer)
    var
        BudgetList: Page "Budget List page"; // 🔹 make sure you have this page
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
 
        case d of
            1:
                begin
                    StartDate := DMY2Date(1, CurrMonth, CurrYear);
                    EndDate := CalcDate('<CM>', StartDate);
                end;
            2:
                begin
                    StartDate := DMY2Date(1, (CurrQuarter - 1) * 3 + 1, CurrYear);
                    EndDate := CalcDate('<CQ>', StartDate);
                end;
            3:
                begin
                    if CurrMonth <= 6 then begin
                        StartDate := DMY2Date(1, 1, CurrYear);
                        EndDate := DMY2Date(30, 6, CurrYear);
                    end else begin
                        StartDate := DMY2Date(1, 7, CurrYear);
                        EndDate := DMY2Date(31, 12, CurrYear);
                    end;
                end;
            4:
                begin
                    StartDate := DMY2Date(1, 1, CurrYear);
                    EndDate := DMY2Date(31, 12, CurrYear);
                end;
            5:
                begin
                    StartDate := DMY2Date(1, 1, PrevYear);
                    EndDate := DMY2Date(31, 12, PrevYear);
                end;
        end;
 
        BudgetRec.Reset();
        BudgetRec.SetRange("Category", Rec."category name");
        BudgetRec.SetFilter(FromDate, '<=%1', EndDate);
        BudgetRec.SetFilter(ToDate, '>=%1', StartDate);
 
        BudgetList.SetTableView(BudgetRec);
        BudgetList.Run();
    end;
}
 