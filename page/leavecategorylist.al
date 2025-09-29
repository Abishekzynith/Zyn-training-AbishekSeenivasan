page 50276 "Leave Cat List page"
{
    Caption = 'Leave Category List';
    PageType = List;
    SourceTable = "leave Category";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Leave Cat card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."category name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec."Leave Description")
                {
                    ApplicationArea = All;
                }

                field("Max Leave Days"; Rec."NO.of days allowed")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}