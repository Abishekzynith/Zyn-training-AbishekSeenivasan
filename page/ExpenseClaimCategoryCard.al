page 50103 "Expense Claim Category Card"
{
    PageType = Card;
    SourceTable = "Expense Claim Category";
    Caption = 'Expense Claim Category';

    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec."Code") { ApplicationArea = All; }
                field("Name"; Rec."Name") { ApplicationArea = All; }
                field("Description"; Rec."Description") { ApplicationArea = All; }
                field("Subtype"; Rec."Subtype") { ApplicationArea = All; }
                field("Limit"; Rec."Limit") { ApplicationArea = All; }
            }
        }
    }
}
