page 17333 "Finance Role Center"
{
    ApplicationArea = All;
    Caption = 'Finance Role Center';
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
        area(reporting)
        {
            group("G/L Reports")
            {
                Caption = 'G/L Reports';
                action("&G/L Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&G/L Trial Balance';
                    Image = "Report";
                    RunObject = Report "Trial Balance";
                    ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }
                action("&Bank Detail Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Bank Detail Trial Balance';
                    Image = "Report";
                    RunObject = Report "Bank Acc. - Detail Trial Bal.";
                    ToolTip = 'View, print, or send a report that shows a detailed trial balance for selected bank accounts. You can use the report at the close of an accounting period or fiscal year.';
                }
                action("&Account Schedule")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Account Schedule';
                    Image = "Report";
                    RunObject = Report "Account Schedule";
                    ToolTip = 'Open an account schedule to analyze figures in general ledger accounts or to compare general ledger entries with general ledger budget entries.';
                }
                action("Bu&dget")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bu&dget';
                    Image = "Report";
                    RunObject = Report Budget;
                    ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
                }
                action("Trial Bala&nce/Budget")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Bala&nce/Budget';
                    Image = "Report";
                    RunObject = Report "Trial Balance/Budget";
                    ToolTip = 'View a trial balance in comparison to a budget. You can choose to see a trial balance for selected dimensions. You can use the report at the close of an accounting period or fiscal year.';
                }
                action("Trial Balance by &Period")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance by &Period';
                    Image = "Report";
                    RunObject = Report "Trial Balance by Period";
                    ToolTip = 'Show the opening balance by general ledger account, the movements in the selected period of month, quarter, or year, and the resulting closing balance.';
                }
                action("&Fiscal Year Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Fiscal Year Balance';
                    Image = "Report";
                    RunObject = Report "Fiscal Year Balance";
                    ToolTip = 'View, print, or send a report that shows balance sheet movements for selected periods. The report shows the closing balance by the end of the previous fiscal year for the selected ledger accounts. It also shows the fiscal year until this date, the fiscal year by the end of the selected period, and the balance by the end of the selected period, excluding the closing entries. The report can be used at the close of an accounting period or fiscal year.';
                }
                action("Balance Comp. - Prev. Y&ear")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance Comp. - Prev. Y&ear';
                    Image = "Report";
                    RunObject = Report "Balance Comp. - Prev. Year";
                    ToolTip = 'View a report that shows your company''s assets, liabilities, and equity compared to the previous year.';
                }
                action("&Closing Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Closing Trial Balance';
                    Image = "Report";
                    RunObject = Report "Closing Trial Balance";
                    ToolTip = 'View, print, or send a report that shows this year''s and last year''s figures as an ordinary trial balance. The closing of the income statement accounts is posted at the end of a fiscal year. The report can be used in connection with closing a fiscal year.';
                }
                action("Dimensions - Total")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions - Total';
                    Image = "Report";
                    RunObject = Report "Dimensions - Total";
                    ToolTip = 'View how dimensions or dimension sets are used on entries based on total amounts over a specified period and for a specified analysis view.';
                }
            }
            group("Cash Flow")
            {
                Caption = 'Cash Flow';
                action("Cash Flow Date List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Date List';
                    Image = "Report";
                    RunObject = Report "Cash Flow Date List";
                    ToolTip = 'View forecast entries for a period of time that you specify. The registered cash flow forecast entries are organized by source types, such as receivables, sales orders, payables, and purchase orders. You specify the number of periods and their length.';
                }
            }

        }
        area(embedding)
        {
            action("Chart of Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'Open the chart of accounts.';
            }
            action("Bank Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
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
            action("Receipts List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'View Posted Receipts';
                Image = Documents;
                RunObject = Page "Posted BOSA Receipts List";
                ToolTip = 'View Posted BOSA Receipts';
            }
        }
        area(sections)
        {

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
                action("G/L Budget")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Budget';
                    Image = GL;
                    RunObject = Page "G/L Budget Names";

                    ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                }
                action(Action170)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Accounts';

                    RunObject = Page "Chart of Accounts";
                    ToolTip = 'View or organize the general ledger accounts that store your financial data. All values from business transactions or internal adjustments end up in designated G/L accounts. Business Central includes a standard chart of accounts that is ready to support businesses in your country, but you can change the default accounts and add new ones.';
                }
                action("G/L Account Categories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Account Categories';
                    Visible = false;

                    RunObject = Page "G/L Account Categories";
                    ToolTip = 'Personalize the structure of your financial statements by mapping general ledger accounts to account categories. You can create category groups by indenting subcategories under them. Each grouping shows a total balance. When you choose the Generate Account Schedules action, the account schedules for the underlying financial reports are updated. The next time you run one of these reports, such as the balance statement, new totals and subentries are added, based on your changes.';
                }
                action(Currencies)
                {
                    ApplicationArea = Suite;
                    Caption = 'Currencies';
                    Image = Currency;
                    Visible = false;

                    RunObject = Page Currencies;
                    ToolTip = 'View the different currencies that you trade in or update the exchange rates by getting the latest rates from an external service provider.';
                }


                action("Account Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Schedules';
                    RunObject = page "Financial Reports";
                    //RunObject = Page "Account Schedule Names";
                    ToolTip = 'Get insight into the financial data stored in your chart of accounts. Account schedules analyze figures in G/L accounts, and compare general ledger entries with general ledger budget entries. For example, you can view the general ledger entries as percentages of the budget entries. Account schedules provide the data for core financial statements and views, such as the Cash Flow chart.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    RunObject = Page Dimensions;
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
#if not CLEAN19
#endif
#if not CLEAN19
                action(Action144)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employees';
                    Visible = false;
                    RunObject = Page "Employee List";
                    ToolTip = 'Manage employees'' details and related information, such as qualifications and pictures, or register and analyze employee absence. Keeping up-to-date records about your employees simplifies personnel tasks. For example, if an employee''s address changes, you register this on the employee card.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Duplicated action use action(Employees)';
                    ObsoleteTag = '19.0';
                }
