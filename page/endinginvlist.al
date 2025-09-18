
page 50121 "Ending inv List"
{
    PageType = ListPart;
    SourceTable = "ExtendedTextTable";
    ApplicationArea = All;

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
                field("Text"; rec."Text")
                {
                    ApplicationArea = All;
                    Caption = 'Text';
                }
            }
        }
    }
}