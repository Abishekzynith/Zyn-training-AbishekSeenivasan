enumextension 50100 "DocumentTypeExt" extends "Sales Document Type"
{
    value(50104; "Posted Invoice")
    {
        Caption = 'Posted Invoice';
    }
    value(50105; "Posted Cr.Memo")
    {
        Caption = 'Posted Cr.Memo';
    }
}
enum 50103 "Sales Invoice Text"
{
    Extensible = true;

    value(0; Beginning)
    {
        Caption = 'Beginning';
    }
    value(1; Ending)
    {
        Caption = 'Ending';
    }
}