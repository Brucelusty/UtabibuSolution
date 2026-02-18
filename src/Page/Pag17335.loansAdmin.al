page 17335 "loans&Admin"
{
    ApplicationArea = All;
    Caption = 'loans&Admin';
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


            }
            group("Leave Management")
            {

                action("Leave Application")
                {
                    Caption = 'Leave Applications';
                    ApplicationArea = basic, suite;
                    RunObject = page "HR Leave Applications List";

                }

                action("Leave Applications(Approved)")
                {
                    Caption = 'Leave Applications(Approved)';
                    ApplicationArea = basic, suite;
                    RunObject = page "HR Leave Applications History";

                }
                action("Leave Applications(Posted)")
                {
                    Caption = 'Leave Applications(Posted)';
                    ApplicationArea = basic, suite;
                    RunObject = page "Posted Leave Applications";

                }


            }

        }
    }
}
profile "Loans Profile 2"
{
    Caption = 'Loans & Customer Care';
    RoleCenter = "Loans & Customer Care";
    ProfileDescription = 'Credit Role Center Custom';
}