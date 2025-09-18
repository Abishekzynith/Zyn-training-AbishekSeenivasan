
// Page Extension for Posted Sales Invoice
pageextension 50111 "PostedSalesInvoice Ext" extends "Posted Sales Invoice"
{
    layout
    {

        addlast(content)
        {
            part("Posted Beginning Text Lines"; "Posted Beginning Text ListPart") // your custom listpart
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Beginning);
            }

            part("Posted Ending Text ListPart"; "Posted Ending Text ListPart") // your custom listpart
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Ending);
            }

        }

    }
}
