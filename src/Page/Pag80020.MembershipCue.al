//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 80020 "Membership Cue"
{
    PageType = CardPart;
    SourceTable = "Membership Cue";

    layout
    {
        area(content)
        {

            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                field("Requests Sent for Approval"; Rec."Requests Sent for Approval")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Approval Entries";
                }
                field("Requests to Approve"; Rec."Requests to Approve")
                {
                    ApplicationArea = Basic;
                    StyleExpr = OutboxCueStyle;
                    DrillDownPageID = "Requests to Approve";
                }
            }
            cuegroup(Members)
            {
                field("Active Members"; Rec."Active Members")
                {
                    ApplicationArea = Basic;
                    Image = None;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Members List";

                }
                field("Dormant Members"; Rec."Dormant Members")
                {
                    ApplicationArea = Basic;
                    Image = None;
                    Style = Ambiguous;
                    StyleExpr = true;
                    DrillDownPageId = "Members List";

                }

                field("Deceased Members"; Rec."Deceased Members")
                {
                    ApplicationArea = Basic;
                    Image = None;
                    Caption = 'Deceased Accounts';
                    Style = Attention;
                    StyleExpr = true;
                    DrillDownPageId = "Members List";

                }
                field("Withdrawn Members"; Rec."Withdrawn Members")
                {
                    ApplicationArea = Basic;
                    Image = None;
                    Style = Attention;
                    StyleExpr = true;
                    DrillDownPageId = "Members List";

                }
                field("Retired"; Rec."Non-Active Members")
                {
                    ApplicationArea = Basic;
                    Image = None;
                    Caption = 'Terminated Accounts';
                    Style = Attention;
                    StyleExpr = true;
                    Visible = true;
                    DrillDownPageId = "Members List";


                }
                field("Group Accounts"; Rec."Group Accounts")
                {
                    ApplicationArea = Basic;
                    DrillDownPageId = "Group List";
                    Image = None;
                    Style = Favorable;
                    StyleExpr = true;


                }
                field("Joint Accounts"; Rec."Joint Accounts")
                {
                    ApplicationArea = Basic;
                    DrillDownPageId = "Members List";
                    Image = None;

                }
                field("Members Awaiting Exit"; Rec."Members Awaiting Exit")
                {
                    ApplicationArea = Basic;
                    DrillDownPageId = "Members List";
                    Image = None;
                    StyleExpr = AwaitingExit;

                }
            }
            cuegroup("Account Categories")
            {
                field("Female Members"; Rec."Female Members")
                {
                    ApplicationArea = Basic;
                    Image = None;
                    DrillDownPageId = "Members List";

                }
                field("Male Members"; Rec."Male Members")
                {
                    ApplicationArea = Basic;
                    Image = None;
                    DrillDownPageId = "Members List";


                }
                field("ALL Members"; Rec."ALL Members")
                {
                    ApplicationArea = Basic;
                    Image = None;
                    Style = Favorable;
                    StyleExpr = true;
                    DrillDownPageId = "Members List";
                }
            }
            cuegroup(Loans)
            {
                Caption = 'Loans';
                field("Development Loan"; Rec."Development Loan")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Loans  List All";
                    Image = None;
                    LookupPageID = "Loans  List All";
                }
                field("Emergency Loan"; Rec."Emergency Loan")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "Loans  List All";
                    Image = None;
                    LookupPageID = "Loans  List All";
                }
                field("Normal  Loans"; Rec."Business Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Coop Loan';
                    DrillDownPageID = "Loans  List All";
                    Image = None;
                    LookupPageID = "Loans  List All";
                }
                field("Super Saver"; Rec."Jijenge Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Coop loan 41';
                    DrillDownPageID = "Loans  List All";
                    Image = None;
                    LookupPageID = "Loans  List All";
                }
                field("School Fees Loan"; Rec."School Fees Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Shool Fee Loan';
                    DrillDownPageID = "Loans  List All";
                    Image = None;
                    LookupPageID = "Loans  List All";
                }
                field("Advance Loan"; Rec."Corporate Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposit Booster Loan';
                    Image = None;
                    DrillDownPageID = "Loans  List All";
                    LookupPageID = "Loans  List All";
                }
                field("M-SHOFCO"; Rec."Personal Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'UTAPESA';
                    DrillDownPageID = "Loans  List All";
                    Image = None;
                    LookupPageID = "Loans  List All";
                }
                field("Asset Finance"; Rec."Asset Finance")
                {
                    ApplicationArea = Basic;
                    Caption = 'Defaulter Loan';
                    DrillDownPageID = "Loans  List All";
                    Image = None;
                    LookupPageID = "Loans  List All";
                }
                field("LPO Loan"; Rec."Community Development Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Instant Loan ';
                    Image = None;
                    DrillDownPageID = "Loans  List All";
                    LookupPageID = "Loans  List All";
                }
                field("Easter Loan"; Rec."Ufalme Project Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Development Plus Loan';
                    DrillDownPageID = "Loans  List All";
                    Image = None;
                    LookupPageID = "Loans  List All";
                }
                field("Div-Advance Loan"; Rec."Dhamana Loan")
                {
                    ApplicationArea = basic;
                    Caption = 'Dividend Loan';
                    DrillDownPageId = "Loans  List All";
                    //     Image = Library;
                    Image = None;
                    LookupPageId = "Loans  List All";
                }
                field("Defaulted Loans"; Rec."Defaulted Loans")
                {
                    ApplicationArea = basic;
                    Caption = 'Jibambe Loan';
                    DrillDownPageId = "Loans  List All";
                    Image = None;
                    LookupPageId = "Loans  List All";

                }
                field("Car Loan"; Rec."Haraka Loan")
                {
                    ApplicationArea = basic;
                    Caption = 'OverDue-Instant Loan';
                    DrillDownPageId = "Loans  List All";
                    Image = None;
                    LookupPageId = "Loans  List All";
                }
                field("house hold Loan"; Rec."House Hold Loan")
                {
                    ApplicationArea = basic;
                    Caption = 'Refinance Loan';
                    DrillDownPageId = "Loans  List All";
                    Image = None;
                    LookupPageId = "Loans  List All";
                }
                field("Pamoja Loan"; Rec."Pamoja Loan")
                {
                    ApplicationArea = basic;
                    Caption = 'Hepuka Shylock';
                    DrillDownPageId = "Loans  List All";
                    Image = None;
                    LookupPageId = "Loans  List All";
                }
                field("Qaribu Loan"; Rec."Qaribu Loan")
                {
                    ApplicationArea = basic;
                    Caption = 'Special Emergency Loan';
                    DrillDownPageId = "Loans  List All";
                    Image = None;
                    LookupPageId = "Loans  List All";
                }
                field("Quick Fix Loan"; Rec."Quick Fix Loan")
                {
                    ApplicationArea = basic;
                    Caption = 'Super Loan';
                    DrillDownPageId = "Loans  List All";
                    Image = None;
                    LookupPageId = "Loans  List All";
                }








            }

            cuegroup(Leave)
            {
                Caption = 'Leave';
                field("Leave Pending"; Rec."Leave Pending")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                }
                field("Leave Approved"; Rec."Leave Approved")
                {
                    ApplicationArea = Basic;
                    DrillDownPageID = "HR Leave Applications List";
                }
            }
            cuegroup("Pending Documents")
            {
                Visible = false;
                Caption = 'Pending Documents';
                //visible = false;

                field("Staff Claims Pending"; Rec."Staff Claims Pending")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Claims Approved"; Rec."Staff Claims Approved")
                {
                    ApplicationArea = Basic;
                }
                field("Pending Cheque Payments"; Rec."Pending Cheque Payments")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Cheque Payments"; Rec."Approved Cheque Payments")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if not Rec.Get(UserId) then begin
            Rec.Init;
            Rec."User ID" := UserId;
            Rec.Insert;
            Style();
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        Style();
    end;

    var
        OutboxCueStyle: Text;
        AwaitingExit: text;

    procedure Style()
    begin
        Rec.CalcFields("Requests to Approve", "Members Awaiting Exit");
        if Rec."Requests to Approve" > 0 then begin
            OutboxCueStyle := 'UnFavorable'
        end else begin
            OutboxCueStyle := 'favorable';
        end;



        if Rec."Members Awaiting Exit" > 0 then
            AwaitingExit := 'UnFavorable'
        else
            AwaitingExit := 'favorable';
    end;

}




