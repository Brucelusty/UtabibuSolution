page 17297 "Member Group List"
{
    ApplicationArea = All;
    Caption = 'Member Group List';
    PageType = List;
    CardPageId = "Member Group Card";
    SourceTable = "Member Group";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
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
                field("Created by"; Rec."Created by")
                {
                    ToolTip = 'Specifies the user who created the group';
                }
                field("Creation TimeDate"; Rec."Creation TimeDate")
                {
                    ToolTip = 'Specifies the creation time of the group';
                }


                field("Deposits Balance"; DepositsBalance) { ApplicationArea = all; Enabled = false; Caption = 'Group Deposits'; }

                field(ShareCapital; ShareCapital) { ApplicationArea = all; Enabled = false; Caption = 'Shares Capital'; }
                field(Loanbalances; Loanbalances) { ApplicationArea = all; Enabled = false; Caption = 'Outstanding Loan Balance'; }
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
