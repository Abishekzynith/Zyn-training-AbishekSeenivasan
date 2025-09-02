

pageextension 50137 PurchaseOrderPageExt extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("Approval Status"; Rec."Approval Status")
            {
                Caption = 'Approval satus';
                ApplicationArea = All;
            }
        }

    }
}
pageextension 50136 CustomerListExt extends "Customer List"
{
    actions
    {
        addlast(Processing)
        {
            action("View Modifications")
            {
                Caption = 'View Modifications';
                ApplicationArea = All;
                Image = View;
                RunObject = page "Modify Data List";
                RunPageLink = "Customer No." = field("No.");

            }
        }
    }
}

pageextension 50122 CompaniesListExt extends Companies
{
    actions
    {
        addlast(processing)
        {
            action(CompanyAction)
            {
                ApplicationArea = All;
                Caption = 'Update Field';
                Image = Edit;
                RunObject = page "improvepage";
            }
        }

    }
}