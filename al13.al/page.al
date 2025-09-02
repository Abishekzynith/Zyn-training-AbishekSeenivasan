page 50119 "Description ListPart"
{
    PageType = ListPart;
    SourceTable = "ExtendedTextTable";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field("Text"; rec."Text")
                {
                    ApplicationArea = All;
                    Caption = 'Text';
                }
            }
        }
    }
}


page 50120 "Ending Text ListPart"
{
    PageType = ListPart;
    SourceTable = "ExtendedTextTable";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field("Text"; rec."Text")
                {
                    ApplicationArea = All;
                    Caption = 'Text';
                }

            }
        }
    }
}
page 50125 "last sold price"
{
    PageType = ListPart;
    SourceTable = "last sold price";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Last Sold Price';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("item no."; rec."item no.")
                {
                    ApplicationArea = All;
                    Caption = 'Item No.';
                }
                field("Customer no."; rec."Customer no.")
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                }
                field("item price"; rec."item price")
                {
                    ApplicationArea = All;
                    Caption = 'Item Price';
                }
                field("posting date"; rec."posting date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                }
              
            }
        }
    }
}
page 50122 "Begining inv ListPart"
{
    PageType = ListPart;
    SourceTable = "ExtendedTextTable";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field("Text"; rec."Text")
                {
                    ApplicationArea = All;
                    Caption = 'Text';
                }
            }
        }
    }
}

page 50121 "Ending inv List"
{
    PageType = ListPart;
    SourceTable = "ExtendedTextTable";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field("Text"; rec."Text")
                {
                    ApplicationArea = All;
                    Caption = 'Text';
                }
            }
        }
    }
}



page 50115 "Beginning Text Credit Memo"
{
    PageType = ListPart;
    SourceTable = ExtendedTextTable;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field(Text; rec."Text")
                {
                    ApplicationArea = All;
                    Caption = 'Text';
                }

            }
        }
    }
}



page 50117 "Ending Text Credit Memo"
{
    PageType = ListPart;
    SourceTable = ExtendedTextTable;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field(Text; rec."Text")
                {
                    ApplicationArea = All;
                    Caption = 'Text';
                }

            }
        }
    }
}



page 50113 "Posted Beginning Text ListPart"
{
    PageType = ListPart;
    SourceTable = ExtendedTextTable;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field(Text; rec."Text")
                {
                    ApplicationArea = All;
                    Caption = 'Text';
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type';
                }

            }
        }
    }
}



page 50114 "Posted Ending Text ListPart"
{
    PageType = ListPart;
    SourceTable = ExtendedTextTable;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field(Text; rec."Text")
                {
                    ApplicationArea = All;
                    Caption = 'Text';
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type';
                }

            }
        }
    }
}



page 50127 "Posted Begin Cr.Memo ListPart"
{
    PageType = ListPart;
    SourceTable = ExtendedTextTable;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field(Text; rec."Text")
                {
                    ApplicationArea = All;
                    Caption = 'Text';
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type';
                }

            }
        }
    }
}


page 50118 "Posted End Cr.Memo ListPart"
{
    PageType = ListPart;
    SourceTable = ExtendedTextTable;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Caption = 'Line No.';
                }
                field(Text; rec."Text")
                {
                    ApplicationArea = All;
                    Caption = 'Text';
                }
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type';
                }

            }
        }
    }
}
