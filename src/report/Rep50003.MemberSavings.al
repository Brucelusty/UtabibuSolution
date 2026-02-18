report 50003 "MemberSavings"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Layouts/MemberSavings.Rdlc';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(DataItemName; Customer)
        {
            DataItemTableView = order(ascending) where(ISNormalMember = filter(true));
            column(Member_No; "No.")
            {


            }
            column(MemberName; Name) { }
            column(Dividend_Amount; "Dividend Amount") { }
            column(Interest_On_Deposits; "Interest On Deposits") { }
            column(Dependant_Savings_1; "Programmed Deposits") { }
            column(Dependant_Savings_3; "Dependant Savings 3") { }
            column(Dependant_Savings_2; "Defaulted Loan Recovery") { }
            column(HouseHold_Savings; "HouseHold Savings") { }
            column(Holiday_Savings; "Holiday Savings") { }
            column(Utafiti_Housing; "Utafiti Housing") { }

        }
    }

    requestpage
    {
        layout
        {

        }
    }




    var
        myInt: Integer;
}