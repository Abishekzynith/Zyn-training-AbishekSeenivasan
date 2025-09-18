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