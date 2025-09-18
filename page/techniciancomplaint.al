
page 50123 "Complaint ListPart"
{
    PageType = ListPart;
    SourceTable = "Complaint";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer ID"; rec."Customer ID")
                {
                    ApplicationArea = All;
                    Caption = 'Customer ID';
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                }
                field("Problem"; rec."Problem")
                {
                    ApplicationArea = All;
                    Caption = 'Problem';
                }

                field("Problem Description"; rec."Problem Description")
                {
                    ApplicationArea = All;
                    Caption = 'Problem Description';
                }
                field("Date"; rec."Date")
                {
                    ApplicationArea = All;
                    Caption = 'Date';
                }
            }
        }
    }

}