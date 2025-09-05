//assessment lines 47-52
tableextension 50139 SalesHeaderExt extends "Sales Header"
{
    fields
    {
      
        field(50103; "Beginning Invoice Text"; Text[50])
        {
            Caption = 'Beginning Invoice Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;
        }
        field(50105; "Ending Invoice Text"; Text[50])
        {
            Caption = 'Ending Invoice Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;
        }

        //Assessment Pointing out
        field(50000; "Subscription ID"; Code[20])
        {
            Caption = 'Subscription ID';
            DataClassification = CustomerContent;
        }

    }
 
}