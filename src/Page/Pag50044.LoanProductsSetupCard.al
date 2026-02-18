//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50044 "Loan Products Setup Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Products Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = Basic;
                }
                field("Paybill Code"; Rec."Paybill Code") { }
                field(Source; rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Interest Rate"; Rec."Minimum Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Interest Rate"; Rec."Maximum Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate"; Rec."Interest rate")
                {
                    ApplicationArea = Basic;
                    Caption = 'Default Interest Rate';
                }

                field("Charge First Int"; Rec."Charge First Int")
                {

                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Principle (M)"; Rec."Grace Period - Principle (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period - Interest (M)"; Rec."Grace Period - Interest (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Instalment Period"; Rec."Instalment Period")
                {
                    ApplicationArea = Basic;
                }
                field("No of Installment"; Rec."No of Installment")
                {
                    ApplicationArea = Basic;
                }
                field("Default Installements"; Rec."Default Installements")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Calculation Days"; Rec."Penalty Calculation Days")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Penalty Percentage"; Rec."Penalty Percentage")
                {
                    ApplicationArea = Basic;

                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                    ApplicationArea = Basic;
                    visible = false;

                }
                field("Min No. Of Guarantors"; Rec."Min No. Of Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Min Re-application Period"; Rec."Min Re-application Period")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Deposits Multiplier"; Rec."Deposits Multiplier")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits Multiplier';
                }
                field("Deposit Multiplier 1st Loan"; Rec."Deposit Multiplier 1st Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Calculation Method"; Rec."Penalty Calculation Method")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Self guaranteed Multiplier"; Rec."Self guaranteed Multiplier")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Loan Product Expiry Date"; Rec."Loan Product Expiry Date")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Maximum No of Active Loans"; Rec."Maximum No of Active Loans")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specify the Maximum No of Active Loans a Member can have on this Product';
                }
                field("Min. Loan Amount"; Rec."Min. Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Loan Amount"; Rec."Max. Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Recovery"; Rec."Check Off Recovery")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Allowable Loan Offset(%)"; Rec."Allowable Loan Offset(%)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("TOPUp Qualification %"; Rec."TOPUp Qualification %")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("TOPUp 1 Qualification %"; Rec."TOPUp 1 Qualification %")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Top Up Commision"; Rec."Top Up Commision")
                {
                    ApplicationArea = Basic;
                    Caption = 'Top Up Interest';
                    visible = false;
                }
                field("Loan Boosting Commission %"; Rec."Loan Boosting Commission %")
                {
                    ApplicationArea = Basic;
                }
                field("Topup1_Super Plus offset Comm%"; Rec."Topup1_Super Plus offset Comm%")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Loan PayOff Fee(%)"; Rec."Loan PayOff Fee(%)")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }
                field("Dont Recover Repayment"; Rec."Dont Recover Repayment")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Special Code"; Rec."Special Code")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Is Staff Loan"; Rec."Is Staff Loan")
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Method"; Rec."Recovery Method")
                {
                    ApplicationArea = Basic;
                }
                field(Deductible; rec.Deductible)
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Qualification for Saver(%)"; Rec."Qualification for Saver(%)")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Amortization Interest Rate(SI)"; Rec."Amortization Interest Rate(SI)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amortization Interest Rate(Sacco Interest)';
                    visible = false;
                }
                field("Accrue Total Insurance&Interes"; Rec."Accrue Total Insurance&Interes")
                {
                    ApplicationArea = Basic;
                    Caption = 'Accrue Total Insurance & Interest on Disburesment';
                    visible = false;
                }
                field("Minimum Deposit For Loan Appl"; Rec."Minimum Deposit For Loan Appl")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("FOSA Loan Shares Ratio"; Rec."FOSA Loan Shares Ratio")
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Loan Shares Ratio';
                    ToolTip = 'Specify the % of Deposits to Qualify For';
                    visible = false;
                }
                field("OneOff  Loan Repayment"; Rec."OneOff  Loan Repayment")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Charge Interest Upfront"; Rec."Charge Interest Upfront")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Recovery Mode"; Rec."Recovery Mode")
                { }
                field("Total Credits"; Rec."Total Credits")
                {
                    ApplicationArea = basic;
                }
                field("Total Debits"; Rec."Total Debits")
                {
                    ApplicationArea = basic;
                }
                field("Product Totals"; Rec."Product Totals")
                {
                    ApplicationArea = basic;
                }
                field("Availabe Mobile Loan"; Rec."Availabe Mobile Loan")
                {

                }
            }
            group("Qualification Criteria")
            {
                Caption = 'Qualification Criteria';
                field("Appraise Deposits"; Rec."Appraise Deposits")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits';
                }
                field("Appraise Shares"; Rec."Appraise Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Shares';
                }
                field("Appraise Salary"; Rec."Appraise Salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary';
                }
                field("Appraise Bank Statement"; Rec."Appraise Bank Statement")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Appraise Guarantors"; Rec."Appraise Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Collateral"; Rec."Appraise Collateral")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Dividend"; Rec."Appraise Dividend")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            group("Fees & Comissions Accounts")
            {
                Caption = 'Fees & Comissions Accounts';
                field("Penalty Paid Account"; Rec."Penalty Paid Account")
                {
                    ApplicationArea = Basic;

                }
                field("Penalty Charged Account"; Rec."Penalty Charged Account")
                {
                    ApplicationArea = Basic;

                }
                field("Loan Account"; Rec."Loan Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Interest Account"; Rec."Loan Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Receivable Interest Account"; Rec."Receivable Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Commision Account"; Rec."Top Up Commision Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Top Up Interest Account';
                }
                field("Interest In Arrears Account"; Rec."Interest In Arrears Account")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Loan PayOff Fee Account"; Rec."Loan PayOff Fee Account")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Receivable Insurance Accounts"; Rec."Receivable Insurance Accounts")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Loan Insurance Accounts"; Rec."Loan Insurance Accounts")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Loan Interest Restructure A/C"; Rec."Loan Interest Restructure A/C")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Loan Insurance Restructure A/C"; Rec."Loan Insurance Restructure A/C")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
                field("Loan Penalty Restructure A/C"; Rec."Loan Penalty Restructure A/C")
                {
                    ApplicationArea = Basic;
                    visible = false;
                }
            }
            group("Loan Numbering")
            {
                Caption = 'Loan Numbering';
                visible = false;
                field("Loan No(HQ)"; Rec."Loan No(HQ)")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No(NAIV)"; Rec."Loan No(NAIV)")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No(ELD)"; Rec."Loan No(ELD)")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No(MSA)"; Rec."Loan No(MSA)")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No(NKR)"; Rec."Loan No(NKR)")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Product)
            {
                Caption = 'Product';
                action("Product Charges")
                {
                    ApplicationArea = Basic;
                    Caption = 'Product Charges';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Product Charges";
                    RunPageLink = "Product Code" = field(Code);
                }
                action("Loan to Share Ratio Analysis")
                {
                    ApplicationArea = Basic;
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Product Deposit>Loan Analysis";
                    RunPageLink = "Product Code" = field(Code);
                }
            }
        }
    }
}




