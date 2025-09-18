page 50130 "expence Claim List"
{
    PageType = List;
    SourceTable = expenseClaim;
    Caption = 'Claim List';
    ApplicationArea = All;
    CardPageId="expense Claim Card";
    UsageCategory = Lists;
    

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID";rec. "ID") { ApplicationArea = All; }
                field("Emp ID"; rec."Emp ID") { ApplicationArea = All; }
                field("Bill"; rec."Bill") { ApplicationArea = All; }
                field("Claim Date"; rec."Claim Date") { ApplicationArea = All; }
                field("Amount"; rec."Amount") { ApplicationArea = All; }
                field("Status"; rec.expenceStatus) { ApplicationArea = All; }
                field("Category"; rec."Category") { ApplicationArea = All; }
                field("BillDate"; rec."BillDate") { ApplicationArea = All; }
                
            }
        }
    }

   
}
