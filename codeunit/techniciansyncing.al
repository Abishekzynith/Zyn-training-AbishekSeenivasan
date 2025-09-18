codeunit 50138 Customersyncing
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"my event publisher", 'OnNewCustomerCreated', '', false, false)]
    local procedure OnCustomerCreated(rec: Record Customer)
    var
        TargetCustomer: Record Customer;
        CompanyName: Text;
    begin

        CompanyName := 'abishek solutions';

        if TargetCustomer.ChangeCompany(CompanyName) then begin
            if not TargetCustomer.Get("rec"."No.") then begin
                TargetCustomer.Init();
                TargetCustomer.TransferFields("rec");
                TargetCustomer.Insert();
            end;
        end else
            Error('Unable to access target company: %1', CompanyName);
    end;
}
