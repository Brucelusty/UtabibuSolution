//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50017 "Loan Application BOSA(New)"
{
    CardPageID = "Loan Application Card(BOSA)";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Loan Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption', Locked = true;
    SourceTable = "Loans Register";
    SourceTableView = where(Posted = filter(false),
                            Source = const(BOSA),
                            "Approval Status" = filter(Open), "Archive Loan" = filter(false));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("ID NO"; Rec."ID NO")
                {
                    ApplicationArea = Basic;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }
                field(Source; rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Captured By";Rec."Captured By")
                {
                  ApplicationArea = Basic;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';
                Image = AnalysisView;
                action("Mark As Rejected")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mark As Rejected';
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        UserSetup: Record "User Setup";
                    begin

                        if UserSetup.Get(UserId) then
                            if UserSetup."Post Pv" = false then error('You dont have this right. Contact System admin for further assistance.');
                        if Confirm('Are you sure you want to mark this loan as rejected?') = false then exit;
                        rec."Loan Status" := Rec."Loan Status"::Rejected;
                        rec.Modify;
                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        rec.TestField("Mode of Disbursement");

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(172493, true, false, LoanApp)
                        end;
                    end;
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';

                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        SFactory.FnGenerateLoanRepaymentSchedule(rec."Loan  No.");

                        LoanApp.reset;
                        LoanApp.SetRange(loanapp."Loan  No.", rec."Loan  No.");
                        if loanapp.Find('-') then begin
                            Report.Run(172477, true, false, LoanApp);
                        end
                    end;
                }
                action("Loan Securities")
                {
                    ApplicationArea = Basic;
                    Caption = 'Securities';
                    Image = AllLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Collateral Security";
                    RunPageLink = "Loan No" = field("Loan  No.");
                    Visible = true;
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                    // ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if rec."Approved Amount" = 0 then Error('Kindly upraise your loan application before sending approval request');

                        rec.TestField("Loan Product Type");
                        rec.TestField("Recovery Mode");
                        rec.TestField("Requested Amount");
                        if rec."Approval Status" <> rec."approval status"::Open then
                            Error(Text001);

                        IF Workflowinteg.CheckLoanApplicationApprovalsWorkflowEnabled(Rec) THEN
                            Workflowinteg.OnSendLoanApplicationForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    //ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        Workflowinteg.OnCancelLoanApplicationApprovalRequest(Rec);
                    end;
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::LoanApplication;
                        ApprovalEntries.SetRecordFilters(Database::"Loans Register", DocumentType, rec."Loan  No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("Captured By", UserId);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        EnableCreateMember := false;
        EditableAction := true;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec."Approval Status" = rec."approval status"::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec."Approval Status" = rec."approval status"::Approved) then
            EnableCreateMember := true;

        if Rec."Approval Status" <> rec."approval status"::Open then
            EditableAction := false;
        if rec."Approval Status" = rec."approval status"::Pending then
            EditableAction := false; //to correct
    end;

    trigger OnAfterGetRecord()
    begin
        Overdue := Overdue::" ";
        if FormatField(Rec) then
            Overdue := Overdue::Yes;
    end;

    var
        LoanType: Record "Loan Products Setup";
        ApprovalsMgmt: Codeunit 1535;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanApp: Record "Loans Register";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        SpecialComm: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        LoansR: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        Vend: Record Vendor;
        LineNo: Integer;
        DoubleComm: Boolean;
        AvailableBal: Decimal;
        Account: Record Vendor;
        RunBal: Decimal;
        TotalRecovered: Decimal;
        OInterest: Decimal;
        OBal: Decimal;
        ReffNo: Code[20];
        DiscountCommission: Decimal;
        BridgedLoans: Record "Loan Offset Details";
        LoanAdj: Decimal;
        LoanAdjInt: Decimal;
        AdjustRemarks: Text[30];
        Princip: Decimal;
        Overdue: Option Yes," ";
        i: Integer;
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sales & Receivables Setup";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Appraisal Salary Details";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "File Movement Tracker";
        SMSMessage: Record Customer;
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        DocumentType: Enum "Document Type";
        //DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        EditableAction: Boolean;
        SFactory: Codeunit "Au Factory";
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Workflowinteg: Codeunit WorkflowIntegration;


    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20])
    begin
        LoanNo := rec."Loan  No.";
        LoanProductType := rec."Loan Product Type";
    end;


    procedure FormatField(Rec: Record "Loans Register") OK: Boolean
    begin
        if rec."Outstanding Balance" > 0 then begin
            if (Rec."Expected Date of Completion" < Today) then
                exit(true)
            else
                exit(false);
        end;
    end;


    procedure CalledFrom()
    begin
        Overdue := Overdue::" ";
    end;
}




