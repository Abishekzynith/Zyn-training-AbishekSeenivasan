page 50157 "temp customer"
{
    PageType = List;
    SourceTable = Customer;
    SourceTableTemporary = true; 
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {


                field("City"; rec."city") { ApplicationArea = All; }
                field(Name; rec.Name) { ApplicationArea = All; }
            }
        }
    }
}