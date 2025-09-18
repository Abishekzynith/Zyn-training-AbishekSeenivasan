table 50180 Asset
{
    DataClassification = ToBeClassified;

    fields
    {
        field(7; "Status"; Enum Status)
        {
            DataClassification = ToBeClassified;
        }
        field(1; "ID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(12; "Emp ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employ Table";
        }
        field(2; "Asset Type"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Asset Type";
        }
        field(3; "Serial No"; Text[50])
        {
             DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            var
                AssetRec: Record Asset;
            begin
                // Check for duplicate Serial No
                if "Serial No" <> '' then begin
                    AssetRec.Reset();
                    AssetRec.SetRange("Serial No", "Serial No");
                    if AssetRec.FindFirst() then begin
                        // If duplicate serial found, check procured date
                        if "Procured Date" <> 0D then begin
                            if "Procured Date" <= CalcDate('<-5Y>', Today) then
                                "Active" := false
                            else
                                "Active" := true;
                        end else
                            "Active" := false;
                    end;
                end;
            end;
        }
        field(4; "Procured Date"; Date)
        {
           DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                AssetRec: Record Asset;
            begin
                if "Procured Date" <> 0D then begin
                    // Default 5-year rule
                    if "Procured Date" <= CalcDate('<-5Y>', Today) then
                        "Active" := false
                    else
                        "Active" := true;

                    // Also check duplicate Serial No again when date changes
                    if "Serial No" <> '' then begin
                        AssetRec.Reset();
                        AssetRec.SetRange("Serial No", "Serial No");
                        if AssetRec.FindFirst() and (AssetRec."ID" <> "ID") then begin
                            if "Procured Date" <= CalcDate('<-5Y>', Today) then
                                "Active" := false;
                        end;
                    end;
                end else
                    "Active" := false;
            end;
        }
        field(5; "Vendor"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Active"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false; // system controlled
        }
        field(8; "Assigned Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Returned Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Lost Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Emp Name"; Text[100])
        {
            DataClassification = ToBeClassified;
              TableRelation="Employ Table"."Name";
        }
       
    }

    keys
    {
        key(PK; "ID","Serial No","Emp Name")
        {
            Clustered = true;
        }
        
        
        
      
    }
}
