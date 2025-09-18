pageextension 50158 Customervisitloglist extends "Customer Card"
{
    actions
    {
        addfirst(Processing)
        {
            action(Visitlog)
            {
                ApplicationArea = All;
                Caption = 'Visit Log';
                Image = View;


                trigger OnAction()
                var
                    NewLog: Record "Customer Visit Log";
                begin

                    NewLog.Init();
                    NewLog."Customer No." := Rec."No.";
                    Page.RunModal(Page::"Customer Visit Log list", NewLog);
                end;

            }
        }
    }


}