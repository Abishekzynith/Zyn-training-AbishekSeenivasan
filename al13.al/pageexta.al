pageextension 50109 SalesInvoiceCardExt extends "Sales Invoice"
{
    layout
    {
        addafter(General)
        {
            group("Invoice Texts")
            {
                Caption = 'Invoice Texts';
                field("Beginning Text"; Rec."Beginning Text")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Extended Text Handler";
                        Type: Enum "Sales Invoice Text";

                    begin
                        Type := Type::Beginning;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec, Rec."Beginning Text", Type)
                    end;

                }
                field("Ending Text"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Extended Text Handler";
                        Type: Enum "Sales Invoice Text";
                    begin
                        Type := Type::Ending;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec, Rec."Ending Text", Type);
                    end;

                }
            }
        }

        addafter("Invoice Texts")
        {
            part("Beginning ListPart"; "Description ListPart")
            {
                ApplicationArea = All;
                Caption = 'Beginning';
                SubPageLink = "Document No." = field("No."), Type = const(Beginning);
            }
            part("Ending ListPart"; "Ending Text ListPart")
            {
                ApplicationArea = All;
                Caption = 'Ending';
                SubPageLink = "Document No." = field("No."), Type = const(Ending);
            }
            part("last sold price"; "last sold price")
            {
                ApplicationArea = All;
                Caption = 'Last Sold Price';
                SubPageLink = "item no." = field("No."), "Customer no." = field("Sell-to Customer No."), "posting date" = field("Posting Date");
            }

        }

    }
}

// Page Extension for Posted Sales Invoice
pageextension 50111 "PostedSalesInvoice Ext" extends "Posted Sales Invoice"
{
    layout
    {

        addlast(content)
        {
            part("Posted Beginning Text Lines"; "Posted Beginning Text ListPart") // your custom listpart
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Beginning);
            }

            part("Posted Ending Text ListPart"; "Posted Ending Text ListPart") // your custom listpart
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Ending);
            }

        }

    }
}


// Page Extension for Posted Sales Invoice
pageextension 50112 "SalesCreditMemoExt" extends "Sales Credit Memo"
{
    layout
    {
        addafter(General)
        {
            group("Credit Memo Texts")
            {
                field("Beginning Text"; Rec."Beginning Text") // Add field in table extension too
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Extended Text Handler";
                        Type: Enum "Sales Invoice Text";
                    begin
                        Type := Type::Beginning;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec, Rec."Beginning Text", Type);
                    end;
                }
                field("Ending Text"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Extended Text Handler";
                        Type: Enum "Sales Invoice Text";
                    begin
                        Type := Type::Ending;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec, Rec."Ending Text", Type);
                    end;
                }
            }
        }
        addafter("Credit Memo Texts")
        {
            part("Beginning Text Lines"; "Beginning Text Credit Memo") // your custom listpart
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Beginning);
            }

            part("Ending Text ListPart"; "Ending Text Credit Memo") // your custom listpart
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Ending);
            }

        }

    }
}

// Page Extension for Posted Sales Invoice
pageextension 50119 "PostedSalesCrMemoExt" extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter(General)
        {
            group("Cr.Memo Texts")
            {
                field("Beginning Text"; Rec."Beginning Text") // Add field in table extension too
                {
                    ApplicationArea = All;

                    Editable = false;
                }
                field("Ending Text"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        addafter("Cr.Memo Texts")
        {
            part("Posted Beginning Cr.Memo "; "Posted Begin Cr.Memo ListPart") // your custom listpart
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Beginning);
            }

            part("Posted Ending Cr.Memo "; "Posted End Cr.Memo ListPart") // your custom listpart
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), Type = const(Ending);
            }

        }

    }
}


pageextension 50108 SalesOrdCardExt extends "Sales Order"
{
    layout
    {
        addafter(General)
        {
            group("Order Text")
            {
                Caption = 'Order Texts';
                field("Beginning Text"; Rec."Beginning Text")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Extended Text Handler";
                        Type: Enum "Sales Invoice Text";
                    begin
                        Type := Type::Beginning;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec, Rec."Beginning Text", Type);
                    end;
                }
                field("Ending Text"; Rec."Ending Text")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Extended Text Handler";
                        Type: Enum "Sales Invoice Text";
                    begin
                        Type := Type::Beginning;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec, Rec."ending Text", Type);
                    end;




                }
                field("Begin"; Rec."beginning inv Text")
                {
                    ApplicationArea = all;




                }
                field("end"; Rec."ending inv Text")
                {
                    ApplicationArea = all;


                }
                field("updated price"; "lastsoldpricevar")
                {
                    ApplicationArea = All;
                    Caption = 'Last Sold Price';
                    Editable = false;
                }

            }


        }
        addafter("order Text")
        {
            part("Beginning ListPart"; "Description ListPart"
)
            {
                ApplicationArea = All;
                Caption = 'Beginning';
                SubPageLink = "Document No." = field("No."), Type = const(Beginning);
            }
            part("Ending ListPart"; "Ending Text ListPart")
            {
                ApplicationArea = All;
                Caption = 'Ending';
                SubPageLink = "Document No." = field("No."), Type = const(Ending);
            }

        }



    }

    var
        LastSoldPriceVar: Decimal;


    trigger OnAfterGetRecord()
    begin
        LastSoldPriceVar := GetLastSoldPrice(Rec."Sell-to Customer No.");

    end;


    local procedure GetLastSoldPrice(CustomerNo: Code[20]): Decimal
    var
        LastPriceFinder: Record "Last Sold Price";
        LastDate: Date;
        MaxPrice: Decimal;
    begin
        if CustomerNo = '' then
            exit(0);

        LastPriceFinder.SetRange("Customer No.", CustomerNo);
        LastPriceFinder.SetCurrentKey("Customer No.", "Posting Date");
        if LastPriceFinder.FindLast() then
            LastDate := LastPriceFinder."Posting Date";

        LastPriceFinder.SetRange("Customer No.", CustomerNo);
        LastPriceFinder.SetRange("Posting Date", LastDate);
        if LastPriceFinder.FindSet() then
            repeat
                if LastPriceFinder."Item Price" > MaxPrice then
                    MaxPrice := LastPriceFinder."Item Price";
            until LastPriceFinder.Next() = 0;

        exit(MaxPrice);
    end;
}

pageextension 50107 SalesQuoteCardExt extends "Sales Quote"
{
    layout
    {
        addafter(General)
        {
            group("Quote Text")
            {
                Caption = 'Quote Texts';
                field("Beginning Text"; Rec."Beginning Text")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Extended Text Handler";
                        Type: Enum "Sales Invoice Text";

                    begin
                        Type := Type::Beginning;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec, Rec."Beginning Text", Type)
                    end;

                }
                field("Ending Text"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        SalesHeaderRec: Record "Sales Header";
                        ExtTextHandler: Codeunit "Extended Text Handler";
                        Type: Enum "Sales Invoice Text";
                    begin
                        Type := Type::Ending;
                        SalesHeaderRec := Rec;
                        ExtTextHandler.LoadExtendedTextGeneric(Rec, Rec."Ending Text", Type);
                    end;

                }
            }
        }

        addafter("Quote Text")
        {
            part("Beginning ListPart"; "Description ListPart")
            {
                ApplicationArea = All;
                Caption = 'Beginning';
                SubPageLink = "Document No." = field("No."), Type = const(Beginning);
            }
            part("Ending ListPart"; "Ending Text ListPart")
            {
                ApplicationArea = All;
                Caption = 'Ending';
                SubPageLink = "Document No." = field("No."), Type = const(Ending);
            }

        }

    }
}
