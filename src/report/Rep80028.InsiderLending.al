report 80028 "InsiderLending"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/InsiderLending.rdlc';


    dataset
    {
        dataitem(InsiderLending; InsiderLending)
        {

            column(Member_No; "Member No") { }
            column(Position_Held; "Position Held") { }
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Member No");
                column(No_; "No.") { }
                column(Current_Shares; "Current Shares") { }
                dataitem("Loans Register"; "Loans Register")
                {
                    DataItemLink = "Client Code" = field("No.");
                    DataItemTableView = where("Outstanding Balance" = filter(> 0));
                    column(Loan__No_; "Loan  No.")
                    {

                    }
                    column(Client_Code; "Client Code") { }
                    column(Client_Name; "Client Name") { }
                    column(Issued_Date; "Issued Date") { }
                    column(Loan_Product_Type; "Loan Product Type") { }
                    column(Requested_Amount; "Requested Amount") { }
                    column(Approved_Amount; "Approved Amount") { }
                    column(Repayment_Start_Date; "Repayment Start Date") { }
                    column(Expected_Date_of_Completion; "Expected Date of Completion") { }
                    column(Loan_Disbursement_Date;"Loan Disbursement Date"){}
                    column(Date_Approved; "Date Approved") { }
                    column(Installments; Installments) { }
                    column(OtherRemarks; OtherRemarks) { }
                    column(Fileter13; Fileter13) { }
                    trigger OnAfterGetRecord()
                    begin
                        Fileter13 := '';
                    end;

                    trigger OnPreDataItem()
                    begin
                        //  "Loans Register".SetFilter("Issued Date", '<%1', calcdate('-CM',AsAt));
                        "Loans Register".SetFilter("Issued Date", '%1..%2', calcdate('-CM', AsAt), CalcDate('CM', AsAt));
                    end;

                }
                dataitem(Loan; "Loans Register")
                {
                    DataItemLink = "Client Code" = field("No.");
                    DataItemTableView = where("Outstanding Balance" = filter(> 0));

                    column(Client_Code2; Loan."Client Code") { }
                    column(Client_Name2; Loan."Client Name") { }
                    column(Loan_Product_Type2; Loan."Loan Product Type") { }
                    column(Requested_Amount2; Loan."Requested Amount") { }
                    column(Approved_Amount2; Loan."Approved Amount") { }
                    column(Repayment_Start_Date2; Loan."Repayment Start Date") { }
                    column(Installments2; Loan.Installments) { }
                    column(Loans_Category2; "Loans Category") { }
                    column(Loan_Disbursement_Date2; "Loan Disbursement Date") { }
                    column(Issued_Date2; Loan."Issued Date") { }
                    column(Outstanding_Balance; "Outstanding Balance") { }
                    column(Fileter1; Fileter1) { }

                    trigger OnPreDataItem()
                    begin

                        Loan.SetFilter("Issued Date", '<%1', calcdate('-CM', AsAt));
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        Fileter1 := '';
                    end;
                }

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
                    field(AsAt; AsAt)
                    {
                        ApplicationArea = All;

                    }
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



    var
        myInt: Integer;
        AsAt: Date;
        OtherRemarks: Text[150];
        Fileter1: Text[20];
        Fileter13: Text[20];
}