


page 50115 "Beginning Text Credit Memo"
{
    PageType = ListPart;
    SourceTable = ExtendedTextTable;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field(Text; rec."Text")
                {
                    ApplicationArea = All;
                    Caption = 'Text';
                }

            }
        }
    }
}
