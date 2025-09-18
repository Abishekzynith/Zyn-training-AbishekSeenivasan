
pageextension 50127 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("points Allowed"; Rec."Loyalty Points")
            {
                ApplicationArea = All;
            }
            field("points Used (Sales Line)"; rec."Loyalty Point used")
            {
                ApplicationArea = All;
                Caption = 'points Used';
                Editable = false;
            }

        }
    }
    actions
    {
        addlast(processing)
        {
            action(problem)
            {
                ApplicationArea = All;
                Caption = 'Raise Complaint';
                Image = Create;
                trigger OnAction()
                var
                    ProblemRec: Record Complaint;
                    CustomerRec: Record Customer;
                begin
                    CustomerRec.Get(Rec."No.");
                    ProblemRec.Init();
                    ProblemRec."Customer ID" := CustomerRec."No.";
                    ProblemRec."customer Name" := CustomerRec."Name";
                    ProblemRec.Insert(true);
                    Page.Run(Page::"Problem Page", ProblemRec);
                end;
            }
        }
    }

    var
        PointsUsedDisplay: Decimal;


}
