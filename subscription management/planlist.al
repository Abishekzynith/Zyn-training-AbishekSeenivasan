

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
