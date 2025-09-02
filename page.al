page 50135 "Modify Data List"
{
    PageType = List;
    SourceTable = "Modify Data";
    ApplicationArea = All;
    Caption = 'Modified Fields History';
    editable = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; rec."Entry No.") { ApplicationArea = All; }
                field("Customer No."; rec."Customer No.") { ApplicationArea = All; }
                field("Field Name"; rec."Field Name") { ApplicationArea = All; }
                field("Old Value"; rec."Old Value") { ApplicationArea = All; }
                field("New Value"; rec."New Value") { ApplicationArea = All; }
                field("User ID"; rec."User ID") { ApplicationArea = All; }


            }

        }
    }
}

PAGE 50139 improvePage
{

    layout
    {


        area(Content)
        {


            field(TableName; TableName)
            {
                Caption = 'TableName';
                ApplicationArea = All;
                TableRelation = "AllObjWithCaption"."Object ID" where("Object Type" = const(Table));

                // DrillDown = True;

                // trigger OnDrillDown()
                // begin

                // end;
            }

            field(FieldName; FieldName)
            {
                Caption = 'FieldName';
                ApplicationArea = All;
                DrillDown = True;
                // TableRelation = Field.TableName where (TableName = const(Database::Field));
                Trigger OnDrillDown()
                var
                    RecRef: RecordRef;
                    FieldRef: FieldRef;
                    TempBuffer: Record "Field Lookup Buffer" temporary;
                    i: Integer;
                    FN: Text[250];
                begin
                    if TableName = 0 then
                        Error('Please select a table first.');

                    RecRef.Open(TableName);
                    FieldRef := RecRef.field(TableID);

                    for i := 1 to RecRef.FieldCount do begin
                        FieldRef := RecRef.FieldIndex(i);
                        TempBuffer.Init();
                        TempBuffer."ID" := FieldRef.Number;
                        FN := FieldRef.Name;
                        TempBuffer."Field Name" := FN;
                        TempBuffer.Insert();
                    end;

                    RecRef.Close();

                    if Page.RunModal(Page::"Field Lookup Buffer Page", TempBuffer, selectedcust) = Action::LookupOK then begin
                        FieldID := TempBuffer."ID";
                        FieldName := TempBuffer."Field Name";
                    end;
                end;

            }
            field(RecordSecltion; RecordSecltion)
            {
                Caption = 'RecordSecltion';
                ApplicationArea = All;
                trigger OnDrillDown()
                var
                    RecRef: RecordRef;
                    FieldRef: FieldRef;
                    TempValueBuffer: Record "Field Lookup Buffer" temporary;
                    LineNo: Integer;
                begin
                    if (TableName = 0) OR (fieldid = 0) then
                        Error('Please select a table and field first.');

                    RecRef.Open(TableName);
                    FieldRef := RecRef.Field(fieldid);

                    LineNo := 0;
                    repeat
                        LineNo += 1;
                        TempValueBuffer.Init();
                        TempValueBuffer."ID" := LineNo;
                        TempValueBuffer."Field Name" := Format(FieldRef.Value);
                        TempValueBuffer.RecordId := recref.RecordId;
                        TempValueBuffer.Insert();
                    until RecRef.Next() = 0;

                    RecRef.Close();

                    if Page.RunModal(Page::"Field Lookup Buffer Page", TempValueBuffer, selectedcust) = Action::LookupOK then begin
                        RecRef.Open(TableName);
                        "Record ID" := TempValueBuffer."ID";
                        RecordSecltion := TempValueBuffer."Field Name";
                        valueID := TempValueBuffer.RecordId;
                        RecRef.Close();

                    end;
                end;
            }

            field(Value_To_Enter; Value_To_Enter)
            {
                Caption = 'Value';
                ApplicationArea = All;
                trigger OnValidate()
                var
                    RecRef: RecordRef;
                    FieldRef: FieldRef;
                begin
                    RecRef.Open(TableName);

                    if not RecRef.Get(valueID) then
                        Error('error message');

                    FieldRef := RecRef.Field(FieldID);
                    FieldRef.Value := Value_To_Enter;
                    RecRef.Modify();

                    Message('Value updated successfully.');
                    RecRef.Close();
                end;

            }

        }


    }
    var
        TableName: Integer;
        FieldName: Text[250];
        RecordSecltion: Text[250];
        Value_To_Enter: Text[250];
        TableID: Integer;
        FieldID: Integer;
        Object: Integer;
        selectedcust: Integer;

        "Record ID": Integer;
        valueID: RecordId;
}





// procedure ListFieldsFromTable(TableID: Integer)
// var
//     RecRef: RecordRef;
//     FieldRef: FieldRef;
//     i: Integer;
//     MsgText: Text;
// begin
//     RecRef.Open(TableID); // Open the table dynamically using Table ID

//     for i := 1 to RecRef.FieldCount do begin
//         FieldRef := RecRef.FieldIndex(i);
//     end;
//     FieldRef := RecRef.FieldIndex(i);


//     RecRef.Close;
// end;

page 50132 "Field Lookup Buffer Page"
{
    PageType = List;
    SourceTable = "Field Lookup Buffer";
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = None;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("FieldName"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    Caption = 'Field Name';
                }
                field("FieldId"; rec."ID")
                {
                    ApplicationArea = all;
                    Caption = 'field id';
                }
            }
        }
    }
}