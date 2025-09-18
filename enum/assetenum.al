
enum 50184 Status
{
    Extensible = true;
    Caption = 'Asset Status';

    value(0; Assigned)
    {
        Caption = 'Assigned';
    }
    value(1; Returned)
    {
        Caption = 'Returned';
    }
    value(2; Lost)
    {
        Caption = 'Lost';
    }
}