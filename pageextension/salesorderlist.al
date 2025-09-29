
pageextension 50104 SalesOrderListExt extends "Sales Order List"
{
    actions
    {
        addafter("Test Report")
        {

            action(BulkPostOrders)
            {
                ApplicationArea = all;
                Caption = 'bulk post sales invoice';
                image = Post;
                trigger OnAction()
                var
                    reportselect: report "bulker posting";

                begin
                    report.RunModal(Report::"bulker posting", true, true);

                end;
            }

        }
    }
}