
page 50187 "Asset List"
{
    Caption = 'Assets';
    PageType = List;
    SourceTable = Asset;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Asset Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                }
                field("Asset Type"; Rec."Asset Type")
                {
                    ApplicationArea = All;
                }
                field("Serial No"; Rec."Serial No")
                {
                    ApplicationArea = All;
                }
                field("Procured Date"; Rec."Procured Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor"; Rec."Vendor")
                {
                    ApplicationArea = All;
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                }
            }
        }
         area(factboxes)
        {
            part(AssignedAssets; "Asset Assigned FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Emp Name" = field("Emp Name");
            }
       
        }
    }
}