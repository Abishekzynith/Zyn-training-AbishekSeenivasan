table 50271 "leave Category"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "category name"; Enum "leave category")
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Leave Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "NO.of days allowed"; Integer)
        {
            DataClassification = ToBeClassified;
        }
 
    }
    keys
    {
        key(PK; "category name")
        {
            Clustered = true;
        }
    }
}
 
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
 
 
table 50278 "Leave Request"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Request No."; integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement=true;
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
        key(PK; "Request No.",name)
        {
            Clustered = true;
        }
       
    }
   
   
}
 
table 50276 "Employ Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Emp Id."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; role; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Department; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Emp id.",name)
        {
            Clustered = true;
        }
    }
}
 