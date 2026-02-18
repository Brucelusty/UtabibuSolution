//************************************************************************
page 80030 "Loans & Customer Care" // default role center change to comapny name
{
    //************************************************************************
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
            part(Control10; "Product Video Topics")
            {
                ObsoleteState = Pending;
                ObsoleteReason = 'Replaced with Assisted Setup.';
                Visible = false;
                ApplicationArea = All;
                ObsoleteTag = '17.0';
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
            action(FOSAAccounts)
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Caption = 'FOSA Accounts';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the FOSA Savings Accounts.';
            }
            action(FOSAAccountsBalance)
            {
                ApplicationArea = Basic, Suite;

                Caption = 'FOSA Account Balances';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
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


            group(Action84)
            {
                Caption = 'Membership Management';
                action(MembershipApp)
                {
                    ApplicationArea = All;
                    Caption = 'Membership Application';
                    RunObject = Page "Membership Application List";
                    ToolTip = 'Apply New Members.';
                    Visible = false;
                }
                action(MembershipApp2)
                {
                    ApplicationArea = All;
                    Caption = 'Membership Application Created';
                    RunObject = Page "Membership Appl. - Created";
                    ToolTip = ' Members Created.';
                    visible = false;
                }

                action(GroupApp)
                {
                    ApplicationArea = All;
                    Caption = 'Group Application';
                    Visible = false;
                    RunObject = Page "Group/Corporate Applic List";
                    ToolTip = 'Apply New Members.';
                }
                action(MembersList)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Member Accounts List';
                    RunObject = Page "Members List";
                    ToolTip = 'Manage Member Accounts';
                }
                action(GroupList)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Group Accounts List';
                    Visible = false;
                    RunObject = Page "Group List";
                    ToolTip = 'Manage Member Accounts';
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
            group(SaccoCRM)
            {
                Caption = 'SACCO CRM';
                Visible = false;

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
                        Caption = 'Escalated Cases List';
                        ApplicationArea = basic, suite;
                        Image = Capacity;
                        RunObject = page "Case Assigned  list";
                        ToolTip = 'New Cases';

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
                group("Case Types Setup")
                {

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
                    }
                    action("Pending BOSA Loan Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending BOSA Loan Applications';
                        Image = CreditCard;
                        RunObject = Page "Loans  List- pending approval";
                        ToolTip = 'Open the list of Pending BOSA Loan Applications.';
                    }
                    action("Approved Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Loans Pending Disbursement.';
                        RunObject = Page "Loans Application List(Approv)";
                        ToolTip = 'Open the list of Approved Loans Pending Disbursement.';
                    }
                    action("Batch List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loans Disbursment Batch List";
                        Caption = 'Loan Batch List';
                        Visible = false;
                    }
                    action("Posted Batch List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loan Disbursment Posted List";
                        Caption = 'Loan Batch List(Posted)';
                        Visible = false;
                    }
                    action("Posted Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Loans';
                        RunObject = Page "Loans Posted List";
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

                group("CRB List")
                {
                    action("CRB List2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'CRB List';
                        RunObject = page "CRBA List";
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
                    action("Process Monthly Interest")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Process Monthly Interest';
                        RunObject = report "Process Loan Monthly Interest";//50072;
                    }
                    action("Interest")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Transfer Interest to Journal';
                        RunObject = report TransferBufferInterest;//50072;
                    }
                    action("Clear Interest Buffer")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Clear buffer Interest';
                        RunObject = report ClearBuffer;///50072;
                    }






                    group("Checkoff Pocessing")
                    {
                        action("Checkoff Processing Distributed")
                        {
                            ApplicationArea = basic, suite;
                            Caption = 'Checkoff';
                            RunObject = page "Bosa Receipts H List-Checkoff";
                        }
                        action("Posted Checkoffs")
                        {
                            ApplicationArea = basic, suite;
                            Caption = 'Posted Checkoff';
                            RunObject = page "Posted Bosa Rcpt List-Checkof";
                        }
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

                group(Collateralmgmt)
                {
                    Caption = 'Collateral Management';

                    action(Collateralreg)
                    {
                        Caption = 'Loan Collateral Register';
                        Image = Register;
                        ApplicationArea = basic, suite;
                        RunObject = page "Loan Collateral Register List";
                    }
                    action(Collateralmvmt)
                    {
                        Caption = 'Loan Collateral Movement';
                        RunObject = page "Collateral Movement List";
                        ApplicationArea = basic, suite;
                        Visible = false;
                    }

                    group(CollateralReports)
                    {
                        Caption = 'Collateral Movement';
                        Visible = false;
                        action(ColateralsReport)
                        {
                            Caption = 'Collateral Report';
                            //  RunObject = report "Collaterals Report";
                        }

                    }
                    group(ArchiveCollateral)
                    {
                        Caption = 'Archive';
                        action(Effectedcollatmvmt)
                        {
                            Caption = 'Effective Collateral Movement';
                            RunObject = page "Effected Collateral Movement";
                            Visible = false;
                        }
                    }
                }
                group(DefaulterManagememnt)
                {
                    group(loanRecovery)
                    {
                        Caption = 'Loan Recovery';
                        action(LoanRecovList)
                        {
                            Caption = 'Loan Recovery List';
                            RunObject = page "Loan Recovery List";
                            ApplicationArea = basic, suit;

                        }
                        action(LoanRecoveryApprov)
                        {
                            Caption = 'Approved Loan Recovery';
                            runobject = page "Loan Recovery - Approved";
                            ApplicationArea = basic, suit;
                        }
                        action(LoanRecoveryPosted)
                        {
                            Caption = 'Posted Loan Recovery';
                            RunObject = page "Posted Loan Recovery Header";
                            ApplicationArea = basic, suit;
                        }
                    }
                    group(demandnotices)
                    {
                        caption = 'Demand Notices';
                        action(LoanDemandnoticeslist)
                        {
                            caption = 'Loan Demand Notices List';
                            RunObject = page "Loan Demand Notices List";
                        }
                        group(DemnandTask)
                        {
                            Caption = 'Create Demand Notices';
                            Visible = false;
                            action(CreateDemand)
                            {
                                Caption = 'Create Demand';
                                //   RunObject = report "Create Demand Notices";
                                Image = Report2;
                            }
                        }
                        group(DemandReports)
                        {
                            Visible = false;
                            action(Ldemandnotice)
                            {
                                Caption = 'Loan Demand Notice';
                                //   RunObject = report "Loan Demand Notice";
                                Image = Report;
                            }
                            action(LcrbNotice)
                            {
                                Caption = 'Loan CRB Notice';
                                //    RunObject = report "Loan CRB Notice";
                                Image = Report;
                            }
                        }
                    }
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
            group("ABC Transactions")
            {
                action(Paybill)
                {
                    Caption = 'Paybill Transactions';
                    ApplicationArea = basic, suite;
                    RunObject = page "Paybill Transactions";//"MOBILE Transactions"
                }
                action(MPaybill)
                {
                    Caption = 'MPesa Transactions';
                    ApplicationArea = basic, suite;
                    RunObject = page "MOBILE Transactions";//"MOBILE Transactions"//Sms Entry 2
                }
                action(SMS)
                {
                    Caption = 'SMS Messages';
                    ApplicationArea = basic, suite;
                    RunObject = page "Sms List";//"MOBILE Transactions"//Sms Entry 2//"MOBILE Applications"
                }
                action("MOBILE Application")
                {
                    Caption = 'MOBILE Applications';
                    ApplicationArea = basic, suite;
                    RunObject = page "MOBILE Applications";//"MOBILE Transactions"//Sms Entry 2//"MOBILE Applications"
                }
                action("Coop B2B Transactions")
                {
                    Caption = 'Coop B2B Transactions';
                    ApplicationArea = basic, suite;
                    RunObject = page "Coop B2B Transactions";

                }
            }
            group("Payment Management")
            {
                Caption = 'Payment Process';
                Image = Payables;
                ToolTip = 'Payment Process.';
                action("Cheque Payment")
                {

                    Caption = 'Cheque Payment ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Payment Voucher List";
                    ToolTip = 'Payment Voucher List.';
                }

                action("Cash Payment")
                {

                    Caption = 'New Petty Cash Payments List ';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "New Petty Cash Payments List";
                    ToolTip = 'New Petty Cash Payments List.';
                }
                action("Posted Cash Payment")
                {

                    Caption = 'Posted Cash Payment';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Posted Petty Cash Payments";
                    ToolTip = 'Posted Cash Payment';
                }
                action("Posted Cheque Payment")
                {

                    Caption = 'Posted Cheque Payment';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Posted Cheque Payment Vouchers";
                    ToolTip = 'Posted Cheque Payment';
                }





                action("Funds Transfer List")
                {
                    Caption = 'Funds Transfer List';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Funds Transfer List";
                    ToolTip = 'Funds Transfer List';
                }

                action("Posted Funds Transfer List")
                {
                    Caption = 'Posted Funds Transfer List';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Posred Funds Transfer List";
                    ToolTip = 'Posted Funds Transfer List';
                }

                action("Receipt Header List")
                {
                    Caption = 'Receipt Header List';
                    ApplicationArea = Basic, Suite;
                    Image = Check;
                    RunObject = page "Receipt Header List";
                    ToolTip = 'Receipt Header List';
                }

                action("Posted Receipt Header List ")
                {
                    Caption = 'Posted Receipt Header List ';
                    ApplicationArea = Basic, Suite;
                    Image = PostedOrder;
                    RunObject = page "Posted Receipt Header List";
                    ToolTip = 'Posted Receipt Header List ';
                }
                group("Payments Setup")
                {
                    Caption = 'Payment Setup';

                    ToolTip = 'Payment Setup.';
                    action("Funds Genral Setup")
                    {

                        Caption = 'Funds General Setup. ';
                        ApplicationArea = Basic, Suite;
                        Image = Check;
                        RunObject = page "Funds General Setup";
                        ToolTip = 'Funds General Setup.';
                    }

                    action("Budgetary Control Setup")
                    {

                        Caption = 'Budgetary Control Setup ';
                        ApplicationArea = Basic, Suite;
                        Image = Check;
                        RunObject = page "Budgetary Control Setup";
                        ToolTip = 'Budgetary Control Setup';
                    }
                    action("Funds User Setup")
                    {

                        Caption = 'Funds User Setup ';
                        ApplicationArea = Basic, Suite;
                        Image = Check;
                        RunObject = page "Funds User Setup";
                        ToolTip = 'Funds User Setup';
                    }
                    action("Receipt and Payment Types List")
                    {

                        Caption = 'Receipt and Payment Types List';
                        ApplicationArea = Basic, Suite;
                        Image = Setup;
                        RunObject = page "Receipt and Payment Types List";
                        ToolTip = 'Receipt and Payment Types List';
                    }
                }


            }




            group(Action172)
            {
                Caption = 'Finance';
                Image = Journals;
                ToolTip = 'Collect and make payments, prepare statements, and reconcile bank accounts.';
                action("General Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action(Action170)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Accounts';

                    RunObject = Page "Chart of Accounts";
                    ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                }



                group("Human Resource Management")
                {

                    Caption = 'Human Resource Management';




                    group("Training Management")
                    {
                        action("Training Needs")
                        {
                            caption = 'Training Needs';
                            ApplicationArea = basic, suite;
                            RunObject = page "HR Training Needs";
                        }
                        action("Hr Training Group")
                        {
                            caption = 'Training Groups';
                            ApplicationArea = basic, suite;
                            RunObject = page "HR Training Group";
                        }
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

#if not CLEAN18

#endif
            }
        }
        area(creation)
        {


            action("Payment Journal Entry")
            {
                AccessByPermission = TableData "Gen. Journal Batch" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Journal Entry';
                RunObject = Page "Payment Journal";
                ToolTip = 'Pay your vendors by filling the payment journal automatically according to payments due, and potentially export all payment to your bank for automatic processing.';
            }
        }
        area(processing)
        {
            group(Payments)
            {
                Caption = 'Payments';
                action("Cas&h Receipt Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cas&h Receipt Journal';
                    Image = CashReceiptJournal;
                    RunObject = Page "Cash Receipt Journal";
                    ToolTip = 'Apply received payments to the related non-posted sales documents.';
                }
                action("Pa&yment Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pa&yment Journal';
                    Image = PaymentJournal;
                    RunObject = Page "Payment Journal";
                    ToolTip = 'Make payments to vendors.';
                }
            }
            group(Analysis)
            {
                Caption = 'Analysis';
                action("Analysis &Views")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Analysis &Views';
                    Image = AnalysisView;
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
                }
                action("Analysis by &Dimensions")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Analysis by &Dimensions';
                    Image = AnalysisViewDimension;
                    RunObject = Page "Analysis by Dimensions";
                    ToolTip = 'Analyze activities using dimensions information.';
                    Visible = false;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'This functionality runs correctly from the Analysis View List page';
                    ObsoleteTag = '18.0';
                }
            }
            group(Tasks)
            {
                Caption = 'Tasks';
                action("Calculate Deprec&iation")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Calculate Deprec&iation';
                    Ellipsis = true;
                    Image = CalculateDepreciation;
                    RunObject = Report "Calculate Depreciation";
                    ToolTip = 'Calculate depreciation according to the conditions that you define. If the fixed assets that are included in the batch job are integrated with the general ledger (defined in the depreciation book that is used in the batch job), the resulting entries are transferred to the fixed assets general ledger journal. Otherwise, the batch job transfers the entries to the fixed asset journal. You can then post the journal or adjust the entries before posting, if necessary.';
                }
                action("Import Co&nsolidation from Database")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Co&nsolidation from Database';
                    Ellipsis = true;
                    Image = ImportDatabase;
                    RunObject = Report "Import Consolidation from DB";
                    ToolTip = 'Import entries from the business units that will be included in a consolidation. You can use the batch job if the business unit comes from the same database in Business Central as the consolidated company.';
                }
                action("Bank Account R&econciliation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account R&econciliation';
                    Image = BankAccountRec;
                    RunObject = Page "Bank Acc. Reconciliation";
                    ToolTip = 'View the entries and the balance on your bank accounts against a statement from the bank.';
                }
                action("Payment Reconciliation Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Reconciliation Journals';
                    Image = ApplyEntries;

                    RunObject = Page "Pmt. Reconciliation Journals";
                    RunPageMode = View;
                    ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                }
                action("Adjust E&xchange Rates")
                {
                    ApplicationArea = Suite;
                    Caption = 'Adjust E&xchange Rates';
                    Ellipsis = true;
                    Image = AdjustExchangeRates;
                    RunObject = Codeunit "Exch. Rate Adjmt. Run Handler";
                    ToolTip = 'Adjust general ledger, customer, vendor, and bank account entries to reflect a more updated balance if the exchange rate has changed since the entries were posted.';
                }
                action("P&ost Inventory Cost to G/L")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost Inventory Cost to G/L';
                    Image = PostInventoryToGL;
                    RunObject = Report "Post Inventory Cost to G/L";
                    ToolTip = 'Record the quantity and value changes to the inventory in the item ledger entries and the value entries when you post inventory transactions, such as sales shipments or purchase receipts.';
                }

                action("Calc. and Pos&t VAT Settlement")
                {
                    ApplicationArea = VAT;
                    Caption = 'Calc. and Pos&t VAT Settlement';
                    Image = SettleOpenTransactions;
                    RunObject = Report "Calc. and Post VAT Settlement";
                    ToolTip = 'Close open VAT entries and transfers purchase and sales VAT amounts to the VAT settlement account. For every VAT posting group, the batch job finds all the VAT entries in the VAT Entry table that are included in the filters in the definition window.';
                }
            }
            group(Create)
            {
                Caption = 'Create';
                action("C&reate Reminders")
                {
                    ApplicationArea = Suite;
                    Caption = 'C&reate Reminders';
                    Ellipsis = true;
                    Image = CreateReminders;
                    RunObject = Report "Create Reminders";
                    ToolTip = 'Create reminders for one or more customers with overdue payments.';
                }
                action("Create Finance Charge &Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Finance Charge &Memos';
                    Ellipsis = true;
                    Image = CreateFinanceChargememo;
                    RunObject = Report "Create Finance Charge Memos";
                    ToolTip = 'Create finance charge memos for one or more customers with overdue payments.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                group("Financial Statements")
                {
                    Caption = 'Financial Statements';
                    Image = ReferenceData;
                    action("Balance Sheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";

                        RunObject = Report "Balance Sheet";
                        ToolTip = 'View a report that shows your company''s assets, liabilities, and equity.';
                    }
                    action("Income Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement';
                        Image = "Report";

                        RunObject = Report "Income Statement";
                        ToolTip = 'View a report that shows your company''s income and expenses.';
                    }
                    action("Statement of Cash Flows")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Cash Flows';
                        Image = "Report";

                        RunObject = Report "Statement of Cashflows";
                        ToolTip = 'View a financial statement that shows how changes in balance sheet accounts and income affect the company''s cash holdings, displayed for operating, investing, and financing activities respectively.';
                    }
                    action("Statement of Retained Earnings")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Retained Earnings';
                        Image = "Report";

                        RunObject = Report "Retained Earnings Statement";
                        ToolTip = 'View a report that shows your company''s changes in retained earnings for a specified period by reconciling the beginning and ending retained earnings for the period, using information such as net income from the other financial statements.';
                    }
                }
                group("Excel Reports")
                {
                    Caption = 'Excel Reports';
                    Image = Excel;
                    action(ExcelTemplatesBalanceSheet)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Balance Sheet";
                        ToolTip = 'Open a spreadsheet that shows your company''s assets, liabilities, and equity.';
                    }
                    action(ExcelTemplateIncomeStmt)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Income Stmt.";
                        ToolTip = 'Open a spreadsheet that shows your company''s income and expenses.';
                    }
                    action(ExcelTemplateCashFlowStmt)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template CashFlow Stmt.";
                        ToolTip = 'Open a spreadsheet that shows how changes in balance sheet accounts and income affect the company''s cash holdings.';
                    }
                    action(ExcelTemplateRetainedEarn)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Retained Earnings Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Retained Earn.";
                        ToolTip = 'Open a spreadsheet that shows your company''s changes in retained earnings based on net income from the other financial statements.';
                    }
                    action(ExcelTemplateTrialBalance)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Trial Balance';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Trial Balance";
                        ToolTip = 'Open a spreadsheet that shows a summary trial balance by account.';
                    }
                    action(ExcelTemplateAgedAccPay)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Payable';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Aged Acc. Pay.";
                        ToolTip = 'Open a spreadsheet that shows a list of aged remaining balances for each vendor by period.';
                    }
                    action(ExcelTemplateAgedAccRec)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Receivable';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Aged Acc. Rec.";
                        ToolTip = 'Open a spreadsheet that shows when customer payments are due or overdue by period.';
                    }
                }
                action("Run Consolidation")
                {
                    ApplicationArea = Suite;
                    Caption = 'Run Consolidation';
                    Ellipsis = true;
                    Image = ImportDatabase;
                    RunObject = Report "Import Consolidation from DB";
                    ToolTip = 'Run the Consolidation report.';
                }
            }
