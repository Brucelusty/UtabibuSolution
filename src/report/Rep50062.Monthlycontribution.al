report 50062 Monthlycontribution
{
    Caption = 'Monthly contribution';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/MonthlyContributions.rdlc';

    dataset
    {
        dataitem(Member; Customer)
        {
            RequestFilterFields = "No.";
            DataItemTableView = where(ISNormalMember = filter(true), "Account Category" = filter(Individual));
            column(MemberNo; "No.") { }
            column(MemberName; Name) { }
            column(JanContribution; MonthlyContributions[1]) { }
            column(FebContribution; MonthlyContributions[2]) { }
            column(MarContribution; MonthlyContributions[3]) { }
            column(AprContribution; MonthlyContributions[4]) { }
            column(MayContribution; MonthlyContributions[5]) { }
            column(JunContribution; MonthlyContributions[6]) { }
            column(JulContribution; MonthlyContributions[7]) { }
            column(AugContribution; MonthlyContributions[8]) { }
            column(SepContribution; MonthlyContributions[9]) { }
            column(OctContribution; MonthlyContributions[10]) { }
            column(NovContribution; MonthlyContributions[11]) { }
            column(DecContribution; MonthlyContributions[12]) { }
            column(TotalContribution; TotalContribution) { }

            trigger OnAfterGetRecord()
            var
                CustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                MonthIndex: Integer;
            begin
                // Reset arrays and total
                Clear(MonthlyContributions);
                TotalContribution := 0;
                CustLedgEntry.Reset();
                CustLedgEntry.SetRange("Customer No.", "No.");
                CustLedgEntry.SetRange("Transaction Type", CustLedgEntry."Transaction Type"::"Deposit Contribution");
                CustLedgEntry.SetRange("Posting Date", StartDate, EndDate); //CalcDate('<CY>', YearFilter));

                if CustLedgEntry.FindSet() then begin
                    repeat
                        MonthIndex := Date2DMY(CustLedgEntry."Posting Date", 2); // Get month (1-12)
                        MonthlyContributions[MonthIndex] += CustLedgEntry.Amount * -1;
                        TotalContribution += CustLedgEntry.Amount * -1;

                    //Message('Member %1: Date %2, Amount %3, Month %4', "No.", CustLedgEntry."Posting Date", CustLedgEntry.Amount, MonthIndex);
                    until CustLedgEntry.Next() = 0;
                end //else begin
                //   //  Message('No deposit contributions found for Member %1 in %2.', "No.", YearFilter);
                // end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(YearFilter; YearFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Year Filter';
                        ToolTip = 'Enter a year (e.g., 2023) or range (e.g., 2022..2023).';
                        trigger OnValidate()
                        var
                            TempYear: Integer;
                        begin
                            if YearFilter = '' then
                                Error('Please enter a year filter (e.g., 2023, 2022..2023).');


                            if Evaluate(TempYear, YearFilter) then begin
                                StartDate := DMY2Date(1, 1, TempYear);
                                EndDate := DMY2Date(31, 12, TempYear);
                            end else begin
                                Error('Please enter a single year (e.g., 2023). Range support not implemented yet.');
                            end;
                        end;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if YearFilter = '' then begin
                YearFilter := Format(Date2DMY(Today, 3));
                StartDate := DMY2Date(1, 1, Date2DMY(Today, 3));
                EndDate := DMY2Date(31, 12, Date2DMY(Today, 3));
            end;
        end;
    }

    labels
    {
        ReportTitle = 'Member Monthly Deposit Contributions Report';
        MemberNoLabel = 'Member No.';
        MemberNameLabel = 'Member Name';
        JanLabel = 'January';
        FebLabel = 'February';
        MarLabel = 'March';
        AprLabel = 'April';
        MayLabel = 'May';
        JunLabel = 'June';
        JulLabel = 'July';
        AugLabel = 'August';
        SepLabel = 'September';
        OctLabel = 'October';
        NovLabel = 'November';
        DecLabel = 'December';
        TotalLabel = 'Total Deposit Contribution';
    }

    var
        MonthlyContributions: array[12] of Decimal;
        TotalContribution: Decimal;
        YearFilter: Text;
        StartDate: Date;
        EndDate: Date;
}