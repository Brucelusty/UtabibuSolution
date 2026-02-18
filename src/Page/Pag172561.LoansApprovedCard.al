//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172561 "Loans Approved Card"
{

    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Loans Register";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan  No.";Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Staff No";Rec."Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff No';
                    Editable = false;
                }
                field("Client Code";Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member';
                    Editable = MNoEditable;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                }
                field("Client Name";Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID NO";Rec."ID NO")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Deposits";Rec."Member Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = ApplcDateEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = LProdTypeEditable;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                    Editable = InstallmentEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Product Currency Code";Rec."Product Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Enabled = true;
                }
                field("Requested Amount";Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Recommended Amount";Rec."Recommended Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = ApprovedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Loan Purpose";Rec."Loan Purpose")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field("Repayment Method";Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = RepaymentEditable;
                }
                field("Approved Repayment";Rec."Approved Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Status";Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = LoanStatusEditable;

                    trigger OnValidate()
                    begin
                        UpdateControl();

                       
                    end;
                }
                field("Batch No.";Rec."Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = BatchNoEditable;
                }
                field("Captured By";Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Offset Amount";Rec."Loan Offset Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bridged Amount';
                }
                field("Repayment Frequency";Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = RepayFrequencyEditable;
                }
                field("Mode of Disbursement";Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = ModeofDisburesmentEdit;
                }
                field("Loan Disbursement Date";Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Cheque No.";Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Visible = true;

                    trigger OnValidate()
                    begin
                        if StrLen(Rec."Cheque No.") > 6 then
                            Error('Document No. cannot contain More than 6 Characters.');
                    end;
                }
                field("Repayment Start Date";Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Date of Completion";Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("External EFT";Rec."External EFT")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Approval Status";Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("partially Bridged";Rec."partially Bridged")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Total Offset Commission";Rec."Total Offset Commission")
                {
                    ApplicationArea = Basic;
                }
                field("Rejection  Remark";Rec."Rejection  Remark")
                {
                    ApplicationArea = Basic;
                    Editable = RejectionRemarkEditable;
                }
            }
            group("Salary Details")
            {
                Caption = 'Salary Details';
            }
            group(Earnings)
            {
                Caption = 'Earnings';
                field("Basic Pay H";Rec."Basic Pay H")
                {
                    ApplicationArea = Basic;
                    Caption = 'Basic Pay';
                }
                field("House AllowanceH";Rec."House AllowanceH")
                {
                    ApplicationArea = Basic;
                    Caption = 'House Allowance';
                }
                field("Medical AllowanceH";Rec."Medical AllowanceH")
                {
                    ApplicationArea = Basic;
                    Caption = 'Medical Allowance';
                }
                field("Transport/Bus Fare";Rec."Transport/Bus Fare")
                {
                    ApplicationArea = Basic;
                }
                field("Other Income";Rec."Other Income")
                {
                    ApplicationArea = Basic;
                }
                field("Gross Pay";Rec."Gross Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Net take Home";Rec."Net take Home")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Non-Taxable Deductions")
            {
                Caption = 'Non-Taxable Deductions';
                field("Pension Scheme";Rec."Pension Scheme")
                {
                    ApplicationArea = Basic;
                }
                field("Other Non-Taxable";Rec."Other Non-Taxable")
                {
                    ApplicationArea = Basic;
                }
                field("Other Tax Relief";Rec."Other Tax Relief")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Deductions)
            {
                Caption = 'Deductions';
                field("Monthly Contribution";Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                }
                field(NHIF; Rec.NHIF)
                {
                    ApplicationArea = Basic;
                }
                field(NSSF; Rec.NSSF)
                {
                    ApplicationArea = Basic;
                }
                field(PAYE; Rec.PAYE)
                {
                    ApplicationArea = Basic;
                }
                field("Risk MGT";Rec."Risk MGT")
                {
                    ApplicationArea = Basic;
                }
                field("Medical Insurance";Rec."Medical Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Life Insurance";Rec."Life Insurance")
                {
                    ApplicationArea = Basic;
                }
                field("Other Liabilities";Rec."Other Liabilities")
                {
                    ApplicationArea = Basic;
                }
                field("Sacco Deductions";Rec."Sacco Deductions")
                {
                    ApplicationArea = Basic;
                }
                field("Other Loans Repayments";Rec."Other Loans Repayments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bank Loan Repayments';
                }
                field("Total Deductions(Salary)";Rec."Total Deductions(Salary)")
                {
                    ApplicationArea = Basic;
                }
                field(UtilizableAmount; Rec."Utilizable Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Bridge Amount Release";Rec."Bridge Amount Release")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cleared Loan Repayment';
                }
                field("Net Utilizable Amount";Rec."Net Utilizable Amount")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000004; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1000000005; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No" = field("Loan  No.");
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
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = Aging;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.run(172384, true, false, LoanApp);
                        end;
                    end;
                }
                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."Client Code");
                        Report.run(172223, true, false, Cust);
                    end;
                }
                separator(Action1102760046)
                {
                }
                action("Loan Repayment Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Repayment Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin

                        SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Commit;
                            Report.Run(172477, true, false, LoanApp);
                        end;
                    end;
                }
                separator(Action1102755012)
                {
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                separator(Action1102760039)
                {
                }
                action("Post Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Loan Appeal';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;

                    trigger OnAction()
                    begin


                        // FOSA posting

                        if Rec."Mode of Disbursement" = Rec."mode of disbursement"::"FOSA Account" then begin
                            LoanApps.Reset;
                            LoanApps.SetRange(LoanApps."Batch No.", Rec."Batch No.");
                            LoanApps.SetRange(LoanApps."System Created", false);
                            LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
                            if LoanApps.Find('-') then begin
                                repeat
                                    LoanApp."Issued Date" := Today;
                                    //MESSAGE('');
                                    LoanApps.Posted := true;
                                    LoanApps.Modify;


                                    LoanApps.CalcFields(LoanApps."Loan Offset Amount", LoanApps."Offset iNTEREST");
                                    TCharges := 0;
                                    TopUpComm := 0;
                                    TotalTopupComm := 0;







                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := Rec."Loan  No.";
                                    GenJournalLine."Posting Date" := Rec."Loan Disbursement Date";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::None;
                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine.Description := 'loans Topup';
                                    GenJournalLine.Amount := LoanApp."Approved Amount";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := 'NAIROBI';
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;





                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Document No." := Rec."Loan  No.";
                                    GenJournalLine."Posting Date" := Rec."Loan Disbursement Date";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := LoanApps."Account No";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine.Description := 'loan Topup';
                                    GenJournalLine.Amount := LoanApp."Approved Amount";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := 'NAIROBI';
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                until LoanApps.Next = 0;
                            end;
                        end;



                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;
                        Rec.Posted := true;
                        Rec.Modify;
                        //Post New





                        Message('Loan posted successfully.');
                    end;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        /*
                        LBatches.RESET;
                        LBatches.SETRANGE(LBatches."Loan  No.","Loan  No.");
                        IF LBatches.FIND('-') THEN BEGIN
                            ApprovalEntries.Setfilters(DATABASE::Loans,17,LBatches."Loan  No.");
                              ApprovalEntries.RUN;
                        END;
                        */

                        DocumentType := Documenttype::Loan;
                        ApprovalEntries.SetRecordFilters(Database::"Loans Register", DocumentType, Rec."Loan  No.");
                        ApprovalEntries.Run;

                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        /*
                       SalDetails.RESET;
                       SalDetails.SETRANGE(SalDetails."Loan No","Loan  No.");
                       IF SalDetails.FIND('-')=FALSE THEN BEGIN
                       ERROR('Please Insert Loan Applicant Salary Information');
                       END;
                          */
                        if Rec."Loan Product Type" <> 'SDV' then begin
                            LGuarantors.Reset;
                            LGuarantors.SetRange(LGuarantors."Loan No", Rec."Loan  No.");
                            if LGuarantors.Find('-') = false then begin
                                Error('Please Insert Loan Applicant Guarantor Information');
                            end;
                        end;
                        //TESTFIELD("Approved Amount");
                        Rec.TestField("Loan Product Type");
                        Rec.TestField("Mode of Disbursement");

                      
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalMgt.SendLoanApprRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Source := Rec.Source::" ";
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        /*IF "Loan Status"="Loan Status"::Approved THEN
        CurrPage.EDITABLE:=FALSE; */

    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange(Posted, true);
        /*IF "Loan Status"="Loan Status"::Approved THEN
        CurrPage.EDITABLE:=FALSE;*/

    end;

    var
        Text001: label 'Status Must Be Open';
        i: Integer;
        LoanType: Record "Loan Products Setup";
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
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record Customer;
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record Customer;
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sales & Receivables Setup";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        LoansR: Record "Loans Register";
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
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        TotalTopupComm: Decimal;
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Special Clearance";
        SMSMessage: Record Customer;
        InstallNo2: Integer;
        currency: Record "Currency Exchange Rate";
        CURRENCYFACTOR: Decimal;
        LoanApps: Record "Loans Register";
        LoanDisbAmount: Decimal;
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        Disbursement: Record "Loan Disburesment-Batching";
        SchDate: Date;
        DisbDate: Date;
        WhichDay: Integer;
        LBatches: Record "Loans Register";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loans Guarantee Details";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,"Payment Voucher","Petty Cash",Requisition,Loan,Imprest,ImprestSurrender,Interbank;
        CurrpageEditable: Boolean;
        LoanStatusEditable: Boolean;
        MNoEditable: Boolean;
        ApplcDateEditable: Boolean;
        LProdTypeEditable: Boolean;
        InstallmentEditable: Boolean;
        AppliedAmountEditable: Boolean;
        ApprovedAmountEditable: Boolean;
        RepayMethodEditable: Boolean;
        RepaymentEditable: Boolean;
        BatchNoEditable: Boolean;
        RepayFrequencyEditable: Boolean;
        ModeofDisburesmentEdit: Boolean;
        DisbursementDateEditable: Boolean;
        AccountNoEditable: Boolean;
        LNBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        RejectionRemarkEditable: Boolean;
        ApprovalEntry: Record "Approval Entry";
        Overdue: Option Yes," ";
        SFactory: Codeunit "Au Factory";


    procedure UpdateControl()
    begin

        if Rec."Loan Status" = Rec."loan status"::Application then begin
            MNoEditable := true;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := true;
            InstallmentEditable := true;
            AppliedAmountEditable := true;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := true;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
        end;

        if Rec."Loan Status" = Rec."loan status"::Appraisal then begin
            MNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := true;
            RepayMethodEditable := true;
            RepaymentEditable := true;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
        end;

        if Rec."Loan Status" = Rec."loan status"::Rejected then begin
            MNoEditable := false;
            AccountNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := false;
            DisbursementDateEditable := false;
            RejectionRemarkEditable := false
        end;

        if Rec."Approval Status" = Rec."approval status"::Approved then begin
            MNoEditable := false;
            AccountNoEditable := false;
            LoanStatusEditable := false;
            ApplcDateEditable := false;
            LProdTypeEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := true;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := true;
            RejectionRemarkEditable := false;
        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;
}




