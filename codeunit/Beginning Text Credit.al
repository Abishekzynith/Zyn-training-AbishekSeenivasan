

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
