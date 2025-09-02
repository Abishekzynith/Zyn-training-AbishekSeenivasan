tableextension 50135 CustomerExt extends Customer
{
    fields
    {
        field(50103; "Open Orders"; Integer)
        {
            Caption = 'Open Orders';
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where(
                "Sell-to Customer No." = field("No."),
                "Document Type" = const(Order),
                Status = const(Open)
            ));
        }

        field(50101; "Open Invoices"; Integer)
        {
            Caption = 'Open Invoices';
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where(
                "Sell-to Customer No." = field("No."),
                "Document Type" = const(Invoice),
                Status = const(Open)
            ));
        }
    }
}