#if not CLEAN19
            group(Setup)
            {
                Caption = 'Setup';
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'Setup is no longer shown in this page.';
                ObsoleteTag = '19.0';

                action(Action112)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("General &Ledger Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General &Ledger Setup';
                    Image = Setup;
                    RunObject = Page "General Ledger Setup";
                    ToolTip = 'Define your general accounting policies, such as the allowed posting period and how payments are processed. Set up your default dimensions for financial analysis.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("&Sales && Receivables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Sales && Receivables Setup';
                    Image = Setup;
                    RunObject = Page "Sales & Receivables Setup";
                    ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("&Purchases && Payables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Purchases && Payables Setup';
                    Image = Setup;
                    RunObject = Page "Purchases & Payables Setup";
                    ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("&Fixed Asset Setup")
                {
                    ApplicationArea = FixedAssets;
                    Caption = '&Fixed Asset Setup';
                    Image = Setup;
                    RunObject = Page "Fixed Asset Setup";
                    ToolTip = 'Define your accounting policies for fixed assets, such as the allowed posting period and whether to allow posting to main assets. Set up your number series for creating new fixed assets.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("Cash Flow Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Setup';
                    Image = CashFlowSetup;
                    RunObject = Page "Cash Flow Setup";
                    ToolTip = 'Set up the accounts where cash flow figures for sales, purchase, and fixed-asset transactions are stored.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("Cost Accounting Setup")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Accounting Setup';
                    Image = CostAccountingSetup;
                    RunObject = Page "Cost Accounting Setup";
                    ToolTip = 'Specify how you transfer general ledger entries to cost accounting, how you link dimensions to cost centers and cost objects, and how you handle the allocation ID and allocation document number.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
                action("Business Units")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Business Units';
                    Image = Setup;
                    RunObject = Page "Business Unit List";
                    ToolTip = 'Set up Business Units that you need to consolidate into this company.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Setup is no longer shown in this page.';
                    ObsoleteTag = '19.0';
                }
            }
#endif
            group(History)
            {
                Caption = 'History';
                action("Navi&gate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Find entries...';
                    Image = Navigate;
                    RunObject = Page Navigate;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';
                }
            }


        }
    }
}
profile "Loans Profile"
{
    Caption = 'Loans & Customer Care';
    RoleCenter = "Loans & Customer Care";
    ProfileDescription = 'Credit Role Center Custom';
}



