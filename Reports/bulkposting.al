report 50133 "bulker posting"{
    ProcessingOnly=true;
    Caption='Bulk posting';
    ApplicationArea=all;
    UsageCategory=ReportsAndAnalysis;
    AdditionalSearchTerms='Bulk posting';
    dataset{
        dataitem("Sales Header";"Sales Header"){
             RequestFilterFields = "Document Type";
             
            trigger OnAfterGetRecord()
            var
            salesposting:Codeunit "Sales-Post";
            begin
                
                  salesposting.run("Sales Header");
                    postedCount +=1;


            end;

        }
    }
 

   var
   postedcount:integer;
  
   trigger OnPostReport()
   begin
    if postedcount > 0 then
    Message('bulk posting invoice changed as %1 records',postedcount)
    else
    Message('no records were changed');
   end;
}