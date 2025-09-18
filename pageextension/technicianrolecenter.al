
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
