table 50107 "Technician Log"
{
    // DataClassification = ToBeClassified;
    fields
    {
        field(1; "Technician ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Technician Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Department"; Enum "Technician Department")
        {
            DataClassification = CustomerContent;
        }
        field(4; "Phone No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Problem count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Complaint where("Technician ID" = field("Technician ID")));
        }
    }
    keys

    {
        key(PK; "Technician ID") { clustered = true; }
    }

}