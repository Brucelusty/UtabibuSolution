page 17298 "Member Group Card"
{
    ApplicationArea = All;
    Caption = 'Member Group Card';
    PageType = Card;
    SourceTable = "Member Group";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                    Caption = 'Group No';
                }

                field("Group Name"; Rec."Group Name")
                {
                    ToolTip = 'Specifies the value of the Group Name field.';
                }
                field("KRA Pin"; Rec."KRA Pin")
                {
                    ToolTip = 'Specifies the value of the KRA Pin field.';
                }

                field("Registration Date"; Rec."Registration Date")
                {
                    ToolTip = 'Specifies the value of the Registration Date field.';
                }
                field("Created by"; Rec."Created by") { }
                field("Creation TimeDate"; Rec."Creation TimeDate") { }
                field("Deposits Balance"; DepositsBalance) { ApplicationArea = all; Enabled = false; Caption = 'Group Deposits'; }

                field(ShareCapital; ShareCapital) { ApplicationArea = all; Enabled = false; Caption = 'Shares Capital'; }
                field(Loanbalances; Loanbalances) { ApplicationArea = all; Enabled = false; Caption = 'Outstanding Loan Balance'; }
            }

            part(members; "Members Group List")
            {
                SubPageLink = "Group No" = field(No);
                ApplicationArea = all;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        DepositsBalance := FnGetMemberDepositsPerGroup();
        ShareCapital := FnGetMemberShareCapitalPerGroup();
        Loanbalances := FnGetMemberLoanBalancesPerGroup();
    end;

    var
        Customer: Record Customer;
        DepositsBalance: Decimal;
        Depositbalances: Decimal;
        ShareCapital: Decimal;
        Loanbalances: Decimal;

    procedure FnGetMemberDepositsPerGroup() Deposits: decimal;
    var
        myInt: Integer;
    begin
        Deposits := 0;
        Customer.Reset();
        Customer.SetRange("Group No", Rec.No);
        Customer.SetAutoCalcFields("Current Shares");
        if Customer.FindSet() then begin
            repeat
                Deposits += Customer."Current Shares";
            until Customer.Next() = 0;
        end;
        exit(Deposits);
    end;

    procedure FnGetMemberLoanBalancesPerGroup() Loan: decimal;

    begin
        Loanbalances := 0;
        Customer.Reset();
        Customer.SetRange("Group No", Rec.No);
        Customer.SetAutoCalcFields("Outstanding Balance");
        if Customer.FindSet() then begin
            repeat
                Loan += Customer."Outstanding Balance";
            until Customer.Next() = 0;
        end;
        exit(Loan);
    end;

    procedure FnGetMemberShareCapitalPerGroup() Share: decimal;
    var
        myInt: Integer;
    begin
        ShareCapital := 0;
        Customer.Reset();
        Customer.SetRange("Group No", Rec.No);
        Customer.SetAutoCalcFields("Shares Retained");
        if Customer.FindSet() then begin
            repeat
                Share += Customer."Shares Retained";
            until Customer.Next() = 0;
        end;
        exit(Share);
    end;

}
