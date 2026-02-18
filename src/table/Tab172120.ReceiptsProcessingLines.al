Table 172120 "Receipts Processing Lines"
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
        field(15; "Trans Type"; Code[20])
        {
            TableRelation = "Checkoff Products";
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
            TableRelation = "Loans Register"."Loan  No." where(Posted = filter(true),
                                                                       "Client Code" = field("Member No"),
                                                                       "Outstanding Balance" = filter(> 0));

            trigger OnValidate()
            begin
                /* memb.RESET;
                 memb.SETRANGE(memb."No.","Member No");
                 IF memb.FIND('-') THEN BEGIN
                  loans.RESET;
                  loans.SETRANGE(loans."Loan  No.","Loan No");
                  IF loans.FIND('-') THEN BEGIN
                   IF "Trans Type"="Trans Type"::"5" THEN BEGIN
                    Amount:=100;
                   END ELSE IF "Trans Type"="Trans Type"::"3" THEN BEGIN
                   loans.CALCFIELDS(loans."Interest Due",loans."Outstanding Balance");
                  /// IF loans."Interest Due">0 THEN
                  // Amount:=loans."Interest Due";
                    Amount:=0.01*loans."Outstanding Balance";
                   END ELSE IF  "Trans Type"="Trans Type"::"2" THEN BEGIN
                   Amount:=loans.Repayment;
                  END;
                END;
                END;
                 */

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

        }
        field(25; "Member No"; Code[20])
        {
            TableRelation = Customer."No." where(ISNormalMember = filter(true));

            trigger OnValidate()
            begin
                /*memb.RESET;
                memb.SETRANGE(memb."No.","Member No");
                IF memb.FIND('-') THEN BEGIN
                "Staff/Payroll No":=memb."Payroll/Staff No";
                "ID No.":=memb."ID No.";
                Name:=memb.Name;
                "Employer Code":=memb."Employer Code";
                IF "Trans Type"="Trans Type"::"1" THEN BEGIN
                Amount:=memb."Monthly Contribution"
                END ELSE IF "Trans Type"="Trans Type"::"4" THEN BEGIN
                Amount:=200
                END ELSE IF "Trans Type"="Trans Type"::"5" THEN BEGIN
                Amount:=100
                END ELSE IF "Trans Type"="Trans Type"::"6" THEN BEGIN
                //memb.CALCFIELDS(memb."KMA Withdrawable Savings");
                //Amount:=memb."KMA Withdrawable Savings"*-1;
                END ELSE IF "Trans Type"="Trans Type"::"7" THEN BEGIN
                //memb.CALCFIELDS(memb."Children Savings");
                //Amount:=memb."Children Savings"*-1;
                END ELSE IF "Trans Type"="Trans Type"::"8" THEN BEGIN
                //memb.CALCFIELDS(memb."CIC Fixed Deposits");
                //Amount:=memb."CIC Fixed Deposits"*-1;
                END ELSE IF "Trans Type"="Trans Type"::"9" THEN BEGIN
                //memb.CALCFIELDS(memb."UAP Premiums");
                //Amount:=memb."UAP Premiums"*-1;
                
                
                
                
                END;
                END;
                 */

            end;
        }
        field(26; "ID No."; Code[20])
        {
        }
        field(27; "Receipt Header No"; Code[20])
        {
            TableRelation = "Receipts Processing Header".No;
        }
        field(28; "Receipt Line No"; Integer)
        {
        }
        field(29; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Member,None,Staff';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,"None",Staff;
        }
        field(30; "Entry No"; Integer)
        {
        }
        field(31; "Loans Cut-Off Date"; Date)
        {
            CalcFormula = lookup("Receipts Processing Header"."Loan CutOff Date" where(No = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(32; "Principle/Interest"; Option)
        {
            OptionCaption = ' ,Principle,Interest';
            OptionMembers = " ",Principle,Interest;
        }
        field(33; "Interest Due to Be Paid"; Decimal)
        {
        }
        field(34; "Member No Not Pushed"; Boolean)
        {
        }
        field(35; "Expected Payment"; Decimal)
        {
            Editable = false;
        }
        field(36; Variance; Decimal)
        {
        }
        field(37; "Total Line Amount"; Decimal)
        {
            CalcFormula = sum("Receipts Processing Lines".Amount where("Receipt Header No" = field("Receipt Header No")));
            FieldClass = FlowField;
        }
        field(38; Outbalance; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Receipt Header No", "Receipt Line No")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
        key(Key2; "Receipt Line No")
        {
        }
        key(Key3; "Staff/Payroll No")
        {
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

