codeunit 50215 "Subscription Recurring Billing"
{
   

    var
        SubscriptionRec: Record Subscription;
        PlanRec: Record Plans;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        WorkDt: Date;
        NewInvNo: Code[20];

    trigger OnRun()
    begin
        WorkDt := System.WorkDate();
        SubscriptionRec.Reset();
        SubscriptionRec.SetRange("NextBilling", 0D, WorkDt); 
        if SubscriptionRec.FindSet() then
            repeat
                if (SubscriptionRec.Status <> SubscriptionRec.Status::Expired) and
                   ((SubscriptionRec.EndDate = 0D) or (SubscriptionRec.EndDate > WorkDt)) then begin

                    
                    if not PlanRec.Get(SubscriptionRec.PlanID) then
                        continue;

            
                    NewInvNo:='subinv-' + Format(SubscriptionRec.SubID)+ '-' + Format(WorkDt,0,'<Year4><Month,2>');
                    SalesHeader.Init();
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                    SalesHeader."No." := NewInvNo;
                    SalesHeader.Validate("Sell-to Customer No.", SubscriptionRec.CustomerID);
                    SalesHeader.Validate("Order Date", WorkDt);
                    SalesHeader.Validate("Posting Date", WorkDt);
                    SalesHeader."Subscription ID" := SubscriptionRec.SubID;
                    
                    SalesHeader.Insert();

                    
                    SalesLine.Init();
                    SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine.Validate(Amount, PlanRec.Fee);
                    SalesLine.Insert();

                    SubscriptionRec.NextBilling := CalcDate('<+1M>', SubscriptionRec.NextBilling);

                    if (SubscriptionRec.EndDate <> 0D) and (SubscriptionRec.NextBilling > SubscriptionRec.EndDate) then
                        SubscriptionRec.Status := SubscriptionRec.Status::Expired;

                    SubscriptionRec.Modify(true);
                end;
            until SubscriptionRec.Next() = 0;
    end;

}