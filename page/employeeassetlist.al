page 50191 "Employee Asset List"
{
    PageType = List;
    SourceTable = Asset;
    ApplicationArea = All;
    Caption = 'Empast';
    CardPageId = "Employee Asset Card"; // opens card when you drill down
    UsageCategory=Lists;

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
                field("Emp ID"; Rec."Emp Name")
                {
                    ApplicationArea = All;
                    
                }
                field("Serial No."; Rec."Serial No")
                {
                    ApplicationArea = All;
                    TableRelation="Asset Type"."Serial No";
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    
                }
                field("Assigned Date"; Rec."Assigned Date")
                {
                    ApplicationArea = All;
                }
                field("Returned Date"; Rec."Returned Date")
                {
                    ApplicationArea = All;
                }
                field("Lost Date"; Rec."Lost Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}