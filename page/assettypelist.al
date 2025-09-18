
page 50183 "Asset Type List"
{
    Caption = 'Asset Types';
    PageType = List;
    SourceTable = "Asset Type";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Asset Type Card";

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