#endif                
                action("Accounting Periods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                    ToolTip = 'Set up the number of accounting periods, such as 12 monthly periods, within the fiscal year and specify which period is the start of the new fiscal year.';
                }
                action("Number Series")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Number Series';
                    RunObject = Page "No. Series";
                    ToolTip = 'View or edit the number series that are used to organize transactions';
                }
#if not CLEAN19

#endif
                group(Journals)
                {
                    Caption = 'Journals';
                    //Image = Journals;
                    ToolTip = 'Post financial transactions.';
                    action(GeneralJournals)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Journals';
                        Image = Journal;

                        RunObject = Page "General Journal Batches";
                        RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(false));
                        ToolTip = 'Post financial transactions directly to general ledger accounts and other accounts, such as bank, customer, vendor, and employee accounts. Posting with a general journal always creates entries on general ledger accounts. This is true even when, for example, you post a journal line to a customer account, because an entry is posted to a general ledger receivables account through a posting group.';
                    }
                    action("<Action3>")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Recurring General Journals';

                        RunObject = Page "General Journal Batches";
                        RunPageView = WHERE("Template Type" = CONST(General),
                                        Recurring = CONST(true));
                        ToolTip = 'Define how to post transactions that recur with few or no changes to general ledger, bank, customer, vendor, or fixed asset accounts';
                    }
                    action(PurchaseJournals)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Journals';
                        RunObject = Page "General Journal Batches";
                        RunPageView = WHERE("Template Type" = CONST(Purchases),
                                        Recurring = CONST(false));
                        ToolTip = 'Post any purchase-related transaction directly to a vendor, bank, or general ledger account instead of using dedicated documents. You can post all types of financial purchase transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a purchase journal.';
                    }
                    action(SalesJournals)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Journals';
                        RunObject = Page "General Journal Batches";
                        RunPageView = WHERE("Template Type" = CONST(Sales),
                                        Recurring = CONST(false));
                        ToolTip = 'Post any sales-related transaction directly to a customer, bank, or general ledger account instead of using dedicated documents. You can post all types of financial sales transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a sales journal.';
                    }
                    action(PostedGeneralJournals)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted General Journals';
                        RunObject = Page "Posted General Journal";
                        ToolTip = 'Open the list of posted general journal lines.';
                    }
                }

                group(Action16)
                {
                    Caption = 'Fixed Assets';
                    ToolTip = 'Manage depreciation and insurance of your fixed assets.';
                    action(Action17)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Assets';
                        RunObject = Page "Fixed Asset List";
                        ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                    }
                    action("Fixed Assets G/L Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Assets G/L Journals';

                        RunObject = Page "General Journal Batches";
                        RunPageView = WHERE("Template Type" = CONST(Assets),
                                        Recurring = CONST(false));
                        ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation, in integration with the general ledger. The FA G/L Journal is a general journal, which is integrated into the general ledger.';
                    }
                    action("Fixed Assets Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Assets Journals';

                        RunObject = Page "FA Journal Batches";
                        RunPageView = WHERE(Recurring = CONST(false));
                        ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                    }
                    action("Fixed Assets Reclass. Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Fixed Assets Reclass. Journals';

                        RunObject = Page "FA Reclass. Journal Batches";
                        ToolTip = 'Transfer, split, or combine fixed assets by preparing reclassification entries to be posted in the fixed asset journal.';
                    }
                    action(Insurance)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance';

                        RunObject = Page "Insurance List";
                        ToolTip = 'Manage insurance policies for fixed assets and monitor insurance coverage.';
                    }
                    action("Insurance Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Journals';

                        RunObject = Page "Insurance Journal Batches";
                        ToolTip = 'Post entries to the insurance coverage ledger.';
                    }
                    action("Recurring Fixed Asset Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Recurring Fixed Asset Journals';

                        RunObject = Page "FA Journal Batches";
                        RunPageView = WHERE(Recurring = CONST(true));
                        ToolTip = 'Post recurring fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                    }
                }

            }
            group("Cash Management")
            {
                Caption = 'Cash Management';
                ToolTip = 'Process incoming and outgoing payments. Set up bank accounts and service connections for electronic banking.  ';
                action(Action164)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;

                    RunObject = Page "Bank Account List";
                    ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
                }
                action(CashReceiptJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;

                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                        Recurring = CONST(false));
                    ToolTip = 'Register received payments by manually applying them to the related customer, vendor, or bank ledger entries. Then, post the payments to G/L accounts and thereby close the related ledger entries.';
                }


                action("Bank Account Posting Groups")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Posting Groups';
                    RunObject = Page "Bank Account Posting Groups";
                    ToolTip = 'Set up posting groups, so that payments in and out of each bank account are posted to the specified general ledger account.';
                }
                action(PaymentJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Journals';
                    Image = Journals;

                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments),
                                        Recurring = CONST(false));
                    ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                }

                action("Payment Recon. Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Recon. Journals';
                    Image = ApplyEntries;
                    Visible = false;

                    RunObject = Page "Pmt. Reconciliation Journals";
                    ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                }
                action("Bank Acc. Statements")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Acc. Statements';
                    Image = BankAccountStatement;

                    RunObject = Page "Bank Account Statement List";
                    ToolTip = 'View statements for selected bank accounts. For each bank transaction, the report shows a description, an applied amount, a statement amount, and other information.';
                }
                action("Cash Flow Forecasts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Forecasts';
                    Visible = false;
                    RunObject = Page "Cash Flow Forecast List";
                    ToolTip = 'Combine various financial data sources to find out when a cash surplus or deficit might happen or whether you should pay down debt, or borrow to meet upcoming expenses.';
                }
                action("Chart of Cash Flow Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Cash Flow Accounts';

                    Visible = false;

                    RunObject = Page "Chart of Cash Flow Accounts";
                    ToolTip = 'View a chart contain a graphical representation of one or more cash flow accounts and one or more cash flow setups for the included general ledger, purchase, sales, services, or fixed assets accounts.';
                }


                action(BankAccountReconciliations)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account Reconciliations';
                    Image = BankAccountRec;

                    RunObject = Page "Bank Acc. Reconciliation List";
                    ToolTip = 'Reconcile bank accounts in your system with bank statements received from your bank.';
                }
            }
            group(Action76)
            {
                Caption = 'Receivables';
                Image = Sales;
                ToolTip = 'Make quotes, orders, and credit memos to customers. Manage customers and view transaction history.';
                action(Action61)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    Image = Customer;

                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }




                action("Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';

                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'Register your sales to customers and invite them to pay according to the delivery and payment terms by sending them a sales invoice document. Posting a sales invoice registers shipment and records an open receivable entry on the customer''s account, which will be closed when payment is received. To manage the shipment process, use sales orders, in which sales invoicing is integrated.';
                }

                action("Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Credit Memos';

                    RunObject = Page "Sales Credit Memos";
                    ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase or return incorrect or damaged items that you sent to them and received payment for. To include the correct information, you can create the sales credit memo from the related posted sales invoice or you can create a new sales credit memo with copied invoice information. If you need more control of the sales return process, such as warehouse documents for the physical handling, use sales return orders, in which sales credit memos are integrated. Note: If an erroneous sale has not been paid yet, you can simply cancel the posted sales invoice to automatically revert the financial transaction.';
                }

                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }





            }
            group(Action84)
            {
                Caption = 'Membership Management';


                action("Member Group")
                {
                    ApplicationArea = All;
                    Caption = 'Cluster';

                    RunObject = Page "Member Group List";
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
            group("Payment Request")
            {
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
                group("Fixed Deposits Mgmt ")
                {
                    Caption = 'Fixed Deposits Mgmt';

                    ToolTip = 'Open Fixed Deposits Submodule';
                    action("Fixed Deposits List")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Fixed Deposits Savings Accounts';
                        Image = Account;
                        RunObject = page "Fixed Deposit Acc. List";
                        ToolTip = 'Open Fixed Deposits'' FOSA Accounts';

                    }
                    action("Fixed Deposits Setup")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Fixed Deposits Types';
                        Image = Account;
                        RunObject = page "Fixed deposit Types list";
                        ToolTip = 'Open Fixed Deposits'' Types';

                    }
                    action("Fixed Deposits interest")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Fixed Deposits Interest';
                        Image = Account;
                        RunObject = page "Fixed Deposit Interest Rates";
                        ToolTip = 'Open Fixed Deposits'' Interest Rates';

                    }
                }
                group("Cashier Banking")
                {

                    Caption = 'Cashier-Banking';

                    action("Cashier Transactions")
                    {
                        Caption = 'Cashier Transactions';
                        ApplicationArea = basic, suite;
                        Image = Payment;
                        RunObject = page "Cashier Transactions - List";
                        ToolTip = 'Cashier Transactions list';
                    }
                    action("Posted Cashier Transactions")
                    {
                        Caption = 'Posted Cashier Transactions';
                        ApplicationArea = basic, suite;
                        Image = Payment;
                        RunObject = page "Posted Cashier Transactions";
                        ToolTip = 'Shows the list of posted Cashier Transactions list';
                    }

                    action("Cashier Transactions Authorisation")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Cashier Transactions Authorisation';
                        RunObject = Page "Cashier Trans Authorisations";
                    }
                    group("Teller/Treasury Management")
                    {
                        Caption = 'Teller/Treasury Management';
                        action(Treasury)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Treasury';
                            RunObject = Page "Treasury List";
                        }
                        action(Teller)
                        {
                            ApplicationArea = Basic;
                            Caption = 'Teller';
                            RunObject = Page "Teller Till List";
                        }
                        action("Treasury Management")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Teller & Treasury Trans List';
                            RunObject = Page "Teller & Treasury Trans List";
                        }
                    }
                    group("EFT Management")
                    {
                        action("EFT List")
                        {
                            ApplicationArea = Basic;
                            Caption = 'EFT List';
                            RunObject = Page "New EFT/RTGS List";
                        }
                        action("Posted EFT List")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Posted EFT List';
                            RunObject = Page "Posted EFT/RTGS List";
                        }
                    }


                    group("Standing Order Management")
                    {
                        action("Standing Order Application")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Standing Order Application';
                            RunObject = Page "Standing Orders - List";
                        }
                        action("Standing Order Application -Approved")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Standing Orders Approved';
                            RunObject = Page "Standing Orders - List Approve";
                        }
                        action("Standing Order Register")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Standing Order Register';
                            RunObject = Page "Standing Order Register";
                        }
                        action("Standing Orders Stopped ")
                        {
                            ApplicationArea = Basic;
                            Caption = 'Standing Orders - Stopped';
                            RunObject = Page "Standing Orders - Stopped";
                        }
                    }

                }
                group("Banking Services Setup")
                {
                    Visible = true;

                    action("Banking Setup")
                    {
                        Caption = 'Transaction Type - List';
                        ApplicationArea = basic, suite;
                        Image = Setup;
                        RunObject = page "Transaction Type - List";
                        ToolTip = 'Transaction Type - List';
                    }//Checktypelist
                    action("Cheque Setup")
                    {
                        Caption = 'Cheque Types';
                        ApplicationArea = basic, suite;
                        Image = Setup;
                        RunObject = page Checktypelist;
                        ToolTip = 'Transaction Type - List';
                    }//Checktypelist
                    action("Front office Setup")
                    {
                        Caption = 'Front Office Charges';
                        ApplicationArea = basic, suite;
                        Image = Setup;
                        RunObject = page "Front Office Charges";
                        ToolTip = 'Front Office Charges';
                    }
                    action("Fixed Deposit Setup")
                    {
                        Caption = 'Fixed deposit Types list';
                        ApplicationArea = basic, suite;
                        Image = Setup;
                        RunObject = page "Fixed deposit Types list";
                        ToolTip = 'Front Office Charges';
                    }
                    action("Audit Setup")
                    {
                        Caption = 'Fixed deposit Types list';
                        ApplicationArea = basic, suite;
                        Image = Setup;
                        //RunObject = page ;
                        ToolTip = 'Front Office Charges';
                    }
                    action("Custodians")
                    {
                        Caption = 'Custodians';
                        ApplicationArea = basic, suite;
                        Image = Setup;
                        RunObject = page Custodian;
                        ToolTip = 'Custodians';
                    }

                }

                group("Salary Processing")
                {

                    action("Salary")
                    {
                        Caption = 'Salary Processing List';
                        ApplicationArea = basic, suite;
                        Image = Setup;
                        RunObject = page "Salary Processing List";
                        ToolTip = 'Salary Processing List';
                    }
                    action("Processed Salary")
                    {
                        Caption = 'Processed Salary List';
                        ApplicationArea = basic, suite;
                        Image = Setup;
                        RunObject = page "Processed Salary List";
                        ToolTip = 'Processed Salary List';
                    }
                }
                group("ATM Banking")
                {

                    Caption = 'ATM Banking';
                    action(ATMApplication)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ATM Card Application';
                        RunObject = page "ATM Cards Application - New";

                    }
                    action(ATMProcessed)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Processed ATM Cards';
                        RunObject = page "ATM Cards Appl. - Processed";

                    }
                    action(ATMTransactionDetails)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ATM Transaction Details';
                        RunObject = page "Atm Transaction Details";

                    }
                    action(ATMRequestBatch)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ATM Card Request Batch List';
                        RunObject = page "ATM Card Request Batch List";

                    }
                    action(ATMBatchReceiptsBatch)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'ATM Card Receipt Batch List';
                        RunObject = page "ATM Card Receipt Batch List";

                    }
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
                    }
                    action("Posted Batch List")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = page "Loan Disbursment Posted List";
                        Caption = 'Loan Batch List(Posted)';
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
                    group("sasra Reports")
                    {
                        action("Deposit Return")
                        {
                            ApplicationArea = basic, suit;
                            Caption = 'Deposit Return Sasra';
                            RunObject = report "Deposit return";

                        }
                        action("Insider Lending")
                        {
                            ApplicationArea = basic, suit;
                            Caption = 'Insider Lending';
                            RunObject = report InsiderLending;

                        }
                        action("Risk Provisioning Report")
                        {
                            ApplicationArea = basic, suit;
                            Caption = 'Risk Provisioning Resport';
                            RunObject = report "Risk Class Of Assets & Prov";
                        }
                        action("Statement Of Financial Position")
                        {
                            ApplicationArea = basic, suite;
                            Caption = 'Statement of Financial Position';
                            RunObject = report "STATEMENT OF FINANCIAL P";
                        }
                        action("Capital Adequacy")

                        {
                            ApplicationArea = basic, suite;
                            Caption = 'Capital Adequacy';
                            RunObject = report "CAPITAL ADEQUACY RETURN";
                        }
                        // action("Statement of Comprehensive Income")
                        // {
                        //     RunObject = report "Form2F Statement of CompIncome";
                        //     ApplicationArea = basic, suite;
                        // }
                        action(Liquidity)
                        {
                            ApplicationArea = basic, suite;
                            RunObject = report "Liquidity Statement";
                        }
                        action("Investment Return")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = report "RETURN ON INVESTMENT.";
                        }
                        action("Sectorial Lending")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = report "Sectorial Lending";
                        }
                        action("Other Disclosures")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = report "Other Disclosures";
                        }
                        action("Insider List")
                        {
                            ApplicationArea = basic, suite;
                            RunObject = page "Insider List";
                        }
                    }

                }
                group("FOSA Loans MAnagement")
                {

                    Caption = 'FOSA Loan Management';
                    Visible = false;
                    ToolTip = 'FOSA Loans'' Management Module';

                    action("New FOSA Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New FOSA Loans.';
                        RunObject = Page "Loan Application FOSA(New)";
                        ToolTip = 'Open new FOSA Loan Applications';

                    }

                    action("Pending FOSA Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending FOSA Loan Applications';
                        RunObject = Page "Loan Application FOSA(Pending)";
                        ToolTip = 'Open Pending FOSA Loan Applications';

                    }
                    action("Approved FOSA Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved FOSA Loan Applications';
                        RunObject = Page "Loan Application FOSA(Approv)";
                        ToolTip = 'Approved Pending FOSA Loan Applications';

                    }
                    action("Posted FOSA Loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted FOSA Loan Applications';
                        RunObject = Page "Loan Application FOSA(Posted)";
                        ToolTip = 'Open Posted FOSA Loan Applications';

                    }


                }
                group(loanssetup)
                {
                    Caption = 'Loans Setup';
                    Visible = false;
                    action(LoansproductSetup)
                    {
                        Caption = 'Loans Product Setup';
                        Image = Setup;
                        ApplicationArea = basic, suite;
                        RunObject = page "Loan Products Setup List";
                    }
                    action(LoanStages)
                    {
                        Caption = 'Loan Stages';
                        Image = Setup;
                        RunObject = page "Loan Stages";
                        Visible = false;
                    }
                    action(CreditOfficers)
                    {
                        Caption = 'Credit Officers';
                        Image = Setup;
                        RunObject = page "Credit/Field Officers";
                        Visible = false;
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


            group("Payment Management")
            {
                Caption = 'Payment Process';
                Image = Payables;
                ToolTip = 'Payment Process.';
                action("Check Payment")
                {

                    Caption = 'Check Payment ';
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
            group("Board Payments")
            {
                action("Board Payment")
                {
                    Caption = 'Board Payment';
                    ApplicationArea = basic;
                    RunObject = page "Board Payments List";//"Member List Report"
                    RunPageView = where(Posted = filter(false));
                }
                action("Board Payment2")
                {
                    Caption = 'Board Payment(Posted)';
                    ApplicationArea = basic;
                    RunObject = page "Board Payments List";//"Member List Report"
                    RunPageView = where(Posted = filter(true));
                }
            }

            group("Dividends Processing")
            {
                action("Process Dividends")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Process Dividends';
                    RunObject = report "Dividend Processing Ver1";
                }
                action("Transfer Dividends")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Transfer Dividends';
                    RunObject = report "TransferDividend-Prorated";

                }
                action("Dividends Register")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Dividends Register List';
                    RunObject = page "Dividend Register";
                }
                action("Dividends Register Report ")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Dividends Register Report';
                    RunObject = report "Dividends Register";
                }
                action("Post Dividends")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Post Dividends';
                    RunObject = report "Post Dividends";
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
            group("Au Mobile Transactions")
            {
                Visible = false;
                action(Paybill)
                {
                    Caption = 'Paybill Transactions';
                    ApplicationArea = basic, suite;
                    RunObject = page "Paybill Transactions";
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
                    }

                }
                action("Hr Employee List")
                {
                    Caption = 'Hr Employee List';
                    ApplicationArea = basic, suite;
                    Image = Employee;
                    RunObject = page "HR Employee List";
                }

                group("Training Management")
                {

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

                Group(SaccoPayroll)
                {
                    Caption = 'Payroll Management';
                    Visible = true;
                    group(payrollEmployees)
                    {
                        Caption = 'Payroll Employees';
                        action(payrollemp)
                        {
                            Caption = 'Payroll Employees list';
                            ApplicationArea = basic, suite;
                            Image = Employee;
                            RunObject = page "Payroll Employee List.";
                            tooltip = 'Open Payroll Employees list';
                        }
                        action(Exitedpayrollemp)
                        {
                            Caption = 'Exited Payroll Employees list';
                            ApplicationArea = basic, suite;
                            Image = Employee;
                            RunObject = page "Exited Payroll Employees";
                            tooltip = 'Open exited Payroll Employees list';
                            Visible = false;
                        }

                    }


                    group(PayrollEarnings)
                    {
                        Caption = 'Earnings&Deductions';
                        Visible = false;
                        action(Earnings)
                        {
                            Caption = 'Payroll Earnings';
                            ApplicationArea = basic, suite;
                            Image = Card;
                            RunObject = page "Payroll Earnings List.";

                        }
                        action(Deductions)
                        {
                            Caption = 'Payroll Deductions';
                            ApplicationArea = basic, suite;
                            Image = Card;
                            RunObject = page "Payroll Deductions List.";

                        }
                    }
                    group("Payroll setup")
                    {
                        action(payesetup)
                        {
                            Caption = 'PAYE SETUP';
                            ApplicationArea = basic, suite;
                            RunObject = page "Payroll PAYE Setup.";
                        }
                        action(NHIF)
                        {
                            Caption = 'NHIF SETUP';
                            ApplicationArea = basic, suite;
                            RunObject = page "Payroll NHIF Setup.";
                        }
                        action(NSSF)
                        {
                            Caption = 'NSSF SETUP';
                            ApplicationArea = basic, suite;
                            RunObject = page "Payroll NSSF Setup.";
                        }
                        action(Payrolposting)
                        {
                            Caption = 'Payroll Posting group';
                            ApplicationArea = basic, suite;
                            RunObject = page "Payroll Posting Group.";
                        }
                        action(Payrollpostingsetup)
                        {
                            caption = 'Payroll posting setup';
                            ApplicationArea = basic, suite;
                            RunObject = page "Payroll Posting Setup Ver1";
                            Visible = false;
                        }
                        action("PayrollTransaction")
                        {
                            caption = 'PayrollTransaction';
                            ApplicationArea = basic, suite;
                            RunObject = page "Payroll Transaction List.";
                        }
                        action(PayrollGeneralsetup)
                        {
                            caption = 'Payroll General setup List';
                            ApplicationArea = basic, suite;
                            RunObject = page "Payroll General Setup LIST.";
                        }
                        action("Control-Info")
                        {
                            caption = 'Control Information ';
                            ApplicationArea = basic, suite;
                            RunObject = page controlInfor;
                        }


                    }
                    group(payrollperiodicactivities)
                    {
                        Caption = 'Payroll Periodic Activities';
                        action(payrollperiods)
                        {
                            Caption = 'Payroll Periods';
                            ApplicationArea = basic, suite;
                            RunObject = page "Payroll Periods.";
                        }
                        action(Transfertojournal)
                        {
                            Caption = 'Payroll Journal Transfer';
                            ApplicationArea = basic, suite;
                            RunObject = report "Payroll JournalTransfer.";

                        }
                        action(Payrolnettransfer)
                        {
                            Caption = 'Payroll Net Transfer';
                            ApplicationArea = basic, suite;
                            RunObject = report "Payroll Net Pay Transfer Ver1";
                        }




                    }
                    group("Payroll Reports ")
                    {
                        action("Payroll Summary New")
                        {
                            Caption = 'Payroll Summary';
                            RunObject = report "Payroll Summary New";
                            ApplicationArea = basic, suite;
                        }
                        action("Bank Schedule")
                        {
                            Caption = 'Bank Schedule';
                            ApplicationArea = basic, suite;
                            RunObject = report "Bank Schedule..";
                        }
                        action("Payroll Summary")
                        {
                            Caption = 'Payroll Summary';
                            ApplicationArea = basic, suite;
                            RunObject = report PayrollSummary;
                            Visible = false;
                        }
                        action("Send Payslips")
                        {
                            Caption = 'Send Payslip via Mail';
                            ApplicationArea = basic, suite;
                            RunObject = report "Send Payslips Via Mail";
                        }
                        action("P9 Report")
                        {
                            Caption = 'P9 Report';
                            RunObject = report P9Report;
                            ApplicationArea = basic, suite;
                        }
                        action("NHIF Report")
                        {
                            Caption = 'NHIF Report';
                            RunObject = report "NHIF Schedule W..";
                            ApplicationArea = basic, suite;
                        }
                        action("NSSF Report")
                        {
                            Caption = 'NSSF Report';
                            RunObject = report "NSSF Schedule W..";
                            ApplicationArea = basic, suite;
                        }

                    }


                }

            }

            group("Sacco Setup")
            {
                Visible = false;
                action("Sacco No series")
                {
                    Caption = 'Sacco No series';
                    ApplicationArea = basic, suite;
                    RunObject = page "Sacco No. Series";
                }
                action("Sacco General Set-Up")
                {
                    Caption = 'Sacco General Set-Up';
                    ApplicationArea = basic, suite;
                    RunObject = page "Sacco General Set-Up";
                }
                action("Loan Product Setup")
                {
                    Caption = 'Loan Product Setup';
                    ApplicationArea = basic, suite;
                    RunObject = page "Loan Products Setup List";
                }
                action("Loan Tax Brackets")
                {
                    Caption = 'PAYE Tax Brackets Credit';
                    ApplicationArea = basic, suite;
                    RunObject = page "PAYE Tax Brackets Credit";
                }
                action("Account Types List")
                {
                    Caption = 'Account Types List';
                    ApplicationArea = basic, suite;
                    RunObject = page "Account Types List";
                }
                action("Transaction Types Setup")
                {
                    Caption = 'Transaction Types Setup';
                    ApplicationArea = basic, suite;
                    RunObject = page "TransactionTypePosting Setup";
                }
                action("Supervisor Approval Levels")
                {
                    Caption = 'Supervisor Approval Levels';
                    ApplicationArea = basic, suite;
                    RunObject = page "Supervisor Approval Levels";
                }
                action("Status Change  Setup")
                {
                    Caption = 'Status Change Permisions';
                    ApplicationArea = basic, suite;
                    RunObject = page "Status Change Permisions";
                }


            }



            group(Procurement)
            {
                action("List of Vendors")
                {
                    ApplicationArea = basic, suit;
                    RunObject = page "Vendor List";
                    Caption = 'Vendor List';
                }
                action("New Purchase Requisition")
                {
                    ApplicationArea = basic, suit;
                    RunObject = page "Task Order";
                    Caption = 'New Purchase Requisition';
                }
                action("Pending Purchase Requisition")
                {
                    ApplicationArea = basic, suit;
                    RunObject = page "Pending Purchase Requisition3";
                    Caption = 'Pending Purchase Requisition';
                }
                action("Approved Purchase Requisition")
                {
                    ApplicationArea = basic, suit;
                    RunObject = page "Approved Purchase Requisition";
                    Caption = 'Approved Purchase Requisition';
                }
                action("Completed Purchase Requisition")
                {
                    ApplicationArea = basic, suit;
                    RunObject = page "CompletedPurchase Req.";
                    Caption = 'Completed Purchase Requisition';
                }
                action("Purchase Quotes")
                {
                    ApplicationArea = basic, suit;
                    RunObject = page "Purchase Quotes List";
                    Caption = 'Purchase Quotes';//Request For Quotes List
                }
                action("Request For Quotes List")
                {
                    ApplicationArea = basic, suit;
                    RunObject = page "Request For Quotes List";
                    Caption = 'Request For Quotes List';//Request For Quotes List
                }
                action("LPO/LSO List")
                {
                    ApplicationArea = basic, suit;
                    RunObject = page "LPO/LSO List";
                    Caption = 'LPO/LSO List';
                }
                action("Purchase Quote Awarded")
                {
                    ApplicationArea = basic, suit;
                    RunObject = page "PQ Awarded List";
                    Visible = false;
                    Caption = 'Purchase Quote Awarded';
                }
                action("Purchase Quote Not Awarded")
                {
                    ApplicationArea = basic, suit;

                    RunObject = page "PQ Not Awarded List";
                    Caption = 'Purchase Quote Archieved';//Purchase Quotes Lis
                }

            }

#if not CLEAN18

#endif
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
profile "Finance Role Center"
{
    Caption = 'Finance Role Center';
    RoleCenter = "Finance Role Center";
    ProfileDescription = 'Finance Role Center';
}



