//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 80070 "Group List"
{
    Caption = 'Group List';
    CardPageID = "Group Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Customer;
    SourceTableView = order(ascending) where(ISNormalMember = filter(true), "Account Category" = filter(Group));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec."Name of the Group/Corporate")
                {
                    ApplicationArea = Basic;
                }


                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = basic;
                    Caption = 'E-Mail';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }

            }
        }
        area(factboxes)
        {
            part(Control14; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
            part(Control13; "Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
            part(Control12; "Member Signature-Uploaded")
            {
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Process)
            {
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                    Visible = false;
                }
                action("Bank Account")
                {
                    ApplicationArea = Basic;
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = field("No.");
                    Visible = false;
                }
                action(Contacts)
                {
                    ApplicationArea = Basic;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        //ShowContact;
                    end;
                }
                action("Member Accounts")
                {
                    ApplicationArea = Basic;
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Accounts List";
                    RunPageLink = "BOSA Account No" = field("No.");
                }
                action("CRB Query Charge")
                {
                    ApplicationArea = Basic;
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "CRB Check Charge List";
                    RunPageLink = "Member No" = field("No.");
                    Visible = false;
                }
            }
            group("Issued Documents")
            {
                Caption = 'Issued Documents';
                Visible = false;
                action("Loans Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guarantors';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.", Rec."No.");
                        IF Cust.FIND('-') THEN
                            //REPORT.RUN(,TRUE,FALSE,Cust);

                            Message('home');
                    end;
                }
                action("Loans Guarantors")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Cust);
                        */
                        LGurantors.Reset;
                        LGurantors.SetRange(LGurantors."Loan No", Rec."No.");
                        if LGurantors.Find('-') then begin
                            Report.Run(172504, true, false, Cust);
                        end;

                    end;
                }
            }
            group(ActionGroup1102755013)
            {
                action("Members Kin Details List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Members Kin Details List';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Nominee Details List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Details';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("No.");

                    trigger OnAction()
                    begin
                        //SFactory."FnRunGetMembersLoanDue&ArrearsAmount"("No.");
                    end;
                }
                action("Members Guaranteed")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loans Guarantee Details";
                    RunPageLink = Name = field(Name);
                    RunPageMode = View;

                    trigger OnAction()
                    begin
                        LGurantors.Reset;
                        LGurantors.SetRange(LGurantors."Loan No", Rec."No.");
                        if LGurantors.Find('-') then begin
                            Report.Run(172504, true, false, Cust);
                        end;
                    end;
                }
                separator(Action1102755008)
                {
                }
            }
            group(ActionGroup1102755007)
            {
                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                            if UserSetup.Get(UserId) then begin
                                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                            end;

                        end;
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(80007, true, false, Cust);
                    end;
                }
                action("Loan Statement")
                {
                    ApplicationArea = Basic;
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(80027, true, false, Cust);

                    end;
                }
                action("Account Closure Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(80008, true, false, Cust);
                    end;
                }
                action("Group Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'House Group Statement  Internal';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ObjCellGroups.Reset;
                        ObjCellGroups.SetRange(ObjCellGroups."Cell Group Code", Rec."Member House Group");
                        if ObjCellGroups.Find('-') then
                            Report.run(172920, true, false, ObjCellGroups);
                    end;
                }
                action(HouseGroupStatement)
                {
                    ApplicationArea = Basic;
                    Caption = 'House Group Statement';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        ObjCellGroups.Reset;
                        ObjCellGroups.SetRange(ObjCellGroups."Cell Group Code", Rec."Member House Group");
                        if ObjCellGroups.Find('-') then
                            Report.run(172946, true, false, ObjCellGroups);
                    end;
                }
                action("Send Member Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(172073, true, false, Cust);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        DepositsBalance := FnGetMemberDepositsPerGroup();
        ShareCapital := FnGetMemberShareCapitalPerGroup();
        Loanbalances := FnGetMemberLoanBalancesPerGroup();
        Customer.Reset();
        Customer.SetRange("No.", Rec."No.");
        if Customer.FindFirst() then begin
            Rec."Name of the Group/Corporate" := Customer.Name;
        end;
    end;


    var
        Cust: Record Customer;
        GeneralSetup: Record "Sacco General Set-Up";
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        TotalAvailable: Integer;
        Loans: Record "Loans Register";
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        TotalDefaulterR: Decimal;
        Value2: Decimal;
        AvailableShares: Decimal;
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        RoundingDiff: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        UserSetup: Record "User Setup";
        MemberLiability: Decimal;
        SFactory: Codeunit "Au Factory";
        ObjCellGroups: Record "Member House Groups";

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
        Customer.SetRange("Group No", Rec."No.");
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
        Customer.SetRange("Group No", Rec."No.");
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
        Customer.SetRange("Group No", Rec."No.");
        Customer.SetAutoCalcFields("Shares Retained");
        if Customer.FindSet() then begin
            repeat
                Share += Customer."Shares Retained";
            until Customer.Next() = 0;
        end;
        exit(Share);
    end;





    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record Customer;
        FirstCust: Code[30];
        LastCust: Code[30];
        SelectionFilter: Code[250];
        CustCount: Integer;
        More: Boolean;
    begin
        /*CurrPage.SETSELECTIONFILTER(Cust);
        CustCount := Cust.COUNT;
        IF CustCount > 0 THEN BEGIN
          Cust.FIND('-');
          WHILE CustCount > 0 DO BEGIN
            CustCount := CustCount - 1;
            Cust.MARKEDONLY(FALSE);
            FirstCust := Cust."No.";
            LastCust := FirstCust;
            More := (CustCount > 0);
            WHILE More DO
              IF Cust.NEXT = 0 THEN
                More := FALSE
              ELSE
                IF NOT Cust.MARK THEN
                  More := FALSE
                ELSE BEGIN
                  LastCust := Cust."No.";
                  CustCount := CustCount - 1;
                  IF CustCount = 0 THEN
                    More := FALSE;
                END;
            IF SelectionFilter <> '' THEN
              SelectionFilter := SelectionFilter + '|';
            IF FirstCust = LastCust THEN
              SelectionFilter := SelectionFilter + FirstCust
            ELSE
              SelectionFilter := SelectionFilter + FirstCust + '..' + LastCust;
            IF CustCount > 0 THEN BEGIN
              Cust.MARKEDONLY(TRUE);
              Cust.NEXT;
            END;
          END;
        END;
        EXIT(SelectionFilter);
        */

    end;


    procedure SetSelection(var Cust: Record Customer)
    begin
        //CurrPage.SETSELECTIONFILTER(Cust);
    end;
}




