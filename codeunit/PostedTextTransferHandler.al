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
