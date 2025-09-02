report 50134 "posted sales invoice report"
{
    Caption = 'rdlc report';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;

    RDLCLayout = 'Reports/PostedSalesInvoiceReport.rdlc';


    dataset
    {

        dataitem("Company Information"; "Company Information")
        {
            column(CompanyName; Name) { }
            column(Address; Address) { }
            column(City; City) { }
            column(Phone_No_; "Phone No.") { }
            column(image; picture) { }

            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
                column(Posting_Date; "Posting Date") { }
                column(Document_Date; "Document Date") { }
                column(Beginning_inv_Text; "Beginning Text") { }
                column(Ending_inv_Text; "Ending Text") { }

                dataitem("Sales Invoice Line"; "Sales Invoice Line")

                {
                    DataItemLink = "Document No." = FIELD("No.");
                    column(item_No; "No.") { }

                    column(Description; Description) { }

                    column(Quantity; "Quantity") { }

                    column(Amount; "Amount") { }

                }
                dataitem("Cust. Ledger Entry";"Cust. Ledger Entry"){
                    DataItemLink="customer No."=field("sell-to customer no."),"document No."=field("no.");
                    column(Entry_No_;"Entry No."){}
                    column(Descriptions;Description){}
                    column(Amounts;Amount){}
                    column(Remaining_Amount;"Remaining Amount"){}

                }

                dataitem(BeginTextLine; ExtendedTextTable)
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Line No.")
                    WHERE("Document Type" = CONST("Posted Invoice"),
                          "Type" = CONST(Beginning));

                    column(BeginLineNo; "Line No.") { }
                    column(BeginText; Text) { }
                }
                dataitem(EndTextLine; ExtendedTextTable)
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Line No.")
                    WHERE("Document Type" = CONST("Posted Invoice"),
                          "Type" = CONST(Ending));
                    column(EndLineNo; "Line No.") { }
                    column(EndText; Text) { }
                }
            }


        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(filtergroup)
                {
                    field("Customer No."; "Sales Invoice Header"."Sell-to Customer No.")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }


}
