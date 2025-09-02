table 50121 "budget table"
{
    fields
    {
        field(1; budgetid; Code[20])
        {
            Caption = 'budget ID';
        }
        field(2; fromdate; Date)
        {
            Caption = 'fromdate';
        }
        field(3; "amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(4; "ToDate"; Date)
        {
            Caption = 'ToDate';
        }
         field(7; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(8; "category name"; code[100])
        {
            Caption = 'Category Name';
            DataClassification = ToBeClassified;
        }
        
        field(5; "category"; code[100])
        {
            Caption = 'Category';
            TableRelation = "expense category"."category name";
        }
        
       
         

        

    }
    keys
    {
        key(PK; budgetid)
        {
            Clustered = true;
        }
        
    }
    procedure GetLastBudget(CategoryCode: Code[20]): Boolean
    var
        TempRec: Record "Budget table";
    begin
        TempRec.Reset();
        TempRec.SetRange(Category, CategoryCode);
        if TempRec.FindLast() then begin
            Rec := TempRec;
            exit(true);
        end;
        exit(false);
    end;
 
    procedure GetBudgetForDate(CategoryName: Code[20]; CurrentDate: Date): Boolean
    begin
        Reset();
        SetRange(Category, CategoryName);
        SetFilter(FromDate, '<=%1', CurrentDate);
        SetFilter(ToDate, '>=%1', CurrentDate);
        exit(FindFirst());
    end;

}
