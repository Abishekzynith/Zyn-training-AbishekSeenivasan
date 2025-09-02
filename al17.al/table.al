page 50140 "Index List Page"
{
    PageType = List;
    SourceTable ="Index table";
    ApplicationArea = ALL;
    Caption = 'Index List';
    CardPageID = "Index Card Page";
    UsageCategory = "Lists";
    InsertAllowed = false;
    ModifyAllowed = false;
 
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Description";Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip='description';
                }
                field("Percentage Increase"; Rec."Per. Increase")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
   
   
}
 
page 50143 "Index Card Page"
{
    PageType = Card;
    SourceTable ="Index table";
    ApplicationArea = ALL;
    Caption = 'Index Card';
 
    layout
    {
        area(content)
        {
            group(general)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Description";Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Percentage Increase"; Rec."Per. Increase")
                {
                    ApplicationArea = All;
                }
                field("Start Year"; Rec."Start Year")
                {
                    ApplicationArea = All;
                }
                field("End Year"; Rec."End Year")
                {
                    ApplicationArea = All;
                }
            }
            part("Index Subpage"; "Index List Part")
            {
                SubPageLink = "Code" = field(Code);
                ApplicationArea = All;
            }
 
        }
 
    }
}
 
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
