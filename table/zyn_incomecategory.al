
table 50129 "income category"
{
    fields
    {
        field(1; categoryid; Code[20])
        {
            Caption = 'Category ID';
            DataClassification = ToBeClassified;
        }
        field(2; "category name"; code[100])
        {
            Caption = 'Category Name';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
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
    fieldgroups
    {
        fieldgroup(DropDown; "category name")
        {

        }
    }
}






