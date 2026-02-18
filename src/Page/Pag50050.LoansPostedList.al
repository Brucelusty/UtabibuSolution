//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50050 "Loans Posted List"
{
    CardPageID = "Loans Application Card(Posted)";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Posted = const(true));


    layout
    {
        area(content)
        {
            repeater(Control1000000008)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                    StyleExpr = StyleExprTxt;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                    StyleExpr = StyleExprTxt;
                }
                field("ID NO"; Rec."ID NO")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Product';
                    StyleExpr = StyleExprTxt;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }

                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    StyleExpr = StyleExprTxt;
                }

                // field("Mode of Disbursement"; Rec."Mode of Disbursement")
                // {
                //     ApplicationArea = Basic;
                //     // Editable = true;
                //     StyleExpr = StyleExprTxt;
                //     Visible=false;
                // }

                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    //StyleExpr = StyleExprTxt;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Disbursed By"; Rec."Disbursed By")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Last Int Date"; REC."Last Int Date")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;

                }
                field("Outstanding Interest"; Rec."Outstanding Interest")
                {
                    ApplicationArea = basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Current Penalty Due"; Rec."Current Penalty Due")
                {
                    Caption = 'Penalty Balance';
                }
                field("Loans Category"; Rec."Loans Category")
                {
                    ApplicationArea = basic;
                    StyleExpr = StyleExprTxt;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }

                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Amount in Arrears"; Rec."Amount in Arrears")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("No of Months in Arrears"; Rec."No of Months in Arrears")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                    
                }

                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field(Rescheduled; Rec.Rescheduled)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Loan Reschedule"; Rec."Loan Reschedule")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Main Sector"; Rec."Main Sector")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Sub Sector"; Rec."Sub Sector")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Sector Specific"; Rec."Sector Specific")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Specific-Sector Discription"; Rec."Specific-Sector Discription")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                }
                field("Default loan Attached"; Rec."Default loan Attached")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
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
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.run(172355, true, false, LoanApp);
                        end;
                    end;
                }
                action("Member Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger Entries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    RunObject = Page "Member Ledger Entries";
                    RunPageLink = "Loan No" = field("Loan  No.");
                    RunPageView = sorting("Customer No.");
                }
                action("Loan Statement")
                {
                    ApplicationArea = Basic;
                    Image = SelectReport;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."Client Code");
                        Cust.SetFilter("Loan No. Filter", Rec."Loan  No.");
                        Cust.SetFilter("Loan Product Filter", Rec."Loan Product Type");
                        if Cust.Find('-') then
                            Report.run(172531, true, false, Cust);
                    end;
                }
                action("Member Accounts")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Accounts';
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Accounts List";
                    RunPageLink = "BOSA Account No" = field("Client Code");
                }
                action("Guarantors' Report")
                {
                    ApplicationArea = Basic;
                    Image = SelectReport;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."Client Code");
                        Cust.SetFilter("Loan No. Filter", Rec."Loan  No.");
                        Cust.SetFilter("Loan Product Filter", Rec."Loan Product Type");
                        if Cust.Find('-') then
                            Report.run(172504, true, false, Cust);
                    end;
                }
                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."Client Code");
                        Report.run(172886, true, false, Cust);
                    end;
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("Client Code");
                }
                action("View ScheduleNew")
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
                        //SFactory.FnRunLoanAmountDue("Loan  No.");
                        //SFactory.FnGenerateLoanRepaymentSchedule("Loan  No.");
                        //COMMIT;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then
                            Report.run(172949, true, false, LoanApp);
                    end;
                }
                action("View ScheduleNew1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Rescheduled Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        //SFactory.FnRunLoanAmountDue("Loan  No.");
                        SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");
                        COMMIT;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then
                            Report.Run(172477, true, false, LoanApp);
                    end;
                }
                action("Loans to Offset")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans to Offset';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loan Offset Detail List-P";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");

                    trigger OnAction()
                    begin
                        //172477
                    end;
                }
                action("Reschedule Repayment Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reschedule Loan Repayment Date';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        VarScheduleDay: Integer;
                        VarScheduleMonth: Integer;
                        VarScheduleYear: Integer;
                    begin
                        Rec.TestField("New Repayment Start Date");
                        if Confirm('Confirm you Want to Change Repayment Dates for  this Loan?', false) = true then begin

                            VarNewInstalmentDate := Rec."New Repayment Start Date";
                            //=======================================================================Loan Repayment Schedule
                            ObjLoanRepaymentSchedule.Reset;
                            ObjLoanRepaymentSchedule.SetCurrentkey(ObjLoanRepaymentSchedule."Repayment Date");
                            ObjLoanRepaymentSchedule.SetRange(ObjLoanRepaymentSchedule."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentSchedule.SetFilter(ObjLoanRepaymentSchedule."Repayment Date", '>=%1', Rec."Reschedule Effective Date");
                            if ObjLoanRepaymentSchedule.FindSet then begin
                                repeat
                                    ObjLoanRepaymentSchedule."Repayment Date" := VarNewInstalmentDate;
                                    ObjLoanRepaymentSchedule.Modify;
                                    VarNewInstalmentDate := CalcDate('1M', VarNewInstalmentDate);
                                until ObjLoanRepaymentSchedule.Next = 0;
                            end;
                            //=======================================================================Loan Repayment Schedule  Temp
                            ObjLoanRepaymentScheduleTemp.Reset;
                            ObjLoanRepaymentScheduleTemp.SetCurrentkey(ObjLoanRepaymentScheduleTemp."Repayment Date");
                            ObjLoanRepaymentScheduleTemp.SetRange(ObjLoanRepaymentScheduleTemp."Loan No.", Rec."Loan  No.");
                            ObjLoanRepaymentScheduleTemp.SetFilter(ObjLoanRepaymentScheduleTemp."Repayment Date", '>=%1', Rec."Reschedule Effective Date");
                            if ObjLoanRepaymentScheduleTemp.FindSet then begin
                                repeat
                                    ObjLoanRepaymentScheduleTemp."Repayment Date" := VarNewInstalmentDate;
                                    ObjLoanRepaymentScheduleTemp.Modify;
                                    VarNewInstalmentDate := CalcDate('1M', VarNewInstalmentDate);
                                until ObjLoanRepaymentScheduleTemp.Next = 0;
                            end;
                            Rec."Repayment Dates Rescheduled" := true;
                            Rec."Repayment Dates Rescheduled By" := UserId;
                            Rec."Repayment Dates Rescheduled On" := Today;
                            Message('Loan Repayment Date Changed Succesfully');
                        end;
                    end;
                }
                action("Generate Repayment Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Repayment Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //SFactory.FnGenerateLoanRepaymentSchedule("Loan  No.");
                        SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");

                        Commit;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then
                            SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");
                        if LoanApp."Loan Product Type" <> 'INST' then begin
                            Report.Run(172477, true, false, LoanApp);
                        end else begin
                            Report.Run(172477, true, false, LoanApp);
                        end;
                    end;
                }
                action("Payoff Loan")
                {
                    ApplicationArea = Basic;
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan PayOff Card";
                }
                action("Loan Recovery Logs")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    RunObject = Page "Loan Recovery Logs List";
                    RunPageLink = "Member No" = field("No. Series"),
                                  "Member Name" = field("Name of Chief/ Assistant");
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
                        ObjCust.SetRange(ObjCust."No.", Rec."Client Code");
                        if ObjCust.Find('-') then
                            Report.run(172963, true, false, ObjCust);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Overdue := Overdue::" ";
        if FormatField(Rec) then
            Overdue := Overdue::Yes;
        If Rec."Loans Category" = Rec."Loans Category"::Perfoming then begin
            StyleExprTxt := 'Favorable'
        end

        else
            If Rec."Loans Category" = Rec."Loans Category"::Watch then begin
                StyleExprTxt := 'Ambiguous'
            end else
                If Rec."Loans Category" = Rec."Loans Category"::Substandard then begin
                    StyleExprTxt := 'AttentionAccent'
                end else
                    If Rec."Loans Category" = Rec."Loans Category"::Doubtful then begin
                        StyleExprTxt := 'Unfavorable'

                    end
                    else
                        If Rec."Loans Category" = Rec."Loans Category"::Loss then begin
                            StyleExprTxt := 'Attention';
                        end


    end;

    var
        i: Integer;
        StyleExprTxt: text[500];
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
        ScheduleBal: Decimal;
        ObjProductCharge: Record "Loan Product Charges";
        LInsurance: Decimal;
        VarNewInstalmentDate: Date;
        ObjLoanRepaymentSchedule: Record "Loan Repayment Schedule";
        ObjLoanRepaymentScheduleTemp: Record "Loan Repayment Schedule Temp";
        SFactory: Codeunit "Au Factory";
        ObjCust: Record Customer;


    procedure GetVariables(var LoanNo: Code[20]; var LoanProductType: Code[20])
    begin
        LoanNo := Rec."Loan  No.";
        LoanProductType := Rec."Loan Product Type";
    end;


    procedure FormatField(Rec: Record "Loans Register") OK: Boolean
    begin
        if Rec."Outstanding Balance" > 0 then begin
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




