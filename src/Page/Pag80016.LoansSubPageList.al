//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 80016 "Loans Sub-Page List"
{
    //CardPageID = "Loans Application Card(Posted)";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    DelayedInsert = true;
    SourceTable = "Loans Register";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                FreezeColumn = "Loan Product Type";

                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;

                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Product';
                    Editable = false;
                    Enabled = false;

                }

                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Product Name';
                    Editable = false;
                    Enabled = false;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                    Editable = false;
                    Enabled = false;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                    Editable = false;
                    Enabled = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Requested Amount';
                    Editable = false;
                    Enabled = false;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Principle Balance';
                    Editable = false;
                    StyleExpr = FieldStyle;

                }
                field(Repayment; Round(Rec.Repayment, 1, '>'))
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outstanding Interest';
                    Editable = false;
                }
                field("Current Penalty Due"; Rec."Current Penalty Due")
                {
                    ApplicationArea = Basic;
                    Caption = 'Outstanding Penalty';
                    Importance = Additional;
                    Editable = false;
                }

                field("Amount in Arrears"; Rec."Amount in Arrears")
                {
                    ApplicationArea = Basic;
                    Caption = 'Arrears Amount';
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = FieldStyleArrears;
                }
                field("Days In Arrears"; Rec."No of Months in Arrears" * 30)
                {
                    ApplicationArea = Basic;
                    Caption = 'Arrears Days';//"Days In Arrears"
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = FieldStyleArrears;
                }

                field("Loan Principle Repayment"; Round(Rec."Loan Principle Repayment", 1, '>')) { ApplicationArea = all; Editable = false; }
                field("Loan Interest Repayment"; Round(Rec."Loan Interest Repayment", 1, '>')) { ApplicationArea = all; editable = false; }

                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }

                field("Loans Category"; Rec."Loans Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Disbused; Rec.Disbused) { }

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin

    end;

    trigger OnAfterGetRecord()
    begin


    end;

    trigger OnOpenPage()
    begin

        Rec.CalcFields("Outstanding Balance");
        Rec.CalcFields("Outstanding Interest");
        Rec.CalcFields("Current Penalty Due");
    end;

    var
        LoanType: Record "Loan Products Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FieldStyle: Text;
        FieldStyleI: Text;
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "Au Factory";
        ObjLoans: Record "Loans Register";
        VarLoanPayoffAmount: Decimal;
        VarInsurancePayoff: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        VarEndYear: Date;
        VarInsuranceMonths: Integer;
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarOutstandingInterestI: Decimal;
        FieldStyleArrears: Text;

        PrincipleAmountupdate: Decimal;


    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20]; var MemberNo: Code[20])
    begin
        LoanNo := Rec."Loan  No.";
        LoanProductType := Rec."Loan Product Type";
        MemberNo := Rec."Client Code";
    end;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        Rec.CalcFields("Outstanding Balance", "Outstanding Interest");
        if (Rec."Outstanding Balance" < 0) then
            FieldStyle := 'Attention';

        if (Rec."Outstanding Interest" < 0) then
            FieldStyleI := 'Attention';


        FieldStyleArrears := 'Strong';
        if (Rec."Amount in Arrears" > 0) then
            FieldStyleArrears := 'Unfavorable';
        if (Rec."Amount in Arrears" = 0) then
            FieldStyleArrears := 'Favorable';
    end;
}




