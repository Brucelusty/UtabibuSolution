report 50014 "Dividends Register"

{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Dividends Register"; "Dividends Register")
        {
            column(Member_No; "Member No")
            {
            }
            column(Shares; Shares) { }
            column(Member_Name; "Member Name") { }
            column(Employer_Code; "Employer Code") { }
            column(Qualifying_Shares; "Qualifying Shares") { }
            column(Qualifying_Share_Capital; "Qualifying Share Capital") { }
            column(Gross_Interest_On_Deposit; "Gross Interest On Deposit") { }
            column(Gross_Dividends; "Gross Dividends") { }
            column(Witholding_Tax; "Witholding Tax") { }
            column(Gross_Interest_On_Chama_Saving; "Gross Interest On Chama Saving") { }
            column(Chama_withholding_Tax; "Chama withholding Tax") { }
            column(Net_Interest_On_Chama; "Net Interest On Chama") { }
            column(Total_Dividend; "Total Dividend") { }
            column(CompanyPic; Company.Picture) { }
            column(CompanyName; Company.Name) { }
            trigger
            OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);
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

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'Layouts/DividendsRegister.rdlc';
        }
    }

    var
        Company: Record "Company Information";
        myInt: Integer;
}