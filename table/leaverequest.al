table 50278 "Leave Request"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Request No."; integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Emp Id."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Category"; Enum "leave category")
        {
            DataClassification = ToBeClassified;
        }
        field(4; "From Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "To Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No.of days"; Integer)
        {



            Editable = false;
        }
        field(7; Status; Enum "Leave Status")
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Remaining Days"; Integer)
        {



            Editable = false;
        }
        field(9; "name"; text[50])
        {



            Editable = false;
        }

    }
    keys
    {
        key(PK; "Request No.", name)
        {
            Clustered = true;
        }

    }


}