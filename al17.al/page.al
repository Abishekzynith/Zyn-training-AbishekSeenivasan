table 50115 "Index table"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Description"; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Per. Increase"; Decimal)
        {
            Caption = 'Percentage Inc';
            trigger OnValidate()
            begin
                RecalculateIndexValues();
            end;
        }
        field(4; "Start Year"; Integer)
        {
            Caption = 'Start Year';
            trigger OnValidate()
            begin
                RecalculateIndexValues();
            end;
        }
        field(5; "End Year";Integer)
        {
            Caption = 'End Year';
            trigger OnValidate()
            begin
                RecalculateIndexValues();
            end;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    local procedure RecalculateIndexValues()
var
    IndexListPartRec: Record "Index List Part";
    CurValue: Decimal;
    YearCounter: Integer;
    EntryNo: Integer;
    YearsElapsed: Integer;
begin
    
    if ("Start Year" = 0) or ("End Year" = 0) or ("Per. Increase" = 0) then
        exit;
 
    if "End Year" < "Start Year" then
        Error('End Year must be greater than or equal to Start Year.');
 
    
    IndexListPartRec.Reset();
    IndexListPartRec.SetRange(Code, Code);
    if IndexListPartRec.FindSet() then
        IndexListPartRec.DeleteAll();
 
    
    CurValue := 100; 
    EntryNo := 0;
 
    
    for YearCounter := "Start Year" to "End Year" do begin
        EntryNo += 1;
 
        
        YearsElapsed := YearCounter - "Start Year";
 
        
        CurValue := 100 * Power(1 + ("Per. Increase" / 100), YearsElapsed);
 
        
        IndexListPartRec.Init();
        IndexListPartRec.Code := Code;
        IndexListPartRec."Entry No" := EntryNo;
        IndexListPartRec.Year := YearCounter;
        IndexListPartRec.Value := CurValue; 
        IndexListPartRec.Insert();
    end;
end;
 
 
    trigger OnDelete()
var
    ChildRec: Record "Index List Part";
begin
    ChildRec.Reset();
    ChildRec.SetRange(Code, Code);
    if ChildRec.FindSet() then
        ChildRec.DeleteAll();
end;
}
 
 
table 50140 "Index List Part"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; "Entry No"; Integer)
        {
            Caption = 'Entry No';
        }
        field(3; "Year"; Integer)
        {
            Caption = 'Year';
        }
        field(4; "Value"; Decimal)
        {
            Caption = 'Value';
        }
    }
    keys
    {
        key(PK; Code, "Entry No")
        {
            Clustered = true;
        }
    }
}
page 50144 "pageintro"{
    PageType = Card;
    SourceTable = "emp";
    ApplicationArea = ALL;
    Caption = 'emptable';
 
    layout
    {
        area(content)
        {
            group(general)
            {
                field("Code"; Rec.empCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the index';
                }
                field("Description"; Rec.empname)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description of the index';
                }
                field("Percentage Increase"; Rec."empdepartment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Percentage increase applied to the index';
                }
              
            }
           
 
        }
 
    }
}
 