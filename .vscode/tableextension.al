tableextension 50133 CustomerAuditExt extends Customer
{
    trigger OnModify()
    var
        ModifyData: Record "Modify Data";
        CurrentUser: Text;
    begin
        CurrentUser := UserId;

        if xRec.Name <> Rec.Name then begin
            ModifyData.Init();
            ModifyData."Customer No." := Rec."No.";
            ModifyData."Field Name" := 'search Name';
            ModifyData."Old Value" := xRec.Name;
            ModifyData."New Value" := Rec.Name;
            ModifyData."User ID" := CurrentUser;

            ModifyData.Insert();
        end;

        if xRec."Phone No." <> Rec."Phone No." then begin
            ModifyData.Init();
            ModifyData."Customer No." := Rec."No.";
            ModifyData."Field Name" := 'name';
            ModifyData."Old Value" := xRec."Phone No.";
            ModifyData."New Value" := Rec."Phone No.";
            ModifyData."User ID" := CurrentUser;

            ModifyData.Insert();
        end;

        // Add similar blocks for other fields you want to track
    end;
}

