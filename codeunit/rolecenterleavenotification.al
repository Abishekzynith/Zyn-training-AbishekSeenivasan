codeunit 50170 "My Notification Mgt."
{
    procedure ShowLeaveBalanceNotification()
    var
        Notification: Notification;
        leaveRec: Record "Employ Table";
        employeerec: Record "leave request";

    begin
        if EmployeeRec.FindSet() then
            repeat
                Notification.Message :=
                    StrSubstNo('Hello %1, current leave request status is %2 and remaining %3 %4.',
                               EmployeeRec."emp id.",
                               EmployeeRec."status",
                               EmployeeRec."remaining days",
                               EmployeeRec.Category);


                Notification.Scope := NotificationScope::LocalScope;
                Notification.Send();
            until EmployeeRec.Next() = 0;
    end;

    procedure ShowpendingNotification()
    var
        Notification: Notification;
        leaveRec: Record "Employ Table";
        employeerec: Record "leave request";
        pending: integer;
    begin
        employeerec.SetRange(status, employeerec.Status::pending);
        pending := employeerec.count;
        if EmployeeRec.FindSet() then
            repeat
                Notification.Message :=
                    StrSubstNo(' %1 requests are pending', pending);


                Notification.Scope := NotificationScope::LocalScope;
                Notification.Send();
            until EmployeeRec.Next() = 0;
    end;

    procedure ShowrejectedNotification()
    var
        Notification: Notification;
        leaveRec: Record "Employ Table";
        employeerec: Record "leave request";

    begin
        if EmployeeRec.FindSet() then
            repeat
                Notification.Message :=
                    StrSubstNo('employee : %1 requests rejected for %2 days', employeerec."Emp Id.", employeerec."To Date" - employeerec."From Date" + 1);


                Notification.Scope := NotificationScope::LocalScope;
                // Correctly reference action


                Notification.Send();
            until EmployeeRec.Next() = 0;
    end;
}