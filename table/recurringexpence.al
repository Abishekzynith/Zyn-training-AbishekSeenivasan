table 50237 "Recurring Expense"
{
 
    DataClassification = ToBeClassified;
 
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
           
        }
       
        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }

        field(4; "Recurrence Pattern"; Enum "Recurrence Pattern")
        {
            DataClassification = ToBeClassified;
              trigger OnValidate()
              begin
                if "Start Date"<> 0D then 
                "next cycle date" := getnextcycledate("Start Date","Recurrence Pattern")
              end;
     
           
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Recurrence Pattern"<>"Recurrence Pattern"::None then
                    "Next Cycle date":= getnextcycledate("Start Date","Recurrence Pattern")
            end;
           
            
        }
        field(6; "Next Cycle date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "category"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "expense category"."category name";
        }
      
        
    }
 
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

 procedure getnextcycledate(CurrentDate: Date; "Recurrence Pattern": Enum "Recurrence Pattern"): Date
         begin
         case "Recurrence Pattern" of
                        "Recurrence Pattern"::Daily:
                            exit(CalcDate('<+1D>', CurrentDate));
                        "Recurrence Pattern"::weekly:
                            exit(CalcDate('<+1W>', CurrentDate));
                        "Recurrence Pattern"::monthly:
                            exit(CalcDate('<+1M>', CurrentDate));
                        "Recurrence Pattern"::yearly:
                            exit(CalcDate('<+1Y>', CurrentDate));
        end;
         end;
}