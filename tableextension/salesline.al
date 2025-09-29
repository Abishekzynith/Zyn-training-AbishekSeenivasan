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