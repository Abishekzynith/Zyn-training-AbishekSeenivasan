

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