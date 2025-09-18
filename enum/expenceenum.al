enum 50100 "expClaimstatus"
{
    Extensible = true;
    Caption = 'Claim Status';

    value(1; Approved)
    {
        Caption = 'Approved';
    }
    value(2; Rejected)
    {
        Caption = 'Rejected';
    }
    value(3; Pending)
    {
        Caption = 'Pending';
    }
    value(4; Cancelled)
    {
        Caption = 'Cancelled';
    }
}
