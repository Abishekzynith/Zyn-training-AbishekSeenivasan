
page 50181 "Asset History FactBox"
{
    PageType = CardPart;
    SourceTable = "Employ Table"; // Employee Table
    Caption = 'Asset History';
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(AssetSummary)
            {
                field(AssignedAssets; GetAssignedAssetCount())
                {
                    ApplicationArea = All;
                    Caption = 'Assigned History';

                    trigger OnDrillDown()
                    var
                        EmpAssetRec: Record Asset;
                        EmpAssetList: Page "Employee Asset List";
                    begin
                        EmpAssetRec.Reset();
                        EmpAssetRec.SetRange("Emp Name", Rec."Name");
                        EmpAssetRec.SetRange(Status, EmpAssetRec.Status::Assigned);

                        if EmpAssetRec.FindSet() then begin
                            EmpAssetList.SetTableView(EmpAssetRec);
                            EmpAssetList.Run();
                        end else
                            Message('No assigned assets for employee %1.', Rec."Emp Id.");
                    end;
                }

                field(ReturnedAssets; GetReturnedAssetCount())
                {
                    ApplicationArea = All;
                    Caption = 'Returned History';

                    trigger OnDrillDown()
                    var
                        EmpAssetRec: Record Asset;
                        EmpAssetList: Page "Employee Asset List";
                    begin
                        EmpAssetRec.Reset();
                        EmpAssetRec.SetRange("Emp Name", Rec."Name");
                        EmpAssetRec.SetRange(Status, EmpAssetRec.Status::Returned);

                        if EmpAssetRec.FindSet() then begin
                            EmpAssetList.SetTableView(EmpAssetRec);
                            EmpAssetList.Run();
                        end else
                            Message('No returned assets for employee %1.', Rec."Emp Id.");
                    end;
                }

                field(LostAssets; GetLostAssetCount())
                {
                    ApplicationArea = All;
                    Caption = 'Lost History';

                    trigger OnDrillDown()
                    var
                        EmpAssetRec: Record Asset;
                        EmpAssetList: Page "Employee Asset List";
                    begin
                        EmpAssetRec.Reset();
                        EmpAssetRec.SetRange("Emp Name", Rec."Name");
                        EmpAssetRec.SetRange(Status, EmpAssetRec.Status::Lost);

                        if EmpAssetRec.FindSet() then begin
                            EmpAssetList.SetTableView(EmpAssetRec);
                            EmpAssetList.Run();
                        end else
                            Message('No lost assets for employee %1.', Rec."Emp Id.");
                    end;
                }
            }
        }
    }

    // ---- Helper Functions ----
    local procedure GetAssignedAssetCount(): Integer
    var
        EmpAssetRec: Record Asset;
    begin
        EmpAssetRec.Reset();
        EmpAssetRec.SetRange("Emp Name", Rec."Name");
        EmpAssetRec.SetRange(Status, EmpAssetRec.Status::Assigned);
        exit(EmpAssetRec.Count());
    end;

    local procedure GetReturnedAssetCount(): Integer
    var
        EmpAssetRec: Record Asset;
    begin
        EmpAssetRec.Reset();
        EmpAssetRec.SetRange("Emp Name", Rec."Name");
        EmpAssetRec.SetRange(Status, EmpAssetRec.Status::Returned);
        exit(EmpAssetRec.Count());
    end;

    local procedure GetLostAssetCount(): Integer
    var
        EmpAssetRec: Record Asset;
    begin
        EmpAssetRec.Reset();
        EmpAssetRec.SetRange("Emp Name", Rec."Name");
        EmpAssetRec.SetRange(Status, EmpAssetRec.Status::Lost);
        exit(EmpAssetRec.Count());
    end;
}