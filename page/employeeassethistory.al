
page 50196 "Employee Asset History"
{
    Caption = 'Employee Asset History';
    PageType = List;
    SourceTable = Asset;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Emp Name"; Rec."Emp Name") { ApplicationArea = All; }
                field("Asset Type"; Rec."Asset Type") { ApplicationArea = All; }
                field("Serial No."; Rec."Serial No") { ApplicationArea = All; }
                field("Assigned Date"; Rec."Assigned Date") { ApplicationArea = All; }
            
            }
        }
    }
}