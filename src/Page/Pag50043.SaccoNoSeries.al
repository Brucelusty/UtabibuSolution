//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50043 "Sacco No. Series"
{
    DeleteAllowed = false;
    Editable = true;
    SourceTable = "Sacco No. Series";
    UsageCategory = Administration;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("SMS Request Series"; Rec."SMS Request Series")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Credit)
            {
                Caption = 'Credit';
                field("Member Application Nos"; Rec."Member Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Loans"; Rec."Micro Loans")
                {
                    ApplicationArea = Basic;
                }
                field("Members Nos"; Rec."Members Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Member Group Nos"; Rec."Member Group Nos")
                {
                    ApplicationArea = basic;
                }
                field("BOSA Loans Nos"; Rec."BOSA Loans Nos")
                {
                    ApplicationArea = Basic;
                }
                field("E-Loan Nos"; Rec."E-Loan Nos")
                {
                    ApplicationArea = Basic;
                }

                field("Loans Batch Nos"; Rec."Loans Batch Nos")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Receipts Nos"; Rec."BOSA Receipts Nos")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Transfer Nos"; Rec."BOSA Transfer Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Closure  Nos"; Rec."Closure  Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Bosa Transaction Nos"; Rec."Bosa Transaction Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill Processing"; Rec."Paybill Processing")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff-Proc Distributed Nos"; Rec."Checkoff-Proc Distributed Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff Proc Block Nos"; Rec."Checkoff Proc Block Nos")
                {
                    ApplicationArea = Basic;
                }
                field(BosaNumber; rec.BosaNumber)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No Used';
                }
                field("Loan PayOff Nos"; Rec."Loan PayOff Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Microfinance Last No Used"; Rec."Microfinance Last No Used")
                {
                    ApplicationArea = Basic;
                }
                field("MicroFinance Account Prefix"; Rec."MicroFinance Account Prefix")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Transactions"; Rec."Micro Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Micro Finance Transactions"; Rec."Micro Finance Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Register No"; Rec."Collateral Register No")
                {
                    ApplicationArea = Basic;
                }
                field("Cloudpesa Reg No."; Rec."Mobile Reg No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile Application No.';
                }
                field("Safe Custody Package Nos"; Rec."Safe Custody Package Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Safe Custody Agent Nos"; Rec."Safe Custody Agent Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Safe Custody Item Nos"; Rec."Safe Custody Item Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Package Retrieval Nos"; Rec."Package Retrieval Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Member Cell Group Nos"; Rec."Member Cell Group Nos")
                {
                    ApplicationArea = Basic;
                }
                field("House Change Request No"; Rec."House Change Request No")
                {
                    ApplicationArea = Basic;
                }
                field("BD Training Nos"; Rec."BD Training Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Member Agent/NOK Change"; Rec."Member Agent/NOK Change")
                {
                    ApplicationArea = Basic;
                }
                field("House Group Application"; Rec."House Group Application")
                {
                    ApplicationArea = Basic;
                    Caption = 'Group Application Nos';
                }
                field("House Group Nos"; Rec."House Group Nos")
                {
                    ApplicationArea = Basic;
                }
                field("CRB Charge"; Rec."CRB Charge")
                {
                    ApplicationArea = Basic;
                    Caption = 'CRB Check Charge No';
                }
                field("Over Draft Application No"; Rec."Over Draft Application No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Restructure"; Rec."Loan Restructure")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Movement No"; Rec."Collateral Movement No")
                {
                    ApplicationArea = Basic;
                }
                field("Sweeping Instructions"; Rec."Sweeping Instructions")
                {
                    ApplicationArea = Basic;
                }
                field("Employers Nos"; Rec."Employers Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Statements"; Rec."Scheduled Statements")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll Document No"; Rec."Payroll Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Audit issue Tracker"; Rec."Audit issue Tracker")
                {
                    ApplicationArea = Basic;
                }
                field("Guarantor Sub No."; Rec."Guarantor Sub No.")
                {
                    ApplicationArea = Basic;
                }
                field("Standing Order Members Nos"; Rec."Standing Order Members Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Change Request No"; Rec."Change Request No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Banking Services")
            {
                Caption = 'Banking Services';
                field("FOSA Loans Nos"; Rec."FOSA Loans Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Nos."; Rec."Transaction Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Treasury Nos."; Rec."Treasury Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Standing Orders Nos."; Rec."Standing Orders Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Current Account"; Rec."FOSA Current Account")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Current Account"; Rec."BOSA Current Account")
                {
                    ApplicationArea = Basic;
                }
                field("Teller Transactions No"; Rec."Teller Transactions No")
                {
                    ApplicationArea = Basic;
                }
                field("Treasury Transactions No"; Rec."Treasury Transactions No")
                {
                    ApplicationArea = Basic;
                }
                field("Applicants Nos."; Rec."Applicants Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("STO Register No"; Rec."STO Register No")
                {
                    ApplicationArea = Basic;
                }
                field("EFT Header Nos."; Rec."EFT Header Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("EFT Details Nos."; Rec."EFT Details Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Processing Nos"; Rec."Salary Processing Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Salaries Nos."; Rec."Salaries Nos.")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Applications"; Rec."ATM Applications")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Clearing Nos"; Rec."Cheque Clearing Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Application Nos"; Rec."Cheque Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Receipts Nos"; Rec."Cheque Receipts Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Care Log Nos"; Rec."Customer Care Log Nos")
                {
                    ApplicationArea = Basic;
                }
                field("S_Mobile Registration Nos"; Rec."S_Mobile Registration Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Trunch Disbursment Nos"; Rec."Trunch Disbursment Nos")
                {
                    ApplicationArea = Basic;
                }

                field("Agent Serial Nos"; Rec."Agent Serial Nos")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Batch Nos"; Rec."ATM Card Batch Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Batch Nos"; Rec."Cheque Book Batch Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Demand Notice Nos"; Rec."Demand Notice Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Placement"; Rec."Fixed Deposit Placement")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Account Nos"; Rec."Cheque Book Account Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Signatories Application Doc No"; Rec."Signatories Application Doc No")
                {
                    ApplicationArea = Basic;
                }
                field("Signatories Document No"; Rec."Signatories Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Account Agent App"; Rec."Member Account Agent App")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Agent Document No';
                }
                field("Member Account Agent"; Rec."Member Account Agent")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Agent Document No';
                }
                field("Account Freezing No"; Rec."Account Freezing No")
                {
                    ApplicationArea = Basic;
                }
                field("Internal PV Document"; Rec."Internal PV Document")
                {
                    ApplicationArea = Basic;
                }
                field("Journal Batch Doc. No"; Rec."Journal Batch Doc. No")
                {
                    ApplicationArea = Basic;
                }
                field("Piggy Bank No"; Rec."Piggy Bank No")
                {
                    ApplicationArea = Basic;
                }

            }
            group("Finance/Others")
            {
                Caption = 'Finance/Others';
                field("Finance UpLoads"; Rec."Finance UpLoads")
                {
                    ApplicationArea = Basic;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = Basic;
                }
                field("Internal Requisition No."; Rec."Internal Requisition No.")
                {
                    ApplicationArea = Basic;
                }
                field("Internal Purchase No."; Rec."Internal Purchase No.")
                {
                    ApplicationArea = Basic;
                }
                field("Quatation Request No"; Rec."Quatation Request No")
                {
                    ApplicationArea = Basic;
                }
                field("Stores Requisition No"; Rec."Stores Requisition No")
                {
                    ApplicationArea = Basic;
                }
                field("Requisition Default Vendor"; Rec."Requisition Default Vendor")
                {
                    ApplicationArea = Basic;
                }
                field("Use Procurement limits"; Rec."Use Procurement limits")
                {
                    ApplicationArea = Basic;
                }
                field("Request for Quotation Nos"; Rec."Request for Quotation Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investors Nos"; Rec."Investors Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Property Nos"; Rec."Property Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investment Project Nos"; Rec."Investment Project Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax %"; Rec."Withholding Tax %")
                {
                    ApplicationArea = Basic;
                }
                field("Withholding Tax Account"; Rec."Withholding Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Account"; Rec."VAT Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Investor)
            {
                Caption = 'Investor';
                field("Investor Application Nos"; Rec."Investor Application Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Investor Nos"; Rec."Investor Nos")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill No."; Rec."Paybill No.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}




