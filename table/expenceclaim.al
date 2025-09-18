table 50199 "expenseClaim"
{
    Caption = 'Claim';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID"; Integer)
        {
            Caption = 'ID';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(2; "Emp ID"; Code[40])
        {
            Caption = 'Employee ID';
            DataClassification = CustomerContent;
        }
        field(9; "Category"; Text[50])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                CategoryRec: Record "Expense Claim Category";
            begin
                if PAGE.RunModal(PAGE::"Expense Claim Category List", CategoryRec) = ACTION::LookupOK then
                    Rec."Category" := CategoryRec.Subtype;

            end;
        }

        field(3; "Claim Date"; Date)
        {
            Caption = 'Claim Date';
            DataClassification = CustomerContent;
            
        }

        field(4; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
            trigger onValidate()
            var
                CategoryReco: record "Expense Claim Category";
                remainingLimit: Decimal;
            begin

                if (Rec.ID <> 0) and CategoryReco.Get(Rec.ID) then begin

                    if Rec.Amount > CategoryReco.Limit then
                        Error('Claim amount %1 exceeds the limit of %2 for category %3',
                              Rec.Amount, CategoryReco.Limit, CategoryReco.Name);
                end;

            end;
        }

        field(5; "expenceStatus"; Enum "expClaimstatus")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }

        field(6; "Bill"; Blob)
        {
            Caption = 'Bill Attachment';

            Subtype = bitmap;
            DataClassification = CustomerContent;
        }
        field(10; "ClaimedAmount"; Decimal)
        {
            Caption = 'Claimed Amount';
            FieldClass = FlowField;
            CalcFormula =
                Sum("ExpenseClaim".Amount WHERE(
                    "Emp ID" = FIELD("Emp ID"),
                    "Category" = FIELD("Category"),
                    "expenceStatus" = CONST(Approved)
                ));
                trigger OnValidate()
                begin
                    CalcRemainingLimit();
                end;
               
        
        }

        field(7; "BillDate"; Date)
        {
            Caption = 'Bill Date';
            DataClassification = CustomerContent;
        }
        field(8; "SubType"; Text[50])
        {
            Caption = 'Sub Type';
            DataClassification = CustomerContent;
            TableRelation = "Expense Claim Category"."Name";
        }
        field(15; "RemainingLimit"; Decimal)
        {
            Caption = 'Remaining Limit';
            DataClassification = CustomerContent;
        }
        field(20; "File Ext"; Text[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }
    var
        ClaimRec: Record ExpenseClaim;
        ExpCat: Record "Expense Claim Category";
 
    procedure CalcRemainingLimit()
    var
        UsedAmount: Decimal;
        YearStart: Date;
        YearEnd: Date;
    begin
        if ("Emp ID" = '') or ("Claim Date" = 0D) then
            exit;

        if not ExpCat.Get("Category") then
            exit;
 
        // Calculate year range from ClaimDate
        YearStart := DMY2Date(1, 1, Date2DMY("Claim Date", 3));
        YearEnd := DMY2Date(31, 12, Date2DMY("Claim Date", 3));
 
        // Sum already approved claims for employee/category/year
        UsedAmount := 0;
        ClaimRec.Reset();
        ClaimRec.SetRange("Emp ID", "Emp ID");
        ClaimRec.SetRange("Category", "Category");
        ClaimRec.SetRange(expenceStatus, expenceStatus::Approved);
        ClaimRec.SetRange("Claim Date", YearStart, YearEnd);

        if ClaimRec.FindSet() then
            repeat
                if ClaimRec.ID <> Rec.ID then
                    UsedAmount += ClaimRec.Amount;
            until ClaimRec.Next() = 0;
 
       
        RemainingLimit := ExpCat.Limit - UsedAmount;
        if RemainingLimit < 0 then
            RemainingLimit := 0;
 
        Modify(true); 
    end;
 
}
