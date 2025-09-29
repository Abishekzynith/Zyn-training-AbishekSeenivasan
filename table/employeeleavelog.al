
table 50280 "Employee Leave Log"
{
    DataClassification = ToBeClassified;
 
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;  
            Editable = false;
        }
        field(2; "Emp Id."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Category"; Enum "leave category")
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Leave From Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Leave To Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No. of Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
 
    keys
    {
        key(PK;  "Entry No.","Emp Id.", Category)
        {
            Clustered = true;
        }
    }
}