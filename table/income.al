

table 50124 "income table"
{
    fields
    {
        field(1; incomeid; Code[20])
        {
            Caption = 'Expense ID';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(5; "category"; code[100])
        {
            Caption = 'Category';
            TableRelation = "income category"."category name";
        }
        field(6; "Category Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("income Category"."category name" where("categoryid" = field("Category")));
        }
         

        

    }
    keys
    {
        key(PK; incomeid)
        {
            Clustered = true;
        }
        
    }

}