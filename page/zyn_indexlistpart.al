
 
page 50142 "Index List Part"
{
    PageType = ListPart;
    SourceTable = "Index List Part";
    Editable = false;
 
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Year"; rec.Year)
                {
                    ApplicationArea = All;
                    Caption = 'Year';
                }
                field(Value; rec.Value)
                {
                    ApplicationArea = All;
                    Caption = 'Value';
                }
            }
        }
    }
}
table 50122 emp{
    DataClassification=CustomerContent;
    Caption='employeeeee';
    fields
    {
        field(1; "empCode"; Code[20])
        {
            Caption = 'Employee Code';
        }
        field(2; "empname"; Text[50])
        {
            Caption = 'Employee Name';
        }
        field(3; "empdepartment"; Text[50])
        {
            Caption = 'Employee Department';
        }
    }
    keys
    {
        key(PK; "empCode")
        {
            Clustered = true;
        }
    }
}
