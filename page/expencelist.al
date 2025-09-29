page 50128 "Expense List Page"
{
    PageType = List;
    SourceTable = "expense table";
    ApplicationArea = ALL;
    Caption = 'Expense List';
    CardPageID = "Expense Card Page";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Expense ID"; Rec.expenseid)
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
        area(FactBoxes)
        {
            part("til"; "budgetfact")
            {
                ApplicationArea = all;


            }


        }

    }
    actions
    {
        area(Processing)
        {
            action(NewExpense)
            {
                ApplicationArea = All;
                Caption = 'category';
                Image = New;
                trigger OnAction()

                begin

                    Page.Run(Page::"Expense category list page");
                end;

            }
            action(new)
            {
                Image = Receipt;
                Caption = 'report';
                RunObject = report "Expense Export Report";
            }



        }
    }
}