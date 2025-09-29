pageextension 50176 "My RC Ext" extends "Business Manager Role Center"
{
    layout
    {
        addfirst(rolecenter)
        {
            part(NotificationPart; "My Notification Part")
            {
                ApplicationArea = All;
            }
        }
    }
}

