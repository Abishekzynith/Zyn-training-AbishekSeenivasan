
enum 50129 "Posting Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }

    value(1; Processing)
    {
        Caption = 'Processing';
    }

    value(2; Approved)
    {
        Caption = 'Approved';
    }
}
tableextension 50134 PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50145; "Approval Status"; Enum "Posting Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Status';
            InitValue = Open;
        }
    }
}
