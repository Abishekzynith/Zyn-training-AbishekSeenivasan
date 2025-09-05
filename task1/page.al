page 50200 "Customer Subscription FactBox"
{
    PageType = ListPart;
    SourceTable = Subscription; 
    Caption = 'Customer Subscriptions';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SubID;Rec.SubID)
                {
                    ApplicationArea = All;
                }
                field(StartDate;Rec.StartDate)
                {
                    ApplicationArea = All;
                }
                field(EndDate;Rec.EndDate)
                {
                    ApplicationArea = All;
                }
                field(Status;Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
page 50210 PlanCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Plans;

    layout
    {
        area(Content)
        {
            group(PlanCard)
            {
                field(PlanID;Rec.PlanID) 
                { 
                    ApplicationArea = All; 
                }
                field(Name;Rec.Name) 
                { 
                    ApplicationArea = All; 
                }
                field(Fee;Rec.Fee) 
                { 
                    ApplicationArea = All; 
                }
                field(Status;Rec.Status) 
                { 
                    ApplicationArea = All; 
                }
            }
        }
    }
}

page 50208 PlanList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Plans;
    CardPageId = 50210;
  
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(PlanList)
            {
                field(PlanID;Rec.PlanID) { ApplicationArea = All; }
                field(Name;Rec.Name) { ApplicationArea = All; }
                field(Fee;Rec.Fee){ApplicationArea=All;}
                field(Status;Rec.Status){ApplicationArea=All;}
            }
        }
    }
}

page 50213 "Zyn Subscription Cue Card"
{
    PageType = CardPart;
    ApplicationArea = All;
    Caption = 'Subscription Dashboard';

    layout
    {
        area(content)
        {
            cuegroup(Subscriptions)
            {
                Caption = 'Subscript';

                field("Active Subscriptions"; ActiveSubs)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SubRec: Record Subscription;
                    begin
                        SubRec.SetRange(Status, SubRec.Status::Active);
                        Page.Run(Page::"SubscriptionList", SubRec);
                    end;
                }

                field("Subscription Revenue This Month"; RevenueThisMonth)
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        SalesHdr: Record "Sales Header";
                        StartDate: Date;
                        EndDate: Date;
                    begin
                        StartDate := DMY2Date(1, Date2DMY(WorkDate(), 2), Date2DMY(WorkDate(), 3));
                        EndDate := WorkDate();

                        SalesHdr.SetRange("Document Type", SalesHdr."Document Type"::Invoice);
                        SalesHdr.SetRange("Document Date", StartDate, EndDate);
                        SalesHdr.SetFilter("Subscription ID", '<>%1', ''); 

                        Page.Run(Page::"Sales Invoice List", SalesHdr);
                    end;
                }
            }
        }
    }

    var
        ActiveSubs: Integer;
        RevenueThisMonth: Decimal;

    trigger OnOpenPage()
    var
        SubRec: Record Subscription;
        SalesHdr: Record "Sales Header";
        StartDate: Date;
        EndDate: Date;
        totalamnt:Decimal;
    begin
        SubRec.SetRange(Status, SubRec.Status::Active);
        ActiveSubs := SubRec.Count();

        StartDate := DMY2Date(1, Date2DMY(WorkDate(), 2), Date2DMY(WorkDate(), 3));
        EndDate := WorkDate();

        SalesHdr.SetRange("Document Type", SalesHdr."Document Type"::Invoice);
        SalesHdr.SetRange("Document Date", StartDate, EndDate);
        SalesHdr.SetFilter("Subscription ID", '<>%1', '');
        totalamnt:=0;
        if SalesHdr.FindSet() then begin
            SalesHdr.CalcFields(Amount);
            repeat

             totalamnt+=SalesHdr.Amount;
            until SalesHdr.Next()=0
        end;

        

        RevenueThisMonth := totalamnt;
    end;
}
page 50212 SubscriptionCard
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = Subscription;

    layout
    {
        area(Content)
        {
            group(SubscriptionCard)
            {
                field(SubID;Rec.SubID) 
                { 
                    ApplicationArea = All; 
                }
                field(CustomerID;Rec.CustomerID) 
                { 
                    ApplicationArea = All; 
                }
                field(PlanID;Rec.PlanID) 
                { 
                    ApplicationArea = All; 
                }
                field(StartDate;Rec.StartDate) 
                { 
                    ApplicationArea = All; 
                }
                field(Duration;Rec.Duration){ApplicationArea=All;}
                field(EndDate;Rec.EndDate){ApplicationArea=All;}
                field(Status;Rec.Status){ApplicationArea=All;}
                field(NextBilling;Rec.NextBilling){ApplicationArea=All;}
            }
        }
    }
}
page 50211 SubscriptionList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Subscription;
    CardPageId = 50212;
    caption= 'cussub';
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(SubscriptionList)
            {
                field(SubID;Rec.SubID) { ApplicationArea = All; }
                field(CustomerID;Rec.CustomerID) { ApplicationArea = All; }
                field(PlanID;Rec.PlanID){ApplicationArea=All;}
                field(StartDate;Rec.StartDate){ApplicationArea=All;}
                field(Duration;Rec.Duration){ApplicationArea=All;}
                field(EndDate;Rec.EndDate){ApplicationArea=All;}
                field(Status;Rec.Status){ApplicationArea=All;}
                field(NextBilling;Rec.NextBilling){ApplicationArea=All;}
            }
        }
    }
}
