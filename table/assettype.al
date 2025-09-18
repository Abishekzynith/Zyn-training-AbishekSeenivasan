table 50100 "Asset Type"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
         field(7; "category"; Enum AssetCategory)
    {
        DataClassification = ToBeClassified;
    }
        field(2; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    field(4; "Serial No"; Text[50])
    {
        DataClassification = ToBeClassified;
    }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
        key(Name; "Name")
        {
            Unique = true;
        }
    }
}

