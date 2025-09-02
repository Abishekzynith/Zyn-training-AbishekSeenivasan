tableextension 50119 SalesInvoiceTableExt extends "Sales Header"
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
        field(50103; "beginning inv Text"; Text[250])
        {
            Caption = 'beginning inv Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text"."Code";
        }
        field(50104; "Ending inv Text"; Text[250])
        {
            Caption = 'Ending inv Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text"."Code";
        }
        field(50124; "last sold price"; decimal)
        {
            Caption = 'last sold price';
           
            Editable = false;
        }
      
    }


}

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
    }
}
tableextension 50115 "Posted Sales Header" extends "Sales Invoice Header"
{
    fields
    {
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
tableextension 50123 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        field(50100; "Last Sold Price"; Decimal)
        {
            Caption = 'Last Sold Price';
            DataClassification = CustomerContent;
        }
    }
}