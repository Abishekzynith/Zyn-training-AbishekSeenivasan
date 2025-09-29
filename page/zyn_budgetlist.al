page 50152 "budget List Page"
{
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