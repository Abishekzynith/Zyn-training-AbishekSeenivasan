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