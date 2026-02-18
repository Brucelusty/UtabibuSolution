page 20387 "Memberlist Report"
{
    ApplicationArea = All;
    Caption = 'Member list Report';
    PageType = List;
    SourceTable = Customer;
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                }

                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }

                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {

                }

                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = basic;
                    Caption = 'E-Mail';
                }
                field(BlackListed; Rec.BlackListed)
                {
                    ApplicationArea = basic;
                    Caption = 'Utapesa Defaulter';
                    Editable = true;

                }
                field("Data Protection"; Rec."Data Protection")
                {
                    ApplicationArea = basic;


                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;

                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;

                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = basic;
                }

                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    Editable = false;
                }
                field("Referee Member No"; Rec."Referee Member No")
                {
                    ApplicationArea = basic;

                }
                field("Referee Name"; Rec."Referee Name")
                {
                    ApplicationArea = basic;

                }

                field("Member Last Transaction Date"; Rec."Member Last Transaction Date")
                {
                    ApplicationArea = basic;
                    Caption = 'Dormancy Base Date';
                }
                field("Current Shares"; Rec."Current Shares")
                {
                    ApplicationArea = all;
                    Caption = 'Member Deposits';
                }
                field("Shares Retained"; Rec."Shares Retained")
                {
                    ApplicationArea = all;
                    Caption = 'Share Capital';
                }
                field("Programmed Deposits"; Rec."Programmed Deposits")
                {
                    ApplicationArea = all;
                }
                field("Benevolent Fund"; Rec."Benevolent Fund")
                {
                    ApplicationArea = all;
                }
                field("M-Wallet Account"; Rec."M-Wallet Account")
                {
                    ApplicationArea = all;
                }
                field("Dividend Amount"; Rec."Dividend Amount")
                {
                    ApplicationArea = all;
                }
                field("Interest On Deposits"; Rec."Interest On Deposits")
                {
                    ApplicationArea = all;
                }
                field("Disbursment Account"; Rec."Disbursment Account")
                {
                    ApplicationArea = all;
                }
                field("Un-allocated Funds"; Rec."Un-allocated Funds")
                {
                    ApplicationArea = all;
                }
                field("Registration Fee Paid"; Rec."Registration Fee Paid")
                {
                    ApplicationArea = all;
                }
                field("Standing Order Acount"; Rec."Standing Order Acount")
                {
                    ApplicationArea = all;
                }
                field("Interest on PD"; Rec."Interest on PD") { ApplicationArea = all; }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = all;
                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

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

}
