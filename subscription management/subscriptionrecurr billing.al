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

                    
                    // NewInvNo := GetNextInvoiceNo();
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

    // local procedure GetNextInvoiceNo(): Code[20]
    // var
    //     LastHdr: Record "Sales Header";
    //     NumText: Text;
    //     LastNum: Integer;
    //     NextNum: Integer;
    //     Suffix: Text[10];
    // begin
        
    //     LastHdr.Reset();
    //     LastHdr.SetRange("Document Type", LastHdr."Document Type"::Invoice);
    //     if LastHdr.FindLast() then begin
    //         if CopyStr(LastHdr."No.", 1, 3) = 'inv' then begin
    //             NumText := CopyStr(LastHdr."No.", 4); // text after inv
    //             if EVALUATE(LastNum, NumText) then
    //                 NextNum := LastNum + 1
    //             else
    //                 NextNum := 1;
    //         end else
    //             NextNum := 1;
    //     end else
    //         NextNum := 1;

        
    //     if NextNum < 10 then
    //         Suffix := '00' + Format(NextNum)
    //     else if NextNum < 100 then
    //         Suffix := '0' + Format(NextNum)
    //     else
    //         Suffix := Format(NextNum);

    //     exit('sin' + Suffix);
    // end;
}