



page 50277 "Leave Cat card"
{
    Caption = 'Leave Category Card';
    PageType = Card;
    SourceTable = "leave Category";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;
 
    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; Rec."category name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec."Leave Description")
                {
                    ApplicationArea = All;
                }
               
                field("Max Leave Days"; Rec."NO.of days allowed")
                {
                    ApplicationArea = All;
            }
        }
    }
 
   
        // No additional variables needed for this page
}
}
 
page 50276 "Leave Cat List page"
{
    Caption = 'Leave Category List';
    PageType = List;
    SourceTable = "leave Category";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CardPageId =  "Leave Cat card";
 
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."category name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec."Leave Description")
                {
                    ApplicationArea = All;
                }
               
                field("Max Leave Days"; Rec."NO.of days allowed")
                {
                    ApplicationArea = All;
            }
        }
    }
 
   
        // No additional variables needed for this page
}
}
 
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
 
   
        // No additional variables needed for this page
}
}
 
page 50374 "Employee List page"
{
    Caption = 'Emp List';
    PageType = List;
    SourceTable = "Employ Table";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CardPageId =  "Employee Card page";
 
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."Emp Id.")
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
     area(factboxes)
        {
            part(AssetHistory; "Asset History FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Emp Id." = FIELD("Emp Id."); // Link employee to factbox
            }
        }
 
   
        // No additional variables needed for this page
}
}
page 50279 "Leave Req List page"
{
    Caption = 'Leave Request List';
    PageType = List;
    SourceTable = "Leave Request";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Leave Req Card page";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No."; Rec."Request No.") { ApplicationArea = All; }
                field("Emp Id."; Rec."Emp Id.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field(Category; Rec.Category) { ApplicationArea = All; }
                field("From Date"; Rec."From Date") { ApplicationArea = All; }
                field("To Date"; Rec."To Date") { ApplicationArea = All; }
                field("No.of days"; Rec."No.of days") { ApplicationArea = All; }
                field(Status; Rec.Status) { ApplicationArea = All; }
            }
        }

        area(factboxes)
        {
            part(AssetHistory; "Asset History FactBox")
            {
                SubPageLink = "Emp Id." = field(Name);
            }
        }
    }

    actions
    {
        // your actions unchanged
    }
}


 
page 50280 "Leave Req Card Page"
{
    Caption = 'Leave Request Card';
    PageType = Card;
    SourceTable = "Leave Request";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = All;
                }
                field("Emp Id."; Rec."Emp Id.")
                {
                    ApplicationArea = All;
                    TableRelation = "Employ Table"."Emp Id.";
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                field("No.of days"; Rec."No.of days")
                {
                    ApplicationArea = All;
                    Editable = false; // system-calculated
                }
                field("Remaining Days"; Rec."Remaining Days")
                {
                    ApplicationArea = All;
                    Editable = false; // system-calculated
                }
                // ❌ Removed Status field from UI
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ApproveLeave)
            {
                Caption = 'Approve Leave';
                Image = Approve;
                ApplicationArea = All;

                trigger OnAction()
                var
                    LeaveMgt: Codeunit "Leave Management";
                begin
                    LeaveMgt.ApproveLeaveRequest(Rec);
                    Message('Leave Request %1 has been approved and logged.', Rec."Request No.");
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status := Rec.Status::Pending; // ✅ Set default status
    end;
}

 
 
 

page 50178 "My Notification Part"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "leave request"; // any lightweight table

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(UserID; UserId())
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage();
    var
        NotificationMgt: Codeunit "My Notification Mgt.";
    begin
        NotificationMgt.ShowLeaveBalanceNotification();
          NotificationMgt.ShowrejectedNotification();
            NotificationMgt.ShowpendingNotification();
    end;
}

