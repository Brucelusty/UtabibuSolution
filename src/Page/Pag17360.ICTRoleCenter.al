page 17360 "ICT Role Center"
{
    ApplicationArea = All;
    Caption = 'ICT Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {

        }
    }

    actions
    {
        area(sections)
        {

            group(ICT)
            {

                action("Users")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Users';
                    RunObject = Page User;
                    ToolTip = 'Open the list of users in the system.';
                }
                action("User Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Users Setup';
                    RunObject = Page "User Setup";
                    ToolTip = 'Open the list of users in the system.';
                }
                action("Sacco Gen Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sacco General Setup';
                    RunObject = Page "Sacco General Set-Up";
                    ToolTip = 'Open the list of General Set-Up in the system.';
                }
                action("Sacco no series")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sacco no series';
                    RunObject = Page "Sacco No. Series";
                    ToolTip = 'Open the list of No. Series in the system.';
                }
                action("Loan Product Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan Product Setup';
                    RunObject = Page "Loan Products Setup List";
                    ToolTip = 'Open the list of Loan Products  in the system.';
                }
                action("Account Types")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Types';
                    RunObject = Page "Account Types List";
                    ToolTip = 'Open the list of Account Types List in the system.';
                }
                action("Transaction Posting Types")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transaction Posting Types';
                    RunObject = Page "TransactionTypePosting Setup";
                    ToolTip = 'Open the list of Transaction Posting Types in the system.';
                }

                action("Funds General Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Funds General Setup';
                    RunObject = Page "Funds General Setup";
                    ToolTip = 'Open the list of Funds General Setup in the system.';
                }

                action("Workflows")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Workflows';
                    RunObject = Page Workflows;
                    ToolTip = 'Open the list of workflows  in the system.';
                }
                action("Workflows User Group")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Workflow User Groups';
                    RunObject = Page "Workflow User Groups";
                    ToolTip = 'Open the list of workflows User Groups in the system.';
                }
                action("Change User Profile")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Change User Profile';
                    RunObject = Page "User Settings List";
                    ToolTip = 'Open the list of User Settings List in the system.';
                }

                action("Mobile  Application")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'MOBILE Applications';
                    RunObject = Page "MOBILE Applications";
                }


            }
        }

    }
}

profile "ICT Role Center"
{
    Caption = 'ICT Profile';
    RoleCenter = "ICT Role Center";
    ProfileDescription = 'ICT Role Center.';
}
