page 50143 "Index Card Page"
{
    PageType = Card;
    SourceTable ="Index table";
    ApplicationArea = ALL;
    Caption = 'Index Card';
 
    layout
    {
        area(content)
        {
            group(general)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Description";Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Percentage Increase"; Rec."Per. Increase")
                {
                    ApplicationArea = All;
                }
                field("Start Year"; Rec."Start Year")
                {
                    ApplicationArea = All;
                }
                field("End Year"; Rec."End Year")
                {
                    ApplicationArea = All;
                }
            }
            part("Index Subpage"; "Index List Part")
            {
                SubPageLink = "Code" = field(Code);
                ApplicationArea = All;
            }
 
        }
 
    }
}