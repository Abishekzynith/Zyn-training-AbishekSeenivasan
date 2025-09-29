

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