
codeunit 50141 MySubscriber
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"my event publisher", 'OnNewCustomerCreated', '', False, false)]
    procedure CheckCustomerNameOnAfterNewCustomerCreated(Rec: Record Customer)
    var
    begin
        Message('New Customer %1 has been Created', Rec);
    end;
}

