



codeunit 50135 "upgrade sold price"{
    subtype=Upgrade;
    trigger OnUpgradePerCompany()

    var
    salesinvoiceline: Record "Sales Invoice Line";
    salesinvheader: Record "Sales Invoice Header";
    lastsoldprice: Record "Last Sold Price";
    tagname:Code[60];
    upgradetag:Codeunit "upgrade tag";
    begin
        tagname:='last sold tag';
        if not upgradetag.HasUpgradeTag(tagname)then begin
    
        if salesinvoiceline.FindSet() then repeat
        if salesinvheader.get(salesinvoiceline."Document No.") then begin
            lastsoldprice.Reset();
            lastsoldprice.SetRange("Customer No.", salesinvoiceline."Sell-to Customer No.");
            lastsoldprice.SetRange("Item No.", salesinvoiceline."No.");

            if lastsoldprice.FindFirst() then begin
                lastsoldprice."Item Price" := salesinvoiceline."Unit Price";
                lastsoldprice."posting date" := salesinvheader."Posting Date";
                lastsoldprice.Modify(true);
            end else begin


    
                lastsoldprice.Init();
                lastsoldprice."Customer No." := salesinvoiceline."Sell-to Customer No.";
                lastsoldprice."Item No." := salesinvoiceline."No.";
                lastsoldprice."Item Price" := salesinvoiceline."Unit Price";
                lastsoldprice."posting date" := salesinvheader."Posting Date";
                lastsoldprice.Insert(true);
            end;
        end;
            until salesinvoiceline.Next() = 0;
            upgradetag.setUpgradeTag(tagname);
        end;
    end;
}