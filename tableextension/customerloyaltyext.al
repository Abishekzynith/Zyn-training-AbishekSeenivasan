tableextension 50146 CustomerLoyaltyExt extends Customer


{

    fields
    {
        field(50134; "Loyalty Points"; Integer)
        {
            Caption = 'Loyalty Points';
            DataClassification = CustomerContent;

        }
        field(50102; "Sales Year"; Date)
        {
            Caption = 'Sales Year';
            FieldClass = FlowFilter;

        }
        field(50143; "Loyalty Point used"; Integer)
        {

            DataClassification = CustomerContent;
            Caption = 'Loyalty Point used';
            Editable = false;
        }
    }
}