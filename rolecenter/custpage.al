table 50192 "Customer Visit Log"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            NotBlank = true;
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }

        field(2; "Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
            NotBlank = true;
            DataClassification = CustomerContent;
        }

        field(3; "Visit Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(4; "Purpose"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(5; "Notes"; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }

        key(CustomerKey; "Customer No.")
        {

        }
    }
}
