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
 