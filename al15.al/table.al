table 50123 "last sold price"
{
    Caption = 'last sold price';
    DataClassification = CustomerContent;
    fields
    {
        field(9; "entry no."; integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(1; "item no."; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "item price"; decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "posting date"; date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Customer no."; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; "sales history"; code[20])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(pk; "item no.", "customer no.")
        {
            Clustered = true;
        }
    }
}
