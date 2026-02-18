report 172996 Note1
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/NOTE1.rdlc';


    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Asat; Format(Asat))
            {


            }
            column(CurrentYear; CurrentYear)
            {

            }
            column(LastYearButOne; LastYearButOne) { }
            column(PreviousYear; PreviousYear)
            {

            }
            column(EndofLastyear; EndofLastyear)
            {

            }
            column(Now; Now) { }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                DateExpr: Text;
                InputDate: Date;
                DateFormula: Text;

            begin
                DateFormula := '<-CY-1D>';
                DateExpr := '<-1y>';
                InputDate := Asat;

                EndofLastyear := CalcDate(DateFormula, Asat);
                CurrentYear := Date2DMY(EndofLastyear, 3);
                LastYearButOne := CalcDate(DateExpr, EndofLastyear);
                PreviousYear := CurrentYear - 1;
                Now := CurrentYear + 1;



            end;
        }

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Asat; Asat)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
    }
    var
        myInt: Integer;
        Asat: Date;
        LastYearButOne: Date;

        CurrentYear: Integer;
        PreviousYear: Integer;
        EndofLastyear: date;
        Now: Integer;
}