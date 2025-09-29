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