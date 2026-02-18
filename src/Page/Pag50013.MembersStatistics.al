//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50013 "Members Statistics"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Customer;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Secondary Phone No.';
                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Width = 50;
                    Editable = false;
                }
                field("Disbursment Account"; Rec."Disbursment Account")
                {
                    Caption = 'Disbursement Account';
                    ApplicationArea = Basic;
                    Width = 50;
                    Editable = false;
                }
                field("M-Wallet Account"; Rec."M-Wallet Account")
                {
                    Caption = 'M-Wallet Account';
                    ApplicationArea = Basic;
                    Width = 50;
                    Editable = false;
                }
                field("Current Shares"; Rec."Current Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Deposits';
                    Visible = false;
                    Editable = false;
                }

                field("Utapesa credit limit"; Rec."Utapesa Credit limit")
                {
                    ApplicationArea = Basic;
                    // Caption = 'Member Deposits';
                    // Visible = false;
                    // Editable = false;
                    // Enabled = false;
                }

                field("Development Loan"; Rec."Development Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Emergency Loan"; Rec."Emergency Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Instant Loan"; Rec."Instant Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Maono Shamba Loan"; Rec."Maono Shamba Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("School Fees Loan"; Rec."School Fees Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Super Plus Loan"; Rec."Super Plus Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Super School Fees Laon"; Rec."Super School Fees Laon")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Top Loan"; Rec."Top Loan")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Top Loan 1"; Rec."Top Loan 1")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Dividend Amount"; Rec."Dividend Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    // Visible = false;
                }
                field("Shares Retained"; Rec."Shares Retained")
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital';
                }
                group("Share Capital")
                {
                    Caption = 'Share Capital';
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = basic;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest") { ApplicationArea = basic; Editable = false; }

                group(LoanAnalysis)
                {
                    field(LoanUderDoubtfulLoass; LoanUderDoubtfulLoass)
                    {
                        ApplicationArea = all;
                        Editable = false;
                        StyleExpr = FieldStyle;
                        trigger OnValidate()
                        begin
                            LoanUderDoubtfulLoass := auFactory.LoanPerformance(Rec."No.", Today);

                        end;
                    }
                    field(LoanunderDoubtfulandloss; LoanunderDoubtfulandloss)
                    {
                        ApplicationArea = all;
                        Editable = false;

                        Caption = 'Loan under Loss and Doubtful Balance';
                    }
                    field("Member Deposit"; Rec."Current Shares")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Member Deposits';
                        Editable = false;
                    }


                }


            }
            part("Member Accounts"; "Member Accounts")
            {
                SubPageLink = "BOSA Account No" = field("No.");
                Visible = false;
            }
            part(Control7; "Loans Sub-Page List")
            {
                SubPageLink = "Client Code" = field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Loan Recovery Logs")
            {
                ApplicationArea = Basic;
                Image = Form;
                Promoted = true;
                //     RunObject = Page "Loan Recovery Logs List";
                //     RunPageLink = "Member No" = field("No."),
                //                   "Member Name" = field(Name);
                //
            }
            action("Guarantor Recovery Report")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    ObjCust: Record "Members Register";
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", Rec."No.");
                    if ObjCust.Find('-') then
                        Report.run(172951, true, false, ObjCust);
                end;
            }
            action("BOSA Account Recovery Report")
            {
                ApplicationArea = Basic;
                Caption = 'BOSA Account Recovery Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    ObjCust: Record "Members Register";
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", Rec."No.");
                    if ObjCust.Find('-') then
                        Report.run(172068, true, false, ObjCust);
                end;
            }
            action("Loan Recovery Log Report")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ObjCust.Reset;
                    ObjCust.SetRange(ObjCust."No.", Rec."No.");
                    if ObjCust.Find('-') then
                        Report.run(172963, true, false, ObjCust);
                end;
            }

            action("Refresh CRedit limit")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;

                trigger OnAction()
                var
                    mobile: Codeunit "Mobile Banking Code";
                begin
                    mobile.GetEligibility('UTAPESA', rEC."ID No.", 1);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        /*ObjLoans.RESET;
        ObjLoans.SETRANGE("Client Code","No.");
        IF ObjLoans.FIND('-') THEN
        OutstandingInterest:=SFactory.FnGetInterestDueTodate(ObjLoans)-ObjLoans."Interest Paid";*/

    end;

    trigger OnOpenPage()
    begin
        Rec.CalcFields("Current Shares");
        Rec.CalcFields("Shares Retained");
        Rec.CalcFields("Interest on PD");
        Rec.CalcFields("Programmed Deposits");
        Rec.CalcFields("Outstanding Balance");
        Rec.CalcFields("Outstanding Interest");
        Rec.CalcFields("Un-allocated Funds");
        Rec.CalcFields("Dividend Amount");
        Rec.CalcFields("Interest On Deposits");
        Rec.CalcFields("Interest Charged");
        Rec.CalcFields("Loan Count");
        Rec.CalcFields("Standing Order Acount");
        Rec.CalcFields("Benevolent Fund");
        Rec.CalcFields("Defaulted Loan Recovery");
        Rec.CalcFields("Registration Fee Paid");
        Rec.CalcFields("Disbursment Account");
        Rec.CalcFields("M-Wallet Account");
    end;

    trigger OnAfterGetRecord()
    begin
        /*IF ("Assigned System ID"<>'') AND ("Assigned System ID"<>USERID) THEN BEGIN
          ERROR('You do not have permission to view this account Details');
          END;*/

        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
            if UserSetup.Get(UserId) then begin
                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
            end;
        end;


        LoanUderDoubtfulLoass := auFactory.LoanPerformance(Rec."No.", Today);
        LoanunderDoubtfulandloss := auFactory.LoanUnderLossBlance(Rec."No.", Today);
        if Rec."Current Shares" > LoanunderDoubtfulandloss then begin
            LoanCreditScore := 10;

        end else begin
            LoanCreditScore := 0;

        end;
        if LoanCreditScore = 0 then
            FieldStyle := 'Attention';
        if LoanCreditScore = 1 then
            FieldStyle := 'Favorable';

        SetFieldStyle;
    end;

    var
        UserSetup: Record "User Setup";
        FieldStyle: Text;
        OutstandingInterest: Decimal;
        InterestDue: Decimal;
        SFactory: Codeunit "Au Factory";
        ObjLoans: Record "Loans Register";
        ObjCust: Record Customer;

        LoanCreditScore: Integer;
        auFactory: Codeunit "Au Factory";
        LoanunderDoubtfulandloss: Decimal;
        LoanUderDoubtfulLoass: Integer;

    local procedure SetFieldStyle()
    begin
        FieldStyle := '';
        Rec.CalcFields("Un-allocated Funds");
        if Rec."Un-allocated Funds" <> 0 then
            FieldStyle := 'Attention';
        if LoanCreditScore = 0 then
            FieldStyle := 'Attention';
        if LoanCreditScore = 1 then
            FieldStyle := 'Favorable';
    end;
}




