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
        field(50130; "beginning inv Text"; Text[250])
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