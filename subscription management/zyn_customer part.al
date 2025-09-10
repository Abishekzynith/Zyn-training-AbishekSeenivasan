pageextension 50190 MyExtension extends "Customer List"
{
    
    layout
    {
        addlast(factboxes)
        {
         
            part(ContactFactBox; "Customer Contact FactBox")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
            part(CustomerSubscriptions; "Customer Subscription FactBox")
            {
                ApplicationArea = All;
                SubPageLink = CustomerID= FIELD("No."); 
            }
            
        }
        
    }
    // trigger OnOpenPage();
    // begin
    //     report.Run(Report::"Sales Invoice RDLC");
    // end;
}
