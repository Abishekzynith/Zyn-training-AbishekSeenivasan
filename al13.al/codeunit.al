codeunit 50134 "Extended Text Handler"
{
    procedure LoadExtendedTextGeneric(SalesHeader: Record "Sales Header"; StandardTextCode: Code[200]; Type: Enum "Sales Invoice Text")
    var
        ExtTextLine: Record "Extended Text Line";
        CustomExtText: Record "ExtendedTextTable";
        CustomerRec: Record Customer;
        LangCode: Code[10];
    begin
        // Delete existing lines for this document and selection
        CustomExtText.SetRange("Document No.", SalesHeader."No.");
        CustomExtText.SetRange(type, Type);
        CustomExtText.DeleteAll();

        // Get customer language
        if CustomerRec.Get(SalesHeader."Sell-to Customer No.") then
            LangCode := CustomerRec."Language Code";

        // Filter the Extended Text Lines based on the standard text code and language
        ExtTextLine.SetRange("No.", StandardTextCode);
        ExtTextLine.SetRange("Language Code", LangCode);

        if ExtTextLine.FindSet() then begin
            repeat
                CustomExtText.Init();
                CustomExtText."Document No." := SalesHeader."No.";
                CustomExtText."Document Type" := SalesHeader."Document Type";
                CustomExtText."Line No." := ExtTextLine."Line No.";
                CustomExtText."Text" := ExtTextLine.Text;
                CustomExtText.Type := Type;
                CustomExtText.Insert(true);
            until ExtTextLine.Next() = 0;
        end;
    end;
}

codeunit 50128 "Beginning Text Transfer"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', true, true)]
    local procedure OnAfterSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header"; PreviewMode: Boolean)
    var
        CustomExtText: Record "ExtendedTextTable";
        PostedExtText: Record ExtendedTextTable;
        TypeEnum: Enum "Sales Invoice Text";
        i: Integer;
    begin
        SalesInvHeader."Beginning Text" := SalesHeader."Beginning Text";
        SalesInvHeader."Ending Text" := SalesHeader."Ending Text";

        for i := 1 to 2 do begin
            case i of

            
                1:
                    TypeEnum := TypeEnum::Beginning;
                2:
                    TypeEnum := TypeEnum::Ending;
            end;
            PostedExtText.Reset();
            // Copy to Posted Extended Text Table
            CustomExtText.SetRange("Document No.", SalesHeader."No.");
            CustomExtText.SetRange(Type, TypeEnum);
            if CustomExtText.FindSet() then begin
                repeat
                    PostedExtText.Init();
                    PostedExtText.TransferFields(CustomExtText);
                    PostedExtText."Document No." := SalesInvHeader."No.";
                    PostedExtText."Document Type" := SalesHeader."Document Type"::"Posted Invoice";
                    PostedExtText."Line No." := CustomExtText."Line No.";
                    PostedExtText."Text" := CustomExtText."Text";
                    PostedExtText.Insert();
                until CustomExtText.Next() = 0;
            end;
            // Delete from ExtendedTextTable
            CustomExtText.SetRange("Document No.", SalesHeader."No.");
            CustomExtText.SetRange(Type, TypeEnum);
            CustomExtText.DeleteAll();
        end;
    end;
}

codeunit 50121 "Beginning Text Credit"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesCrMemoHeaderInsert', '', true, true)]
    local procedure OnAfterSalesCrMemoHeaderInsert(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; WhseShip: Boolean; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header")
    var
        CustomExtText: Record "ExtendedTextTable";
        PostedExtText: Record ExtendedTextTable;
        TypeEnum: Enum "Sales Invoice Text";
        i: Integer;
    begin
        SalesCrMemoHeader."Beginning Text" := SalesHeader."Beginning Text";
        SalesCrMemoHeader."Ending Text" := SalesHeader."Ending Text";

        for i := 1 to 2 do begin
            case i of
                1:
                    TypeEnum := TypeEnum::Beginning;
                2:
                    TypeEnum := TypeEnum::Ending;
            end;

            CustomExtText.Reset();
            CustomExtText.SetRange("Document No.", SalesHeader."No.");
            CustomExtText.SetRange(Type, TypeEnum);
            if CustomExtText.FindSet() then begin
                repeat
                    PostedExtText.Init();
                    PostedExtText.TransferFields(CustomExtText);
                    PostedExtText."Document No." := SalesCrMemoHeader."No.";
                    PostedExtText."Document Type" := SalesHeader."Document Type"::"Posted Cr.Memo";
                    PostedExtText."Line No." := CustomExtText."Line No.";
                    PostedExtText."Text" := CustomExtText."Text";
                    PostedExtText.Insert();
                until CustomExtText.Next() = 0;
            end;
            // Delete from ExtendedTextTable
            CustomExtText.Reset();
            CustomExtText.SetRange("Document No.", SalesHeader."No.");
            CustomExtText.SetRange(Type, TypeEnum);
            CustomExtText.DeleteAll();
        end;
    end;
}

codeunit 50132 "PostedTextTransferHandler"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', true, true)]
    local procedure OnAfterSalesInvHeaderInsert(
        var SalesInvHeader: Record "Sales Invoice Header";
        SalesHeader: Record "Sales Header";
        CommitIsSuppressed: Boolean;
        WhseShip: Boolean;
        WhseReceive: Boolean;
        var TempWhseShptHeader: Record "Warehouse Shipment Header";
        var TempWhseRcptHeader: Record "Warehouse Receipt Header";
        PreviewMode: Boolean)
    begin
        TransferCustomTextToPosted(SalesHeader, SalesInvHeader, Enum::"Sales Invoice Text"::Beginning);
        TransferCustomTextToPosted(SalesHeader, SalesInvHeader, Enum::"Sales Invoice Text"::Ending);
    end;

    local procedure TransferCustomTextToPosted(
        SalesHeader: Record "Sales Header";
        var SalesInvHeader: Record "Sales Invoice Header";
        TextType: Enum "Sales Invoice Text")
    var
        CustomExtText: Record "ExtendedTextTable";
        PostedExtText: Record "ExtendedTextTable";
    begin
        // Assign main header field values
        case TextType of
            TextType::Beginning:
                SalesInvHeader."Beginning Text" := SalesHeader."Beginning Text";
            TextType::Ending:
                SalesInvHeader."Ending Text" := SalesHeader."Ending Text";
        end;

        // Transfer records
        CustomExtText.SetRange("Document No.", SalesHeader."No.");
        CustomExtText.SetRange("type", TextType);
        if CustomExtText.FindSet() then begin
            repeat
                PostedExtText.Init();
                PostedExtText.TransferFields(CustomExtText);
                PostedExtText."Document No." := SalesInvHeader."No.";
                PostedExtText.Type := TextType;
                PostedExtText."Document Type" := SalesHeader."Document Type"::"posted invoice";
                PostedExtText.Insert(true);
            until CustomExtText.Next() = 0;
        end;

        // Delete original
        CustomExtText.SetRange("Document No.", SalesHeader."No.");
        CustomExtText.SetRange("type", TextType);
        CustomExtText.DeleteAll();
    end;
 
}
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