enum 50105 "Technician Department"
{
    Extensible = true;
    value(0; IT)
    {
        Caption = 'IT';
    }
    value(1; Hardware)
    {
        Caption = 'Hardware';
    }
    value(2; Networking)
    {
        Caption = 'Networking';
    }
}
pageextension 50145 RoleCentreExt extends "Business Manager Role Center"
{
    actions
    {
        addlast(embedding)
        {
            action("technician")
            {
                ApplicationArea = All;
                Caption = 'Technician';
                RunObject = page "Technician List";

            }

        }
    }
}
enum 50102 "Available Problems"
{
    Extensible = true;
    value(0; SoftwareIssue)
    {
        Caption = 'Software Issue';
    }
    value(1; HardwareIssue)
    {
        Caption = 'Hardware Issue';
    }
    value(2; Networking)
    {
        Caption = 'Networking';
    }
}
