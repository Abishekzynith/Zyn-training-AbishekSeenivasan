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
