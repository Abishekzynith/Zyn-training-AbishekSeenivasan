
tableextension 50112 "Posted Sales Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(50100; "Beginning Text"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "Ending Text"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
         field(50103; "Beginning inv Text"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Ending inv Text"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50124; "last sold price"; decimal)
        {
            Caption = 'last sold price';
            FieldClass = FlowField;
            CalcFormula = max("last sold price"."item price" where( "Customer no." = field("Sell-to Customer No.")));
            Editable = false;
        }
    }
}