report 50012 "DividendSlip"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {

        dataitem(Customer; Customer)
        {
            column(No_; "No.")
            { }
            dataitem("Dividends Progression"; "Dividends Progression")
            {
                DataItemLink = "Member No" = field("No.");
                column(Member_No; "Member No")
                {

                }
                column(Gross_Dividends; "Gross Dividends") { }
                column(Gross_Interest_On_Deposit; "Gross Interest On Deposit") { }
                column(Witholding_Tax; "Witholding Tax") { }
                column(Net_Dividends; "Net Dividends") { }
                column(Net_Interest_On_Deposit; "Net Interest On Deposit") { }
                column(Qualifying_Share_Capital; "Qualifying Share Capital") { }
                column(Qualifying_Shares; "Qualifying Shares") { }
                column(Shares; Shares) { }
                column(MemberName; MemberName) { }
                column(FilterVaue; FilterVaue) { }
                column(CompanyInformationPic; CompanyInformation.Picture) { }
                column(CompanyInformationName; CompanyInformation.Name) { }
                column(Date; Date) { }
                trigger OnAfterGetRecord()
                begin
                    FilterVaue := 0;
                    MemberName := '';
                    Cust.Reset();
                    Cust.SetRange(Cust."No.", "Dividends Progression"."Member No");
                    if Cust.Find('-') then begin
                        MemberName := Cust.Name;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    CompanyInformation.Get;
                    CompanyInformation.CalcFields(Picture);
                end;

            }
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
            LayoutFile = 'Layouts/DividendSlip.rdlc';
        }
    }

    var
        myInt: Integer;
        Cust: Record Customer;
        MemberName: Text[250];

        FilterVaue: Decimal;
        CompanyInformation: Record "Company Information";
}