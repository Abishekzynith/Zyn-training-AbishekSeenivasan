table 50101 "Expense Claim Category"
{
    Caption = 'Expense Claim Category';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID"; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }
      


        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }

        field(4; "Subtype"; Text[40])
        {
            Caption = 'Subtype';
            DataClassification = CustomerContent;
        }

        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

       
        field(5; "Limit"; Decimal)
        {
            Caption = 'Limit Amount';
            DataClassification = CustomerContent;
        }

        field(6; "Name"; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "ID", "Code", "Name", "Subtype")
        {
            Clustered = true;
        }

       
    }
}
