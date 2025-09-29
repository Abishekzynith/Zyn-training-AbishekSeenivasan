table 50233 zyn_company
{
    Caption = 'Company';
    DataPerCompany = false;
    Scope = Cloud;
    ReplicateData = false;

    fields
    {
        field(1; Name; Text[30])
        {
            Caption = 'Name';
            ToolTip='company name pk not editable after creation';
            trigger OnValidate()
            begin
                if xRec.name <> ''then
                Error(nameerr);
            end;           
        }
        field(2; "Evaluation Company"; Boolean)
        {
            Caption = 'Evaluation Company';
        }
        field(3; "Display Name"; Text[250])
        {
            Caption = 'Display Name';
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
        }
        field(8005; "Business Profile Id"; Text[250])
        {
            Caption = 'Business Profile Id';
        }
       
         
        field(4; IsMaster; Boolean)
        {
            Caption = 'Is Master';
 
            trigger OnValidate()
            var
                MirrorRec: Record zyn_company;
            begin
                if IsMaster then begin
                    MirrorRec.Reset();
                    MirrorRec.SetRange(IsMaster, true);
                    if MirrorRec.FindFirst() and (MirrorRec.Name <> Rec.Name) then
                        Error(nameerr, MirrorRec.Name);
                end;
            end;
        }
        field(5; MasterName; Text[30])
        {
            Caption = 'Master Name';
 
            trigger OnValidate()
            var
                MirrorRec: Record zyn_company;
            begin
                if (MasterName <> '') then begin
                    MirrorRec.Reset();
                    MirrorRec.SetRange(Name, MasterName);
                    if not MirrorRec.FindFirst() then
                        Error(companynameerr, MasterName);
 
                    if MirrorRec.Name = Rec.Name then
                        Error(selfmastererr);
                    if IsMaster = true then
                        Error(masterselferr);
                end;
            end;
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
var
nameerr: label 'changing name is not allowed!';
mastererr: label 'Only one company can be selected as Master. "%1" is already a Master company!';
selfmastererr: label 'A company cannot be its own master.';
companynameerr:label 'no mastercompany in this name or spelling mistake!';
masterselferr:label 'This is master company, it cannot assigned master';
 }

   
