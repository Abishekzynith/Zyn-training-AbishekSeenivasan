
table 50104 "Complaint"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Customer ID"; Code[20])
        {
            Caption = 'Customer ID';
            DataClassification = CustomerContent;
            Editable = false;
            //TableRelation = "Customer" WHERE("No." = field("Customer ID"));
        }
        field(3; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            
        }
        field(4; "Problem"; Enum "Available Problems")
        {
            Caption = 'Problem';
            DataClassification = CustomerContent;
        }
        field(5; "Department"; Enum "Technician Department")
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
        }
        field(6; "Technician ID"; Code[20])
        {
            Caption = 'Technician ID';
            DataClassification = SystemMetadata;
            TableRelation = "Technician Log"."Technician ID" WHERE(Department = FIELD(Department));
        }
        field(7; "Problem Description"; Text[250])
        {
            Caption = 'Problem Description';
            DataClassification = CustomerContent;
        }
        field(8; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.", "Customer ID") { Clustered = true; }
    }
}
