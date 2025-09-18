
page 50146 "Problem Page"
{
    PageType = Card;
    SourceTable = "Complaint";
    ApplicationArea = All;
    Caption = 'Compliant Card';
    layout
    {
        area(Content)
        {
            group(Group)
            {
                field("Customer ID"; Rec."Customer ID")
                {
                    ApplicationArea = All;
                    Caption = 'Customer ID';
                }

                field("Problem"; Rec.Problem)
                {
                    ApplicationArea = All;
                    Caption = 'Problem';
                }
                field("Department"; Rec."Department")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }
                field("Technician id"; Rec."Technician ID")
                {
                    ApplicationArea = All;
                    Caption = 'Technician ID';
                }
                field("Problem Description"; Rec."Problem Description")
                {
                    ApplicationArea = All;
                    Caption = 'Problem Description';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
            }
        }
    }
}
