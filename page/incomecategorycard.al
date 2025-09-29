

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