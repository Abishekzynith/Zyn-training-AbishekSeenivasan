
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