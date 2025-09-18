table 50167 "TempBlob"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Blob"; Blob) { 
            Caption = 'Blob';
            DataClassification = CustomerContent;
        }
        
         field(2; "ID"; Integer)
    {
        DataClassification = SystemMetadata;
    }
    }
   

   keys
    {
        key(PK; "ID") { Clustered = true; }
    }
}
