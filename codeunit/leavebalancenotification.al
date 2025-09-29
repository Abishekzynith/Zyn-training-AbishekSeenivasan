codeunit 50101 "My Notification Actions"
{
    procedure OpenLeaveBalance(Notification: Notification)
    var
        LeavePage: Page "Leave Req List page"; // Your page here
    begin
        LeavePage.Run();
    end;
}