page 50141 "income List Page"
{
    PageType = List;
    SourceTable = "income table";
    ApplicationArea = ALL;
    Caption = 'income List';
    CardPageID = "income Card Page";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("income ID"; Rec.incomeid)
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec.amount)
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec.date)
                {
                    ApplicationArea = All;
                }
                field("Category n"; Rec."Category")
                {
                    ApplicationArea = All;


                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Newincome)
            {
                ApplicationArea = All;
                Caption = 'category';
                Image = New;
                trigger OnAction()

                begin

                    Page.Run(Page::"income category list page");
                end;

            }
            action(new)
            {
                Image = Receipt;
                Caption = 'report';
                RunObject = report "income Export Report";
            }



        }
    }
}