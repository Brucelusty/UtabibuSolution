//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 172049 "Cash Office Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(172001; "Normal Payments No"; Code[10])
        {
            Caption = 'Normal Payments No';
            TableRelation = "No. Series";
        }
        field(172002; "Cheque Reject Period"; DateFormula)
        {
        }
        field(172003; "Petty Cash Payments No"; Code[10])
        {
            Caption = 'Petty Cash Payments No';
            TableRelation = "No. Series";
        }
        field(172004; "Current Budget"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(172005; "Current Budget Start Date"; Date)
        {
        }
        field(172006; "Current Budget End Date"; Date)
        {
        }
        field(172009; "Surrender Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(172010; "Surrender  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Surrender Template"));
        }
        field(172011; "Payroll Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(172012; "Payroll  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(172013; "Payroll Control A/C"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(172014; "PV Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(172015; "PV  Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(172016; "Contract No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(172017; "Receipts No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(172018; "Petty Cash Voucher  Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(172019; "Petty Cash Voucher Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name;
        }
        field(172020; "Max. Petty Cash Request"; Decimal)
        {
        }
        field(172022; "Imprest Req No"; Code[20])
        {
            Caption = 'Receipts No';
            TableRelation = "No. Series";
        }
        field(172023; "Quotation Request No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(172024; "Tender Request No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(172025; "Transport Pay Type"; Code[20])
        {
        }
        field(172026; "Minimum Chargeable Weight"; Decimal)
        {
        }
        field(172027; "Imprest Surrender No"; Code[20])
        {
            Caption = 'Imprest Surrender No';
            TableRelation = "No. Series";
        }
        field(172028; "Bank Deposit No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(172029; "InterBank Transfer No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(172030; "PA Payment Vouchers Nos"; Code[20])
        {
            Caption = 'Farmers Payment Vouchers Nos.';
            TableRelation = "No. Series".Code;
        }
        field(172031; "Cash Request Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172032; "Cash Issue Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172033; "Cash Receipt Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172034; "Cash Transfer Template"; Code[10])
        {
            TableRelation = "Gen. Journal Template".Name;
        }
        field(172035; "Cash Transfer Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Cash Transfer Template"));
        }
        field(172036; "Enable AutoTeller Monitor"; Boolean)
        {
        }
        field(172037; "Alert After ?(Mins)"; Integer)
        {
        }
        field(172038; "Transporter Depot"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(172039; "Transporter Department"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(172040; "Transporter Cashier"; Code[20])
        {
            TableRelation = "Cash Office User Template";
        }
        field(172041; "Transporter PayType"; Code[20])
        {
            TableRelation = "Funds Transaction Types"."Transaction Code" where("Transaction Type" = const(Payment));
        }
        field(172042; "Cashier Transfer Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172043; "Interim Transfer Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(172044; "Default Bank Deposit Slip A/C"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(172045; "Apply Cash Expenditure Limit"; Boolean)
        {
        }
        field(172046; "Expenditure Limit Amount(LCY)"; Decimal)
        {
        }
        field(172050; "Staff Claim No."; Code[20])
        {
            Caption = 'Staff Claim No';
            TableRelation = "No. Series";
        }
        field(172051; "Other Staff Advance No."; Code[20])
        {
            Caption = 'Other Staff Advance No';
            TableRelation = "No. Series";
        }
        field(172052; "Staff Advance Surrender No."; Code[20])
        {
            Caption = 'Staff Adv. Surrender No';
            TableRelation = "No. Series";
        }
        field(172053; "Prompt Cash Reimbursement"; Boolean)
        {
        }
        field(172054; "Use Central Payment System"; Boolean)
        {
        }
        field(172060; "Payment Request Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(172061; "Journal Voucher Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(172070; "Minimum Cheque Creation Amount"; Decimal)
        {
            Description = 'Starting Amount to create a check';
        }
        field(172071; "Grant Surrender Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172072; "Cash Purchases"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(172073; "Board Payment Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172074; "Committee Payment Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172075; "Board PV Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172076; "Committee PV Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(172077; "Cash Collection A/C"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(172078; "Cheque Collection A/C"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(172079; "MPESA Collection A/C"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(172080; "Airtel Collection A/C"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(172081; "Mobile Money Payment Nos"; Code[20])
        {
        }
        field(172082; "Casual Req. No's"; Code[20])
        {
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}




