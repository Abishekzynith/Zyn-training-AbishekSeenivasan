
page 50194 "Assigned Asset Details"
{
    PageType = List;
    SourceTable = Asset;
    Caption = 'Assigned Assets Details';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            

            repeater(Group)
            {
                field("Emp Name"; Rec."Emp Name")
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
            }
        }
    }

    var
        AssignedCount: Integer;

    trigger OnAfterGetRecord()
    var
        AssetRec: Record Asset;
    begin
        // Filter page to show only assigned assets
        AssetRec.Reset();
        AssetRec.SetRange("Emp Name");
  

        // Count total assigned assets
       
        AssetRec.SetRange(Status, AssetRec.Status::Assigned);
        AssignedCount := AssetRec.Count();
    end;
}



page 50186 "Asset Card"
{
    Caption = 'Asset';
    PageType = Card;
    SourceTable = Asset;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false; // AutoIncrement
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
                    Editable = false; // Calculated via OnValidate
                }
            }
        }
    }
}
