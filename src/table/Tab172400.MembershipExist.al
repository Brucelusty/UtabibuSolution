//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Table 172400 "Membership Exist"
{

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Closure  Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Customer where(Status = filter('Awaiting Exit'));

            trigger OnValidate()
            begin
                IntTotal := 0;
                LoanTotal := 0;
                Intpenalty := 0;

                if Cust.Get("Member No.") then
                    ExitingMember := Cust.Name;
                //Restrict No of Withdrawals
                Closure.Reset;
                Closure.SetRange(Closure."Member No.", "Member No.");
                Closure.SetRange(Closure."Member Name", ExitingMember);
                Closure.SetFilter(Closure."No.", '<>%1', "No.");
                Closure.SetRange(Closure.Posted, false);
                if Closure.FindSet then begin
                    Error('The Member has another withdrawal application Closure No %1', Closure."No.");
                end;
                if Cust.Get("Member No.") then begin
                    "Member Name" := Cust.Name;
                    Cust.CalcFields(Cust."Current Shares", Cust."Shares Retained", Cust."Interest On Deposits", Cust."Programmed Deposits", Cust."Dividend Amount");
                    "Member Liability2" := SFactory.FnGetMemberLiability("Member No.");
                    "Member Deposits" := Round(Cust."Current Shares", 1, '=');
                    "FOSA Account No." := Cust."FOSA Account No.";
                    //"Unpaid Dividends" := Cust."Dividend Amount" + Cust."Interest On Deposits";
                    "Share Capital" := Cust."Shares Retained";
                    "Member Savings" := Cust."Programmed Deposits" + Cust."Defaulted Loan Recovery" + Cust."Dependant Savings 3" + Cust."HouseHold Savings" + Cust."Utafiti Housing" + Cust."Holiday Savings";
                    "Seller Share Capital Account" := Cust."Share Capital No";
                    Dependand1 := (Cust."Programmed Deposits");
                    dependand2 := Cust."Defaulted Loan Recovery";
                    dependand3 := Cust."Dependant Savings 3";
                    dependand4 := Cust."Dividend Amount";


                    PrdOverdeduction := Cust."Un-allocated Funds";
                    "Closing Date" := CalcDate('60D', Cust."Withdrawal Application Date");
                    "Risk Fund" := Cust."Risk Fund";
                    if Cust."Risk Fund" < 0 then
                        "Risk Beneficiary" := true;

                    GenSetup.Get();
                    if "Risk Beneficiary" <> true then
                        "Risk Refundable" := (GenSetup."Risk Beneficiary (%)" / 100) * "Risk Fund";
                end;

                CalcFields("Share Capital to Sell");

                "Tax: Membership Exit Fee" := Round(GenSetup."Withdrawal Fee" * (GenSetup."Excise Duty(%)" / 100), 1, '=');

                if "Sell Share Capital" = false then begin
                    "Total Adds" := "Member Deposits" + "Unpaid Dividends" + "Member Savings" + Dependand1
                end else
                    "Total Adds" := "Member Deposits" + "Unpaid Dividends" + "Share Capital to Sell" + "Member Savings" + Dependand1 + dependand4;


                Loans.Reset;
                Loans.SetRange(Loans."Client Code", "Member No.");
                Loans.SetRange(Loans.Posted, true);
                Loans.SetFilter(Loans."Outstanding Balance", '>0');
                if Loans.Find('-') then begin
                    repeat
                        Loans.CalcFields(Loans."Outstanding Balance", loans."Outstanding Interest", "Current Penalty Due");
                        VarLoanDue := SFactory.FnRunLoanAmountDue(Loans."Loan  No.");
                        LoanTotal := LoanTotal + Loans."Outstanding Balance";
                    until Loans.Next = 0;
                end;

                Loans.Reset;
                Loans.SetRange(Loans."Client Code", "Member No.");
                Loans.SetRange(Loans.Posted, true);
                if Loans.Find('-') then begin
                    repeat
                        Loans.CalcFields(loans."Outstanding Interest");
                        IntTotal := IntTotal + Loans."Outstanding Interest";
                    until Loans.Next = 0;
                end;

                Loans.Reset;
                Loans.SetRange(Loans."Client Code", "Member No.");
                Loans.SetRange(Loans.Posted, true);
                if Loans.Find('-') then begin
                    repeat
                        Loans.CalcFields(loans."Current Penalty Due");
                        Intpenalty := Loans."Current Penalty Due";
                    until Loans.Next = 0;
                end;

                // Message('%1|%2|%3|%4', Loans."Outstanding Interest", IntTotal, IntTotal, Loans."Interest Charged");

                //FOSA Loans
                Loans.Reset;
                Loans.SetRange(Loans."Client Code", "FOSA Account No.");
                Loans.SetRange(Loans.Posted, true);
                Loans.SetRange(Loans.Source, Loans.Source::FOSA);
                Loans.SetFilter(Loans."Outstanding Balance", '>0');
                if Loans.Find('-') then begin
                    repeat
                        Loans.CalcFields(Loans."Outstanding Balance", "Outstanding Interest", "Interest Charged", "Current Penalty Due");
                        VarLoanDue := SFactory.FnRunLoanAmountDue(Loans."Loan  No.");
                        IntTotalFOSA := IntTotalFOSA + (Loans."Outstanding Interest" + Loans."Interest Charged");
                        LoanTotalFOSA := LoanTotalFOSA + Loans."Outstanding Balance";
                    until Loans.Next = 0;
                end;


                "Total Loan" := LoanTotal;
                "Total Interest" := IntTotal;
                "Total Penalty" := Intpenalty;
                "Total Loans FOSA" := LoanTotalFOSA;
                "Total Oustanding Int FOSA" := IntTotalFOSA;
                "Total Lesses" := Round("Total Loan" + "Total Interest" + "Total Penalty" + "Total Loans FOSA" + "Total Oustanding Int FOSA", 1, '=');//+ "Member Liability2";
                "Net Payable to the Member" := Round("Total Adds" - "Total Lesses", 1, '=');

                // "Member Liability" := SFactory.FnGetMemberLiability("Member No.");
            end;
        }
        field(3; "Member Name"; Text[50])
        {
        }
        field(4; "Closing Date"; Date)
        {
            Editable = false;
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Total Loan"; Decimal)
        {
        }
        field(8; "Total Interest"; Decimal)
        {
        }
        field(9; "Member Deposits"; Decimal)
        {
        }
        field(10; "No. Series"; Code[20])
        {
        }
        field(11; "Closure Type"; Option)
        {
            OptionCaption = 'Member Exit - Normal,Member Exit - Deceased,Member Exit-Defaulter';
            OptionMembers = "Member Exit - Normal","Member Exit - Deceased","Member Exit-Defaulter";
        }
        field(12; "Mode Of Disbursement"; Option)
        {
            OptionCaption = ' ,Cheque,EFT,Bank Account,RTGS,M-Pesa';
            OptionMembers = " ","Cheque","EFT","Bank Account","RTGS","M-Pesa";
        }
        field(13; "Paying Bank"; Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                //if ("Mode Of Disbursement" = "mode of disbursement"::Customer) or ("Mode Of Disbursement" = "mode of disbursement"::Vendor) then begin
                // if "Paying Bank" = '' then
                //     Error('You Must Specify the Paying bank');
            end;
            //end;
        }
        field(14; "Cheque No."; Code[20])
        {
        }

        field(15; "FOSA Account No."; Code[20])
        {
            TableRelation = Vendor."No." where("BOSA Account No" = field("Member No."),
                                                Status = filter(<> Closed | Deceased),
                                                Blocked = filter(<> Payment | All));
        }
        field(16; Payee; Text[80])
        {
        }
        field(17; "Net Pay"; Decimal)
        {
        }
        field(18; "Risk Fund"; Decimal)
        {
        }
        field(19; "Risk Beneficiary"; Boolean)
        {
        }
        field(20; "Risk Refundable"; Decimal)
        {
        }
        field(21; "Total Adds"; Decimal)
        {
        }
        field(22; "Total Lesses"; Decimal)
        {
        }
        field(23; "Unpaid Dividends"; Decimal)
        {
        }
        field(24; "Total Loans FOSA"; Decimal)
        {
        }
        field(25; "Total Oustanding Int FOSA"; Decimal)
        {
        }
        field(26; "Net Payable to the Member"; Decimal)
        {
        }
        field(27; "Risk Fund Arrears"; Decimal)
        {
        }
        field(28; "Withdrawal Application Date"; Date)
        {

            trigger OnValidate()
            begin
                //GenSetup.GET();
            end;
        }
        field(29; "Reason For Withdrawal"; Option)
        {
            OptionCaption = 'Relocation,Financial Constraints,House/Group Challages,Join another Institution,Personal Reasons,Other';
            OptionMembers = Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other;
        }
        field(30; "Sell Share Capital to"; Code[20])
        {
            TableRelation = "Members Register"."No.";

            trigger OnValidate()
            begin
                if Cust.Get("Sell Share Capital to") then begin
                    "Sell Shares Member Name" := Cust.Name;
                end;
            end;
        }
        field(31; "Sell Shares Member Name"; Code[20])
        {
        }
        field(32; "Share Capital Transfer Fee"; Decimal)
        {
        }
        field(33; "Sell Share Capital"; Boolean)
        {

            trigger OnValidate()
            begin
                GenSetup.Get();
                "Share Capital Transfer Fee" := GenSetup."Share Capital Transfer Fee";
                "Tax: Share Capital Transfer Fe" := "Share Capital Transfer Fee" * (GenSetup."Excise Duty(%)" / 100);
            end;
        }
        field(34; "Share Capital"; Decimal)
        {
        }
        field(35; "Share Capital to Sell"; Decimal)
        {
            CalcFormula = sum("Share Capital Sell".Amount where("Document No" = field("No.")));
            FieldClass = FlowField;
        }
        field(36; "Posting Date"; Date)
        {
        }
        field(37; "Member Liability"; Decimal)
        {
        }
        field(38; "House Group Exit Application"; Code[30])
        {
        }
        field(39; "Seller Share Capital Account"; Code[30])
        {
        }
        field(40; "Tax: Share Capital Transfer Fe"; Decimal)
        {
        }
        field(41; "Tax: Membership Exit Fee"; Decimal)
        {
        }
        field(42; "Closed By"; Code[30])
        {
            Editable = false;
        }
        field(43; "Closed On"; Date)
        {
            Editable = false;
        }
        field(44; "Absolve Member Liability"; Boolean)
        {
        }
        field(45; "Exit Type"; Option)
        {
            OptionCaption = 'Full Member Exit, BOSA Account Clousre';
            OptionMembers = "Full Member Exit"," BOSA Account Clousre";
        }
        field(46; "Member Savings"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; Dependand1; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; dependand2; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; dependand3; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(58; dependand4; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50; "Credit Comments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(51; PrdOverdeduction; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Finance Comments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Member Liability2"; Decimal)
        {
            Editable = false;

        }
        field(54; "Share Capital ded"; Decimal)
        {

        }
        field(55; "Charge Withdrawal"; Boolean)
        {
            Caption = 'Charge withdrawal Fee';
        }
        field(56; "Withdrawal Fee"; Decimal)
        {

        }
        field(57; "Loan Greater than Deposits"; Boolean) { }
        field(60; "Total Penalty"; Decimal)
        {

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Closure  Nos");
            NoSeriesMgt.InitSeries(SalesSetup."Closure  Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        GenSetup.Get;

        "Tax: Membership Exit Fee" := GenSetup."Withdrawal Fee" * (GenSetup."Excise Duty(%)" / 100);
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record Customer;
        Loans: Record "Loans Register";
        MemLed: Record "Member Ledger Entry";
        IntTotal: Decimal;
        Intpenalty: Decimal;
        LoanTotal: Decimal;
        GenSetup: Record "Sacco General Set-Up";
        IntTotalFOSA: Decimal;
        LoanTotalFOSA: Decimal;
        SFactory: Codeunit "Au Factory";
        VarLoanDue: Decimal;
        Closure: Record "Membership Exist";
        ExitingMember: Text;
}




