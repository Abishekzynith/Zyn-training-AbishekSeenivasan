page 50199 "Today Customer List"
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = Customer;
    Caption = 'Customers';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Created Date"; rec."Created Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CurrPage.SetSelectionFilter(Customer);
        Customer.SetRange("Created Date", Today);
    end;

    var
        Customer: Record Customer;
}
