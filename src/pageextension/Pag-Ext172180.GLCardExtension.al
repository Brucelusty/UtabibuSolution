//************************************************************************
pageextension 172180 "GLCardExtension" extends "G/L Account Card"
{
    layout
    {
        // Add changes to page layout here
        modify("Account Category")
        {
            Visible = false;
        }
        addbefore("Income/Balance")
        {
            field("Account Category2"; Rec."Account Category")
            {
                Caption = 'Account Category';
                trigger OnValidate()
                begin
                    //if Rec."No." = StrPos()
                end;
            }
        }
        addlast(General)
        {
            field("Budget Controlled"; Rec."Budget Controlled") { }

        }
        addafter("Cost Accounting")
        {
            group("Sasra Setup")
            {
                Caption = 'Sasra Setup Controls';
                field(StatementOfFP; Rec.StatementOfFP)
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                    Caption = 'Statement of Financial Position';
                }
                field("Form2F(Statement of C Income)"; Rec."Form2F(Statement of C Income)")
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                    Caption = 'Statement of Comprehensive Income';

                }
                field("Capital adequecy"; Rec."Capital adequecy")
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                }
                field(Liquidity; Rec.Liquidity)
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;

                }
                field("Form 2H other disc"; Rec."Form 2H other disc")
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                    Caption = 'Form 2H Other disclosures';
                }
                field("Form2E(investment)"; Rec."Form2E(investment)")
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                }
                field("Form2E(investment)Land"; Rec."Form2E(investment)Land")
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                }
                field("Form2E(investment)New"; Rec."Form2E(investment)New")
                {
                    ApplicationArea = basic, suite;
                    Importance = Promoted;
                }

            }

        }
        modify(Reporting)
        {
            Visible = false;
        }
        modify("Cost Accounting")
        {
            Visible = false;
        }
        modify(Consolidation)
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    begin
        IsCOAEditable := CanEditCOA();
        if not IsCOAEditable then
            CurrPage.Editable(false);
    end;

    var
        IsCOAEditable: Boolean;

    local procedure CanEditCOA(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then
            exit(UserSetup."Can Edit COA");
        exit(false);
    end;

    var
        myInt: Integer;


}


