page 50167 "renewNotification"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "subscription"; 

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(UserID; UserId())
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage();
    var
        NotificationMgt: Codeunit "Subscription Reminder Mgt";
    begin
        NotificationMgt.CheckAndSendReminders();
    end;
}