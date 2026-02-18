report 50000 "UpdateLoanStatus"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(DataItemName; "Loans Register")
        {
            RequestFilterFields = "Loan Product Type", "Loan  No.";

            DataItemTableView = where("Outstanding Balance" = filter(> 0));//, "Loan Product Type" = filter('INSTANT'));

            column(Loan_Status;
            "Loan Status")
            {

            }
            trigger OnAfterGetRecord()
            var

                loanapp: Record "Loans Register";
                MembersRegister: Record Customer;
            begin



                if loantype.Get("Loan Product Type") then begin

                    // Message('%1', LoanType."Interest rate");
                    DataItemName."Loan Product Type Name" := loantype."Product Description";
                    DataItemName.Modify(true);
                end;
                //DataItemName."Repayment Method" := loantype."Repayment Method";
                //DataItemName."Loan Product Type Name" := loantype."Product Description";
                // LPrincipal := ROUND(DataItemName."Approved Amount" / DataItemName.Installments, 1, '>');
                // if DataItemName.Installments > 12 then
                //     LInterest := ROUND((DataItemName.Interest / 12 / 100) * DataItemName."Approved Amount", 1, '>')
                // else
                //     LInterest := ROUND((DataItemName.Interest / DataItemName.Installments / 100) * DataItemName."Approved Amount", 1, '>');
                // //LPrincipal := TotalMRepay - LInterest;
                // DataItemName."Loan Principle Repayment" := LPrincipal;
                // DataItemName."Loan Interest Repayment" := LInterest;

                //if DataItemName."Repayment Start Date"  0D then begin
                // DataItemName."Expected Date of Completion" := CalcDate('90D', DataItemName."Issued Date");
                //DataItemName."Repayment Start Date" := DataItemName."Issued Date";

                //if loantype.Get("Loan Product Type") then begin

                DataItemName."Loan Product Type Name" := loantype."Product Description";
                // DataItemName.date of
                DataItemName.Modify(true);
                // end;
                //DataItemName."Repayment Frequency" := DataItemName."Repayment Frequency"::Monthly;
                // DataItemName."Repayment Method" := loantype."Repayment Method";

                // DataItemName.Validate("Requested Amount");
                //DataItemName.Modify(true);

                //AuFactory.FnGenerateLoanRepaymentSchedule(DataItemName."Loan  No.");

                // end;


                //end;

                // MembersRegister.Reset();
                // MembersRegister.SetRange("No.", "Client Code");
                // if MembersRegister.Find('-') then begin


                //     "Employer Code" := MembersRegister."Employer Code";
                //     "Employer Name" := MembersRegister."Employer Name";
                //     //modify(true);
                // end;

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
            LayoutFile = 'Layouts/mylayout.rdl';
        }
    }

    var
        myInt: Integer;
        AuFactory: Codeunit "Au Factory";
        TotalMRepay: Decimal;
        LInterest: Decimal;
        loantype: Record "Loan Products Setup";
        LPrincipal: Decimal;
        LoanregisterCopy: Record "Loans Register";
        LoanG: Record "Loans Guarantee Details";

}