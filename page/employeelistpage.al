
page 50374 "Employee List page"
{
    Caption = 'Emp List';
    PageType = List;
    SourceTable = "Employ Table";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Employee Card page";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."Emp Id.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }

                field(role; Rec.role)
                {
                    ApplicationArea = All;
                }
            }

        }
        area(factboxes)
        {
            part(AssetHistory; "Asset History FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Emp Id." = FIELD("Emp Id."); // Link employee to factbox
            }
        }


        // No additional variables needed for this page
    }
}