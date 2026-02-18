//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 80083 "Account Types Card"
{
    Editable = true;
    PageType = Card;
    SourceTable = "Account Types-Saving Products";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Account No Prefix"; Rec."Account No Prefix")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No Prefix';
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch';
                }
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = Basic;
                }
                field("Last No Used"; Rec."Last No Used")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Description"; Rec."SMS Description")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Group';
                }
                field("Dormancy Period (M)"; Rec."Dormancy Period (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Dormancy Period (-M)"; Rec."Dormancy Period (-M)")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Interval"; Rec."Withdrawal Interval")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Penalty"; Rec."Withdrawal Penalty")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Interval Account"; Rec."Withdrawal Interval Account")
                {
                    ApplicationArea = Basic;
                }
                field("Requires Opening Deposit"; Rec."Requires Opening Deposit")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Loan Applications"; Rec."Allow Loan Applications")
                {
                    ApplicationArea = Basic;
                }
                field("Use Savings Account Number"; Rec."Use Savings Account Number")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit"; Rec."Fixed Deposit")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Balance"; Rec."Minimum Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Bulk Withdrawal Amount"; Rec."Bulk Withdrawal Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Standing Orders Suspense"; Rec."Standing Orders Suspense")
                {
                    ApplicationArea = Basic;
                }
                field("Bankers Cheque Account"; Rec."Bankers Cheque Account")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Withdrawal Amount"; Rec."Maximum Withdrawal Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Allowable Deposit"; Rec."Maximum Allowable Deposit")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Recovery"; Rec."Check Off Recovery")
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Priority"; Rec."Recovery Priority")
                {
                    ApplicationArea = Basic;
                }
                field("Use Graduated Charges"; Rec."Use Graduated Charges")
                {
                    ApplicationArea = Basic;
                }
                field("Default Account"; Rec."Default Account")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum No Of Accounts"; Rec."Maximum No Of Accounts")
                {
                    ApplicationArea = Basic;
                    ToolTip = 'Specify the maximum no of accounts a member can have for this product';
                }
                field("Individual Account"; Rec."Individual Account")
                {
                    ApplicationArea = Basic;
                }
                field("Primary Account"; Rec."Primary Account")
                {
                    ApplicationArea = all;
                }
                field("Corporate Account"; Rec."Corporate Account")
                {
                    ApplicationArea = Basic;
                }
                field("Over Draft Account"; Rec."Over Draft Account")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Overdraft Period"; Rec."Maximum Overdraft Period")
                {
                    ApplicationArea = Basic;
                }
                field("Default Piggy Bank Issuance"; Rec."Default Piggy Bank Issuance")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Interest Computation")
            {
                Caption = 'Interest Computation';
                field("Earns Interest"; Rec."Earns Interest")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        InterestVisible := false;

                        if Rec."Earns Interest" = true then
                            InterestVisible := true;
                    end;
                }
                field("Interest Calc Min Balance"; Rec."Interest Calc Min Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Min. Balance';
                }
                field("Minimum Interest Period (M)"; Rec."Minimum Interest Period (M)")
                {
                    ApplicationArea = Basic;
                }
                field("Tax On Interest"; Rec."Tax On Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Account Openning Fee"; Rec."Account Openning Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Openning Deposit';
                }
                field("Re-activation Fee"; Rec."Re-activation Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Requires Closure Notice"; Rec."Requires Closure Notice")
                {
                    ApplicationArea = Basic;
                }
                field("Closure Notice Period"; Rec."Closure Notice Period")
                {
                    ApplicationArea = Basic;
                }
                field("Closing Charge"; Rec."Closing Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Closing Prior Notice Charge"; Rec."Closing Prior Notice Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Min Bal. Calc Frequency"; Rec."Min Bal. Calc Frequency")
                {
                    ApplicationArea = Basic;
                }
                field("Fee Below Minimum Balance"; Rec."Fee Below Minimum Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Over Draft Interest Rate"; Rec."Over Draft Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Over Draft Interest Account"; Rec."Over Draft Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Overdraft Charge"; Rec."Overdraft Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Authorised Ovedraft Charge"; Rec."Authorised Ovedraft Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Service Charge"; Rec."Service Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Maintenence Fee"; Rec."Maintenence Fee")
                {
                    ApplicationArea = Basic;
                }
                field("External EFT Charges"; Rec."External EFT Charges")
                {
                    ApplicationArea = Basic;
                }
                field("Internal EFT Charges"; Rec."Internal EFT Charges")
                {
                    ApplicationArea = Basic;
                }
                field("RTGS Charges"; Rec."RTGS Charges")
                {
                    ApplicationArea = Basic;
                }
                field("Statement Charge"; Rec."Statement Charge")
                {
                    ApplicationArea = Basic;
                }
                field("New Piggy Bank Fee"; Rec."New Piggy Bank Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Additional Piggy Bank Fee"; Rec."Additional Piggy Bank Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Duration"; Rec."Savings Duration")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Withdrawal penalty"; Rec."Savings Withdrawal penalty")
                {
                    ApplicationArea = Basic;
                }
                field("Term terminatination fee"; Rec."Term terminatination fee")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Shares"; Rec."FOSA Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = all;

                }
            }
            part(Control3; "Account Types Interest Rates")
            {
                SubPageLink = "Account Type" = field(Code);
                Visible = InterestVisible;
            }
            group("Fees & Comissions Accounts")
            {
                Caption = 'Fees & Comissions Accounts';
                field("Interest Expense Account"; Rec."Interest Expense Account")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Payable Account"; Rec."Interest Payable Account")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Forfeited Account"; Rec."Interest Forfeited Account")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Tax Account"; Rec."Interest Tax Account")
                {
                    ApplicationArea = Basic;
                }
                field("Account Openning Fee Account"; Rec."Account Openning Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Re-activation Fee Account"; Rec."Re-activation Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Fee bellow Min. Bal. Account"; Rec."Fee bellow Min. Bal. Account")
                {
                    ApplicationArea = Basic;
                }
                field("EFT Charges Account"; Rec."EFT Charges Account")
                {
                    ApplicationArea = Basic;
                }
                field("RTGS Charges Account"; Rec."RTGS Charges Account")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Penalty Account"; Rec."Savings Penalty Account")
                {
                    ApplicationArea = Basic;
                }
                field("Term Termination Account"; Rec."Term Termination Account")
                {
                    ApplicationArea = Basic;
                }
                field("Piggy Bank Fee Account"; Rec."Piggy Bank Fee Account")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        InterestVisible := false;

        if Rec."Earns Interest" = true then
            InterestVisible := true;
    end;

    trigger OnAfterGetRecord()
    begin
        InterestVisible := false;

        if Rec."Earns Interest" = true then
            InterestVisible := true;
    end;

    var
        InterestVisible: Boolean;
}




