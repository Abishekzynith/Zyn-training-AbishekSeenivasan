report 50132 "posted transfer"{
    ProcessingOnly=true;
    Caption='posting date';
    ApplicationArea=all;
    UsageCategory=ReportsAndAnalysis;
    AdditionalSearchTerms='posting date';
    dataset{
        dataitem("Sales Header";"Sales Header"){
            DataItemTableView=where(Status=const(open),"Document Type"=const(order));
            trigger OnAfterGetRecord()
            begin
                if "Sales Header"."Posting Date" <> NewPostingDate then begin
                    "Sales Header"."Posting Date":= NewPostingDate;
                    "Sales Header".Modify(true);
                    UpdatedCount +=1;


                end;
            end;

        }
    }
   requestpage{
    layout{
        area(Content){
            group(group1){
                field("New Posting Date"; NewPostingDate){
                    ApplicationArea=all;
                    caption='New Posting Date';

                }
            }
        }
    }
   }
   trigger OnInitReport()
   begin
    clear(UpdatedCount);
   end;
   var
   updatedcount:integer;
   NewPostingDate:Date;
   trigger OnPostReport()
   begin
    if updatedcount > 0 then
    Message('posting dates changed for %1 records',updatedcount)
    else
    Message('no records were changed');
   end;
}