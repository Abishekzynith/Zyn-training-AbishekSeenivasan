
page 50178 "My Notification Part"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "leave request"; // any lightweight table

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
        NotificationMgt: Codeunit "My Notification Mgt.";
    begin
        NotificationMgt.ShowLeaveBalanceNotification();
        NotificationMgt.ShowrejectedNotification();
        NotificationMgt.ShowpendingNotification();
    end;
}

