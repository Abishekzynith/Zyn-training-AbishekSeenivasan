
page 50125 "last sold price"
{
    PageType = ListPart;
    SourceTable = "last sold price";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Last Sold Price';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("item no."; rec."item no.")
                {
                    ApplicationArea = All;
                    Caption = 'Item No.';
                }
                field("Customer no."; rec."Customer no.")
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                }
                field("item price"; rec."item price")
                {
                    ApplicationArea = All;
                    Caption = 'Item Price';
                }
                field("posting date"; rec."posting date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                }
              
            }
        }
    }
}