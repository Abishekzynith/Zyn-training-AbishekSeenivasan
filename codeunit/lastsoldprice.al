codeunit 50100 "Last Sold Price Update"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterpostsalesdoc', '', true, true)]
    local procedure OnAfterSalesInvHeaderInsert(var SalesHeader: Record "Sales Header";
     var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; 
     SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; 
     InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry";
      WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean)

    var
        SalesInvLine: Record "Sales Invoice Line";
        LastSoldPrice: Record "Last Sold Price";
        PostedInvoice: Record "Sales Invoice Header";
    begin
        if SalesInvHdrNo <> '' then
            if PostedInvoice.get(SalesInvHdrNo) then begin
        SalesInvLine.SetRange("Document No.", PostedInvoice."No.");
        if SalesInvLine.FindSet() then
            repeat
                LastSoldPrice.Init();
                LastSoldPrice."Customer No." := SalesInvLine."Sell-to Customer No.";
                LastSoldPrice."Item No." := SalesInvLine."No.";
                LastSoldPrice."Item Price" := SalesInvLine."Unit Price";
                LastSoldPrice."posting date" := PostedInvoice."Posting Date";
                LastSoldPrice.Insert(true);
            until SalesInvLine.Next() = 0;
        end;

    end;
}
