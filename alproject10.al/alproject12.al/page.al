page 50134 "Technician list"
{
    PageType = List;
    SourceTable = "Technician Log";
    ApplicationArea = All;
    Caption = 'Technician List';
    UsageCategory = Lists;
    Editable = true;
    CardPageID = "Technician Log Card";

    layout
    {
        area(Content)
        {
            group(main)
            {
                repeater(Group)
                {
                    field("ID"; Rec."Technician ID")
                    {
                        ApplicationArea = All;
                        Caption = 'ID';
                    }
                    field("Name"; Rec."Technician Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Name';
                    }
                    field("Department"; rec."Department")
                    {
                        ApplicationArea = All;
                        Caption = 'Department';
                    }
                    field("Phone No."; rec."Phone No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Phone No.';
                    }
                    field("Problem count"; rec."Problem count")
                    {
                        ApplicationArea = All;
                        Caption = 'Problem count';
                    }
                }
            }
            part("Complaint ListPart"; "Complaint ListPart")
            {
                SubPageLink = "Technician ID" = field("Technician ID");
                ApplicationArea = All;
                Caption = 'Complaint List';
            }
        }
    }
}
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
page 50107 "Technician Log Card"
{
    PageType = Card;
    SourceTable = "Technician Log";
    ApplicationArea = All;
    Editable = true;
    Caption = 'Technician Log Card';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("ID"; Rec."Technician ID")
                {
                    ApplicationArea = All;
                    Caption = 'Technician ID';
                }
                field("Name"; Rec."Technician Name")
                {
                    ApplicationArea = All;
                    Caption = 'Technician Name';
                }
                field("Department"; Rec."Department")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'Phone No.';
                }

            }
        }
    }
}