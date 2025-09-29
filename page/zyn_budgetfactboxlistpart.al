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