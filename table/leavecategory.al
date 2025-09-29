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