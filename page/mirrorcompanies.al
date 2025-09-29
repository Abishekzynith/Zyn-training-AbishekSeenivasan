page 50254 zyn_companylist
{
    PageType = List;
    SourceTable = zyn_company;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; rec.Name)
                {
                    
                }
                field("Evaluation Company"; rec."Evaluation Company")
                {
                    
                }
                field("Display Name"; rec."Display Name")
                {
                   
                }
                field("id";rec.Id){
                    
                }
                field("Business Profile Id"; rec."Business Profile Id")
                {
                    
                }
                field("ismaster";rec.IsMaster){

                }
                field("mastercompany";rec.MasterName){

                }
            }
        }
    }
    trigger OnOpenPage();
    var
        SystemCompany: Record Company;
        MyCompanies: Record Zyn_Company;
    begin
            if MyCompanies.IsEmpty() then begin
                if SystemCompany.FindSet() then
                    repeat
                        if not MyCompanies.Get(SystemCompany.Name) then begin
                            MyCompanies.Init();
                            MyCompanies.Name := SystemCompany.Name;
                            MyCompanies."Evaluation Company" := SystemCompany."Evaluation Company";
                            MyCompanies."Display Name" := SystemCompany."Display Name";
                            MyCompanies.Id := SystemCompany.Id;
                            MyCompanies."Business Profile Id" := SystemCompany."Business Profile Id";
                            MyCompanies.Insert();
                        end;
                    until SystemCompany.Next() = 0;
            end;
    end;

}