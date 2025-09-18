
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