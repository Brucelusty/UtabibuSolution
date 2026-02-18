//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 80013 "Loans Guarantee Details"
{
    PageType = ListPart;
    RefreshOnActivate = false;
    SourceTable = "Loans Guarantee Details";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("ID No.";Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(Shares; Rec.Shares)
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Deposits';
                }
                field("Amont Guaranteed";Rec."Amont Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Guaranteed';

                    trigger OnValidate()
                    begin
                        FnRunGetCummulativeAmountGuaranteed(Rec."Loan No");
                    end;
                }
                field("Loan Balance";Rec."Loan Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Total Amount Guaranteed";Rec."Total Amount Guaranteed")
                {
                    ApplicationArea = Basic;
                }
                field("Acceptance Status";Rec."Acceptance Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approval Status';
                    Editable = false;
                }
                field("Date Accepted";Rec."Date Accepted")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Responded';
                    Editable = false;
                }
                field("Mobile No";Rec."Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Free Shares";Rec."Free Shares")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Self Guarantee";Rec."Self Guarantee")
                {
                    ApplicationArea = Basic;
                }
                field(Substituted; Rec.Substituted)
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

    end;

    var
        Cust: Record Customer;
        EmployeeCode: Code[20];
        CStatus: Option Active,"Non-Active",Blocked,Dormant,"Re-instated",Deceased,Withdrawal,Retired,Termination,Resigned,"Ex-Company",Casuals,"Family Member","New (Pending Confirmation)","Defaulter Recovery";
        LoanApps: Record "Loans Register";
        StatusPermissions: Record "Status Change Permision";
        RunningBalance: Decimal;

    local procedure FnRunGetCummulativeAmountGuaranteed(VarLoanNo: Code[30])
    var
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
    begin
        RunningBalance := 0;

        LoansGuaranteeDetails.Reset;
        LoansGuaranteeDetails.SetRange(LoansGuaranteeDetails."Loan No", VarLoanNo);
        if LoansGuaranteeDetails.FindSet then begin
            repeat
                RunningBalance := RunningBalance + LoansGuaranteeDetails."Amont Guaranteed";
            until LoansGuaranteeDetails.Next = 0;
        end;
    end;
}




