table 50126 "expense table"
{
    fields
    {
        field(1; expenseid; integer)
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
              DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Remaining: Decimal;
            begin
                Remaining := RemainingBudget();
                if Amount > Remaining then
                    Error('You cannot exceed the remaining monthly budget. Remaining: %1', Remaining);
            end;
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(5; "category"; code[100])
        {
            Caption = 'Category';
            TableRelation = "expense category"."category name";
        }
        field(6; "Category Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Expense Category"."category name" where("categoryid" = field("Category")));
        }
        field(9;"budgetamount";Decimal){
            FieldClass = FlowField;
            CalcFormula = lookup("Budget table".Amount where(Category = field(Category)));
        }
        field(10;fromdate;date){
            
        }
        field(11;todate;date){
            
        }
         

        

    }
    keys
    {
        key(PK; expenseid)
        {
            Clustered = true;
        }
        
    }
     procedure RemainingBudget(): Decimal
var
    BudgetRec: Record "Budget table";
    ExpenseRec: Record "Expense table";
    PeriodExpense: Decimal;
    CurrentDate: Date;
begin
    // Use record Date if available, otherwise WorkDate
    if Date <> 0D then
        CurrentDate := Date
    else
        CurrentDate := WorkDate();
 
    BudgetRec.Reset();
    BudgetRec.SetRange(Category, Category);
    BudgetRec.SetFilter(FromDate, '<=%1', CurrentDate);
    BudgetRec.SetFilter(ToDate, '>=%1', CurrentDate);
 
    if BudgetRec.FindFirst() then begin
        ExpenseRec.Reset();
        ExpenseRec.SetRange(Category, Category);
        ExpenseRec.SetRange("Date", BudgetRec.FromDate, BudgetRec.ToDate);
 
        if ExpenseRec.FindSet() then
            repeat
                if ExpenseRec.ExpenseID <> ExpenseID then
                    PeriodExpense += ExpenseRec.Amount;
            until ExpenseRec.Next() = 0;
 
        exit(BudgetRec.Amount - PeriodExpense);
    end;
 
    exit(0);
end;

}
table 50127 "expense category"
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






