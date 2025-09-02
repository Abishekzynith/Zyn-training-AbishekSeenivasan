table 50143 "Modify Data"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(2; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
        }

        field(3; "Field Name"; Text[100])
        {
            DataClassification = SystemMetadata;
        }

        field(4; "Old Value"; Text[250])
        {
            DataClassification = SystemMetadata;
        }

        field(5; "New Value"; Text[250])
        {
            DataClassification = SystemMetadata;
        }

        field(6; "User ID"; code[50])
        {
            DataClassification = SystemMetadata;
        }


    }

    keys
    {
        key(PrK; "Entry No.") { Clustered = true; }
    }
}
table 50111 "Field Lookup Buffer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer) { AutoIncrement = true; }
        field(2; "Field Name"; Text[100]) { }
        field(3; "RecordId"; RecordId) { }
    }

    keys
    {
        key(PK; ID, "Field Name") { Clustered = true; }
    }
}
