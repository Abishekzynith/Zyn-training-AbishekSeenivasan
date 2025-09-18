codeunit 50104 LoyaltyPointsValidator
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean; var CalledBy: Integer)
    var
        Customer: Record Customer;

        TotalLoyaltyPoints: Integer;
    begin
        if (SalesHeader."Document Type" in [SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::Order]) then begin

            if Customer.Get(SalesHeader."Sell-to Customer No.") then begin


                if Customer."Loyalty Points" <= Customer."Loyalty Point Used" then
                    Error('Loyalty point limit exceeded for customer %1. Cannot post the invoice.', Customer.Name);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'onAfterPostSalesDoc', '', true, true)]
    local procedure onAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)
    var
        CustomerRec: Record Customer;
        

    begin
        if (SalesHeader."Document Type" in [SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::Order]) then begin

            if CustomerRec.Get(SalesHeader."Sell-to Customer No.") then begin
                CustomerRec."Loyalty Point Used" += 10;
                CustomerRec.Modify();
            end;
        end;
    end;

}