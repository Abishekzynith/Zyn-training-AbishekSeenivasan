pageextension 50134 bulkposting extends "Sales Invoice List"
{
    actions
    {
        addlast(processing)
        {
            action(bulkpostingsalesinvoice)
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