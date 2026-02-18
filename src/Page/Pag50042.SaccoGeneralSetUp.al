//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50042 "Sacco General Set-Up"
{
    PageType = Card;
    SourceTable = "Sacco General Set-Up";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Setup';
                field("Min. Member Age"; Rec."Min. Member Age")
                {
                    ApplicationArea = Basic;
                }
                field("Retirement Age"; Rec."Retirement Age")
                {
                    ApplicationArea = Basic;
                }
                field("Min. Contribution"; Rec."Min. Contribution")
                {
                    ApplicationArea = Basic;
                    Caption = 'Individual Minimum Monthly Contributions';
                }
                field("Benevolent Fund Contribution"; Rec."Benevolent Fund Contribution")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Benevolent Fund Contibution';
                }
                field("Corporate Minimum Monthly Cont"; Rec."Corporate Minimum Monthly Cont")
                {
                    ApplicationArea = Basic;
                    Caption = 'Corporate Minimum Monthly Contributions';
                    Visible = false;
                }
                field("Retained Shares"; Rec."Retained Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital Amount';
                }
                field("FOSA Shares Amount"; Rec."FOSA Shares Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Min Deposit Cont.(% of Basic)"; Rec."Min Deposit Cont.(% of Basic)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Minimum Take home"; Rec."Minimum Take home")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Minimum take home FOSA"; Rec."Minimum take home FOSA")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Max. Non Contribution Periods"; Rec."Max. Non Contribution Periods")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date of Checkoff Advice"; Rec."Last Date of Checkoff Advice")
                {
                    ApplicationArea = Basic;
                }
                field("Dormancy Period"; Rec."Dormancy Period")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Min. Loan Application Period"; Rec."Min. Loan Application Period")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bank Statement Period"; Rec."Bank Statement Period")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal Statement Period';
                    Visible = false;
                }
                field("Maximum No of Guarantees"; Rec."Maximum No of Guarantees")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Min. Guarantors"; Rec."Min. Guarantors")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Max. Guarantors"; Rec."Max. Guarantors")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Member Can Guarantee Own Loan"; Rec."Member Can Guarantee Own Loan")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Self Guarantee Multiplier"; Rec."Self Guarantee Multiplier")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Dividend (%)"; Rec."Dividend (%)")
                {
                    ApplicationArea = Basic;

                }
                field("Interest on Deposits (%)"; Rec."Interest on Deposits (%)")
                {
                    ApplicationArea = Basic;

                }
                field("Chama Savings Rate"; Rec."Chama Savings Rate") { ApplicationArea = Basic; }
                FIELD("Dividend processing start date"; Rec."Dividend processing start date") { }
                FIELD("Withholding Tax (%) on dividends"; Rec."Withholding Tax (%) on dividends") { }
                field("Deposit Boosting Rate"; Rec."Deposit Boosting Rate") { ApplicationArea = Basic; }
                field("Min. Dividend Proc. Period"; Rec."Min. Dividend Proc. Period")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Div Capitalization Min_Indiv"; Rec."Div Capitalization Min_Indiv")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Dividend Capitalization Minimum Deposit_Individula';
                    ToolTip = 'Less this Deposits the System will capitalize part of your dividend based on the Dividend Capitalization %';
                }
                field("Div Capitalization Min_Corp"; Rec."Div Capitalization Min_Corp")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Dividend Capitalization Minimum Deposit_Corporate Account';
                    ToolTip = 'Less this Deposits the System will capitalize part of your dividend based on the Dividend Capitalization %';
                }
                field("Div Capitalization %"; Rec."Div Capitalization %")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Dividend Capitalization %';
                }
                field("Days for Checkoff"; Rec."Days for Checkoff")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Boosting Shares Maturity (M)"; Rec."Boosting Shares Maturity (M)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Contactual Shares (%)"; Rec."Contactual Shares (%)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Use Bands"; Rec."Use Bands")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Max. Contactual Shares"; Rec."Max. Contactual Shares")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Withholding Tax (%)"; Rec."Withholding Tax (%)")
                {
                    ApplicationArea = Basic;
                }
                field("Welfare Contribution"; Rec."Welfare Contribution")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Insurance Contribution';
                }
                field("ATM Expiry Duration"; Rec."ATM Expiry Duration")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Monthly Share Contributions"; Rec."Monthly Share Contributions")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Risk Fund Amount"; Rec."Risk Fund Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Deceased Cust Dep Multiplier"; Rec."Deceased Cust Dep Multiplier")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposit Refund Multiplier-Death';
                    Visible = false;
                }
                field("Begin Of Month"; Rec."Begin Of Month")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("End Of Month"; Rec."End Of Month")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("E-Loan Qualification (%)"; Rec."E-Loan Qualification (%)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Charge FOSA Registration Fee"; Rec."Charge FOSA Registration Fee")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Charge BOSA Registration Fee"; Rec."Charge BOSA Registration Fee")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Defaulter LN"; Rec."Defaulter LN")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Last Transaction Duration"; Rec."Last Transaction Duration")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Branch Code No"; Rec."Branch Code No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Allowable Cheque Discounting %"; Rec."Allowable Cheque Discounting %")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Sto max tolerance Days"; Rec."Sto max tolerance Days")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Order Maximum Tolerance Days';
                    ToolTip = 'Specify the Maximum No of  Days the Standing order should keep trying if the Member account has inserficient amount';
                }
                field("Dont Allow Sto Partial Ded."; Rec."Dont Allow Sto Partial Ded.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dont Allow Sto Partial Deduction';
                }
                field("Standing Order Bank"; Rec."Standing Order Bank")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specify the Cash book account to be credit when a member places an External standing order';
                }
                field("ATM Destruction Period"; Rec."ATM Destruction Period")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Go Live Date"; Rec."Go Live Date")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Request Path"; Rec."Cheque Book Request Path")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ATM Card Request Path"; Rec."ATM Card Request Path")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Collateral Collection Period"; Rec."Collateral Collection Period")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Amount Due Freeze Period"; Rec."Loan Amount Due Freeze Period")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(OnlineMemberMonthlyTransLimit; rec.OnlineMemberMonthlyTransLimit)
                {
                    ApplicationArea = Basic;
                    Caption = 'Online Member Monthly Transaction Limit';
                    Visible = false;
                }
                field("Referee Comm. Period"; Rec."Referee Comm. Period")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Recruitment Commission"; Rec."Recruitment Commission")
                {
                    ApplicationArea = Basic;

                }
                field("Recruitment Comm. Expense GL"; Rec."Recruitment Comm. Expense GL")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Application Perion"; Rec."Loan Application Perion")
                {
                    Caption = 'Loan Application Period';

                }
            }
            group("Fees & Commissions")
            {
                Caption = 'Fees & Commissions';
                field("Withdrawal Fee"; Rec."Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Maximum Closure Fee';
                }
                field("Withdrawal Fee %"; Rec."Withdrawal Fee %")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure %1';
                }
                field("FOSA Registration Fee Amount"; Rec."FOSA Registration Fee Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("BOSA Registration Fee Amount"; Rec."BOSA Registration Fee Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Registration Fee';
                }
                field("Staff Registration Fee Amount"; Rec."Staff Registration Fee Amount")
                {
                    ApplicationArea = all;
                    Caption = 'Staff Registration Fee';
                }
                field("BOSA Reg. Fee Corporate"; Rec."BOSA Reg. Fee Corporate")
                {
                    ApplicationArea = Basic;
                    Caption = 'BOSA Registration Fee Corporate';
                }
                field("Rejoining Fee"; Rec."Rejoining Fee")
                {
                    ApplicationArea = Basic;

                }
                field("Boosting Shares %"; Rec."Boosting Shares %")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Dividend Processing Fee"; Rec."Dividend Processing Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Trasfer Fee-EFT"; Rec."Loan Trasfer Fee-EFT") { ApplicationArea = all; }
                field("Loan Trasfer Fee-RTGS"; Rec."Loan Trasfer Fee-RTGS") { ApplicationArea = all; }
                field("M-Pesa Charge(0-10K)"; Rec."M-Pesa Charge(0-10K)") { ApplicationArea = all; }
                field("M-Pesa Charge(>10K)"; Rec."M-Pesa Charge(>10K)") { ApplicationArea = all; }
                field("M-Pesa Charges PV"; Rec."M-Pesa Charges PV") { ApplicationArea = all; }
                field(" EFT Charges PV"; Rec." EFT Charges PV") { ApplicationArea = all; }
                field("RTGS Charges PV"; Rec."RTGS Charges PV") { ApplicationArea = all; }
                field("Top up Commission"; Rec."Top up Commission")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Excise Duty(%)"; Rec."Excise Duty(%)")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Fee Amount"; Rec."SMS Fee Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Risk Beneficiary (%)"; Rec."Risk Beneficiary (%)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Cash Clearing Fee(%)"; Rec."Loan Cash Clearing Fee(%)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Mpesa Withdrawal Fee"; Rec."Mpesa Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Share Transfer Fee %"; Rec."Share Transfer Fee %")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Cheque Discounting Comission"; Rec."Cheque Discounting Comission")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Funeral Expense Amount"; Rec."Funeral Expense Amount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Share Capital Transfer Fee"; Rec."Share Capital Transfer Fee")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Partial Deposit Refund Fee"; Rec."Partial Deposit Refund Fee")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Penalty On Deposit Arrears"; Rec."Penalty On Deposit Arrears")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Penalty on Failed Monthly Contribution';
                    ToolTip = 'Specify the Penalty Amount to Charge a Member who has not meet the minimum Monthly contribution';
                }
                field("ATM Card Fee-New Coop"; Rec."ATM Card Fee-New Coop")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ATM Card Fee-New Sacco"; Rec."ATM Card Fee-New Sacco")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ATM Card Fee-Replacement Coop"; Rec."ATM Card Fee-Replacement Coop")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ATM Card Fee-Replacement SACCO"; Rec."ATM Card Fee-Replacement SACCO")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ATM Card Renewal Fee Coop"; Rec."ATM Card Renewal Fee Coop")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ATM Card Renewal Fee Sacco"; Rec."ATM Card Renewal Fee Sacco")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("CRB Check Charge"; Rec."CRB Check Charge")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("CRB Check Vendor Charge"; Rec."CRB Check Vendor Charge")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Internal Transfer Fee"; Rec."Internal Transfer Fee")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("FB ATM Withdrawal Limit"; Rec."FB ATM Withdrawal Limit")
                {
                    ApplicationArea = Basic;
                    Caption = 'Family Bank ATM Withdrawal Limit';
                    Visible = false;
                }
            }
            group("Fees & Commissions Accounts")
            {
                Caption = 'Fees & Commissions Accounts';
                field("Loan Trasfer Fee A/C-EFT"; Rec."Loan Trasfer Fee A/C-EFT") { ApplicationArea = all; }
                field("Loan Trasfer Fee A/C-Cheque"; Rec."Loan Trasfer Fee A/C-Cheque") { ApplicationArea = all; }
                field("Loan Trasfer Fee A/C-RTGS"; Rec."Loan Trasfer Fee A/C-RTGS") { ApplicationArea = all; }
                field("Mpesa A/c"; Rec."Mpesa A/c") { ApplicationArea = all; }

                field("Withdrawal Fee Account"; Rec."Withdrawal Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Registration Fee Account"; Rec."FOSA Registration Fee Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("BOSA Registration Fee Account"; Rec."BOSA Registration Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Rejoining Fees Account"; Rec."Rejoining Fees Account")
                {
                    ApplicationArea = Basic;
                }
                field("Insurance Retension Account"; Rec."Insurance Retension Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("WithHolding Tax Account"; Rec."WithHolding Tax Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'WithHolding Tax Account ';
                }
                field("Deposit Boosting A/C"; Rec."Deposit Boosting A/C")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Acc Dividend"; Rec."Withholding Tax Acc Dividend")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Retension Account"; Rec."Shares Retension Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Transfer Fees Account"; Rec."Loan Transfer Fees Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Boosting Fees Account"; Rec."Boosting Fees Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Bridging Commision Account"; Rec."Bridging Commision Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Funeral Expenses Account"; Rec."Funeral Expenses Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Dividend Payable Account"; Rec."Dividend Payable Account")
                {
                    ApplicationArea = Basic;
                }
                field("IOD Account"; Rec."IOD Account") { ApplicationArea = all; }
                field("Dividend Process Fee Account"; Rec."Dividend Process Fee Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Dividend Processing Fee Account';
                }
                field("Excise Duty Account"; Rec."Excise Duty Account")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Fee Account"; Rec."SMS Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Discounting Fee Account"; Rec."Cheque Discounting Fee Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Deposit Refund On DeathAccount"; Rec."Deposit Refund On DeathAccount")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Attachment Comm. Account"; Rec."Loan Attachment Comm. Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Share Capital Transfer Fee Acc"; Rec."Share Capital Transfer Fee Acc")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Partial Deposit Refund Fee A/C"; Rec."Partial Deposit Refund Fee A/C")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Penalty On Deposit Arrears A/C"; Rec."Penalty On Deposit Arrears A/C")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Caption = 'Penalty On Failed Monthly Contr. Account';
                }
                field("CRB Vendor Account"; Rec."CRB Vendor Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("CRB Check SACCO income A/C"; Rec."CRB Check SACCO income A/C")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Benevolent Fund Account"; Rec."Benevolent Fund Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ATM Card Co-op Bank Account"; Rec."ATM Card Co-op Bank Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("ATM Card Income Account"; Rec."ATM Card Income Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Cheque Processing Fee Account"; Rec."Cheque Processing Fee Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Cheque Clearing Family Income"; Rec."Cheque Clearing Family Income")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cheque Clearing Family Income Control';
                    Visible = false;
                }
                field("Unpaid Cheques Fee Account"; Rec."Unpaid Cheques Fee Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Internal Transfer Fee Account"; Rec."Internal Transfer Fee Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Paybill Suspense Account"; Rec."Paybill Suspense Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Internal PV Control Account"; Rec."Internal PV Control Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("New Piggy Bank Debit G/L"; Rec."New Piggy Bank Debit G/L")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("New Piggy Bank Credit G/L"; Rec."New Piggy Bank Credit G/L")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            group("SMS Notifications")
            {
                field("Send Membership App SMS"; Rec."Send Membership App SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Membership Application SMS';
                }
                field("Send Membership Reg SMS"; Rec."Send Membership Reg SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Membership Registration SMS';
                }
                field("Send Loan App SMS"; Rec."Send Loan App SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Loan Application SMS';
                }
                field("Send Loan Disbursement SMS"; Rec."Send Loan Disbursement SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Loan Disbursement SMS';
                }
                field("Send Guarantorship SMS"; Rec."Send Guarantorship SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Guarantorship SMS';
                }
                field("Send Membership Withdrawal SMS"; Rec."Send Membership Withdrawal SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Membership Withdrawal SMS';
                }
                field("Send ATM Withdrawal SMS"; Rec."Send ATM Withdrawal SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send ATM Withdrawal SMS';
                    Visible = false;
                }
                field("Send Cash Withdrawal SMS"; Rec."Send Cash Withdrawal SMS")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Cash Withdrawal SMS';
                    Visible = false;
                }
                field("SMS Alert Fees"; Rec."SMS Alert Fees")
                {
                    ApplicationArea = Basic;
                    Caption = 'SMS Alert Fees';
                    Visible = false;
                }
                field("SMS Alert Fee Account"; Rec."SMS Alert Fee Account")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Active SMS Service Provider"; Rec."Active SMS Service Provider")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            group("Email Notifications")
            {
                field("Send Membership App Email"; Rec."Send Membership App Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Membership Reg Email"; Rec."Send Membership Reg Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Loan App Email"; Rec."Send Loan App Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Loan Disbursement Email"; Rec."Send Loan Disbursement Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Guarantorship Email"; Rec."Send Guarantorship Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send Membship Withdrawal Email"; Rec."Send Membship Withdrawal Email")
                {
                    ApplicationArea = Basic;
                }
                field("Send ATM Withdrawal Email"; Rec."Send ATM Withdrawal Email")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Send Cash Withdrawal Email"; Rec."Send Cash Withdrawal Email")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            group("Departmental Emails")
            {
                Visible = false;
                field("Credit Department E-mail"; Rec."Credit Department E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("Operations Department E-mail"; Rec."Operations Department E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("Finance Department E-mail"; Rec."Finance Department E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("BD Department E-mail"; Rec."BD Department E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("IT Department E-mail"; Rec."IT Department E-mail")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Demand Notice Period")
            {
                field("1st Demand Notice Days"; Rec."1st Demand Notice Days")
                {
                    ApplicationArea = Basic;
                }
                field("2nd Demand Notice Days"; Rec."2nd Demand Notice Days")
                {
                    ApplicationArea = Basic;
                }
                field("CRB Notice Days"; Rec."CRB Notice Days")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leaders Notice Days"; Rec."Group Leaders Notice Days")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Auctioneer Notice Days"; Rec."Auctioneer Notice Days")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Member Notice Days"; Rec."Member Notice Days")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Repetitive SMS Frequency Days"; Rec."Repetitive SMS Frequency Days")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Group Members Notice Days"; Rec."Group Members Notice Days")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Mobile Loan CRB Notice Days"; Rec."Mobile Loan CRB Notice Days")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            group("SASRA Required Provisions")
            {
                Caption = 'SASRA Required Provision %';
                field("Performing Required Provision%"; Rec."Performing Required Provision%")
                {
                    ApplicationArea = Basic;
                    Caption = 'Performing';
                }
                field("Watch Required Provision%"; Rec."Watch Required Provision%")
                {
                    ApplicationArea = Basic;
                    Caption = 'Watch';
                }
                field("Substandar Required Provision%"; Rec."Substandar Required Provision%")
                {
                    ApplicationArea = Basic;
                    Caption = 'Substandard';
                }
                field("Doubtful Required Provision%"; Rec."Doubtful Required Provision%")
                {
                    ApplicationArea = Basic;
                    Caption = 'Doubtful';
                }
                field("Loss Required Provision%"; Rec."Loss Required Provision%")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loss';
                }
            }

        }
    }

    actions
    {
        area(navigation)
        {
            group("Shares Bands")
            {
                Caption = 'Shares Bands';
            }
        }

    }

    var

}




