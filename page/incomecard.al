

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