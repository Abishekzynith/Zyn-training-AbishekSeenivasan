page 50102 "Expense Claim Category List"
{
    PageType = List;
    SourceTable = "Expense Claim Category";
    Caption = 'ExpenseClaimCat';
    CardPageId="Expense Claim Category Card";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; rec."Code") { ApplicationArea = All; }
                field("Name"; rec."Name") { ApplicationArea = All; }
                field("Description"; rec."Description") { ApplicationArea = All; }
                field("Subtype"; rec."Subtype") { ApplicationArea = All; }
                field("Limit"; rec."Limit") { ApplicationArea = All; }
            }
        }
    }
}
