table 50179 Plans
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1;PlanID; Code[20]) { DataClassification = ToBeClassified; }
        field(2;Fee;Decimal) { DataClassification=ToBeClassified; }
        field(3;Name;Text[50]) { DataClassification=ToBeClassified; }
        field(4;Status;Enum SimpleStatusEnum) { DataClassification=ToBeClassified; }
    }

    keys
    {
        key(PK;PlanID) { Clustered = true; }
    }

    trigger OnModify()
    var
        SubscriptionRec: Record Subscription;
    begin
        if Rec.Status = Rec.Status::Inactive then begin
            SubscriptionRec.Reset();
            SubscriptionRec.SetRange(PlanID, Rec.PlanID);
            if SubscriptionRec.FindSet() then
                repeat
                    SubscriptionRec.Delete(true);
                until SubscriptionRec.Next() = 0;
        end;
    end;
}
table 50181 Subscription
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; SubID; Code[20]) { DataClassification = ToBeClassified; }
        field(2; CustomerID; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
        field(3; PlanID; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Plans.PlanID;
            trigger OnValidate()
            var
                PlanRec: Record Plans;
            begin
                if PlanRec.Get(PlanID) then begin
                    if PlanRec.Status <> PlanRec.Status::Active then
                        Error('You can only subscribe to an active plan (%1).', PlanID);
                end else
                    Error('Plan %1 not found.', PlanID);
            end;

        }
        field(4; StartDate; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateDates();
            end;
        }
        field(8; Duration; Integer)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateDates();
            end;
        }
        field(5; EndDate; Date) { DataClassification = ToBeClassified; }
        field(6; Status; Enum StatusEnum) { DataClassification = ToBeClassified; }
        field(7; NextBilling; Date) { DataClassification = ToBeClassified; }
    }

    keys
    {
        key(PK; SubID, PlanID)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        UpdateDates();
        UpdateStatus();
    end;

    trigger OnModify()
    begin
        UpdateStatus();
    end;

    local procedure UpdateDates()
    var
        Expr: Text[30];
    begin
        if (StartDate <> 0D) and (Duration > 0) then begin
            Expr := StrSubstNo('<+%1M>', Format(Duration));
            EndDate := System.CalcDate(Expr, StartDate);
            
            if NextBilling = 0D then
                NextBilling := System.CalcDate('<+1M>', StartDate);
        end;
    end;

    local procedure UpdateStatus()
    var
        WD: Date;
    begin
        WD := System.WorkDate();
        if (EndDate <> 0D) and (EndDate <= WD) then
            Status := Status::Expired
        else
            if (StartDate <> 0D) then
                Status := Status::Active;
    end;

    local procedure AdvanceNextBilling()
    begin
        if NextBilling <> 0D then
            NextBilling := System.CalcDate('<+1M>', NextBilling);
    end;
}