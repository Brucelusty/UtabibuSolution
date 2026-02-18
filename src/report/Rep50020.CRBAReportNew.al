report 50020 "CRBA Report New"
{
    RDLCLayout = 'Layouts/CRBAReportNew.Rdlc';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(Cust; Customer)
        {
            RequestFilterFields = "No.";

            column(No_; "No.") { }
            column(Name; Name) { }

            trigger OnAfterGetRecord()
            begin


                NoDays := 0;
                Loans.CalcFields(Loans."Outstanding Balance", Loans."Last Pay Date");


                Loans.Reset;
                Loans.SetRange(Loans."Client Code", Cust."No.");
                // Loans.SETFILTER(Loans."Outstanding Balance",'>0');
                if Loans.FindSet then begin
                    repeat
                        //Message('%1', Loans."Client Code");
                        NoLine := NoLine + 1;

                        CRBA.Init;
                        CRBA.No := NoLine;

                        TempString := '';

                        if Member.Get(Loans."Client Code") then begin
                            MyString := Member.Name;
                            ////  Message('%1', MyString);
                            TempString := ConvertStr(MyString, ' ', ',');


                            TempString := ConvertStr(MyString, ' ', ',');
                            String1 := SplitNamesSurname(TempString);
                            String2 := SplitNamesFirstname(TempString);
                            String3 := SplitNamesLastname(TempString);



                            if TempString <> '' then begin
                                ;
                                String1 := SelectStr(1, TempString);


                                CRBA.Surname := String1;
                                CRBA."Name 2" := String2;
                                CRBA."Name 3" := String3;
                                CRBA."Forename 1" := String2;
                                CRBA."Forename 2" := String3;


                            end;

                            CRBA."Date of Birth" := Member."Date of Birth";
                            // CRBA.Surname:=Cust.Name;
                            CRBA."Client Code" := Member."No.";
                            CRBA."Account Number" := Loans."Loan  No.";
                            if Member.Gender = Member.Gender::Male then begin
                                CRBA.Gender := 'M';
                                CRBA."Customer Gender" := Member.Gender;
                            END else begin
                                CRBA.Gender := 'F';
                                CRBA."Customer Gender" := Member.Gender;
                            end;

                            //CRBA.Gender:=Cust.Gender;
                            CRBA.Nationality := 'KE';
                            CRBA."Customer Nationality" := 'KENYA';
                            CRBA."Marital Status" := Member."Marital Status";
                            if CRBA."Marital Status" = CRBA."Marital Status"::Devorced then
                                CRBA."Marital Status 2" := 'D'
                            else
                                if CRBA."Marital Status" = CRBA."Marital Status"::Married then
                                    CRBA."Marital Status 2" := 'M'
                                else
                                    if CRBA."Marital Status" = CRBA."Marital Status"::Single then
                                        CRBA."Marital Status 2" := 'S'
                                    else
                                        if CRBA."Marital Status" = CRBA."Marital Status"::Widower then
                                            CRBA."Marital Status 2" := 'W'
                                        else
                                            CRBA."Marital Status 2" := 'U';
                            CRBA."Primary Identification 1" := Member."ID No.";
                            CRBA."Primary Identification code" := '001';
                            CRBA."Secondary Identification code" := '002';
                            CRBA."Primary Identification 2" := Member."Passport No.";
                            CRBA."Mobile No" := Member."Mobile Phone No.";
                            CRBA."Work Telephone" := Member."Office Telephone No.";
                            CRBA."Postal Address 1" := Member.Address;
                            CRBA."Postal Address 2" := Member."Address 2";
                            CRBA."Postal Location Town" := 'NAIROBI';
                            CRBA."Postal Location Country" := 'KE';
                            CRBA."Post Code" := Member."Post Code";
                            CRBA."Physical Address 1" := Member."Address 2";
                            CRBA."Physical Address 2" := Member."Home Address";
                            CRBA."Location Town" := Member.Location;
                            //CRBA."Location Country":=Cust."Country/Region Code";
                            CRBA."Location Country" := 'KE';
                            CRBA."Date of Physical Address" := 0D;
                            CRBA."Customer Work Email" := Member."E-Mail";
                            CRBA."PIN Number" := Member.Pin;
                            Member.CalcFields(Member."Last Payment Date");
                            if Member."Last Payment Date" <> 0D then begin
                                CRBA."Account Status Date" := Member."Last Payment Date";
                            end;
                            CRBA."Employer Name" := Member."Employer Code";

                            if Member."Employer Code" = 'UTAFITI' then
                                CRBA."Employer Industry Type" := 'FINANCE'
                            else
                                if Member."Employer Code" <> '' then
                                    CRBA."Employer Industry Type" := 'NGO'
                                else
                                    if (Member."Employer Code" = 'NONPAYROLL') and (Member."Employer Code" = '') then
                                        CRBA."Employer Industry Type" := 'OTHERS';

                            if (Member."Employer Code" = 'UTAFITI') then
                                CRBA.Employment := 'PERMANENT'
                            else
                                CRBA.Employment := 'CONTRACT';



                            CRBA."Account Type" := Member."Account Category";
                            CRBA."Is Secure" := 'UNSECURE';

                            if Loans."Loans Category-SASRA" = Loans."Loans Category-SASRA"::Perfoming then
                                CRBA."Performing/Nonperforming" := 'Performing'
                            else
                                CRBA."Performing/Nonperforming" := 'Non-Performing';

                            Loans.CalcFields(Loans."Schedule Repayments", Loans."Current Repayment", Loans."Last Pay Date");

                            if Loans."Last Pay Date" <> 0D then
                                LoanSche.Reset;
                            LoanSche.SetRange(LoanSche."Loan No.", Loans."Loan  No.");
                            LoanSche.SetRange(LoanSche."Repayment Date", AsatDate);

                            if LoanSche.Find('-') then begin
                                Loans.CalcFields("Outstanding Balance");
                                CRBA."No of Days in Arreas" := Round((LoanSche."Loan Balance" - Loans."Outstanding Balance") / 30, 1, '<');
                                CRBA."No of Installment In" := CRBA."No of Days in Arreas";


                            end;
                            //END

                            if Loans."Last Pay Date" = 0D then
                                CRBA."Installment Due Date" := Loans."Issued Date"
                            else
                                CRBA."Installment Due Date" := Loans."Last Pay Date";
                            CRBA."Overdue Balance" := 0;
                            if CRBA."Installment Due Date" <> 0D then
                                CRBA."Overdue Balance" := Loans."Amount in Arrears";

                            if Loans."Loan Product Type" <> 'MOBIADV' then
                                CRBA.Product := 'PERSONAL LOANS'
                            else
                                CRBA.Product := 'MOBILE BANKING LOAN';



                            CRBA."Over Due Date" := Loans."Last Pay Date";
                            CRBA."Income Amount" := Loans."Basic Pay";

                            if Member."Registration Date" <> 0D then begin
                                CRBA."Date Account Opened" := Member."Registration Date";
                            end;

                            CRBA."Original Amount" := Format(Round(Loans."Approved Amount", 1, '='));
                            CRBA."Currency of Facility" := 'KES';
                            CRBA."Amonut in Kenya shillings" := Format(Round(Loans."Approved Amount", 1, '='));
                            Loans.CalcFields("Outstanding Balance");
                            CRBA."Current Balance" := Loans."Outstanding Balance";

                            CRBA."Lenders Registered Name" := 'UTAFITI SACCO SOCIETY LIMITED';
                            CRBA."Lenders Trading Name" := 'UTAFITI SACCO SOCIETY LIMITED';
                            CRBA."Lenders Branch Name" := 'HEAD OFFICE';
                            CRBA."Lenders Branch Code" := 'N258001';
                            CRBA.Currency := 'Kenya Shilling';


                            if Loans.Defaulted = false then
                                CRBA."Performing / NPL Indicator" := 'A'
                            else
                                CRBA."Performing / NPL Indicator" := 'B';

                            if Member.Status <> Member.Status::Active then
                                CRBA."Status Of Account" := Member.Status::Dormant
                            else
                                CRBA."Status Of Account" := Member.Status::Active;

                            if Member.Status = Member.Status::Active then
                                CRBA."Account Status" := 'F'
                            else
                                CRBA."Account Status" := 'B';


                            // CRBA."Account Status Date":='0';
                            CRBA."Repayment Period" := Loans.Installments;
                            CRBA."Payment Frequency" := 'M';

                            if Loans."Loan Disbursement Date" <> 0D then begin

                                Day := Date2DMY(Loans."Loan Disbursement Date", 1);
                                Month := Date2DMY(Loans."Loan Disbursement Date", 2);
                                Year := Date2DMY(Loans."Loan Disbursement Date", 3);
                                DateFor := Format(Day) + '' + Format(Month) + '' + Format(Year);
                            end
                            else
                                DateFor := '0';


                            //CRBA."Disbursement Date":=DateFor;
                            CRBA."Disbursement Date" := Loans."Issued Date";
                            CRBA."Insallment Amount" := Round(Loans.Repayment, 1, '=');


                            if Loans."Last Pay Date" = 0D then
                                CRBA."Date of Latest Payment" := Loans."Issued Date"
                            else
                                CRBA."Date of Latest Payment" := Loans."Last Pay Date";
                            CRBA."Last Payment Amount" := Round(Loans."Current Repayment", 1, '=');
                            CRBA."Type of Security" := 'U';
                            CRBA.Insert(true);

                        end;
                    until Loans.Next = 0;
                end;


            end;

            trigger OnPreDataItem()
            begin
                CRBA.DeleteAll;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CustS: Record Customer;
        CRBA: Record "CRBA Datas";
        MyString: Text;
        String1: Text;
        String2: Text;
        String3: Text;
        String5: Text;
        String4: Text;
        NoDays: Integer;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        DateFor: Text;
        AsatDate: Date;
        NoLine: Integer;
        TxtKeep: Text;
        DateInput: Date;
        TempString: Text;
        LoanSche: Record "Loan Repayment Schedule";
        Member: Record Customer;
        Loans: Record "Loans Register";

    procedure Token(Pos: Integer)
    begin
    end;

    procedure SplitNamesSurname(var Names: Text[100]) RtnSurname: Text[100]
    var
        lngPos: Integer;
        lngPos2: Integer;
        Surname: Text[50];
        "Other Names": Text[50];
        "First Names": Text;
        "Last Names": Text;
    begin
        /*Get the position of the space character*/
        lngPos := StrPos(Names, ',');
        if lngPos <> 0 then begin
            Surname := CopyStr(Names, 1, lngPos - 1);
            RtnSurname := Surname;
            exit(RtnSurname);
            "Other Names" := CopyStr(Names, lngPos + 1);
            lngPos2 := StrPos("Other Names", ',');
            if lngPos2 <> 0 then begin
                "First Names" := CopyStr("Other Names", 1, lngPos2 - 1);
                "Last Names" := CopyStr("Other Names", lngPos2 + 1);
            end
            else
                exit;
        end;

    end;

    procedure SplitNamesFirstname(var Names: Text[100]) RtnSurname: Text[100]
    var
        lngPos: Integer;
        lngPos2: Integer;
        Surname: Text[50];
        "Other Names": Text[100];
        "First Names": Text[100];
        "Last Names": Text[130];
    begin
        /*Get the position of the space character*/
        lngPos := StrPos(Names, ',');
        if lngPos <> 0 then begin
            Surname := CopyStr(Names, 1, lngPos - 1);
            ;
            "Other Names" := CopyStr(Names, lngPos + 1);
            lngPos2 := StrPos("Other Names", ',');
            if lngPos2 <> 0 then begin
                "First Names" := CopyStr("Other Names", 1, lngPos2 - 1);
                "Last Names" := CopyStr("Other Names", lngPos2 + 1);
                RtnSurname := "First Names";
                exit(RtnSurname);
            end
            else begin
                ;
                RtnSurname := "Other Names";
                exit(RtnSurname);
            end;
        end;

    end;

    procedure SplitNamesLastname(var Names: Text[100]) RtnSurname: Text[100]
    var
        lngPos: Integer;
        lngPos2: Integer;
        Surname: Text[50];
        "Other Names": Text[100];
        "First Names": Text[100];
        "Last Names": Text[100];
    begin
        /*Get the position of the space character*/
        lngPos := StrPos(Names, ',');
        if lngPos <> 0 then begin
            Surname := CopyStr(Names, 1, lngPos - 1);
            ;
            "Other Names" := CopyStr(Names, lngPos + 1);
            lngPos2 := StrPos("Other Names", ',');
            if lngPos2 <> 0 then begin
                "First Names" := CopyStr("Other Names", 1, lngPos2 - 1);
                "Last Names" := CopyStr("Other Names", lngPos2 + 1);
                RtnSurname := "Last Names";
                exit(RtnSurname);
            end
            else begin
                ;
                RtnSurname := '';
                exit(RtnSurname);
            end;
        end;

    end;
}

