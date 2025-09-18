
page 50192 "Asset Assigned FactBox"
{
    PageType = CardPart;
    SourceTable = Asset;
    Caption = 'Asset Summary';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(Assets)
            {
                field("Assigned Assets"; AssignedAssetsCount)
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        AssetRec: Record Asset;
                    begin
                        AssetRec.Reset();
                        AssetRec.SetRange(Status, AssetRec.Status::Assigned);                  
                        PAGE.Run(PAGE::"Asset List", AssetRec);
                    end;
                }
            }
        }
    }

    var
        AssignedAssetsCount: Integer;

    trigger OnAfterGetCurrRecord()
    begin
        CalcAssignedAssets();
    end;

    local procedure CalcAssignedAssets()
    var
        AssetRec: Record Asset;
    begin
        AssetRec.Reset();
        AssetRec.SetRange(Status, AssetRec.Status::Assigned);
        AssignedAssetsCount := AssetRec.Count();
    end;
}

