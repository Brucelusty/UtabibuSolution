report 50028 "Chama Savings Slip"
{
    Caption = 'Programmed Savings Slip';
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
                column(Chama_saving; "Chama saving") { }
                column(Gross_Interest_On_Chama_Saving; "Gross Interest On Chama Saving") { }
                column(Net_Interest_On_Chama; "Net Interest On Chama") { }
                column(QualifyingChama; QualifyingChama) { }
                column(FilterVaue; FilterVaue) { }
                column(CompanyInformationPic; CompanyInformation.Picture) { }
                column(CompanyInformationName; CompanyInformation.Name) { }
                column(Date; Date) { }
                column(Total_Chama_Savings; "Chama saving" + "Net Interest On Chama") { }
                //column()
                column(DecemberSavings; DecemberSavings) { }
                column(GrandTotal; GrandTotal + DecemberSavings + "Chama saving" + "Net Interest On Chama") { }
                // trigger OnAfterGetRecord()
                // begin
                //     Datefilter := Format(CalcDate('CY-31D+1D', Today)) + '..' + Format(CalcDate('CY', Today));
                //     FilterVaue := 0;
                //     DecemberSavings := 0;
                //     MemberName := '';
                //     Cust.Reset();
                //     Cust.SetRange(Cust."No.", "Dividends Progression"."Member No");
                //     //Cust.SetFilter("Date Filter",Datefilter);
                //     if Cust.Find('-') then begin
                //         MemberName := Cust.Name;

                //         //DecemberSavings:=Cust."Chama Savings"
                //     end;
                //     Cust.Reset();
                //     Cust.SetRange(Cust."No.", "Dividends Progression"."Member No");
                //     Cust.SetFilter("Date Filter", Datefilter);
                //     Cust.SetAutoCalcFields("Chama Savings");
                //     if Cust.Find('-') then begin
                //         repeat
                //             DecemberSavings += Cust."Chama Savings";
                //         until Cust.Next() = 0;
                //     end;
                // end;
                trigger OnAfterGetRecord()
                begin

                    Datefilter := Format(CalcDate('<CM>', Today)) + '..' + Format(CalcDate('<CY>', Today));

                    DecemberSavings := 0;
                    MemberName := '';

                    Cust.Reset();
                    Cust.SetRange("No.", "Dividends Progression"."Member No");
                    if Cust.FindFirst() then
                        MemberName := Cust.Name;


                    Cust.Reset();
                    Cust.SetRange("No.", "Dividends Progression"."Member No");
                    Cust.SetFilter("Date Filter", Datefilter);
                    Cust.SetAutoCalcFields("Programmed Deposits");

                    if Cust.FindFirst() then
                        DecemberSavings := Cust."Programmed Deposits";
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
            LayoutFile = 'Layouts/ChamaSlip.rdlc';
        }
    }

    var
        myInt: Integer;
        Cust: Record Customer;
        GrandTotal: Decimal;
        MemberName: Text[250];
        DecemberSavings: Decimal;
        FilterVaue: Decimal;
        Datefilter: Text;
        CompanyInformation: Record "Company Information";
}
