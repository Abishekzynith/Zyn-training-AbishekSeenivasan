page 50150 "MyRoleCenter"
{
    ApplicationArea = All;
    Caption = 'Role Center Page';
    PageType = RoleCenter;
    UsageCategory = Administration;

    layout
    {
        area(rolecenter)
        {
             part(SubscriptionCue; "Zyn Subscription Cue Card")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(PlanSubscription)
            {
                Caption = 'Plan ~ Subscription';
                action(Plans)
                {
                    Caption = 'Plans';
                    ApplicationArea = All;
                    RunObject = page "PlanList";
                }
                action(Subscription)
                {
                    Caption = 'Subscription';
                    ApplicationArea = All;
                    RunObject = page "SubscriptionList";
                }
            }

            group(MyNavigations)
            {
                Caption = 'My Navigations';
                action(Customers)
                {
                    ApplicationArea = All;
                    Caption = 'Customer List';
                    Image = Customer;
                    RunObject = page "Customer List";
                }
            }

            group(Assets)
            {
                Caption = 'Assets';

                action(AssetTypeList)
                {
                    Caption = 'Asset Type List';
                    ApplicationArea = All;
                    RunObject = page "Asset Type List";
                }

                action(AssetList)
                {
                    Caption = 'Asset List';
                    ApplicationArea = All;
                    RunObject = page "Asset List";
                }

                action(EmployeeList)
                {
                    Caption = 'Employee List';
                    ApplicationArea = All;
                    RunObject = page "Employee List"; // removed "page" suffix
                }

                action(EmployeeAssets)
                {
                    Caption = 'Employee Assets';
                    ApplicationArea = All;
                    RunObject = page "Employee Asset List";
                }
            }

            group(LeaveManagement)
            {
                Caption = 'Leave Management';

                action(LeaveCategory)
                {
                    Caption = 'Leave Category';
                    ApplicationArea = All;
                    RunObject = page "Leave Cat List Page"; // remove "page" suffix if not in object name
                }

                action(LeaveRequest)
                {
                    Caption = 'Leave Request';
                    ApplicationArea = All;
                    RunObject = page "Leave Req List Page";
                }
            }

            group(Expenses)
            {
                Caption = 'Expenses';

                action(ExpenseCategory)
                {
                    Caption = 'Expense Category';
                    ApplicationArea = All;
                    RunObject = page "Expense Category List Page";
                }

                action(ExpenseList)
                {
                    Caption = 'Expense List';
                    ApplicationArea = All;
                    RunObject = page "Expense List Page";
                }

                action(RecurringExpense)
                {
                    Caption = 'Recurring Expense';
                    ApplicationArea = All;
                    RunObject = page "RecurringPage";
                }
            }

            group(BudgetIncome)
            {
                Caption = 'Budget ~ Income';

                action(BudgetList)
                {
                    Caption = 'Budget List';
                    ApplicationArea = All;
                    RunObject = page "Budget List Page"; 
                }

                action(IncomeCategory)
                {
                    Caption = 'Income Category';
                    ApplicationArea = All;
                    RunObject = page "Income Category List Page";
                }

                action(IncomeList)
                {
                    Caption = 'Income List';
                    ApplicationArea = All;
                    RunObject = page "Income List Page";
                }
            }
        }
    }
}
