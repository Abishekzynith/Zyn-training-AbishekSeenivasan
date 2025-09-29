

page 50149 "Expense Category List Page"
{
    PageType = List;
    SourceTable = "expense category";
    ApplicationArea = ALL;
    Caption = 'Expense Category List';
    CardPageID = "Expense Category Card Page";
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
            part("tile"; "Expense Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "category name" = field("category name");
            }
            part("tilee";"budget Factbox"){
                ApplicationArea=all;
                SubPageLink="category name"=field("category name");
            }

        }

    }
}
