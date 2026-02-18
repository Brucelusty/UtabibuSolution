//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 172390 "ReceiptsProcessing_L-Checkoff"
{

    fields
    {
        field(1; "Staff/Payroll No"; Code[20])
        {
        }
        field(2; Amount; Decimal)
        {
        }
        field(3; "No Repayment"; Boolean)
        {
        }
        field(4; "Staff Not Found"; Boolean)
        {
        }
        field(5; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(6; "Transaction Date"; Date)
        {
        }
        field(8; Generated; Boolean)
        {
        }
        field(9; "Payment No"; Integer)
        {
        }
        field(10; Posted; Boolean)
        {
        }
        field(11; "Multiple Receipts"; Boolean)
        {
        }
        field(12; Name; Text[200])
        {
        }
        field(13; "Early Remitances"; Boolean)
        {
        }
        field(14; "Early Remitance Amount"; Decimal)
        {
        }
        field(15; "Trans Type"; Option)
        {
            OptionCaption = ' ,sShare,sLoan,sDeposits,sInterest,sInsurance,sBenevolent';
            OptionMembers = " ",sShare,sLoan,sDeposits,sInterest,sInsurance,sBenevolent;
        }
        field(16; Description; Text[60])
        {
        }
        field(17; "Member Found"; Boolean)
        {
        }
        field(18; "Search Index"; Code[20])
        {
        }
        field(19; "Loan Found"; Boolean)
        {
        }
        field(20; "Loan No"; Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where(Posted = const(true),
                                                                "Client Code" = field("Member No"));

            trigger OnValidate()
            begin

            end;
        }
        field(21; User; Code[20])
        {
        }
        field(22; "Member Moved"; Boolean)
        {
        }
        field(23; "Employer Code"; Code[20])
        {
        }
        field(24; "Batch No."; Code[30])
        {
            TableRelation = "Loan Disburesment-Batching"."Batch No.";
        }
        field(25; "Member No"; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = filter(true));

            trigger OnValidate()
            begin



            end;
        }
        field(26; "ID No."; Code[20])
        {
        }
        field(27; "Receipt Header No"; Code[20])
        {
            TableRelation = "ReceiptsProcessing_H-Checkoff".No;
        }
        field(28; "Receipt Line No"; Integer)
        {
            //AutoIncrement = true;
        }
        field(29; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,None,Staff';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,"None",Staff;
        }
        field(30; "Entry No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Receipt Header No", "Staff/Payroll No")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }

    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Posted = true then
            Error('You cannot delete a Posted Check Off');
    end;

    trigger OnModify()
    begin
        if Posted = true then
            Error('You cannot modify a Posted Check Off');
    end;

    trigger OnRename()
    begin
        if Posted = true then
            Error('You cannot rename a Posted Check Off');
    end;

    var
        memb: Record Customer;
        loans: Record "Loans Register";
}




