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