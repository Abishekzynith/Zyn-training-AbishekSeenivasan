page 50275 "Employee Card page"
{
    Caption = 'Employee Card';
    PageType = Card;
    SourceTable = "Employ Table";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Emp Id"; Rec."Emp Id.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }

                field(role; Rec.role)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}