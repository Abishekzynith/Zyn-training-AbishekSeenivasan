codeunit 50140 "my event publisher"
{
    [IntegrationEvent(false, false)]



    procedure OnNewCustomerCreated(Rec: Record Customer)

    begin

    end;
}