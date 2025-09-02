codeunit 50101 "My Notification Actions"
{
    procedure OpenLeaveBalance(Notification: Notification)
    var
        LeavePage: Page "Leave Req List page"; // Your page here
    begin
        LeavePage.Run();
    end;
}
codeunit 50170 "My Notification Mgt."
{
    procedure ShowLeaveBalanceNotification()
    var
        Notification: Notification;
        leaveRec: Record "Employ Table";
        employeerec: Record "leave request";
         // replace with your table
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
                // Correctly reference action
               

                Notification.Send();
            until EmployeeRec.Next() = 0;
    end;
      procedure ShowpendingNotification()
    var
        Notification: Notification;
        leaveRec: Record "Employ Table";
        employeerec: Record "leave request";
        pending:integer;
         // replace with your table
    begin
        employeerec.SetRange(status, employeerec.Status::pending);
        pending:=employeerec.count;
        

    
        if EmployeeRec.FindSet() then
            repeat
                Notification.Message :=
                    StrSubstNo(' %1 requests are pending',pending);
                               

                Notification.Scope := NotificationScope::LocalScope;
                // Correctly reference action
               

                Notification.Send();
            until EmployeeRec.Next() = 0;
    end;
      procedure ShowrejectedNotification()
    var
        Notification: Notification;
        leaveRec: Record "Employ Table";
        employeerec: Record "leave request";
         // replace with your table
    begin
        if EmployeeRec.FindSet() then
            repeat
                Notification.Message :=
                    StrSubstNo('employee : %1 requests rejected for %2 days', employeerec."Emp Id.", employeerec."To Date"-employeerec."From Date"+1);
                               

                Notification.Scope := NotificationScope::LocalScope;
                // Correctly reference action
               

                Notification.Send();
            until EmployeeRec.Next() = 0;
    end;
}
codeunit 50281 "Leave Management"
{
    procedure ApproveLeaveRequest(var LeaveReq: Record "Leave Request")
    var
        LeaveCat: Record "Leave Category";
        LeaveLog: Record "Employee Leave Log";
        DaysTaken: Integer;
        TotalUsed: Integer;
    begin
        // --- Prevent duplicate approval ---
        if LeaveReq.Status = LeaveReq.Status::Approved then begin
            Message('This leave request is already approved.');
            exit;
        end;

        if LeaveReq.Status = LeaveReq.Status::Rejected then begin
            Message('This leave request was already rejected. Cannot approve.');
            exit;
        end;

        // --- Calculate leave days ---
        DaysTaken := LeaveReq."To Date" - LeaveReq."From Date" + 1;
        if DaysTaken <= 0 then
            Error('Invalid leave period. To Date must be after From Date.');

        // --- Get Leave Category ---
        if not LeaveCat.Get(LeaveReq.Category) then
            Error('Leave category %1 not found.', LeaveReq.Category);

        // --- Calculate how many days already taken ---
        TotalUsed := 0;
        LeaveLog.Reset();
        LeaveLog.SetRange("Emp Id.", LeaveReq."Emp Id.");
        LeaveLog.SetRange(Category, LeaveReq.Category);
        if LeaveLog.FindSet() then
            repeat
                TotalUsed += LeaveLog."No. of Days";
            until LeaveLog.Next() = 0;

        // --- Check against allowed days ---
        if (TotalUsed + DaysTaken) > LeaveCat."NO.of days allowed" then
            Error('Leave request exceeds allowed days (%1) for category %2. Currently used: %3, Requested: %4',
                LeaveCat."NO.of days allowed", LeaveReq.Category, TotalUsed, DaysTaken);

        // --- Insert into Leave Log ---
        LeaveLog.Init();
        LeaveLog."Emp Id." := LeaveReq."Emp Id.";
        LeaveLog."Category" := LeaveReq.Category;
        LeaveLog."Leave From Date" := LeaveReq."From Date";
        LeaveLog."Leave To Date" := LeaveReq."To Date";
        LeaveLog."No. of Days" := DaysTaken;
        LeaveLog.Insert(true);

        // --- Update Request ---
        LeaveReq."No.of days" := DaysTaken;
        LeaveReq."Remaining Days" := LeaveCat."NO.of days allowed" - (TotalUsed + DaysTaken);
        LeaveReq.Status := LeaveReq.Status::Approved;
        LeaveReq.Modify(true);

        Message('Leave approved successfully. %1 days deducted. Remaining: %2',
            DaysTaken, LeaveReq."Remaining Days");
    end;
}
