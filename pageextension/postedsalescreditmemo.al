pageextension 50119 "PostedSalesCrMemoExt" extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter(General)
        {
            group("Cr.Memo Texts")
            {
                field("Beginning Text"; Rec."Beginning Text") // Add field in table extension too
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("Ending Text"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        addafter("Cr.Memo Texts")
        {
            part("Posted Beginning Cr.Memo "; "Posted Begin Cr.Memo ListPart") // your custom listpart
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Beginning);
            }

            part("Posted Ending Cr.Memo "; "Posted End Cr.Memo ListPart") // your custom listpart
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Ending);
            }

        }

    }
}