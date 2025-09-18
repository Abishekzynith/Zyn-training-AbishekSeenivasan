

page 50182 "Asset Type Card"
{
    Caption = 'Asset Type';
    PageType = Card;
    SourceTable = "Asset Type";
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
                    Editable = false; // AutoIncrement ID should not be edited
                }
                field("Category"; Rec."category")
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
