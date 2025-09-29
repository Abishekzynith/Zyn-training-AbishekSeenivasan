
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