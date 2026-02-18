page 17334 "Customer Care"
{
    ApplicationArea = All;
    Caption = 'Customer Care';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {

            part(Control75; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
            }

            part(Control99; "Finance Performance")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control1902304208; "Membership Cue")
            {
                ApplicationArea = Basic, Suite;

            }

            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control123; "Team Member Activities")
            {
                ApplicationArea = Suite;
                Visible = false;
            }
            part(Control1907692008; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control103; "Trailing Sales Orders Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control106; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control9; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
            }

            part(Control100; "Cash Flow Forecast Chart")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control108; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control122; "Power BI Report Spinner Part")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {


        area(embedding)
        {
            action(Members)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Members';
                Image = Customer;
                RunObject = Page "Members List";
                ToolTip = 'View or edit detailed information for the Members.';
            }


            action(OutstandingLoans)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Outstanding Loan Balances';
                Image = Balance;
                RunObject = Page "Loans  List All";
                RunPageView = WHERE("Outstanding Balance" = FILTER(<> 0));
                ToolTip = 'View a summary of the Outstanding Loan Balances In The Sacco.';
            }

        }
        area(sections)
        {

            group(Action172)
            {
                Caption = 'Finance';
                Image = Journals;
                ToolTip = 'Collect and make payments, prepare statements, and reconcile bank accounts.';






#if not CLEAN19
#endif
#if not CLEAN19

#endif

#if not CLEAN19

#endif
                group(Journals)
                {
                }

                group(Action16)
                {
                }

            }
            group("Cash Management")
            {
                Caption = 'Cash Management';
                ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.  ';

            }
            group(Action76)
            {
                Caption = 'Receivables';
                Image = Sales;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';

            }
            group(Action84)
            {
                Caption = 'Membership Management';
                action(MembershipApp)
                {
                    ApplicationArea = All;
                    Caption = 'Membership Application';

                    RunObject = Page "Membership Application List";
                    ToolTip = 'Apply New Members.';
                }
                action(MembershipApp2)
                {
                    ApplicationArea = All;
                    Caption = 'Membership Application Created';

                    RunObject = Page "Membership Appl. - Created";
                    ToolTip = ' Members Created.';
                }
                action("Member Group")
                {
                    ApplicationArea = All;
                    Caption = 'Cluster';

                    RunObject = Page "Member Group List";
                    ToolTip = 'Apply New Members.';
                    Visible = false;
                }
                action(GroupApp)
                {
                    ApplicationArea = All;
                    Caption = 'Group Application';

                    RunObject = Page "Group/Corporate Applic List";
                    ToolTip = 'Apply New Members.';
                    Visible = false;
                }
                action(MembersList)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Member Accounts List';

                    RunObject = Page "Members List";
                    ToolTip = 'Manage Member Accounts';
                }
                action("Mobile  Application")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'MOBILE Applications';
                    RunObject = Page "MOBILE Applications";
                }
                action(GroupList)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Group Accounts List';

                    RunObject = Page "Group List";
                    ToolTip = 'Manage Member Accounts';
                    Visible = false;
                }
                group(ChangeRequest)
                {
                    Caption = 'Change Request';
                    action("Change Request")
                    {
                        ApplicationArea = All;
                        Caption = 'Change Request List';

                        RunObject = Page "Change Request List";
                        ToolTip = 'Change Member Details';
                    }
                    action(AgentNOKSignatoriesChange)
                    {
                        ApplicationArea = CostAccounting;
                        Caption = 'Agent/NOK/Signatories Change';

                        RunObject = Page "New Agent/NOK/Sign Change List";
                    }
                    group(ReportsChangereq)
                    {
                        caption = 'Reports Change Request';
                        action(ChangeReqMobile)
                        {
                            ApplicationArea = All;
                            Caption = 'Change Req(mobile)';

                            //RunObject = report "Change Request Report(Mobile)";
                        }
                        action(ChangeReqAcc)
                        {
                            ApplicationArea = All;
                            Caption = 'Change Req(Account)';

                            // RunObject = report "Change Request Report(Account)";
                        }

                    }
                    group(EffectedChangeReqs)

                    {
                        Caption = 'Effected Change Requests';
                        action(updatedchangereqslist)
                        {
                            ApplicationArea = All;
                            Caption = 'Updated Change requests';

                            RunObject = page "Updated Change Request List";
                        }

                        action(updatedNOKAgentSign)
                        {
                            Caption = 'Updated NOK/Agent & Signatories';
                            RunObject = page "Agent/NOK Change - Effected";
                        }
                    }

                }
                group("Membership Closure")
                {
                    Caption = 'Membership Closure';
                    action("MeMbership Exit")
                    {
                        ApplicationArea = All;
                        Caption = 'Member Withdrawal';
                        RunObject = page "Membership Exit List";
                    }
                    action("Membership Exit(Posted)")
                    {
                        ApplicationArea = All;
                        Caption = 'Posted Member Withdrawal';
                        RunObject = page "Posted Member Withdrawal List";
                    }
                }
                group("Sacco Transfer")
                {
                    caption = 'Sacco Transfer';
                    Visible = false;
                    action("Sacco Transfer List")
                    {
                        Applicationarea = basic, suite;
                        Caption = 'Open Sacco Transfer List';
                        Image = Payment;
                        RunObject = page "Internal Transfer List.";

                    }

                    action("POsted Sacco Transfers")
                    {
                        Caption = 'Posted Sacco Transfers';
                        ApplicationArea = basic, suite;
                        Image = PostedPayment;
                        RunObject = page "Posted Internal Transfer List.";
                    }

                }
                group(Receipts)
                {
                    Caption = 'BOSA Receipts';

                    ToolTip = 'Member Receipting Process.';
                    Visible = false;

                    action("BOSA Receipts")
                    {
                        Caption = 'Open BOSA Receipts';
                        Image = Receipt;
                        RunObject = page "BOSA Receipts List";
                        ToolTip = 'New Member Receipts for payments done.';

                    }
                    action("Posted BOSA Receipts")
                    {
                        Caption = 'Posted BOSA Receipts';
                        Image = PostedReceipt;
                        RunObject = page "Posted BOSA Receipts List";
                        ToolTip = 'New Member Receipts for payments done.';

                    }
                }

            }
            group("Payment Request")
            {
                Visible = false;
                action("Payment Request23")
                {
                    Caption = 'Payment Request';
                    Image = PostedReceipt;
                    RunObject = page "Paymrnt Request List";
                    RunPageLink = Status = filter(New);
                    ToolTip = 'New payments requests done.';
                }
                action("Payment Request222")
                {
                    Caption = 'Payment Request(Pending Approval)';
                    Image = PostedReceipt;
                    RunObject = page "Paymrnt Request List";
                    RunPageLink = Status = filter("Pending Approval");
                    ToolTip = 'New payments requests done.';
                }
                action("Payment Request22")
                {
                    Caption = 'Payment Request(Approved)';
                    Image = PostedReceipt;
                    RunObject = page "Paymrnt Request List";
                    RunPageLink = Status = filter(Approved);
                    ToolTip = 'New payments requests done.';
                }
            }

            group("Saving Products Management")
            {
                Visible = false;
                Caption = 'FOSA Management';
                ToolTip = 'Manage Saving Accounts Eg. FOSA Savings and Fixed Deposits';
                action("Account Applications")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Membership Products Application';
                    Image = Customer;
                    RunObject = page "Member Account Application";
                    ToolTip = 'Open New membership products accounts Application.';

                }
                action("Member FOSA Accounts")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'FOSA Accounts';
                    Image = Customer;
                    RunObject = page "Member Accounts List";
                    ToolTip = 'Open Members'' FOSA Accounts';

                }

            }

            group("Loans Management")
            {
                Caption = 'Loan Management';

                ToolTip = 'Loans'' Management Module';
                group("BOSA Loans Management")
                {
                    Caption = 'BOSA Loan Management';

                    ToolTip = 'BOSA Loans'' Management Module';
                    action("BOSA Loan Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'BOSA Loan Application';
                        Image = CreditCard;
                        RunObject = Page "Loan Application BOSA(New)";
                        ToolTip = 'Open BOSA Loan Applications';
                        Visible = false;
                    }
                    action("Pending BOSA Loan Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending BOSA Loan Applications';
                        Image = CreditCard;
                        RunObject = Page "Loans  List- pending approval";
                        ToolTip = 'Open the list of Pending BOSA Loan Applications.';
                        Visible = false;
                    }
                    action("Approved Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Loans Pending Disbursement.';
                        RunObject = Page "Loans Application List(Approv)";
                        ToolTip = 'Open the list of Approved Loans Pending Disbursement.';
                        Visible = false;
                    }


                    action("Posted Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Loans';
                        RunObject = Page "Loans Posted List";
                        ToolTip = 'Open the list of the Loans Posted.';
                    }
                    action("Cleared Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cleared Loans';
                        RunObject = Page "Loans Posted List";
                        RunPageView = where("Outstanding Balance" = filter(<= 0));
                        ToolTip = 'Open the list of the Loans Posted.';
                    }
                    action("Loan Calculator")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Calculator';
                        RunObject = Page "Loan Calculator";
                        ToolTip = 'Open Loan Calculator.';
                    }
                    action("Rejected Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rejected Loans.';
                        RunObject = Page "Rejected Loans";
                        ToolTip = 'Open the list of loans rejected.';
                    }

                }


                group("Loans Reports")
                {
                    action("Loan Expectation Monthly")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Expectation Monthly';
                        RunObject = report "Loans Monthly Expectation Ver1";
                    }
                    action("Loans Balances Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Register Report';
                        RunObject = report "Loans Balances Report";

                    }

                    action("Loans Balances Report CIC")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Balances Report CIC';
                        RunObject = report "Loans Balances Report CIC";
                    }
                    action("Loan Aging Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Aging Report (PAR)';
                        RunObject = report "Loans Defaulter Aging - SASRA";
                    }
                    action("Membership Exit Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Membership Exit Report';
                        RunObject = report "Membership Exit Report";
                    }

                }
                group("Periodic Activities")
                {
                    Visible = false;







                    group("Checkoff Pocessing")
                    {

                        action("Generate Prd")
                        {
                            ApplicationArea = basic, suite;
                            Caption = 'Generate CheckOff Advice';
                            RunObject = report "CheckOff Advice";
                        }
                    }
                    group("Guarantor Substitution")
                    {
                        action("Gurantor Substitution")
                        {
                            RunObject = page "Guarantorship Sub List";
                            ApplicationArea = basic, suite;

                        }
                        action("Posted Guarantor Substitution")
                        {
                            RunObject = page "Processed Guarantor Sub List";
                            ApplicationArea = basic, suite;
                        }
                    }

                }


            }



            group(SaccoCRM)
            {
                Caption = 'SACCO CRM';

                group("Case Management")
                {
                    action("Case Registration")
                    {
                        Caption = 'Case Enquiry Registration List';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "Crm Log List";
                        ToolTip = 'Book a New Case enquiry';

                    }
                    action("Assigned Cases")
                    {
                        Caption = 'Cases List';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "Case Assigned  list";
                        ToolTip = 'New Cases';

                    }
                    action("Resolved Case Enquiries")
                    {
                        Caption = 'Resolved Cases Enquiries';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        //RunObject = page resolved;
                        ToolTip = 'Resolved Cases Enquiries';

                    }
                    action("Resolved Cases")
                    {
                        Caption = 'Resolved Cases';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "Case Assigned  solved";
                        ToolTip = 'Resolved Cases';

                    }
                }
                group("CRM Gen Setup")
                {
                    action("CRM General setup")
                    {
                        Caption = 'CRM General Setup';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "Crm Nos series Card";
                        ToolTip = 'CRM Setup';

                    }
                    action("CRM Case types")
                    {
                        Caption = 'CRM Case types';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "CRM Case Types";
                        ToolTip = 'CRM Case Types';

                    }
                }

            }

            group("Portal Users")
            {
                action(Feedback)
                {
                    Caption = 'Online Member';
                    ApplicationArea = basic, suite;
                    RunObject = page "Online Member Accessibility";
                }
            }


            group("All Reports")
            {
                group("Member Report")
                {
                    action("MemberList")
                    {
                        Caption = 'Member List';
                        ApplicationArea = basic;
                        RunObject = report "Member List Report";//"Member List Report"
                    }
                    action("Member Application List")
                    {
                        Caption = 'Member Application List';
                        ApplicationArea = basic;
                        RunObject = report "Members Applications List";//"Member List Report"
                    }
                    action("Share Capital Balances")
                    {
                        Caption = 'Share Capital Balances';
                        ApplicationArea = basic;
                        RunObject = report "Share Capital Balances Report.";//"Member List Report"
                    }
                    action("Member Deposits Balances")
                    {
                        Caption = 'Member Deposit Balances';
                        ApplicationArea = basic;
                        RunObject = report "Member Deposit Balances Repor.";//"Member List Report"
                    }
                    action("Member Referee")
                    {
                        Caption = 'Member Referee Report';
                        ApplicationArea = basic;
                        RunObject = report "Member Referee Report";//"Member List Report"
                    }
                    action("Member Group Reports")
                    {
                        Caption = 'Member Deposits Per Group';
                        ApplicationArea = basic;
                        RunObject = report "Member Deposits Per Group";//"Member List Report"
                    }
                    action("Membership Exit Report2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Membership Exit Report';
                        RunObject = report "Membership Exit Report";
                    }
                }
                group("Loan Reports")
                {
                    action("Loan Expectation Monthly2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Expectation Monthly';
                        RunObject = report "Loans Monthly Expectation Ver1";
                    }
                    action("Loans Balances Report2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Balances Report';
                        RunObject = report "Loans Balances Report";

                    }

                    action("Loans Balances Report CIC2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Balances Report CIC';
                        RunObject = report "Loans Balances Report CIC";
                    }
                    action("Loan Aging Report2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Aging Report';
                        RunObject = report "Loans Defaulter Aging - SASRA";
                    }


                }
            }

            group("Human Resource Management")
            {

                Caption = 'Human Resource Management';

                group(Recruitment)
                {
                    action("Employee Requisition")
                    {
                        Caption = 'Employee Requisition';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Employee Requisitions List";
                        Visible = false;
                    }

                }


                group("Training Management")
                {
                    Visible = false;

                    group("Training Application")
                    {
                        action("Hr  Application List")
                        {
                            caption = 'Training Application List';
                            ApplicationArea = basic, suite;
                            RunObject = page "HR Training Application List";
                            RunPageLink = Status = filter(New);
                        }
                        action("Hr Pending Approved Application List")
                        {
                            caption = 'Training Pending Approved  List';
                            ApplicationArea = basic, suite;
                            RunObject = page "HR Training Application List";
                            RunPageLink = Status = filter("Pending Approval");
                        }
                        action("Hr  Approved Application List")
                        {
                            caption = 'Training Approved List';
                            ApplicationArea = basic, suite;
                            RunObject = page "HR Training Application List";
                            RunPageLink = Status = filter(Approved);
                        }
                    }


                }
                group("Leave Management")
                {

                    action("Leave Application")
                    {
                        Caption = 'Leave Applications';
                        ApplicationArea = basic, suite;
                        RunObject = page "HR Leave Applications List";

                    }





                }
            }

        }
    }
}
profile "Customer Care"
{
    Caption = 'Customer Care';
    RoleCenter = "Customer Care";
    ProfileDescription = 'Customer Care Role';
}



