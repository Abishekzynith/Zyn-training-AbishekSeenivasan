

tableextension 50113 PostedSalesCreditMemoTableExt extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50101; "Beginning Text"; Text[250])
        {
            Caption = 'Beginning Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text"."Code";

        }
        field(50102; "Ending Text"; Text[250])
        {
            Caption = 'Ending Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text"."Code";
        }
    }


}