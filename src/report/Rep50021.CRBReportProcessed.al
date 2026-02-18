
Report 50021 "CRB Report(Processed)"
{

    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    ExcelLayout = 'Layouts/CRB Report(Processed).xlsx';
    DefaultLayout = Excel;

    dataset
    {
        dataitem("CRBA Datas"; "CRBA Datas")
        {
            DataItemTableView = where("Current Balance" = filter(<> 0));


            column(Surname; "CRBA Datas".Surname)
            {
            }
            column(Forename1; "CRBA Datas"."Forename 1")
            {
            }
            column(Forename2; "CRBA Datas"."Forename 2")
            {
            }
            column(Forename3; "CRBA Datas"."Forename 3")
            {
            }
            column(TradingAs; Salutation)
            {
            }
            column(DateofBirth; "CRBA Datas"."Date of Birth")
            {
            }
            column(ClientCode; "CRBA Datas"."Client Code")
            {
            }

            column(AccountNumber; "CRBA Datas"."Account Number")
            {
            }
            column(OldAccountNo; OldAccountNo) { }
            column(Gender; "CRBA Datas".Gender)
            {
            }

            // column(CustomerGender; "CRBA Datas"."Customer Gender")
            // {
            // }

            column(Nationality; "CRBA Datas".Nationality)
            {
            }

            // column(MaritalStatus; "CRBA Datas"."Marital Status")
            // {
            // }
            column(MaritalStatus; "CRBA Datas"."Marital Status 2")
            {
            }
            column(PrimaryIdentificationDocumentType; "CRBA Datas"."Primary Identification code")
            {
            }
            column(PrimaryIdentification1; "CRBA Datas"."Primary Identification 1")
            {
            }
            column(SecondaryIdentificationDocumentType; "CRBA Datas"."Secondary Identification code")
            {
            }
            column(Secondary_Identification_code; "CRBA Datas"."Primary Identification 2") { }
            column(OtherIdentificationType; "CRBA Datas"."Other Identification Type")
            {
            }
            // column(PrimaryIdentification2; "CRBA Datas"."Primary Identification 2")
            // {
            // }
            column(Passport_Country_Code; "Passport Country Code") { }
            column(MobileNo; "CRBA Datas"."Mobile No")
            {
            }
            column(Home_Telephone; "Home Telephone") { }
            column(WorkTelephone; "CRBA Datas"."Work Telephone")
            {
            }
            column(PostalAddress1; "CRBA Datas"."Postal Address 1")
            {
            }
            column(PostalAddress2; "CRBA Datas"."Postal Address 2")
            {
            }
            column(PostalLocationTown; "CRBA Datas"."Postal Location Town")
            {
            }
            column(PostalLocationCountry; "CRBA Datas"."Postal Location Country")
            {
            }
            column(PostCode; "CRBA Datas"."Post Code")
            {
            }
            column(PhysicalAddress1; "CRBA Datas"."Physical Address 1")
            {
            }
            column(PhysicalAddress2; "CRBA Datas"."Physical Address 2")
            {
            }
            column(Plot_Number; "Plot Number") { }
            column(LocationTown; "CRBA Datas"."Location Town")
            {
            }
            column(LocationCountry; "CRBA Datas"."Location Country")
            {
            }
            column(Type_of_Residence; "Type of Residence") { }
            column(PIN_Number; "PIN Number") { }
            column(Consumer_Email; "Customer Work Email") { }
            column(Employer_Name; "Employer Name") { }
            column(Employer_Industry_Type; "Employer Industry Type") { }
            column(EmploymentDate; "CRBA Datas"."Employment Date")
            {
            }
            column(EmploymentType; "CRBA Datas"."Employment Type")
            {
            }
            column(Income_Amount; "Income Amount") { }
            column(LendersRegisteredName; "CRBA Datas"."Lenders Registered Name")
            {
            }
            column(LendersTradingName; "CRBA Datas"."Lenders Trading Name")
            {
            }
            column(LendersBranchName; "CRBA Datas"."Lenders Branch Name")
            {
            }
            column(LendersBranchCode; "CRBA Datas"."Lenders Branch Code")
            {
            }
            column(JointSingleIndicator; "CRBA Datas"."Joint Single Indicator")
            {
            }
            column(AccountProductType; "CRBA Datas"."Account Product Type")
            {
            }
            column(DateAccountOpened; "CRBA Datas"."Date Account Opened")
            {
            }
            column(InstallmentDueDate; "CRBA Datas"."Installment Due Date")
            {
            }
            column(OriginalAmount; "CRBA Datas"."Original Amount")
            {
            }
            column(CurrencyofFacility; "CRBA Datas"."Currency of Facility")
            {
            }
            column(AmonutinKenyashillings; "CRBA Datas"."Amonut in Kenya shillings")
            {
            }
            column(CurrentBalance; "CRBA Datas"."Current Balance")
            {
            }
            column(OverdueBalance; "CRBA Datas"."Overdue Balance")
            {
            }
            column(OverDueDate; "CRBA Datas"."Over Due Date")
            {
            }
            column(NoofDaysinArreas; "CRBA Datas"."No of Days in Arreas")
            {
            }
            column(NoofInstallmentIn; "CRBA Datas"."No of Installment In")
            {
            }
            column(Prudent_Risk; "Prudent Risk") { }
            column(AccountStatus; "CRBA Datas"."Account Status")
            {
            }
            column(AccountStatusDate; "CRBA Datas"."Account Status Date")
            {
            }
            column(AccountClosureReason; "CRBA Datas"."Account Closure Reason")
            {
            }
            column(RepaymentPeriod; "CRBA Datas"."Repayment Period")
            {
            }
            column(DeferredPaymentDate; "CRBA Datas"."Deferred Payment Date")
            {
            }
            column(DeferredPayment; "CRBA Datas"."Deferred Payment")
            {
            }
            column(PaymentFrequency; "CRBA Datas"."Payment Frequency")
            {
            }

            column(Disbursement_Date; "CRBA Datas"."Disbursement Date")
            {
            }
            column(InsallmentAmount; "CRBA Datas"."Insallment Amount")
            {
            }
            column(DateofLatestPayment; "CRBA Datas"."Date of Latest Payment")
            {
            }
            column(LastPaymentAmount; "CRBA Datas"."Last Payment Amount")
            {
            }
            column(Type_of_Security; "Type of Security") { }
            column(GroupID; GroupID) { }

            // column(DateofPhysicalAddress; "CRBA Datas"."Date of Physical Address")
            // {
            // }



            // column(AccountType; "CRBA Datas"."Account Type")
            // {
            // }




            // column(PerformingNPLIndicator; "CRBA Datas"."Performing / NPL Indicator")
            // {
            // }






            // column(HomeTelephone; "CRBA Datas"."Home Telephone")
            // {
            // }
            // column(PlotNumber; "CRBA Datas"."Plot Number")
            // {
            // }


            // column(SalaryBand; "CRBA Datas"."Salary Band")
            // {
            // }



            // column(TypeofSecurity; "CRBA Datas"."Type of Security")
            // {
            // }



            // column(Name2; "CRBA Datas"."Name 2")
            // {
            // }
            // column(Name3; "CRBA Datas"."Name 3")
            // {
            // }
            // column(PrimaryIdentificationDocument; "Primariy Identification")
            // {
            // }
            // column(IdentificationDocument; "Identification Document")
            // {
            // }
            // column(PerformingNonperforming; "CRBA Datas"."Performing/Nonperforming")
            // {
            // }
            // column(Employment; "CRBA Datas".Employment)
            // {
            // }

            // column(Product; "CRBA Datas".Product)
            // {
            // }
            // column(Currency; "CRBA Datas".Currency)
            // {
            // }

            // column(StatusOfAccount; "CRBA Datas"."Status Of Account")
            // {
            // }

            // column(IsSecure; "CRBA Datas"."Is Secure")
            // {
            // }
            // column(Industry; Industry)
            // {
            // }

            trigger OnPreDataItem();
            begin
                NewOriginal := 0;
            end;

            trigger OnAfterGetRecord();
            begin
                if "CRBA Datas".Gender = 'M' then
                    Salutation := 'Mr' else
                    Salutation := 'Mrs';
                "Primariy Identification" := 'National ID';
                "Identification Document" := '001';
                if "CRBA Datas"."Marital Status 2" = 'U' then
                    "CRBA Datas"."Marital Status" := "CRBA Datas"."marital status"::Uknown;
                if "CRBA Datas"."Employer Name" = '' then
                    "CRBA Datas"."Employer Name" := 'OTHERS';
                if "CRBA Datas"."Performing/Nonperforming" <> 'PERFORMING' then
                    "CRBA Datas"."Performing / NPL Indicator" := 'B'
                else
                    "CRBA Datas"."Performing / NPL Indicator" := 'A';
                if "CRBA Datas"."Account Type" = "CRBA Datas"."account type"::Joint then
                    "CRBA Datas"."Joint Single Indicator" := 'J'
                else
                    "CRBA Datas"."Joint Single Indicator" := 'S';
                if "CRBA Datas".Product <> 'MOBILE BANKING LOAN' then
                    "CRBA Datas"."Account Product Type" := 'H'
                else
                    "CRBA Datas"."Account Product Type" := 'I';
                "CRBA Datas"."Last Payment Amount" := "CRBA Datas"."Last Payment Amount" * -1;
                // if "CRBA Datas"."Employer Industry Type" ='GOVERNMENT' then begin
                // Industry:='011'
                // end else
                // Industry:='012';
                if "CRBA Datas"."Location Country" = 'KENYA' then begin
                    Country := 'KE';
                end;
                //MESSAGE('%1',Country);
            end;

        }
    }

    requestpage
    {


        SaveValues = false;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin

        end;
    }

    trigger OnInitReport()
    begin


    end;

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin

    end;

    var
        Salutation: Text;
        "Primariy Identification": Text;
        "Identification Document": Code[10];
        NewOriginal: Decimal;
        Industry: Text;
        Country: Text;
        OldAccountNo: Code[50];
        GroupID: Code[50];

    // --> Reports ForNAV Autogenerated code - do not delete or modify






    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
