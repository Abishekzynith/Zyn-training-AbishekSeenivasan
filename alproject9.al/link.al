page 50145 customerlinking
{
    PageType = ListPart;
    SourceTable = "Sales Header";
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("no"; rec."No.")
                {
                    ApplicationArea = all;
                }

                field("sell-to customer No"; rec."sell-to customer No.")
                {
                    ApplicationArea = all;
                }

                field("sell-to customer name"; rec."sell-to customer Name")
                {
                    ApplicationArea = all;
                }
                field("amount"; rec."Amount")
                {
                    ApplicationArea = all;
                }

            }
        }
    }
}