codeunit 50102 "Block Purchase Posting"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    begin
        case PurchaseHeader."Approval Status" of
            PurchaseHeader."Approval Status"::Processing:
                Error('Cannot post: Purchase Order is in Processing status.');
            PurchaseHeader."Approval Status"::Open:
                Error('Cannot post: Purchase Order must be Approved first.');

        end;
    end;
}
codeunit 50123 modifylogtable
{
    [EventSubscriber(ObjectType::Table, database::Customer, OnAfterModifyEvent, '', true, true)]
    local procedure checkcall(var Rec: Record Customer; var xRec: Record Customer)
    var
        recref: RecordRef;
        xrecref: RecordRef;
        fieldref: FieldRef;
        xfieldref: FieldRef;
        i: Integer;
        changelog: Record "Modify Data";
        userid: Code[20];
    begin
        recref.GetTable(Rec);
        xrecref.GetTable(xRec);
        userid := userid;
        for i := 1 to recref.FieldCount do begin
            fieldref := recref.FieldIndex(i);
            xfieldref := xrecref.FieldIndex(i);
            if fieldref.Value <> xfieldref.Value then begin
                Clear(changelog);
                changelog.Init();
                changelog."customer no." := Rec."No.";
                changelog."field name" := CopyStr(fieldref.Name, 1, MaxStrLen(changelog."field name"));
                changelog."Old Value" := CopyStr(Format(xfieldref.Value), 1, MaxStrLen(changelog."Old Value"));
                changelog."new value" := CopyStr(Format(fieldref.Value), 1, MaxStrLen(changelog."new value"));
                changelog."user id" := userid;
                changelog.Insert()
            end;
        end;
    end;
}