page 50136 cuucustlist
{
    PageType = list;
    SourceTable = customer;
    ApplicationArea = all;
    InsertAllowed = false;
    Editable = false;
    Caption = 'cuucustlist';
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(s)
            {
                repeater(group)
                {
                    field("No"; Rec."No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Name"; Rec."Name")
                    {
                        ApplicationArea = all;
                    }
                    field("pincode"; Rec."Post Code")
                    {
                        ApplicationArea = all;
                    }
                    field("city"; Rec."City")
                    {
                        ApplicationArea = all;
                    }
                    field("phonno"; Rec."Phone No.")
                    {
                        ApplicationArea = all;
                    }
                }
            }

            part("customer link"; linkingorder)
            {
                subpagelink = "sell-to customer No." = field("No.");
                SubPageView = where("Document Type" = const(order));
                ApplicationArea = all;
            }
            part("customer invoice "; linkingorder)
            {
                subpagelink = "sell-to customer No." = field("No.");
                ApplicationArea = all;
                Caption = 'invoice';
                SubPageView = where("Document Type" = const(invoice));
            }
            part("customer memo"; linkingorder)
            {
                subpagelink = "sell-to customer No." = field("No.");
                ApplicationArea = all;
                Caption = 'credit memo';
                SubPageView = where("Document Type" = const("Credit Memo"));
            }


        }
    }
}




