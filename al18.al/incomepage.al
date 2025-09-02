page 50141 "income List Page"
{
    PageType = List;
    SourceTable = "income table";
    ApplicationArea = ALL;
    Caption = 'income List';
    CardPageID = "income Card Page";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("income ID"; Rec.incomeid)
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
    }
    actions
    {
        area(Processing)
        {
            action(Newincome)
            {
                ApplicationArea = All;
                Caption = 'category';
                Image = New;
                trigger OnAction()

                begin

                    Page.Run(Page::"income category list page");
                end;

            }
            action(new)
            {
                Image = Receipt;
                Caption = 'report';
                RunObject = report "income Export Report";
            }



        }
    }
}

page 50166 "income Card Page"
{
    PageType = Card;
    SourceTable = "income table";
    ApplicationArea = ALL;
    Caption = 'income Card';

    layout
    {
        area(content)
        {
            group(general)
            {
                field("income ID"; Rec.incomeid)
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

page 50101 "income Category List Page"
{
    PageType = List;
    SourceTable = "income category";
    ApplicationArea = ALL;
    Caption = 'income Category List';
    CardPageID = "income Category Card Page";
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
            part("tile"; "income Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "category name" = field("category name");
            }

        }

    }
}

page 50109 "income Category Card Page"
{
    PageType = Card;
    SourceTable = "income category";
    ApplicationArea = ALL;
    Caption = 'income Category Card';

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
report 50102 "income Export Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;



    dataset
    {
        dataitem(income; "income table")
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
                ExcelBuf.AddColumn("incomeID", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
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
                        TableRelation = "income Category"."category name";
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
        ExcelBuf.AddColumn('income ID', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
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

        ExcelBuf.CreateNewBook('income Export');
        ExcelBuf.WriteSheet('income', CompanyName, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.OpenExcel();
    end;
}
page 50106 "income Factbox"
{
    PageType = CardPart;
    SourceTable = "income category";
    ApplicationArea = All;
    Caption = 'Category income Summary';

    layout
    {
        area(content)
        {
            cuegroup(Summary)
            {
                field(CurrentMonth; CurrMonthincome)
                {
                    ApplicationArea = All;
                    Caption = 'Current Month';

                    trigger OnDrillDown()
                    begin
                        OpenincomeList(1);
                    end;
                }
                field(CurrentQuarter; CurrQuarterincome)
                {
                    ApplicationArea = All;
                    Caption = 'Current Quarter';

                    trigger OnDrillDown()
                    begin
                        OpenincomeList(2);
                    end;
                }
                field(CurrentHalfYear; CurrHalfYearincome)
                {
                    ApplicationArea = All;
                    Caption = 'Current Half-Year';

                    trigger OnDrillDown()
                    begin
                        OpenincomeList(3);
                    end;
                }
                field(CurrentYear; CurrYearincome)
                {
                    ApplicationArea = All;
                    Caption = 'Current Year';

                    trigger OnDrillDown()
                    begin
                        OpenincomeList(4);
                    end;
                }
                field(PrevYear; PrevYearincome)
                {
                    ApplicationArea = All;
                    Caption = 'Previous Year';

                    trigger OnDrillDown()
                    begin
                        OpenincomeList(5);
                    end;
                }
            }
        }
    }

    var
        incomeRec: Record "income Table";
        CurrMonthincome: Decimal;
        CurrQuarterincome: Decimal;
        CurrHalfYearincome: Decimal;
        CurrYearincome: Decimal;
        PrevYearincome: Decimal;

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
        Clear(CurrMonthincome);
        Clear(CurrQuarterincome);
        Clear(CurrHalfYearincome);
        Clear(CurrYearincome);
        Clear(PrevYearincome);

        WorkDt := WorkDate();
        CurrYear := Date2DMY(WorkDt, 3);
        CurrMonth := Date2DMY(WorkDt, 2);
        CurrQuarter := (CurrMonth - 1) div 3 + 1;
        PrevYear := CurrYear - 1;

        //---Previous year---
        StartDate := DMY2Date(1, 1, PrevYear);
        EndDate := DMY2Date(31, 12, PrevYear);
        PrevYearincome := GetincomeTotal(Rec."category name", StartDate, EndDate);

        // --- Current Month ---
        StartDate := DMY2Date(1, CurrMonth, CurrYear);
        EndDate := CalcDate('<CM>', StartDate);
        CurrMonthincome := GetincomeTotal(Rec."category name", StartDate, EndDate);

        // --- Current Quarter ---
        StartDate := DMY2Date(1, (CurrQuarter - 1) * 3 + 1, CurrYear);
        EndDate := CalcDate('<CQ>', StartDate);
        CurrQuarterincome := GetincomeTotal(Rec."category name", StartDate, EndDate);

        // --- Current Half-Year ---
        if CurrMonth <= 6 then
            StartDate := DMY2Date(1, 1, CurrYear)
        else
            StartDate := DMY2Date(1, 7, CurrYear);

        if CurrMonth <= 6 then
            EndDate := DMY2Date(30, 6, CurrYear)
        else
            EndDate := DMY2Date(31, 12, CurrYear);

        CurrHalfYearincome := GetincomeTotal(Rec."category name", StartDate, EndDate);

        // --- Current Year ---
        StartDate := DMY2Date(1, 1, CurrYear);
        EndDate := DMY2Date(31, 12, CurrYear);
        CurrYearincome := GetincomeTotal(Rec."category name", StartDate, EndDate);
    end;

    local procedure GetincomeTotal(CategoryName: Code[100]; StartDate: Date; EndDate: Date): Decimal
    begin
        incomeRec.Reset();
        incomeRec.SetRange("Category", CategoryName);
        incomeRec.SetRange(Date, StartDate, EndDate);
        incomeRec.CalcSums(Amount);
        exit(incomeRec.Amount);
    end;

    local procedure OpenincomeList(PeriodType: Integer)
    var
        incomeList: Page "income List Page"; // Replace with your actual income List page ID/name
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

        incomeRec.Reset();
        incomeRec.SetRange("Category", Rec."category name");
        incomeRec.SetRange(Date, StartDate, EndDate);

        incomeList.SetTableView(incomeRec);
        incomeList.Run();
    end;
}