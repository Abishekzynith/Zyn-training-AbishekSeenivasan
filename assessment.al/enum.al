enum 50185 AssetCategory
{
    Extensible = true;
    Caption = 'Asset Category';

    value(0; Furniture)
    {
        Caption = 'Furniture';
    }
    value(1; Electronics)
    {
        Caption = 'Electronics';
    }
    value(2; Vehicles)
    {
        Caption = 'Vehicles';
    }
    value(3; Buildings)
    {
        Caption = 'Buildings';
    }
    value(4; Other)
    {
        Caption = 'Other';
    }
}
enum 50184 Status
{
    Extensible = true;
    Caption = 'Asset Status';

    value(0; Assigned)
    {
        Caption = 'Assigned';
    }
    value(1; Returned)
    {
        Caption = 'Returned';
    }
    value(2; Lost)
    {
        Caption = 'Lost';
    }
}