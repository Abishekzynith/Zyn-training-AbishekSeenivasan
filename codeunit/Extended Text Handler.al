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