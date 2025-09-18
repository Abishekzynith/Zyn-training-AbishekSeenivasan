pageextension 50103 "Customer Card Validate Ext" extends "Customer Card"
{
    var
        IsNewCustomer: Boolean;

    trigger OnOpenPage()
    begin
        if Rec."No." = '' then
            IsNewCustomer := true;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if IsNewCustomer and (Rec.Name = '') then begin
            Message('Please enter a customer name before closing the page.');
            exit(false);
        end;

        exit(true);
    end;

    trigger OnClosePage()
    var
        Publisher: Codeunit "my event publisher";
    begin
        if IsNewCustomer and (Rec.Name <> '') then
            Publisher.OnNewCustomerCreated(Rec);
    end;
}