codeunit 50190 "Subscription Reminder Mgt"
{
    Subtype = Normal;

    procedure CheckAndSendReminders()
    var
        Sub: Record "Subscription";
        Customer: Record Customer;
        MyNotification: Notification;
    begin
        sub.reset();
        sub.SetRange(Status, Sub.Status::Active);
        Sub.SetRange("RemainderSent", false);
        if Sub.FindSet() then
            repeat
                if (Sub."NextRenewalDate" <> 0D)  then begin
                    // Send notification
                    if Customer.Get(Sub."Customerid") then begin
                        MyNotification.Id := CreateGuid();
                        MyNotification.Scope := NotificationScope::LocalScope;
                        MyNotification.Message :=
                          StrSubstNo(
                            'Hi %1 (%2), you have %3 days left to renew your subscription (renewal on %4)..',
                            Customer.Name,
                            Customer."No.",
                            15,
                            Format(Sub."EndDate")
                          );
                       
                        MyNotification.Send();
                    end;

                    Sub."RemainderSent" := true;
                    Sub.Modify(true);
                end;
            until Sub.Next() = 0;
    end;
}
