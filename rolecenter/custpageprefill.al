page 50195 "Customer Visit Log Card"
{
    PageType = Card;
    SourceTable = "Customer Visit Log";
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Entry No."; rec."Entry No.") { ApplicationArea = All; }
                field("Customer No."; rec."Customer No.") { ApplicationArea = All; }
                field("Visit Date"; rec."Visit Date") { ApplicationArea = All; }
                field("Purpose"; rec."Purpose") { ApplicationArea = All; }
                field("Notes"; rec."Notes") { ApplicationArea = All; }
            }
        }
    }

    trigger OnOpenPage()
    begin
        // Prefill Customer No. logic can go here if called with parameter
    end;
}
