page 50191 "Employee Asset List"
{
    PageType = List;
    SourceTable = Asset;
    ApplicationArea = All;
    Caption = 'Empast';
    CardPageId = "Employee Asset Card"; // opens card when you drill down
    UsageCategory=Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                }
                field("Emp ID"; Rec."Emp Name")
                {
                    ApplicationArea = All;
                    
                }
                field("Serial No."; Rec."Serial No")
                {
                    ApplicationArea = All;
                    TableRelation="Asset Type"."Serial No";
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    
                }
                field("Assigned Date"; Rec."Assigned Date")
                {
                    ApplicationArea = All;
                }
                field("Returned Date"; Rec."Returned Date")
                {
                    ApplicationArea = All;
                }
                field("Lost Date"; Rec."Lost Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
page 50189 "Employee Asset Card"
{
    PageType = Card;
    SourceTable = Asset;
    ApplicationArea = All;
    Caption = 'Employee Asset Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false; // AutoIncrement
                }
                field("Serial No."; Rec."Serial No")
                {
                    ApplicationArea = All;
                    TableRelation = Asset."Serial No";

                    trigger OnValidate()
                    var
                        AssetRec: Record Asset;
                    begin
                        // Check if same employee already has this serial no. in active status
                        AssetRec.Reset();
                        AssetRec.SetRange("Serial No", Rec."Serial No");
                        AssetRec.SetRange("Emp Name", Rec."Emp Name");
                        AssetRec.SetFilter(Status, '%1|%2', AssetRec.Status::Assigned, AssetRec.Status::Lost);

                        if AssetRec.FindFirst() then
                            Error(
                                'Employee %1 already has Serial No. %2 assigned or marked lost.',
                                Rec."Emp Name", Rec."Serial No");
                    end;
                }

                field("Emp ID"; Rec."Emp name")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        case Rec."Status" of
                            Rec."Status"::Assigned:
                                begin
                                    if Rec."Assigned Date" = 0D then
                                        Error('Please fill the Assigned Date manually.');
                                    Rec."Returned Date" := 0D;
                                    Rec."Lost Date" := 0D;
                                end;

                            Rec."Status"::Returned:
                                begin
                                    // Auto set Assigned Date = Today if not set
                                    if Rec."Assigned Date" = 0D then
                                        Rec."Assigned Date" := Today;

                                    // Returned Date must be filled manually
                                    Rec."Lost Date" := 0D;
                                end;

                            Rec."Status"::Lost:
                                begin
                                    // Auto set Assigned Date = Today if not set
                                    if Rec."Assigned Date" = 0D then
                                        Rec."Assigned Date" := Today;

                                    // Lost Date must be filled manually
                                    Rec."Returned Date" := 0D;
                                end;

                            else
                                begin
                                    Rec."Assigned Date" := 0D;
                                    Rec."Returned Date" := 0D;
                                    Rec."Lost Date" := 0D;
                                end;
                        end;
                    end;
                }

                field("Assigned Date"; Rec."Assigned Date")
                {
                    ApplicationArea = All;
                    Editable = IsAssignedEditableVar;
                }

                field("Returned Date"; Rec."Returned Date")
                {
                    ApplicationArea = All;
                    Editable = IsReturnedEditableVar;
                }
                field("Lost Date"; Rec."Lost Date")
                {
                    ApplicationArea = All;
                    Editable = IsLostEditableVar;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetEditability();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Default Status = Assigned
        Rec."Status" := Rec."Status"::Assigned;
        SetEditability();
    end;

    local procedure SetEditability()
    begin
        IsAssignedEditableVar := (Rec."Status" = Rec."Status"::Assigned);
        IsReturnedEditableVar := (Rec."Status" = Rec."Status"::Returned);
        IsLostEditableVar := (Rec."Status" = Rec."Status"::Lost);
    end;

    var
        IsAssignedEditableVar: Boolean;
        IsReturnedEditableVar: Boolean;
        IsLostEditableVar: Boolean;
}


page 50183 "Asset Type List"
{
    Caption = 'Asset Types';
    PageType = List;
    SourceTable = "Asset Type";
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Asset Type Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                }
                field("Category"; Rec."category")
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

page 50182 "Asset Type Card"
{
    Caption = 'Asset Type';
    PageType = Card;
    SourceTable = "Asset Type";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false; // AutoIncrement ID should not be edited
                }
                field("Category"; Rec."category")
                {
                    ApplicationArea = All;
                }
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}



page 50180 "Assigned Asset List"
{
    PageType = List;
    SourceTable = Asset;
    ApplicationArea = All;
    Caption = 'Assigned Assets';
    UsageCategory=Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Name"; Rec."Emp Name") { }
                field("Asset Type"; Rec."Asset Type") { }
                field("Serial No."; Rec."Serial No") { }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Status, Rec.Status::Assigned);
    end;
}
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




page 50187 "Asset List"
{
    Caption = 'Assets';
    PageType = List;
    SourceTable = Asset;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Asset Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                }
                field("Asset Type"; Rec."Asset Type")
                {
                    ApplicationArea = All;
                }
                field("Serial No"; Rec."Serial No")
                {
                    ApplicationArea = All;
                }
                field("Procured Date"; Rec."Procured Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor"; Rec."Vendor")
                {
                    ApplicationArea = All;
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                }
            }
        }
         area(factboxes)
        {
            part(AssignedAssets; "Asset Assigned FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Emp Name" = field("Emp Name");
            }
       
        }
    }
}
page 50196 "Employee Asset History"
{
    Caption = 'Employee Asset History';
    PageType = List;
    SourceTable = Asset;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Emp Name"; Rec."Emp Name") { ApplicationArea = All; }
                field("Asset Type"; Rec."Asset Type") { ApplicationArea = All; }
                field("Serial No."; Rec."Serial No") { ApplicationArea = All; }
                field("Assigned Date"; Rec."Assigned Date") { ApplicationArea = All; }
            
            }
        }
    }
}

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

page 50194 "Assigned Asset Details"
{
    PageType = List;
    SourceTable = Asset;
    Caption = 'Assigned Assets Details';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            

            repeater(Group)
            {
                field("Emp Name"; Rec."Emp Name")
                {
                    ApplicationArea = All;
                }
                field("Asset Type"; Rec."Asset Type")
                {
                    ApplicationArea = All;
                }
                field("Serial No"; Rec."Serial No")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        AssignedCount: Integer;

    trigger OnAfterGetRecord()
    var
        AssetRec: Record Asset;
    begin
        // Filter page to show only assigned assets
        AssetRec.Reset();
        AssetRec.SetRange("Emp Name");
  

        // Count total assigned assets
       
        AssetRec.SetRange(Status, AssetRec.Status::Assigned);
        AssignedCount := AssetRec.Count();
    end;
}



page 50186 "Asset Card"
{
    Caption = 'Asset';
    PageType = Card;
    SourceTable = Asset;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false; // AutoIncrement
                }
                field("Asset Type"; Rec."Asset Type")
                {
                    ApplicationArea = All;
                }
                field("Serial No"; Rec."Serial No")
                {
                    ApplicationArea = All;
                }
                field("Procured Date"; Rec."Procured Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor"; Rec."Vendor")
                {
                    ApplicationArea = All;
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                    Editable = false; // Calculated via OnValidate
                }
            }
        }
    }
}
