



page 50180 "Assigned Asset List"
{
    PageType = List;
    SourceTable = Asset;
    ApplicationArea = All;
    Caption = 'Assigned Assets';
    UsageCategory=Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Name"; Rec."Emp Name") { }
                field("Asset Type"; Rec."Asset Type") { }
                field("Serial No."; Rec."Serial No") { }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Status, Rec.Status::Assigned);
    end;
}