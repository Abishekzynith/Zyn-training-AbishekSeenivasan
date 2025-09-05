page 50151 "Customer Cue Part"
{
    PageType = CardPart;
    SourceTable = Customer;
    ApplicationArea = All;

    layout
    {
        area(content)
        {

            cuegroup("Customer Insights")
            {

                field(CustomerCount; CustomerCount)
                {
                    ApplicationArea = All;
                    Caption = 'Customers Created Today';
                    DrillDown = true;
                    DrillDownPageId = "Customer List";
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        page.RunModal(Page::"Customer List");



                        if Customer.FindSet() then
                            repeat
                                TempCustomer.Init();

                                TempCustomer.Name := rec.Name;
                                TempCustomer.City := rec.City;
                                TempCustomer.Insert();
                            until Customer.Next() = 0;
                        PAGE.RunModal(PAGE::"Temp customer", TempCustomer);

                    end;


                }


            }
        }
    }

    var
        CustomerCount: Integer;
        CustomerRec: Record Customer;
        Customer: Record Customer;
        TempCustomer: Record Customer temporary;


    trigger OnOpenPage()
    begin

        CustomerRec.Reset();
        CustomerRec.SetRange("Created Date", Today);
        CustomerCount := CustomerRec.Count();

    end;



}
