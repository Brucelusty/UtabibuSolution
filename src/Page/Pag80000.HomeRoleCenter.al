//************************************************************************
page 80000 "Home Role Center" // default role center change to comapny name
{
    Caption = 'Home ';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {

            part(Control75; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control16; "O365 Activities")
            {
                AccessByPermission = TableData "Activities Cue" = I;
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

            part(Control106; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control9; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
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

            group("Cost Accounting")
            {
                Caption = 'Cost Accounting';
                action("Cost Accounting P/L Statement")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Accounting P/L Statement';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Statement";
                    ToolTip = 'View the credit and debit balances per cost type, together with the chart of cost types.';
                }
                action("CA P/L Statement per Period")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'CA P/L Statement per Period';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Stmt. per Period";
                    ToolTip = 'View profit and loss for cost types over two periods with the comparison as a percentage.';
                }
                action("CA P/L Statement with Budget")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'CA P/L Statement with Budget';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Statement/Budget";
                    ToolTip = 'View a comparison of the balance to the budget figures and calculates the variance and the percent variance in the current accounting period, the accumulated accounting period, and the fiscal year.';
                }
                action("Cost Accounting Analysis")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Accounting Analysis';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Analysis";
                    ToolTip = 'View balances per cost type with columns for seven fields for cost centers and cost objects. It is used as the cost distribution sheet in Cost accounting. The structure of the lines is based on the chart of cost types. You define up to seven cost centers and cost objects that appear as columns in the report.';
                }
            }
        }
        area(embedding)
        {

            action(membership)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Membership Application List';
                RunObject = Page "Membership Application List";
                ToolTip = 'Membership Application List';
            }
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
                group("SASRA Reports")
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
                    action("Statement of Comprehensive Income")
                    {
                        RunObject = report "Form2F Statement of CompIncome";
                        ApplicationArea = basic, suite;
                    }
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
                group("M-kopo Report")
                {
                    action("saccoinformation")
                    {
                        ApplicationArea = basic, suit;
                        Caption = 'Sacco information report';
                        RunObject = report saccoinformationreport;

                    }
                    action("saccoinformation2")
                    {
                        ApplicationArea = basic, suit;
                        Caption = 'Sacco information Page';
                        RunObject = page Saccoinformation;

                    }
                    // action("Statement Of Financial Position 2")
                    // {
                    //     ApplicationArea = basic, suite;
                    //     Caption = 'Statement of Financial Position';
                    //     RunObject = report "STATEMENTOFFINANCIALP";
                    // }
                    action("Statement of Comprehensive Income2")
                    {
                        RunObject = report "Statement Of Comp Income";
                        ApplicationArea = basic, suite;
                    }
                    action("Financial Statistical Information")
                    {
                        ApplicationArea = basic, suit;
                        Caption = 'Financial Statistical Information';
                        RunObject = report FinanciaStatisticalInformation;

                    }
                    action("Report of the Directors")
                    {
                        ApplicationArea = basic, suit;
                        Caption = 'Report of the Directors';
                        RunObject = report boardofdirectorsReport;

                    }
                    action("Statement Of Directors")
                    {
                        ApplicationArea = basic, suit;
                        Caption = 'Statement of Directors';
                        RunObject = report "Statement of Directors'RE";

                    }
                    action("Note1")
                    {
                        RunObject = report Note1;
                        ApplicationArea = basic, suite;
                    }
                    // action("Note3")
                    // {
                    //     RunObject = report "Notes3-16";
                    //     ApplicationArea = basic, suite;
                    //     Caption = 'Notes3-6';
                    //     Visible= false;
                    // }
                    action("Note4")
                    {
                        Runobject = Report "Notes2-4";
                        ApplicationArea = Basic, suite;
                        Caption = 'Note 2-4';
                    }
                    action("Note5")
                    {
                        Runobject = Report "Note 6";
                        ApplicationArea = Basic, suite;
                        Caption = 'Note 5';
                    }
                    action("Note6")
                    {
                        Runobject = Report "Note 8";
                        ApplicationArea = Basic, suite;
                        Caption = 'Note 6-7';
                    }
                    action("Note7")
                    {
                        RunObject = report "Note9-10";
                        ApplicationArea = basic, suite;
                        Caption = 'Notes8-10';
                    }
                    action("Note8")
                    {
                        RunObject = report "Note 11";
                        ApplicationArea = basic, suite;
                        Caption = 'Notes 11';
                    }
                    action("Note9")
                    {
                        RunObject = report "Note 12";
                        ApplicationArea = basic, suite;
                        Caption = 'Notes 12';
                    }
                    action("Note10")
                    {
                        RunObject = report "Note 13";
                        ApplicationArea = basic, suite;
                        Caption = 'Notes 13';
                    }


                    action("InsiderLending")
                    {
                        RunObject = report "insider lending report";
                        ApplicationArea = basic, suite;
                        Caption = 'InsiderLending';
                    }
                    action("cashflow")
                    {
                        ApplicationArea = basic, suit;
                        Caption = 'Cash Flow Report';
                        RunObject = report "Cash Flow Statement";

                    }
                    action(StatementOfChangesInEquity)
                    {
                        ApplicationArea = basic, suit;
                        Caption = 'StatementOfChangesInEquity';
                        RunObject = report StatementOfChangesInEquity;

                    }
                    action(StatementProfitorloss)
                    {
                        ApplicationArea = basic, suit;
                        Caption = 'StatementProfitorloss';
                        RunObject = report StatementProfitorloss;

                    }

                    action(boardofdirectors2)
                    {
                        ApplicationArea = basic, suit;
                        Caption = 'Board Of Directors';
                        RunObject = report "board Payment";

                    }
                    action("xml")
                    {
                        RunObject = xmlport "Import Checkoff Receipts";
                        ApplicationArea = basic, suite;
                        Visible = false;


                    }



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

                    RunObject = Page "Bank Acc. Recon List Conv";
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
                    Visible = false;
                    RunObject = Page "Member Group List";
                    ToolTip = 'Apply New Members.';
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
                action(MembersList2)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'AGM Member List';
                    RunObject = Page AGMMemberlist;
                    ToolTip = 'Manage Member Accounts';
                }
                action(MembersListII)
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Member List Report(Use for analysis)';
                    RunObject = Page "Memberlist Report";
                    ToolTip = 'Used only for analysis';
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
                    action("Mobile Applications")
                    {
                        ApplicationArea = All;
                        Caption = 'Mobile Applications';
                        RunObject = Page "MOBILE Applications";
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
                        Caption = 'Member Withdrawal-Open';
                        RunObject = page "Membership Exit List";
                    }
                    action("Membership Exit(Pending)")
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Member Withdrawal';
                        RunObject = page "MembershipExitList-Pending";
                    }
                    action("Membership Exit(Approved)")
                    {
                        ApplicationArea = All;
                        Caption = 'Approved Member Withdrawal';
                        RunObject = page "Membership Exit-Approved";
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
                    action("Pending Sacco Transfer List")
                    {
                        Applicationarea = basic, suite;
                        Caption = 'Pending Sacco Transfer List';
                        Image = Payment;
                        RunObject = page "Pending-Internal Transfer List";
                    }
                    action("Approved Sacco Transfer List")
                    {
                        Applicationarea = basic, suite;
                        Caption = 'Approved Sacco Transfer List';
                        Image = Payment;
                        RunObject = page "Approve-Internal Transfer List";
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
                Visible = False;
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


            group("Saving Products Management")
            {
                visible = False;
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




                }
                group("Banking Services Setup")
                {
                    Visible = false;

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
                        Caption = 'Approved Loans Pending Posting.';
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
                        RunPageView = where("Outstanding Balance" = filter(> 0));
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
                    action("posted/cleared loans")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'All Loans';
                        RunObject = Page "Loans Posted List";
                        // RunPageView = where("Outstanding Balance" = filter(<= 0));
                        ToolTip = 'Open the list of the Loans Posted.';
                    }

                    action("Loan Calculator")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Calculator';
                        RunObject = Page "Loan Calculator List";
                        ToolTip = 'Open Loan Calculator.';
                    }
                    action("Loan Trunch Disbursment")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Trunch Disbursment';
                        RunObject = Page "Loan Trunch Disburesment List";
                        ToolTip = 'Loan Trunch Disbursment';
                    }
                    action("Posted trunch disburesment")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted trunch disburesment';
                        RunObject = Page "Posted Trunch Disbursment List";
                        ToolTip = 'Open the list of the Posted trunches.';
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
                    action("Loans Report Customized")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Report Customized';
                        RunObject = report "Loans Reprt customized";
                    }
                    action("Loan Aging Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Aging Report (PAR)';
                        RunObject = report "Loans Defaulter Aging - SASRA";
                    }
                    action("Loans Guarantors")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Guarantors report';
                        RunObject = report "Members Loans Guarantors";
                    }

                    action("Membership Exit Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Membership Exit Report';
                        RunObject = report "Membership Exit Report";
                    }
                    action("Loan Movement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loan Movement';
                        RunObject = report "Loan Movement";
                    }
                    action("NWDTSasra Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'NWDTSasra Loan Report';
                        RunObject = report NWDTloansSasra;
                    }
                    action("Deposit Sasra")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Deposits Sasra Report';
                        RunObject = report DepositSasra;
                    }
                    action("Share capital Sasra")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Share capital Sasra Report';
                        RunObject = report "Share capital sasra";
                    }
                    action("Programmed Deposit Sasra")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Programmed Deposit Sasra Report';
                        RunObject = report "Programmed Deposit";
                    }
                    action("Monthly Contribution")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Monthly Deposit Contribution Report';
                        RunObject = report Monthlycontribution;
                    }

                }
                group("Periodic Activities")
                {
                    action("Share Caspital Recovery")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Share Capital Recovery';
                        RunObject = report "Share Caspital Recovery";//50072;
                    }
                    action("Process Monthly Interest")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Process Monthly Interest';
                        RunObject = report "Process Loan Monthly Interest";//50072;
                    }

                    action("Process Monthly Interest-UTAPESA")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Process Monthly Interest UTAPESA';
                        RunObject = report UtapesaLoaninterest;//50072;
                    }

                    action("Process Monthly Interest2")
                    {
                        ApplicationArea = basic, suite;
                        Caption = 'Process Monthly Interest2';
                        RunObject = report "Process Monthly Interest 2";//50072;
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

                    action("Generate Penalties")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Generate Penalties';
                        RunObject = report "Generate Penalties";//"Monthly Instant Interest"
                    }
                    action("Generate Penalties2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Generate Penalties2';
                        Visible = false;
                        RunObject = report "Instant Penalty";
                    }
                    action("Charge Penalties On Late Payme")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Charge Penalties On Late Payment';
                        RunObject = report "Charge Penalties On Late Payme";//"Monthly Instant Interest"
                    }
                    action("Monthly Instant Interest")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Monthly Instant Interest';
                        RunObject = report "Monthly Instant Interest";//"Monthly Instant Interest"
                    }

                    action("FOA DEFAULTED")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'FOA Defaulted';
                        RunObject = report "FOA DEFAULTED";//"Monthly Instant Interest"
                    }
                    action("Utapesa Recovery")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'utapesa';
                        RunObject = report "Test Utapesa Recovery";//"Monthly Instant Interest"
                    }

                    action("Instant Loan Extension")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Instant Loan Extension';
                        RunObject = report "Instant Loan Extension";//"Monthly Instant Interest"
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
                        action("Posted Checkoffsr")
                        {
                            ApplicationArea = basic, suite;
                            Caption = 'Distributed Checkoff';
                            RunObject = page "Bosa Receipts Header List";
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
                    Caption = 'Defaulter Management';
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
                            RunObject = page "posted loan recovery";
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
            Group(LoanRescheduling)
            {
                action("Loan Reschedule List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan Reschedule List';
                    RunObject = Page "Loan Reschedule List";
                    ToolTip = 'Loan Reschedule List';
                }//"Loan Reschedule List"
                action("Loan Reschedule List(Efected)")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan Reschedule List-Effected';
                    RunObject = Page "Loan Reschedule List-Effected";
                    ToolTip = 'Loan Reschedule List-Effected';
                }//"Loan Reschedule List"

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
                action("Disbursement Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Disbursement Report';
                    RunObject = report "Disbursement Report";
                }
                action("PvMpesa")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Voucher Mpesa';
                    RunObject = report "Payment voucher Mpesa";
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
                    RunObject = report "Post Dividends";//"Dividend Capitalization"
                }
                action("Dividend Capitalization")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Dividend Capitalization on Shares';
                    RunObject = report "Dividend Capitalization";//"Dividend Capitalization"
                }
                action("Dividend Capitalization on Loan")
                {
                    ApplicationArea = basic, suite;
                    Caption = 'Dividend Capitalization on Loan';
                    RunObject = report "Capitalize Dividends";//"Dividend Capitalization"
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

                    action("Member dividends Reports")
                    {
                        Caption = 'Member dividends Reports';
                        ApplicationArea = basic;
                        RunObject = report "Member Dividends Report";
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
                group("Staff Payslip")
                {
                    action("Employee Payslip View")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee Payslip View';
                        RunObject = page "Employee Payslip View";
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

                    action("Loans Movement Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Loans Movement Report';
                        RunObject = report "Loan Movement";
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
                group("Company Jobs")
                {
                    Visible = false;
                    action("Hr Job List")
                    {
                        Caption = 'HR Jobs List';
                        ApplicationArea = basic, suite;
                        Image = Employee;

                        RunObject = page "HR Jobs List";
                    }
                    action("Field Of Study")
                    {
                        Caption = 'Fields of Study';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "Fields of Study";
                    }
                    action("Job Industries")
                    {
                        Caption = 'Employment Industries';
                        RunObject = page "Company Job Industries";
                        Image = Setup;
                        ApplicationArea = All;
                        ToolTip = 'Executes the Employment Industries action';
                    }
                    action("Proffessional Body")
                    {
                        Caption = 'Proffessional Memberships';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "Prof Membership";
                    }
                    action("Academic Qualification")
                    {
                        Caption = 'Academic Qualifications';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "Academic Qualifications";
                    }
                }
                group(Recruitment)
                {
                    Visible = false;
                    action("Employee Requisition")
                    {
                        Caption = 'Employee Requisition';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Employee Requisitions List";
                    }
                    action("Job Application")
                    {
                        Caption = 'Job Application';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Job Applications List";
                    }
                    action("Short Listed")
                    {
                        Caption = 'Short Listed';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Shortlisting List";
                    }
                    action("Qualified")
                    {
                        Caption = 'Qualified Listed';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Job Applicants Qualified";
                    }
                    action("Un-Qualified")
                    {
                        Caption = 'Un-Qualified Listed';
                        ApplicationArea = basic, suite;
                        Image = Employee;
                        RunObject = page "HR Applicants UnQualified List";
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
                    Visible = false;
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
                    action("leave statement")
                    {
                        Caption = 'Leave Statement';
                        ApplicationArea = basic, suite;
                        RunObject = report "HrLeave statement";

                    }
                    action("Leave Balances")
                    {
                        Caption = 'Leave Balances';
                        ApplicationArea = basic, suite;
                        RunObject = report "Leave Balances Report";

                    }


                }

                group("Hr Leave Setup")
                {
                    action("HR Leave Journal")
                    {
                        Caption = 'HR Leave Journal';
                        ApplicationArea = basic, suite;
                        RunObject = page "HR Leave Journal Lines";
                    }
                    action("HR Leave Types")
                    {
                        Caption = 'HR Leave Types';
                        ApplicationArea = basic, suite;
                        RunObject = page "HR Leave Types";
                    }
                    action("Leave Period List")
                    {
                        ApplicationArea = basic, suite;
                        RunObject = page "HR Leave Period List";
                        Caption = 'Leave Period List';
                    }
                    action("HR Lookup Values")
                    {
                        caption = 'HR Lookup Values List';
                        ApplicationArea = basic, suite;
                        RunObject = page "HR Lookup Values List";
                    }
                    action("Leave Summary Report")
                    {
                        caption = 'Leave Summary Report';
                        ApplicationArea = basic, suite;
                        RunObject = report LeaveReport;
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
                        action("View Payslip")
                        {
                            Caption = 'Generate Payslip';
                            ApplicationArea = basic, suite;
                            RunObject = report "Payroll Payslip.";
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
            group("Stores Management")
            {
                Caption = 'Stores Management';
                ToolTip = 'Stores Requisition-Open';

                action("Item List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items List';
                    RunObject = Page "item List";
                }

                action("New Stores Requisitions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Stores Requisitions';
                    RunObject = Page "Open Store Requisitions List";
                }
                action("Pending Store Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Stores Requisition';
                    RunObject = Page "Store Requisitions(Pending)";
                }
                action("Approved Stores Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Stores Requisition';
                    RunObject = Page "Store Requisitions List-App";
                }
                action("Posted Stores Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Stores Requisition';
                    RunObject = Page "Posted Store Requisitions list";
                }

            }
            group(AML)
            {

                action("Politically Exposed Persons")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Politically Exposed Persons';
                    RunObject = Page "Politically Exposed Persons";
                }
                action("Customer Risk Rating Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Risk Rating Setup';
                    RunObject = Page "Customer Risk Rating";
                }
                action("Customer Net Income Rating Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Net Income Risk Rates Setup';
                    RunObject = Page "Customer Net Income Risk Rates";
                }
                action("Member Net Risk Scale Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Member Net Risk Scale Setup';
                    RunObject = Page "Member Net Risk Rating Scale";
                }
                action("Product Risk Rating Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Product Risk Rating Setup';
                    RunObject = Page "Product Risk Rating";
                }
                action("AML Listing")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'AML Listing';
                    RunObject = Page "AML Listing";
                }
                action("Generate AML List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Generate AML Listings';
                    RunObject = report "AML Listings";
                }

            }

            group("Sacco Setup")
            {
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
                action("Purchase Invoices List")
                {
                    ApplicationArea = basic, suit;
                    RunObject = page "Purchase Invoices";

                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = basic, suit;
                    RunObject = page "Posted Purchase Invoices";
                }

                action("Purchase Credit memo")
                {
                    ApplicationArea = basic, suit;
                    RunObject = page "Purchase Credit Memos";
                }
                action("Posted Purchase Credit memo")
                {
                    ApplicationArea = basic, suit;
                    RunObject = page "Posted Purchase Credit Memos";

                }
                action("Purchase Quote Not Awarded")
                {
                    ApplicationArea = basic, suit;

                    RunObject = page "PQ Not Awarded List";
                    Caption = 'Purchase Quote Archieved';//Purchase Quotes Lis
                }

            }
            group(Administration)
            {
                // Visible = false;
                Caption = 'Administration';
                Image = Administration;
                ToolTip = 'Check the administration services';
                action("Workflow")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Change Workflow ';
                    RunObject = Page "Workflow User Groups";

                }
                action("User Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'User Setup';
                    RunObject = Page "User Setup";
                }
                action("Users")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Add user';
                    RunObject = Page Users;
                }
                action("Profiles")
                {

                    ApplicationArea = Basic, Suite;
                    Caption = 'Change User Profile';
                    RunObject = Page "User Settings List";

                }
                action("Mobile  Application")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'MOBILE Applications';
                    RunObject = Page "MOBILE Applications";
                }
                action("By Sms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bulk SMS';
                    RunObject = Page "Bulk SMS Header List";
                    RunPageView = where("SMS Status" = filter(Pending));
                }
                action("By Sms2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bulk SMS Sent';
                    RunObject = Page "Bulk SMS Header List";
                    RunPageView = where("SMS Status" = filter(Sent));
                }

                action("Delivered sms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delivered sms';
                    RunObject = Page "Sms List";
                    RunPageView = where(Status = filter(Success));
                }

                action("Pending sms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending sms';
                    RunObject = Page "Sms List";
                    RunPageView = where(Bulk = filter(true), Attemted = filter(false));
                }

                action("Undelivered sms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Undelivered sms';
                    RunObject = Page "Sms List";
                    RunPageView = where(Status = filter(Failed), Attemted = filter(true));
                }
                action("Test Sms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Sms';
                    RunObject = Page "Sms setup";

                }
                action("Service Sms")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Service Sms';
                    RunObject = Page "Service Sms";

                }

                action("ICT")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Password Policy';
                    RunObject = Page "ICT Setup";
                }

                action("Change Password")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Change Password';
                    RunObject = Page PasswordChangeDate;
                }
                action("Change Log Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Change Log Report';
                    RunObject = report ChangeLogreport;
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

#if not CLEAN18
            group(SetupAndExtensions)
            {
                Caption = 'Setup & Extensions';
                Image = Setup;
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Visible = false;
                ObsoleteState = Pending;
                ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                ObsoleteTag = '18.0';
                action("Assisted Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action("Manual Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Manual Setup';
                    RunObject = Page "Manual Setup";
                    ToolTip = 'Define your company policies for business departments and for general activities.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action("Service Connections")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Service Connections';
                    Image = ServiceTasks;
                    RunObject = Page "Service Connections";
                    ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action(Extensions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Extensions';
                    Image = NonStockItemSetup;
                    RunObject = Page "Extension Management";
                    ToolTip = 'Install Extensions for greater functionality of the system.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
                action(Workflows)
                {
                    ApplicationArea = Suite;
                    Caption = 'Workflows';
                    RunObject = Page Workflows;
                    ToolTip = 'Set up or enable workflows that connect business-process tasks performed by different users. System tasks, such as automatic posting, can be included as steps in workflows, preceded or followed by user tasks. Requesting and granting approval to create new records are typical workflow steps.';
                    ObsoleteState = Pending;
                    ObsoleteReason = 'The new common entry points to all Settings is introduced in the app bar''s cogwheel menu (aligned with the Office apps).';
                    ObsoleteTag = '18.0';
                }
            }
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


        }
    }
}


profile Myprofile
{
    Caption = 'Credit Role Center H';
    RoleCenter = "Home Role Center";
    ProfileDescription = 'Credit Role Center Custom';
}



