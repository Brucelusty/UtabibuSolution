//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50052 "Loans Application Card(Approv)"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "Loans Register";
    PromotedActionCategories = 'New,Process,Report, Posting';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member';
                    Editable = MNoEditable;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field("ID NO"; Rec."ID NO")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Member Deposits"; Rec."Member Deposits")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Deposits';
                }
                field("Total Outstanding Loan BAL"; Rec."Total Outstanding Loan BAL")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Outstanding Loan Balance';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }

                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = ApplcDateEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = LProdTypeEditable;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Product Name';
                    Editable = false;
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
                field("Product Currency Code"; Rec."Product Currency Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = true;
                    Importance = Additional;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount Applied';
                    Editable = AppliedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Recommended Amount"; Rec."Recommended Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Qualifying Amount';
                    Editable = false;
                }

                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved Amount';
                    Editable = ApprovedAmountEditable;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Posted, false);
                    end;
                }
                field("Loan Disbursed Amount"; Rec."Loan Disbursed Amount") { Caption = 'Net Amount'; Editable = ApprovedAmountEditable; }
                field("Disburesment Type"; Rec."Disburesment Type")
                {

                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        TrunchDetailsVisible := false;

                        if (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") or (Rec."Disburesment Type" = Rec."disburesment type"::" ") then begin
                            TrunchDetailsVisible := false;
                        end else
                            TrunchDetailsVisible := true;
                    end;
                }
                group("Tranch Details")
                {
                    Caption = 'Tranch Details';
                    Visible = TrunchDetailsVisible;
                    field("Amount to Disburse on Tranch 1"; Rec."Amount to Disburse on Trunch 1")
                    {
                        ApplicationArea = Basic;
                    }
                    field("No of Tranch Disbursment"; Rec."No of Tranch Disbursment")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }


                field("Main Sector"; Rec."Main Sector")
                {
                    ApplicationArea = Basic;
                }
                field("Sub Sector"; Rec."Sub Sector")
                {
                    ApplicationArea = Basic;

                }

                field("Sector Specific"; Rec."Sector Specific")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Sub-Sector Discription"; Rec."Sub-Sector Discription")
                {
                    ApplicationArea = all;
                    Caption = 'Sector Discription';
                }




                field("Income Type"; Rec."Income Type")
                {
                    visible = false;
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        FnVisibility();
                    end;
                }

                field("Received Copy Of ID"; Rec."Received Copy Of ID")
                {
                    ApplicationArea = Basic;
                    Editable = CopyofIDEditable;
                }
                field("Received Payslip/Bank Statemen"; Rec."Received Payslip/Bank Statemen")
                {
                    ApplicationArea = Basic;
                    Editable = CopyofPayslipEditable;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Approved Repayment"; Rec."Approved Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Deposit Contrib"; Rec."Deposit Contrib") { }
                field("Share Capital Contrib"; Rec."Share Capital Contrib") { }
                field("Programmed Deposit Contrib"; Rec."Programmed Deposit Contrib") { }
                field("CRB Querry Charge"; Rec.CRBQuerryCharge) { }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                    Importance = Additional;

                    trigger OnValidate()
                    begin
                        UpdateControl();
                    end;
                }
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = BatchNoEditable;
                    Importance = Additional;
                }

                field("Paying Bank Account No"; Rec."Paying Bank Account No")
                {
                    Importance = Additional;
                    ShowMandatory = true;
                    ApplicationArea = basic;
                    Visible = false;


                }

                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }

                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Loan Offset Amount"; Rec."Loan Offset Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Offset Amount';
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic;
                    Editable = RepayFrequencyEditable;
                }
                field("Mode of Disbursement"; Rec."Mode of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;

                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                    Editable = DisbursmentDate;

                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;


                    trigger OnValidate()
                    begin
                        if StrLen(Rec."Cheque No.") > 6 then
                            Error('Document No. cannot contain More than 6 Characters.');
                    end;
                }

                field("Repayment Start Date"; Rec."Repayment Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = DisbursmentDate;
                }
                field("Expected Date of Completion"; Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("External EFT"; Rec."External EFT")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                    Visible = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }

                field("Recovery Mode"; Rec."Recovery Mode")
                {
                    ApplicationArea = Basic;
                    Editable = RecoveryModeEditable;
                }

            }
            group("Salary Details")
            {
                Caption = 'Salary Details';
                Visible = PayslipDetailsVisible;
                group("Monthly Income Details")
                {
                    field(PayPayee; Rec.PayPayee)
                    {
                        ApplicationArea = all;
                        Caption = 'Pays Payee';
                    }
                    field("Basic Pay H"; Rec."Basic Pay H")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Basic Pay';
                    }
                    field("House AllowanceH"; Rec."House AllowanceH")
                    {
                        ApplicationArea = all;
                        Caption = 'Allowances';

                    }
                    field("Medical AllowanceH"; Rec."Medical AllowanceH")
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }
                    field("Transport Allowance"; Rec."Transport Allowance")
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }
                    field("Other Income"; Rec."Other Income")
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }
                    field(Nettakehome; Nettakehome)
                    {
                        Caption = '1/3 of Gross';
                        ApplicationArea = all;
                        Enabled = false;
                    }
                    field("Chargeable Pay"; Rec."Chargeable Pay")
                    {
                        ApplicationArea = all;
                        Enabled = false;
                    }
                    field(Pension; Rec."Pension Scheme")
                    {

                    }

                }

                group(Deductions)
                {
                    field("Monthly Contribution"; Rec."Monthly Contribution") { ApplicationArea = all; }
                    field(PAYE; Rec.PAYE) { ApplicationArea = all; Enabled = false; }
                    field(NHIF; Rec.NHIF) { ApplicationArea = all; }
                    field(NSSF; Rec.NSSF) { ApplicationArea = all; }
                    field("Risk MGT"; Rec."Risk MGT") { Caption = 'Benovalent Fund'; }
                    field("Housing Levy"; Rec."Housing Levy") { Enabled = false; }
                    field("Sacco Deductions"; Rec."Sacco Deductions") { ApplicationArea = all; Caption = 'Other Deductions'; }
                    field("Other Liabilities"; Rec."Other Liabilities") { ApplicationArea = all; Visible = false; }
                    field(Loan_Repayment; Rec.Repayment) { ApplicationArea = all; Enabled = false; }
                    field("Utilizable Amount"; Rec."Utilizable Amount") { ApplicationArea = all; Enabled = false; }



                }
                group("Monthly Expenses Detailss")
                {
                    Visible = false;
                    field("SExpenses Rent"; Rec."SExpenses Rent")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Rent';
                    }
                    field("SExpenses Transport"; Rec."SExpenses Transport")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Transport';
                    }
                    field("SExpenses Education"; Rec."SExpenses Education")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Education';
                    }
                    field("SExpenses Food"; Rec."SExpenses Food")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Food';
                    }
                    field("SExpenses Utilities"; Rec."SExpenses Utilities")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Utilities';
                    }
                    field("SExpenses Others"; Rec."SExpenses Others")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Others';
                    }
                    field("Exisiting Loans Repayments"; Rec."Exisiting Loans Repayments")
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
            group("Statement Details")
            {
                Caption = 'Statement Details';
                Visible = BankStatementDetailsVisible;
                field("Bank Statement Avarage Credits"; Rec."Bank Statement Avarage Credits")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Statement Avarage Debits"; Rec."Bank Statement Avarage Debits")
                {
                    ApplicationArea = Basic;
                }
                group("Monthly Expenses Details")
                {
                    Caption = 'Monthly Expenses Details';
                    field("BSExpenses Rent"; Rec."BSExpenses Rent")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Rent';
                    }
                    field("BSExpenses Transport"; Rec."BSExpenses Transport")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Transport';
                    }
                    field("BSExpenses Education"; Rec."BSExpenses Education")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Education';
                    }
                    field("BSExpenses Food"; Rec."BSExpenses Food")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Food';
                    }
                    field("BSExpenses Utilities"; Rec."BSExpenses Utilities")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Utilities';
                    }
                    field("BSExpenses Others"; Rec."BSExpenses Others")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Others';
                    }
                    field("<Exisiting Loans Repayments.>"; Rec."Exisiting Loans Repayments")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Exisiting Loans Repayments.';
                    }
                }
                field("Bank Statement Net Income"; Rec."Bank Statement Net Income")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Rejection Details")
            {
                //Visible = RejectionDetailsVisible;
                field("Rejection  Remark"; Rec."Rejection  Remark")
                {
                    ApplicationArea = Basic;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Rejection"; Rec."Date of Rejection")
                {
                    ApplicationArea = Basic;
                    Caption = 'Rejection Date';
                }
            }
            part(Control1000000001; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
            }
            part(Control1000000000; "Loan Collateral Security")
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

                action("Return To Approval")
                {


                    Visible = false;
                    ApplicationArea = Basic;

                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    trigger OnAction()
                    begin
                        Rec.Posted := false;
                        Rec."Loan Status" := Rec."loan status"::Disbursed;
                        Rec."Approval Status" := Rec."Approval Status"::Approved;
                        Rec.Posted := true;
                        // Rec."Issued Date" := Today;
                        Rec.Modify;
                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        //     if Rec."Loan Product Type" <> 'QF' then begin
                        //         Rec.TestField("Mode of Disbursement");
                        //     end;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.run(50084, true, false, LoanApp)
                        end;
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Loan';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                        TransCustomField: Codeunit "Transfer Custom Field";
                        DetailedLedger: Record "Detailed Cust. Ledg. Entry";
                        MobileBankingCode: Codeunit "Mobile Banking Code";
                    begin
                        TransCustomField.clearJournalBatch;
                        DetailedLedger.Reset();
                        DetailedLedger.setrange("Loan No", Rec."Loan  No.");
                        // if DetailedLedger.FindFirst() then begin
                        //     If DetailedLedger.Reversed = False then
                        //         error('Loan Already Posted .Posting Date %1', DetailedLedger."Posting Date");
                        // end;

                        if Rec."View Schedule" = false then Error('Generate Schedule for this Loan before posting');
                        if Rec."Mode of Disbursement" = Rec."Mode of Disbursement"::Cheque then Rec.TestField("Cheque No.");
                        if Confirm('Are you sure you want to post this loan?') = false then exit;
                        if (Rec."Mode of Disbursement" <> Rec."mode of disbursement"::"FOSA Account") then begin

                            //if Rec."Mode Of Disbursement" <> Rec."Mode Of Disbursement"::"FOSA Account" then begin
                            TransCustomField.FnDisburseToBankAccount(Rec, Rec."Loan  No.");

                            GenSetUp.Get();
                            //Send Loan Disburesment SMS*********************************************
                            if GenSetUp."Send Loan Disbursement SMS" = true then begin
                                TransCustomField.FnSendDisburesmentSMS(Rec."Loan  No.", Rec."Client Code");
                            end;
                        end else begin

                            TransCustomField.FnDisburseToCurrentAccount(Rec, Rec."Loan  No.");
                            GenSetUp.Get();
                            //Send Loan Disburesment SMS*********************************************
                            if GenSetUp."Send Loan Disbursement SMS" = true then begin
                                TransCustomField.FnSendDisburesmentSMS(Rec."Loan  No.", Rec."Client Code");
                            end;
                        end;

                        // Exit;
                        TransCustomField.FnSendDisburesmentEmail(Rec."Loan  No.");
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        end;


                        Rec.Posted := true;
                        Rec."Loan Status" := Rec."loan status"::Disbursed;
                        Rec."Issued Date" := Rec."Loan Disbursement Date";
                        Rec."Posting Date" := Rec."Loan Disbursement Date";
                        Rec."Disbursed By" := UserId;
                        Rec."Loan Disbursement Date" := Rec."Loan Disbursement Date";
                        Rec.Modify(true);
                        Commit();
                        //end;
                    end;

                }
                action(Post2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post To Disbursment Account';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        TransCustomField: Codeunit "Transfer Custom Field";
                        DetailedLedger: Record "Detailed Cust. Ledg. Entry";
                        MobileBankingCode: Codeunit "Mobile Banking Code";
                        TempBlob: Codeunit "Temp Blob";
                        OutStr: OutStream;
                        LoanScheduleReportID: Integer;
                        FileName: Text;
                        ClientEmail: Text;
                        cust: Record Customer;
                        GenJnlPost: Codeunit "Gen. Jnl.-Post";
                        Email: Codeunit Email;
                        EmailMessage: Codeunit "Email Message";
                        LoanRecRef: RecordRef;
                        InStr: InStream;
                        ToRecipients: List of [Text];
                        CcRecipients: List of [Text];
                        BccRecipients: List of [Text];

                    begin
                        TransCustomField.clearJournalBatch;
                        SFactory.FnGenerateLoanRepaymentSchedule(rec."Loan  No.");
                        Rec."View Schedule" := true;
                        DetailedLedger.Reset();
                        DetailedLedger.setrange("Loan No", Rec."Loan  No.");
                        DetailedLedger.SetRange(Reversed, false);
                        if DetailedLedger.FindFirst() then begin
                            If DetailedLedger.Reversed = False then
                                error('Loan Already Posted .Posting Date %1', DetailedLedger."Posting Date");
                        end;

                        if Rec."View Schedule" = false then Error('Generate Schedule for this Loan before posting');
                        // if Rec."Mode of Disbursement" = Rec."Mode of Disbursement"::Cheque then Rec.TestField("Cheque No.");
                        if Confirm('Are you sure you want to post this loan?') = false then exit;
                        if (Rec."Mode of Disbursement" <> Rec."mode of disbursement"::"FOSA Account") then begin

                            //if Rec."Mode Of Disbursement" <> Rec."Mode Of Disbursement"::"FOSA Account" then begin
                            TransCustomField.FnDisburseToDisbursmentAccount(Rec, Rec."Loan  No.");

                            GenSetUp.Get();
                            //Send Loan Disburesment SMS*********************************************
                            if GenSetUp."Send Loan Disbursement SMS" = true then begin
                                TransCustomField.FnSendDisburesmentSMS(Rec."Loan  No.", Rec."Client Code");
                            end;
                        end else begin


                        end;

                        //  Exit;
                        TransCustomField.FnSendDisburesmentEmail(Rec."Loan  No.");
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                        end;


                        Rec.Posted := true;
                        Rec."Loan Status" := Rec."loan status"::Disbursed;
                        Rec."Issued Date" := Rec."Loan Disbursement Date";
                        Rec."Posting Date" := Rec."Loan Disbursement Date";
                        Rec."Disbursed By" := UserId;
                        Rec."Loan Disbursement Date" := Rec."Loan Disbursement Date";
                        Rec.Modify(true);
                        Commit();
                        // end;
                        // Send repayment schedule by email
                        SendLoanScheduleByEmail(Rec."Loan  No.")



                    end;
                }
                action("Go to FOSA Accounts")
                {
                    ApplicationArea = Basic;
                    Image = List;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Member Accounts List";
                    RunPageLink = "BOSA Account No" = field("Client Code");
                }
                action("Re-Open Loan")
                {
                    ApplicationArea = Basic;
                    Image = Status;
                    Promoted = true;
                    Visible = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Confirm('Confirm Re-Open Loan?', false) = true then begin

                            rec."Approval Status" := Rec."approval status"::Open;
                            rec."Loan Status" := rec."loan status"::Application;

                        end;
                    end;

                }
                action("Reject Loan Application")
                {
                    ApplicationArea = Basic;
                    Image = Reject;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Confirm Rejection?', false) = true then begin
                            rec."Intent to Reject" := true;

                            RejectionDetailsVisible := false;
                            if rec."Intent to Reject" = true then begin
                                RejectionDetailsVisible := true;
                            end;

                            if rec."Rejection  Remark" = '' then begin
                                Error('Specify the Rejection Remarks/Reason on the Rejection Details Tab');
                            end else
                                rec."Rejected By" := UserId;
                            rec."Date of Rejection" := WorkDate;
                            rec."Approval Status" := Rec."approval status"::Rejected;
                            rec."Loan Status" := rec."loan status"::Rejected;

                            //=========================================================================================Loan Stages Common On All Applications
                            ObjLoanStages.Reset;
                            ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::Declined);
                            ObjLoanStages.SetFilter("Min Loan Amount", '=%1', 0);
                            if ObjLoanStages.FindSet then begin
                                repeat
                                    ObjLoanApplicationStages.Init;
                                    ObjLoanApplicationStages."Loan No" := rec."Loan  No.";
                                    ObjLoanApplicationStages."Member No" := rec."Client Code";
                                    ObjLoanApplicationStages."Member Name" := rec."Client Name";
                                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                                    ObjLoanApplicationStages."Stage Status" := ObjLoanApplicationStages."stage status"::Succesful;
                                    ObjLoanApplicationStages."Updated By" := UserId;
                                    ObjLoanApplicationStages."Date Upated" := WorkDate;
                                    ObjLoanApplicationStages.Insert;
                                until ObjLoanStages.Next = 0;
                            end;

                        end;
                        CurrPage.Close;
                    end;
                }
                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", rec."Client Code");
                        Report.run(172886, true, false, Cust);
                    end;
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

                        SFactory.FnGenerateLoanRepaymentSchedule(rec."Loan  No.");
                        Rec."View Schedule" := true;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", rec."Loan  No.");
                        if LoanApp.Find('-') then begin

                            Report.Run(80014, true, false, LoanApp);
                        end;
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
                }
                action("Disburse Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Disburse Loan';
                    Image = Post;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        VarMailSubject: Text[200];
                        VarMailBody: Text[250];
                    begin
                        ObjMemberLedger.Reset;
                        ObjMemberLedger.SetRange(ObjMemberLedger."Loan No", rec."Loan  No.");
                        ObjMemberLedger.SetRange(ObjMemberLedger.Reversed, false);
                        if ObjMemberLedger.FindSet then begin
                            Message('Loan already Posted');
                            rec.Posted := true;
                            rec."Loan Status" := rec."loan status"::Disbursed;
                            rec."Loan Disbursement Date" := WorkDate;
                            rec."Issued Date" := WorkDate;
                            CurrPage.Close;
                            exit;
                        end;


                        FnRunCheckLoanStages;//=======================Check that All loan Stages are Succesful

                        //Check if Collateral Details have been Updated
                        ObjCollateral.Reset;
                        ObjCollateral.SetRange(ObjCollateral."Loan No", rec."Loan  No.");
                        if ObjCollateral.FindSet = true then begin
                            if ObjCollateral."Collateral Registe Doc" = '' then begin
                                Error('Update the Collateral details on the Collateral register # Go to collateral details>>Collateral register Doc');
                            end;

                            if ObjCollateral.Value = 0 then begin
                                Error('Update the Collateral market value')
                            end;

                            if ObjCollateral."Registered Owner" = '' then begin
                                Error('Update the Collateral Registered Owner')
                            end;

                            if ObjCollateral."Reference No" = '' then begin
                                Error('Update the Collateral Reference No')
                            end;
                        end;



                        if rec.Posted = true then
                            Error('Loan already posted.');

                        if rec."Approved Amount" <= 0 then
                            Error('You cannot post this Amount Less or Equal to Zero');

                        if rec."Repayment Start Date" <= WorkDate then
                            Error('The Loan Repayment Start Date must be greater than today.');

                        if Confirm('Are you sure you want to Disburse this Loan? \\The Loan Repayment Start Date specified is ' +
                          Format(rec."Repayment Start Date", 0, '<Day,2> <Month Text,3> <Year4>') + '\\Proceed?', false) = true then begin
                            SFactory.FnGenerateLoanRepaymentSchedule(rec."Loan  No.");

                            rec."Loan Disbursement Date" := Today;
                            rec.TestField("Loan Disbursement Date");
                            rec."Posting Date" := rec."Loan Disbursement Date";
                            BATCH_TEMPLATE := 'PAYMENTS';
                            BATCH_NAME := 'LOANS';
                            DOCUMENT_NO := Rec."Loan  No.";
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                            GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                            GenJournalLine.DeleteAll;


                            //=========================================================================Disburesment to FOSA Account
                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan  No.");
                            if ObjLoans.FindSet then begin

                                if Rec."Mode of Disbursement" = Rec."mode of disbursement"::" " then begin
                                    ObjLoans."Mode of Disbursement" := Rec."mode of disbursement"::"FOSA Account";
                                    ObjLoans.Modify;
                                end;

                                if ObjLoans."Mode of Disbursement" = Rec."mode of disbursement"::"FOSA Account" then begin
                                    FnDisburseToCurrentAccount(Rec);


                                    //CU posting
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                                    GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                                    if GenJournalLine.Find('-') then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                    end;

                                    FnRunDisbursementSMS;//=============================================================================Send Disburesment SMS

                                    ObjLoansII.Reset;
                                    ObjLoansII.SetRange(ObjLoansII."Loan  No.", Rec."Loan  No.");
                                    if ObjLoansII.FindSet then begin
                                        ObjMemberLedger.Reset;
                                        ObjMemberLedger.SetRange(ObjMemberLedger."Loan No", Rec."Loan  No.");
                                        if ObjMemberLedger.FindSet then begin
                                            ObjLoansII.Posted := true;
                                            ObjLoansII."Loan Status" := Rec."loan status"::Disbursed;
                                            ObjLoansII."Issued Date" := WorkDate;
                                            ObjLoansII."Offset Eligibility Amount" := Rec."Approved Amount" * 0.5;
                                            ObjLoansII."Posting Date" := WorkDate;
                                            ObjLoansII."Disbursed By" := UserId;
                                            ObjLoansII."Loan Disbursement Date" := Today;


                                            if (Rec."Disburesment Type" = Rec."disburesment type"::" ") or (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") then begin
                                                ObjLoansII."Tranch Amount Disbursed" := Rec."Approved Amount";
                                            end else
                                                ObjLoansII."Tranch Amount Disbursed" := Rec."Amount to Disburse on Trunch 1";

                                            ObjLoansII.Modify;
                                        end;
                                    end;
                                end;
                            end;

                            //=========================================================================Disburesment to Bank Account
                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan  No.");
                            if ObjLoans.FindSet then begin

                                if Rec."Mode of Disbursement" = Rec."mode of disbursement"::" " then begin
                                    ObjLoans."Mode of Disbursement" := ObjLoans."mode of disbursement"::Mpesa;
                                    ObjLoans.Modify;
                                end;

                                if
                                (ObjLoans."Mode of Disbursement" = ObjLoans."mode of disbursement"::EFT) then begin
                                    Rec.TestField("Paying Bank Account No");
                                    FnDisburseToBankAccount(Rec);


                                    //CU posting
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                                    GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                                    if GenJournalLine.Find('-') then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                    end;

                                    FnRunDisbursementSMS;//=============================================================================Send Disburesment SMS

                                    ObjLoansII.Reset;
                                    ObjLoansII.SetRange(ObjLoansII."Loan  No.", Rec."Loan  No.");
                                    if ObjLoansII.FindSet then begin
                                        ObjMemberLedger.Reset;
                                        ObjMemberLedger.SetRange(ObjMemberLedger."Loan No", Rec."Loan  No.");
                                        if ObjMemberLedger.FindSet then begin
                                            ObjLoansII.Posted := true;
                                            ObjLoansII."Loan Status" := Rec."loan status"::Disbursed;
                                            ObjLoansII."Issued Date" := WorkDate;
                                            ObjLoansII."Offset Eligibility Amount" := Rec."Approved Amount" * 0.5;
                                            ObjLoansII."Posting Date" := WorkDate;
                                            ObjLoansII."Disbursed By" := UserId;
                                            ObjLoansII."Loan Disbursement Date" := Today;


                                            if (Rec."Disburesment Type" = Rec."disburesment type"::" ") or (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") then begin
                                                ObjLoansII."Tranch Amount Disbursed" := Rec."Approved Amount"
                                            end else
                                                ObjLoansII."Tranch Amount Disbursed" := Rec."Amount to Disburse on Trunch 1";

                                            ObjLoansII.Modify;
                                        end;
                                    end;
                                end;
                            end;

                            //Update Share Boosted Deposits
                            FnUpdateShareBoostedTrans();
                            FnRunCreateLSAfor1sttimeLoanees;//=========================================================Create LSA Account For 1st time Loanees
                            FnRunUpdateDisburesmentLoanStage;//========================================================Update Disburesment Loan Stage on the Loan Application Stages
                            FnAccrueInterestOneOffLoans(Rec."Loan  No.");//================================================Accrue Interest for Oneoff Loans

                            //============================================================Send Repayment Schedule Via Mail
                            ObjLoans.Reset;
                            ObjLoans.SetRange(ObjLoans."Loan  No.", Rec."Loan  No.");
                            if ObjLoans.FindSet then begin
                                if ObjMember.Get(Rec."Client Code") then begin
                                    if (ObjMember."E-Mail" <> '') then begin
                                        VarMemberEmail := Lowercase(ObjMember."E-Mail");

                                        //  SMTPSetup.Get();
                                        Filename := '';
                                        //Filename := SMTPSetup."Path to Save Report" + 'Loan Repayment Schedule.pdf';
                                        //   Report.SaveAsPdf(Report::"Loans Repayment Schedule", Filename, ObjLoans);

                                        VarMailSubject := 'Loan Repayment Schedule - ' + Rec."Loan  No.";
                                        VarMailBody := 'Your ' + Rec."Loan Product Type Name" + ' Application of Ksh. ' + Format(Rec."Approved Amount") + ' has been disbursed to your Account No. ' + ObjMember."Bank Name" + ' Acc no. ' + ObjMember."Bank Account No." +
                                        '. Please find attached the loan repayment schedule for your New Loan Account No. ' + Rec."Loan  No." + '.';

                                        // EmailSend := SFactory.FnSendStatementViaMail("Client Name", VarMailSubject, VarMailBody, VarMemberEmail, 'Loan Repayment Schedule.pdf', '');
                                    end;
                                end;
                            end;
                            //============================================================End Send Repayment Schedule Via Mail

                            Message('Loan Disbursed Successfully. The Member has been notified via SMS and Email.');
                            CurrPage.Close;
                        end;

                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    var
                    //ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //ApprovalMgt.SendLoanApprRequest(Rec);
                        if Confirm('Are you sure you want to cancel the approval request', false) = true then begin
                            Rec."Loan Status" := Rec."loan status"::Application;
                            Rec."Approval Status" := Rec."approval status"::Open;
                            Rec.MODIFY;
                        end;
                    end;
                }

                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin

                        DocumentType := Documenttype::LoanApplication;
                        ApprovalEntries.SetRecordFilters(Database::"Loans Register", DocumentType, Rec."Loan  No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Update Offset Details")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    trigger OnAction()
                    begin
                        /*IF "Loan Offset Amount" > 0 THEN
                        BEGIN
                        LoanTopUp.RESET;
                        LoanTopUp.SETRANGE(LoanTopUp."Loan No.","Loan  No.");
                        IF LoanTopUp.FIND('-') THEN
                        BEGIN
                          LoanTopUp.fn_UpdateLoanOffsetDetails();
                          LoanTopUp.MODIFY;
                        END;
                        END*/
                        Message('Loan Offset Amount %1', LoanApps."Loan Offset Amount");
                        if LoanApps."Loan Offset Amount" > 0 then begin
                            Message('Getting LoanApps."Loan Offset Amount"');
                            LoanTopUp.Reset;
                            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                            if LoanTopUp.Find('-') then begin
                                LoanTopUp.fn_UpdateLoanOffsetDetails();
                                LoanTopUp.Modify;
                                Message('Modified Loan Offset Amount');
                            end;

                            LoanTopUp.Reset;
                            LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                            if LoanTopUp.Find('-') then
                                Message('Getting Updated Loan Apps');
                        end

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        EditableField := true;
    end;

    trigger OnAfterGetRecord()
    begin
        EditableField := true;
        UpdateControl();

        TrunchDetailsVisible := false;

        if (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") or (Rec."Disburesment Type" = Rec."disburesment type"::" ") then begin
            TrunchDetailsVisible := false;
        end else
            TrunchDetailsVisible := true;
    end;

    trigger OnOpenPage()
    begin
        EditableField := true;
        FnVisibility;
        TrunchDetailsVisible := false;

        if (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") or (Rec."Disburesment Type" = Rec."disburesment type"::" ") then begin
            TrunchDetailsVisible := false;
        end else
            TrunchDetailsVisible := true;
    end;

    var
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        LoanGuar: Record "Loans Guarantee Details";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
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
        GenSetUp: Record "Sacco General Set-Up";
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
        SalaryEditable: boolean;
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
        SMSMessage: Record "SMS Messages";
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
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
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
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        GrossPay: Decimal;
        Nettakehome: Decimal;
        TotalDeductions: Decimal;
        UtilizableAmount: Decimal;
        NetUtilizable: Decimal;
        Deductions: Decimal;
        Benov: Decimal;
        TAXABLEPAY: Record "PAYE Brackets Credit";
        PAYE: Decimal;
        PAYESUM: Decimal;
        BAND1: Decimal;
        BAND2: Decimal;
        BAND3: Decimal;
        BAND4: Decimal;
        BAND5: Decimal;
        Taxrelief: Decimal;
        OTrelief: Decimal;
        Chargeable: Decimal;
        PartPay: Record "Loan Partial Disburesments";
        PartPayTotal: Decimal;
        AmountPayable: Decimal;
        RepaySched: Record "Loan Repayment Schedule";
        LoanReferee1NameEditable: Boolean;
        LoanReferee2NameEditable: Boolean;
        LoanReferee1MobileEditable: Boolean;
        LoanReferee2MobileEditable: Boolean;
        LoanReferee1AddressEditable: Boolean;
        LoanReferee2AddressEditable: Boolean;
        LoanReferee1PhyAddressEditable: Boolean;
        LoanReferee2PhyAddressEditable: Boolean;
        LoanReferee1RelationEditable: Boolean;
        LoanReferee2RelationEditable: Boolean;
        LoanPurposeEditable: Boolean;
        WitnessEditable: Boolean;
        compinfo: Record "Company Information";
        CummulativeGuarantee: Decimal;
        LoansRec: Record "Loans Register";
        RecoveryModeEditable: Boolean;
        RemarksEditable: Boolean;
        CopyofIDEditable: Boolean;
        CopyofPayslipEditable: Boolean;
        ScheduleBal: Decimal;
        SFactory: Codeunit "Au Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        ReschedulingFees: Decimal;
        ReschedulingFeeAccount: Code[50];
        LoanProcessingFee: Decimal;
        ExciseDuty: Decimal;
        EditableField: Boolean;
        DOCUMENT_NO: Code[40];
        PayslipDetailsVisible: Boolean;
        BankStatementDetailsVisible: Boolean;
        ObjProductCharge: Record "Loan Product Charges";
        ObjAccountLedger: Record "Detailed Vendor Ledg. Entry";
        ObjStatementB: Record "Loan Appraisal Statement Buffe";
        StatementStartDate: Date;
        StatementDateFilter: Date;
        StatementEndDate: Date;
        VerStatementAvCredits: Decimal;
        VerStatementsAvDebits: Decimal;
        VerMonth1Date: Integer;
        VerMonth1Month: Integer;
        VerMonth1Year: Integer;
        VerMonth1StartDate: Date;
        VerMonth1EndDate: Date;
        VerMonth1DebitAmount: Decimal;
        VerMonth1CreditAmount: Decimal;
        VerMonth2Date: Integer;
        VerMonth2Month: Integer;
        VerMonth2Year: Integer;
        VerMonth2StartDate: Date;
        VerMonth2EndDate: Date;
        VerMonth2DebitAmount: Decimal;
        VerMonth2CreditAmount: Decimal;
        VerMonth3Date: Integer;
        VerMonth3Month: Integer;
        VerMonth3Year: Integer;
        VerMonth3StartDate: Date;
        VerMonth3EndDate: Date;
        VerMonth3DebitAmount: Decimal;
        VerMonth3CreditAmount: Decimal;
        VerMonth4Date: Integer;
        VerMonth4Month: Integer;
        VerMonth4Year: Integer;
        VerMonth4StartDate: Date;
        VerMonth4EndDate: Date;
        VerMonth4DebitAmount: Decimal;
        VerMonth4CreditAmount: Decimal;
        VerMonth5Date: Integer;
        VerMonth5Month: Integer;
        VerMonth5Year: Integer;
        VerMonth5StartDate: Date;
        VerMonth5EndDate: Date;
        VerMonth5DebitAmount: Decimal;
        VerMonth5CreditAmount: Decimal;
        VerMonth6Date: Integer;
        VerMonth6Month: Integer;
        VerMonth6Year: Integer;
        VerMonth6StartDate: Date;
        VerMonth6EndDate: Date;
        VerMonth6DebitAmount: Decimal;
        VerMonth6CreditAmount: Decimal;
        VarMonth1Datefilter: Text;
        VarMonth2Datefilter: Text;
        VarMonth3Datefilter: Text;
        VarMonth4Datefilter: Text;
        VarMonth5Datefilter: Text;
        VarMonth6Datefilter: Text;
        ObjCollateral: Record "Loan Collateral Details";
        ObjCust: Record Customer;
        ObjMemberLedg: Record "Member Ledger Entry";
        ObjMemberCellG: Record "Member House Groups";
        VarAmounttoDisburse: Decimal;
        TrunchDetailsVisible: Boolean;
        LInsurance: Decimal;
        RejectionDetailsVisible: Boolean;
        ObjLoanStages: Record "Loan Stages";
        ObjLoanApplicationStages: Record "Loan Application Stages";
        EmailSend: Boolean;
        DisbursmentDate: Boolean;
        ObjMember: Record Customer;
        VarMemberEmail: Text[250];
        Filename: Text[250];
        //SMTPSetup: Record "SMTP Mail Setup";
        ObjLoans: Record "Loans Register";
        ObjMemberLedger: Record "Member Ledger Entry";
        VarLineNo: Integer;
        VarMemberName: Text;

        ObjLoansII: Record "Loans Register";
        varShowTranchDisbursement: Boolean;
        CoveragePercentStyle: Text;


    procedure UpdateControl()
    begin

        if Rec."Approval Status" = Rec."approval status"::Open then begin
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
            RepayFrequencyEditable := false;
            DisbursmentDate := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
            SalaryEditable := true;
            LoanPurposeEditable := true;
            RecoveryModeEditable := true;
            Remarkseditable := true;
            LoanPurposeEditable := true;
            CopyofIDEditable := true;
            CopyofPayslipEditable := true;
            AccountNoEditable := true;
        end;

        if Rec."Approval Status" = Rec."approval status"::Pending then begin
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
            SalaryEditable := false;
            DisbursmentDate := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := false;
            LoanPurposeEditable := false;
            RecoveryModeEditable := false;
            Remarkseditable := false;
            LoanPurposeEditable := false;
            CopyofIDEditable := false;
            CopyofPayslipEditable := false;
        end;

        if Rec."Approval Status" = Rec."approval status"::Rejected then begin
            MNoEditable := false;
            AccountNoEditable := false;
            ApplcDateEditable := false;
            LoanStatusEditable := false;
            LProdTypeEditable := false;
            SalaryEditable := false;
            InstallmentEditable := false;
            AppliedAmountEditable := false;
            ApprovedAmountEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := false;
            DisbursmentDate := false;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := false;
            DisbursementDateEditable := false;
            RejectionRemarkEditable := false;
            LoanPurposeEditable := false;
            RecoveryModeEditable := false;
            Remarkseditable := false;
            LoanPurposeEditable := false;
            CopyofIDEditable := false;
            CopyofPayslipEditable := false;
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
            SalaryEditable := false;
            RepayMethodEditable := false;
            RepaymentEditable := false;
            BatchNoEditable := true;
            DisbursmentDate := true;
            RepayFrequencyEditable := false;
            ModeofDisburesmentEdit := true;
            DisbursementDateEditable := true;
            RejectionRemarkEditable := false;
            LoanPurposeEditable := false;
            RecoveryModeEditable := false;
            Remarkseditable := false;
            LoanPurposeEditable := false;
        end;
    end;


    procedure LoanAppPermisions()
    begin
    end;

    local procedure FnVisibility()
    begin
        PayslipDetailsVisible := false;
        BankStatementDetailsVisible := false;

        if Rec."Income Type" = Rec."income type"::"Bank Statement" then begin
            BankStatementDetailsVisible := true;
            PayslipDetailsVisible := false
        end else
            if Rec."Income Type" = Rec."income type"::Payslip then begin
                PayslipDetailsVisible := true;
                BankStatementDetailsVisible := false;
            end else
                if Rec."Income Type" = Rec."income type"::"Payslip & Bank Statement" then begin
                    PayslipDetailsVisible := true;
                    BankStatementDetailsVisible := true;
                end;
    end;

    local procedure FnGenerateSchedule()
    begin
        if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
            Evaluate(InPeriod, '1D')
        else
            if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                Evaluate(InPeriod, '1W')
            else
                if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                    Evaluate(InPeriod, '1M')
                else
                    if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                        Evaluate(InPeriod, '1Q');


        QCounter := 0;
        QCounter := 3;
        ScheduleBal := 0;
        GrPrinciple := Rec."Grace Period - Principle (M)";
        GrInterest := Rec."Grace Period - Interest (M)";
        InitialGraceInt := Rec."Grace Period - Interest (M)";

        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan  No.", Rec."Loan  No.");
        if LoansR.Find('-') then begin

            Rec.TestField("Loan Disbursement Date");
            Rec.TestField("Repayment Start Date");

            RSchedule.Reset;
            RSchedule.SetRange(RSchedule."Loan No.", Rec."Loan  No.");
            RSchedule.DeleteAll;

            LoanAmount := LoansR."Approved Amount" + LoansR."Capitalized Charges";
            InterestRate := LoansR.Interest;
            RepayPeriod := LoansR.Installments;
            InitialInstal := LoansR.Installments + Rec."Grace Period - Principle (M)";
            LBalance := LoansR."Approved Amount" + LoansR."Capitalized Charges";
            LNBalance := LoansR."Outstanding Balance";
            RunDate := Rec."Repayment Start Date";

            InstalNo := 0;
            Evaluate(RepayInterval, '1W');

            //Repayment Frequency
            if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                RunDate := CalcDate('-1D', RunDate)
            else
                if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                    RunDate := CalcDate('-1W', RunDate)
                else
                    if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                        RunDate := CalcDate('-1M', RunDate)
                    else
                        if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                            RunDate := CalcDate('-1Q', RunDate);
            //Repayment Frequency


            repeat
                InstalNo := InstalNo + 1;
                ScheduleBal := LBalance;

                //*************Repayment Frequency***********************//
                if Rec."Repayment Frequency" = Rec."repayment frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else
                    if Rec."Repayment Frequency" = Rec."repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else
                        if Rec."Repayment Frequency" = Rec."repayment frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else
                            if Rec."Repayment Frequency" = Rec."repayment frequency"::Quaterly then
                                RunDate := CalcDate('1Q', RunDate);


                //*******************If Amortised****************************//
                if Rec."Repayment Method" = Rec."repayment method"::Amortised then begin
                    Rec.TestField(Installments);
                    Rec.TestField(Interest);
                    Rec.TestField(Installments);
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                    TotalMRepay := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount;
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate);

                    LPrincipal := TotalMRepay - LInterest;
                end;



                if Rec."Repayment Method" = Rec."repayment method"::"Straight Line" then begin
                    Rec.TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    if (Rec."Loan Product Type" = 'INST') or (Rec."Loan Product Type" = 'MAZAO') then begin
                        LInterest := 0;
                    end else begin
                        LInterest := ROUND((InterestRate / 1200) * LoanAmount, 1, '>');
                    end;

                    Rec.Repayment := LPrincipal + LInterest;
                    Rec."Loan Principle Repayment" := LPrincipal;
                    Rec."Loan Interest Repayment" := LInterest;
                end;


                if Rec."Repayment Method" = Rec."repayment method"::"Reducing Balance" then begin
                    Rec.TestField(Interest);
                    Rec.TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');
                end;

                if Rec."Repayment Method" = Rec."repayment method"::Constants then begin
                    Rec.TestField(Rec.Repayment);
                    if LBalance < Rec.Repayment then
                        LPrincipal := LBalance
                    else
                        LPrincipal := Rec.Repayment;
                    LInterest := Rec.Interest;
                end;


                //Grace Period
                if GrPrinciple > 0 then begin
                    LPrincipal := 0
                end else begin
                    if Rec."Instalment Period" <> InPeriod then
                        LBalance := LBalance - LPrincipal;
                    ScheduleBal := ScheduleBal - LPrincipal;
                end;

                if GrInterest > 0 then
                    LInterest := 0;

                GrPrinciple := GrPrinciple - 1;
                GrInterest := GrInterest - 1;
                LInterest := ROUND(LoansR."Approved Amount" * LoansR.Interest / 12 * (RepayPeriod + 1) / (200 * RepayPeriod), 0.05, '>'); //For Nafaka Only
                                                                                                                                          //Grace Period
                RSchedule.Init;
                RSchedule."Repayment Code" := RepayCode;
                RSchedule."Loan No." := Rec."Loan  No.";
                RSchedule."Loan Amount" := LoanAmount;
                RSchedule."Instalment No" := InstalNo;
                RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                RSchedule."Member No." := Rec."Client Code";
                RSchedule."Loan Category" := Rec."Loan Product Type";
                RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                RSchedule."Monthly Interest" := LInterest;
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule."Loan Balance" := ScheduleBal;
                RSchedule.Insert;
                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


            until LBalance < 1

        end;
        Commit;
    end;

    local procedure FnDisburseToCurrentAccount(LoanApps: Record "Loans Register")
    var
        ProcessingFees: Decimal;
        ProcessingFeesAcc: Code[50];
        PChargeAmount: Decimal;
        BLoan: Code[30];
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        VarLoanInsuranceBalAccount: Code[30];
    begin

        GenSetUp.Get();
        if LoanApps.Get(Rec."Loan  No.") then begin
            LoanApps.CalcFields(LoanApps."Loan Offset Amount", LoanApps."Offset iNTEREST");
            TCharges := 0;
            TopUpComm := 0;
            TotalTopupComm := LoanApps."Loan Offset Amount";

            if (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") or (Rec."Disburesment Type" = Rec."disburesment type"::" ") then begin
                VarAmounttoDisburse := Rec."Approved Amount"
            end else begin
                VarAmounttoDisburse := Rec."Amount to Disburse on Trunch 1";
                if VarAmounttoDisburse <= 0 then
                    Error('You have specified Disbursement Mode as Trunch/Multiple Disbursement, Amount to Disburse on Trunch 1 must be greater than zero.')
            end;

            //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
            GenJournalLine."account type"::None, LoanApps."Client Code", Rec."Posting Date", VarAmounttoDisburse, Format(LoanApps.Source), LoanApps."Loan  No.",
            'Loan Disbursement - ' + LoanApps."Loan Product Type Name", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
            //--------------------------------(Debit Member Loan Account)---------------------------------------------

            //------------------------------------2. CREDIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::Vendor, Rec."Account No", Rec."Posting Date", VarAmounttoDisburse * -1, 'BOSA', LoanApps."Loan  No.",
            'Loan Disbursement - ' + LoanApps."Loan Product Type Name" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
            //----------------------------------(Credit Member Fosa Account)------------------------------------------------

            //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
            PCharges.SetFilter(PCharges."Loan Charge Type", '<>%1', PCharges."loan charge type"::"Loan Insurance");
            if PCharges.Find('-') then begin
                repeat
                    PCharges.TestField(PCharges."G/L Account");
                    GenSetUp.TestField(GenSetUp."Excise Duty Account");
                    PChargeAmount := PCharges.Amount;
                    if PCharges."Use Perc" = true then
                        PChargeAmount := (VarAmounttoDisburse * PCharges.Percentage / 100);//LoanDisbAmount
                                                                                           //-------------------EARN CHARGE-------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", Rec."Posting Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    //-------------------RECOVER-----------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, Rec."Account No", Rec."Posting Date", PChargeAmount, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + '-' + LoanApps."Loan Product Type Name", LoanApps."Loan  No.", GenJournalLine."application source"::" ");

                    //------------------10% EXCISE DUTY----------------------------------------
                    if SFactory.FnChargeExcise(PCharges.Code) then begin
                        //-------------------Earn---------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", Rec."Posting Date", (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                        //-----------------Recover---------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, Rec."Account No", Rec."Posting Date", PChargeAmount * 0.1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + '-' + LoanApps."Loan Product Type Name" + ' - Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    end
                //----------------END 10% EXCISE--------------------------------------------
                until PCharges.Next = 0;
            end;


            //----------------------------------------4. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------
            if LoanApps."Loan Offset Amount" > 0 then begin
                LoanTopUp.Reset;
                LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                if LoanTopUp.Find('-') then begin
                    LoanTopUp.fn_UpdateLoanOffsetDetails();
                    LoanTopUp.Modify;
                end;

                LoanTopUp.Reset;
                LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                if LoanTopUp.Find('-') then begin
                    repeat
                        //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
                        //------------------------------------Principal---------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                        GenJournalLine."account type"::None, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        //------------------------------------Outstanding Interest----------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::None, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Interest Paid- ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        //-------------------------------------Levy--------------------------
                        LineNo := LineNo + 10000;
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", LoanType."Top Up Commision Account", Rec."Posting Date", LoanTopUp.Commision * -1, 'BOSA', LoanTopUp."Loan Top Up",
                            'Levy on Bridging -' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        end;

                        //-------------------------------------Loan Insurance--------------------------
                        // LineNo := LineNo + 10000;
                        // if LoanType.Get(LoanApps."Loan Product Type") then begin
                        //     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                        //     GenJournalLine."account type"::None, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Loan Insurance: Current Year" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        //     'Insurance on Loan Clearance -' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        // end;

                        if ObjLoans.Get(LoanTopUp."Loan Top Up") then begin
                            if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                                VarLoanInsuranceBalAccount := ObjLoanType."Loan Insurance Accounts";
                            end;
                        end;


                        //------------------------------------DEBIT INSURANCE FOR THE CURRENT YEAR  A/C---------------------------------------------------------------------------------------------

                        // LineNo := LineNo + 10000;
                        // SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        // GenJournalLine."account type"::None, LoanApps."Client Code", WorkDate, 'Loan Insurance:Diff. Calender Year _' + LoanTopUp."Loan Top Up", GenJournalLine."bal. account type"::"G/L Account",
                        // VarLoanInsuranceBalAccount, LoanTopUp."Loan Insurance: Current Year", 'FOSA', LoanTopUp."Loan Top Up");
                        //--------------------------------(Credit Loan Penalty Account)-------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, Rec."Account No", Rec."Posting Date", LoanTopUp."Penalty Charged", 'BOSA', LoanTopUp."Loan Top Up",
                        'Loan Penalty Paid  - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        //-------------------------------------RECOVER-------------------------------------------------------------------------------------------------------
                        //-------------------------------------Principal-----------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, Rec."Account No", Rec."Posting Date", LoanTopUp."Principle Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                        'Loan Offset  - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        //-------------------------------------Outstanding Interest-------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, Rec."Account No", Rec."Posting Date", LoanTopUp."Interest Top Up", 'BOSA', LoanTopUp."Loan Top Up",
                        'Interest Paid on topup - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");

                        //-------------------------------------Insurance For the Year-------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, Rec."Account No", Rec."Posting Date", LoanTopUp."Loan Insurance: Current Year", 'BOSA', LoanTopUp."Loan Top Up",
                        'Insurance on Loan Clearance - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        //--------------------------------------Levies--------------------------------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::Vendor, Rec."Account No", Rec."Posting Date", LoanTopUp.Commision, 'BOSA', LoanTopUp."Loan Top Up",
                            'Levy on Bridging - ' + LoanApps."Loan Product Type Name", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        end;

                        //------------------------------Credit Excise Duty Account-----------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", Rec."Posting Date", (LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', BLoan,
                        'Excise Duty_Levy on Bridging', BLoan, GenJournalLine."application source"::" ");

                        //----------------------Debit FOSA A/C Excise Duty on Bridging Fee-----------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::Vendor, Rec."Account No", Rec."Posting Date", (LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)), 'BOSA', BLoan,
                        'Excise Duty_Levy on Bridging', BLoan, GenJournalLine."application source"::" ");
                    until LoanTopUp.Next = 0;
                end;
            end;

            //-----------------------------------------Accrue Interest Disburesment--------------------------------------------------------------------------------------------
            if LoanType.Get(LoanApps."Loan Product Type") then begin
                if LoanType."Accrue Total Insurance&Interes" = true then begin

                    //----------------------Debit interest Receivable Account a/c-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
                    GenJournalLine."account type"::None, LoanApps."Client Code", Rec."Posting Date", (LoanApps."Approved Amount" * (LoanType."Interest rate" / 1200)) * LoanType."No of Installment", 'BOSA', BLoan,
                    'Interest Due' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");

                    //----------------------Credit interest Income Account a/c-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", LoanType."Loan Interest Account", Rec."Posting Date", ((LoanApps."Approved Amount" * (LoanType."Interest rate" / 1200)) * LoanType."No of Installment") * -1, 'BOSA', BLoan,
                    'Interest Due' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                end;
            end;


            //-----------------------------------------Accrue insurance on Disburesment--------------------------------------------------------------------------------------------

            if LoanType.Get(LoanApps."Loan Product Type") then begin
                if LoanType."Accrue Total Insurance&Interes" = true then begin


                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                    PCharges.SetRange(PCharges."Loan Charge Type", PCharges."loan charge type"::"Loan Insurance");
                    if PCharges.Find('-') then begin
                        PCharges.TestField(PCharges."G/L Account");
                        GenSetUp.TestField(GenSetUp."Excise Duty Account");
                        PChargeAmount := PCharges.Amount;
                        if PCharges."Use Perc" = true then
                            PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);
                        //----------------------Debit insurance Receivable Account a/c-----------------------------------------------------
                        // LineNo := LineNo + 10000;
                        // SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        // GenJournalLine."account type"::None, LoanApps."Client Code", Rec."Posting Date", PChargeAmount * LoanType."No of Installment", 'BOSA', BLoan,
                        // 'Insurance Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");

                        //----------------------Credit Insurance Payable Account a/c-----------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", LoanType."Loan Insurance Accounts", Rec."Posting Date", (PChargeAmount * LoanType."No of Installment") * -1, 'BOSA', BLoan,
                        'Insurance Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    end;
                end;
            end;



            //-----------------------------------------5. BOOST DEPOSITS COMMISSION / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
            if LoanApps."Share Boosting Comission" > 0 then begin

                //----------------------Debit FOSA a/c-----------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, Rec."Account No", Rec."Posting Date", LoanApps."Share Boosting Comission", 'BOSA', BLoan,
                'Deposits Boosting Fee', BLoan, GenJournalLine."application source"::" ");

                GenSetUp.Get();
                //------------------------------Credit Income G/L-----------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", GenSetUp."Boosting Fees Account", Rec."Posting Date", LoanApps."Share Boosting Comission" * -1, 'BOSA', BLoan,
                'Deposits Boosting Fee', BLoan, GenJournalLine."application source"::" ");

                //----------------------Debit FOSA A/C Excise Duty on Boosting Fee-----------------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::Vendor, Rec."Account No", Rec."Posting Date", (LoanApps."Share Boosting Comission" * (GenSetUp."Excise Duty(%)" / 100)), 'BOSA', BLoan,
                'Excise Duty_Boosting Fee', BLoan, GenJournalLine."application source"::" ");

                GenSetUp.Get();
                //------------------------------Credit Excise Duty Account-----------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", Rec."Posting Date", (LoanApps."Share Boosting Comission" * (GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', BLoan,
                'Excise Duty_Boosting Fee', BLoan, GenJournalLine."application source"::" ");


            end;


            if ObjLoans.Get(Rec."Loan  No.") then begin
                ObjLoans."Net Payment to FOSA" := ObjLoans."Approved Amount";
                ObjLoans."Processed Payment" := true;
                ObjLoans.Modify;
            end;
        end;
    end;

    local procedure FnDisburseToBankAccount(LoanApps: Record "Loans Register")
    var
        ProcessingFees: Decimal;
        ProcessingFeesAcc: Code[50];
        PChargeAmount: Decimal;
        BLoan: Code[30];
        ObjLoans: Record "Loans Register";
        ObjLoanType: Record "Loan Products Setup";
        VarLoanInsuranceBalAccount: Code[30];
        TotalPCharges: Decimal;
    begin

        GenSetUp.Get();
        if LoanApps.Get(Rec."Loan  No.") then begin
            LoanApps.CalcFields(LoanApps."Loan Offset Amount", LoanApps."Offset iNTEREST");
            TCharges := 0;
            TopUpComm := 0;
            TotalTopupComm := LoanApps."Loan Offset Amount";

            if (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") or (Rec."Disburesment Type" = Rec."disburesment type"::" ") then begin
                VarAmounttoDisburse := Rec."Approved Amount"
            end else begin
                VarAmounttoDisburse := Rec."Amount to Disburse on Trunch 1";
                if VarAmounttoDisburse <= 0 then
                    Error('You have specified Disbursement Mode as Trunch/Multiple Disbursement, Amount to Disburse on Trunch 1 must be greater than zero.')
            end;

            //------------------------------------1. DEBIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Loan,
            GenJournalLine."account type"::None, LoanApps."Client Code", Rec."Posting Date", VarAmounttoDisburse, Format(LoanApps.Source), LoanApps."Loan  No.",
            'Loan Disbursement - ' + LoanApps."Loan Product Type Name", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
            //--------------------------------(Debit Member Loan Account)---------------------------------------------



            //------------------------------------3. EARN/RECOVER PRODUCT CHARGES FROM FOSA A/C--------------------------------------
            PCharges.Reset;
            PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
            PCharges.SetFilter(PCharges."Loan Charge Type", '<>%1', PCharges."loan charge type"::"Loan Insurance");
            if PCharges.Find('-') then begin
                repeat
                    PCharges.TestField(PCharges."G/L Account");
                    GenSetUp.TestField(GenSetUp."Excise Duty Account");
                    PChargeAmount := PCharges.Amount;
                    if PCharges."Use Perc" = true then
                        PChargeAmount := (VarAmounttoDisburse * PCharges.Percentage / 100);//LoanDisbAmount
                                                                                           //-------------------EARN CHARGE-------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", PCharges."G/L Account", Rec."Posting Date", PChargeAmount * -1, 'BOSA', LoanApps."Loan  No.",
                    PCharges.Description + ' - ' + LoanApps."Client Code" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");


                    //------------------10% EXCISE DUTY----------------------------------------
                    if SFactory.FnChargeExcise(PCharges.Code) then begin
                        //-------------------Earn---------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", Rec."Posting Date", (PChargeAmount * -1) * 0.1, 'BOSA', LoanApps."Loan  No.",
                        PCharges.Description + '-' + LoanApps."Client Code" + '-' + LoanApps."Loan Product Type Name" + '-' + LoanApps."Loan  No." + '- Excise(10%)', LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    end;

                    TotalPCharges := TotalPCharges + PChargeAmount;
                //----------------END 10% EXCISE--------------------------------------------
                until PCharges.Next = 0;
            end;


            //----------------------------------------4. PAY/RECOVER TOP UPS------------------------------------------------------------------------------------------
            if LoanApps."Loan Offset Amount" > 0 then begin
                LoanTopUp.Reset;
                LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                if LoanTopUp.Find('-') then begin
                    LoanTopUp.fn_UpdateLoanOffsetDetails();
                    LoanTopUp.Modify;
                end;

                LoanTopUp.Reset;
                LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                if LoanTopUp.Find('-') then begin
                    repeat
                        //------------------------------------PAY-----------------------------------------------------------------------------------------------------------
                        //------------------------------------Principal---------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::Repayment,
                        GenJournalLine."account type"::None, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Principle Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Off Set By - ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        //------------------------------------Outstanding Interest----------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                        GenJournalLine."account type"::None, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Interest Top Up" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        'Interest Paid- ' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        //-------------------------------------Levy--------------------------
                        LineNo := LineNo + 10000;
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                            GenJournalLine."account type"::"G/L Account", LoanType."Top Up Commision Account", Rec."Posting Date", LoanTopUp.Commision * -1, 'BOSA', LoanTopUp."Loan Top Up",
                            'Levy on Bridging -' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        end;

                        //-------------------------------------Loan Insurance--------------------------
                        // LineNo := LineNo + 10000;
                        // if LoanType.Get(LoanApps."Loan Product Type") then begin
                        //     SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Paid",
                        //     GenJournalLine."account type"::None, LoanApps."Client Code", Rec."Posting Date", LoanTopUp."Loan Insurance: Current Year" * -1, 'BOSA', LoanTopUp."Loan Top Up",
                        //     'Insurance on Loan Clearance -' + LoanApps."Client Code" + '-' + LoanApps."Loan  No.", LoanTopUp."Loan Top Up", GenJournalLine."application source"::" ");
                        // end;

                        if ObjLoans.Get(LoanTopUp."Loan Top Up") then begin
                            if ObjLoanType.Get(ObjLoans."Loan Product Type") then begin
                                VarLoanInsuranceBalAccount := ObjLoanType."Loan Insurance Accounts";
                            end;
                        end;


                        //------------------------------------DEBIT INSURANCE FOR THE CURRENT YEAR  A/C---------------------------------------------------------------------------------------------
                        /*
                          LineNo:=LineNo+10000;
                          SFactory.FnCreateGnlJournalLineBalanced(BATCH_TEMPLATE,BATCH_NAME,DOCUMENT_NO,LineNo,GenJournalLine."Transaction Type"::"Loan Insurance Charged",
                          GenJournalLine."Account Type"::Member,LoanApps."Client Code",WORKDATE,'Loan Insurance:Diff. Calender Year _'+LoanTopUp."Loan Top Up",GenJournalLine."Bal. Account Type"::"G/L Account",
                          VarLoanInsuranceBalAccount,LoanTopUp."Loan Insurance: Current Year",'FOSA',LoanTopUp."Loan Top Up");
                          */

                        //------------------------------Credit Excise Duty Account-----------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", Rec."Posting Date", (LoanTopUp.Commision * (GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', BLoan,
                        'Excise Duty_Levy on Bridging', BLoan, GenJournalLine."application source"::" ");


                    until LoanTopUp.Next = 0;
                end;
            end;

            //-----------------------------------------Accrue Interest Disburesment--------------------------------------------------------------------------------------------
            if LoanType.Get(LoanApps."Loan Product Type") then begin
                if LoanType."Accrue Total Insurance&Interes" = true then begin

                    //----------------------Debit interest Receivable Account a/c-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Interest Due",
                    GenJournalLine."account type"::None, LoanApps."Client Code", Rec."Posting Date", (LoanApps."Approved Amount" * (LoanType."Interest rate" / 1200)) * LoanType."No of Installment", 'BOSA', BLoan,
                    'Interest Due' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");

                    //----------------------Credit interest Income Account a/c-----------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::"G/L Account", LoanType."Loan Interest Account", Rec."Posting Date", ((LoanApps."Approved Amount" * (LoanType."Interest rate" / 1200)) * LoanType."No of Installment") * -1, 'BOSA', BLoan,
                    'Interest Due' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                end;
            end;


            //-----------------------------------------Accrue insurance on Disburesment--------------------------------------------------------------------------------------------

            if LoanType.Get(LoanApps."Loan Product Type") then begin
                if LoanType."Accrue Total Insurance&Interes" = true then begin


                    PCharges.Reset;
                    PCharges.SetRange(PCharges."Product Code", LoanApps."Loan Product Type");
                    PCharges.SetRange(PCharges."Loan Charge Type", PCharges."loan charge type"::"Loan Insurance");
                    if PCharges.Find('-') then begin
                        PCharges.TestField(PCharges."G/L Account");
                        GenSetUp.TestField(GenSetUp."Excise Duty Account");
                        PChargeAmount := PCharges.Amount;
                        if PCharges."Use Perc" = true then
                            PChargeAmount := (LoanApps."Approved Amount" * PCharges.Percentage / 100);

                        //----------------------Debit insurance Receivable Account a/c-----------------------------------------------------

                        // LineNo := LineNo + 10000;
                        // SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged",
                        // GenJournalLine."account type"::None, LoanApps."Client Code", Rec."Posting Date", PChargeAmount * LoanType."No of Installment", 'BOSA', BLoan,
                        // 'Insurance Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");

                        //----------------------Credit Insurance Payable Account a/c-----------------------------------------------------
                        LineNo := LineNo + 10000;
                        SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                        GenJournalLine."account type"::"G/L Account", LoanType."Loan Insurance Accounts", Rec."Posting Date", (PChargeAmount * LoanType."No of Installment") * -1, 'BOSA', BLoan,
                        'Insurance Charged' + '_' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
                    end;
                end;
            end;

            //-----------------------------------------5. BOOST DEPOSITS COMMISSION / RECOVER FROM FOSA A/C--------------------------------------------------------------------------------------------
            if LoanApps."Share Boosting Comission" > 0 then begin


                GenSetUp.Get();
                //------------------------------Credit Income G/L-----------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", GenSetUp."Boosting Fees Account", Rec."Posting Date", LoanApps."Share Boosting Comission" * -1, 'BOSA', BLoan,
                'Deposits Boosting Fee', BLoan, GenJournalLine."application source"::" ");


                GenSetUp.Get();
                //------------------------------Credit Excise Duty Account-----------------------------------------------
                LineNo := LineNo + 10000;
                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                GenJournalLine."account type"::"G/L Account", GenSetUp."Excise Duty Account", Rec."Posting Date", (LoanApps."Share Boosting Comission" * (GenSetUp."Excise Duty(%)" / 100)) * -1, 'BOSA', BLoan,
                'Excise Duty_Boosting Fee', BLoan, GenJournalLine."application source"::" ");


            end;

            //------------------------------------2. CREDIT MEMBER BANK A/C---------------------------------------------------------------------------------------------
            LineNo := LineNo + 10000;
            SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
            GenJournalLine."account type"::"Bank Account", Rec."Paying Bank Account No", Rec."Posting Date", Rec."Loan Disbursed Amount" * -1, 'BOSA', LoanApps."Cheque No.",
            'Loan Disbursement - ' + LoanApps."Loan Product Type Name" + ' - ' + LoanApps."Loan  No.", LoanApps."Loan  No.", GenJournalLine."application source"::" ");
            //----------------------------------(Credit Member Bank Account)------------------------------------------------

            if ObjLoans.Get(Rec."Loan  No.") then begin
                ObjLoans."Net Payment to FOSA" := ObjLoans."Approved Amount";
                ObjLoans."Processed Payment" := true;
                ObjLoans.Modify;
            end;
        end;

    end;

    local procedure FnBoosterLoansDisbursement(ObjLoanDetails: Record "Loans Register"; LineNo: Integer): Code[40]
    var
        GenJournalLine: Record "Gen. Journal Line";
        CUNoSeriesManagement: Codeunit NoSeriesManagement;
        DocNumber: Code[100];
        loanTypes: Record "Loan Products Setup";
        ObjLoanX: Record "Loans Register";
    begin
        loanTypes.Reset;
        loanTypes.SetRange(loanTypes.Code, 'BLOAN');
        if loanTypes.Find('-') then begin
            DocNumber := CUNoSeriesManagement.GetNextNo('LOANSB', 0D, true);
            LoansRec.Init;
            LoansRec."Loan  No." := DocNumber;
            LoansRec.Insert;

            if LoansRec.Get(LoansRec."Loan  No.") then begin
                LoansRec."Client Code" := ObjLoanDetails."Client Code";
                LoansRec.Validate(LoansRec."Client Code");
                LoansRec."Loan Product Type" := 'BLOAN';
                LoansRec.Validate(LoansRec."Loan Product Type");
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Loan Status" := LoansRec."loan status"::Closed;
                LoansRec."Application Date" := ObjLoanDetails."Application Date";
                LoansRec."Issued Date" := ObjLoanDetails."Posting Date";
                LoansRec."Loan Disbursement Date" := ObjLoanDetails."Loan Disbursement Date";
                LoansRec.Validate(LoansRec."Loan Disbursement Date");
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"FOSA Account";
                LoansRec."Repayment Start Date" := ObjLoanDetails."Repayment Start Date";
                LoansRec."Global Dimension 1 Code" := 'BOSA';
                LoansRec."Global Dimension 2 Code" := SFactory.FnGetUserBranch();
                LoansRec.Source := ObjLoanDetails.Source;
                LoansRec."Approval Status" := ObjLoanDetails."Approval Status";
                LoansRec.Repayment := ObjLoanDetails."Boosted Amount";
                LoansRec."Requested Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec."Approved Amount" := ObjLoanDetails."Boosted Amount";
                LoansRec.Interest := ObjLoanDetails.Interest;
                LoansRec."Mode of Disbursement" := LoansRec."mode of disbursement"::"FOSA Account";
                LoansRec.Posted := true;
                LoansRec."Advice Date" := Today;
                LoansRec.Modify;
            end;
        end;
        exit(DocNumber);
    end;

    local procedure FnUpdateShareBoostedTrans()
    begin

        ObjCust.Reset;
        ObjCust.SetRange(ObjCust."No.", Rec."Client Code");
        if ObjCust.Find('-') then begin
            Rec."Employer Code" := ObjCust."Employer Code";
            //MODIFY;

            GenSetUp.Get();

            ObjMemberLedg.Reset;
            ObjMemberLedg.SetRange(ObjMemberLedg."Customer No.", Rec."Client Code");
            ObjMemberLedg.SetRange(ObjMemberLedg."Journal Batch Name", 'FTRANS');
            ObjMemberLedg.SetRange(ObjMemberLedg."No Boosting", false);
            ObjMemberLedg.SetRange(ObjMemberLedg."Transaction Type", ObjMemberLedg."transaction type"::"Deposit Contribution");
            if ObjMemberLedg.FindSet then begin
                if ObjMemberLedg."No Boosting" = false then begin //>
                    repeat
                        if ObjMemberLedg."Posting Date" > CalcDate(GenSetUp."Boosting Shares Maturity (M)", Today) then begin

                            if ((ObjMemberLedg."Credit Amount") > ObjCust."Monthly Contribution") then begin
                                ObjMemberLedg."Share Boosting Fee Charged" := true;
                                ObjMemberLedg.Modify;
                            end;
                        end;
                    until ObjMemberLedg.Next = 0;
                end;
            end;
        end;
    end;

    local procedure FnRunSendScheduleViaMail(LoanNo: Code[30]; ClientCode: Code[30])
    var
        Filename: Text[100];
        // SMTPSetup: Record "SMTP Mail Setup";
        //SMTPMail: Codeunit "SMTP Mail";
        VarMemberEmail: Text[50];
        ObjMember: Record Customer;
        Attachment: Text[250];
        ObjLoanType: Record "Loan Products Setup";
        VarProductDescription: Code[50];
        ObjLoans: Record "Loans Register";
        VarNewMemberName: Text[100];
        Recipient: list of [Text];
    begin
        //  SMTPSetup.Get();

        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNo);
        if ObjLoans.FindSet then begin
            if ObjMember.Get(ClientCode) then begin
                VarMemberEmail := Lowercase(ObjMember."E-Mail");
            end;
            Recipient.Add(VarMemberEmail);
            Filename := '';
            //   Filename := SMTPSetup."Path to Save Report" + 'Loan Repayment Schedule.pdf';
            // Report.SaveAsPdf(Report::"Loans Repayment Schedule", Filename, ObjLoans);

            VarProductDescription := ObjLoans."Loan Product Type Name";
            VarNewMemberName := UpperCase(CopyStr(Rec."Client Name", 1, 1)) + Lowercase(CopyStr(Rec."Client Name", 2));

            // SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Recipient, 'Loan Repayment Schedule', '', true);
            // SMTPMail.AppendBody('Dear ,' + VarNewMemberName);
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('Please find attached your loan repayment schedule.');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('Thank you for choosing Kingdom SACCO');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('Kind Regards');
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody(UserId);
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AppendBody('<HR>');
            // SMTPMail.AddAttachment(Filename, Attachment);
            // SMTPMail.Send;
        end;
    end;

    local procedure FnRunCreateLSAfor1sttimeLoanees()
    var
        ObjAccount: Record Vendor;
        ObjAccountType: Record "Account Types-Saving Products";
        VarAcctNo: Code[30];
    begin
        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."BOSA Account No", Rec."Client Code");
        ObjAccount.SetFilter(ObjAccount.Status, '<>%1|%2', ObjAccount.Status::Closed, ObjAccount.Status::Deceased);
        ObjAccount.SetRange(ObjAccount."Account Type", '507');
        if ObjAccount.Find('-') = false then begin
            SFactory.FnRunCreatNewAccount('507', Rec."Global Dimension 2 Code", Rec."Client Code");
        end;
    end;

    local procedure FnRunCheckLoanStages()
    var
        ObjLoanApplicationStages: Record "Loan Application Stages";
    begin
        ObjLoanApplicationStages.Reset;
        ObjLoanApplicationStages.SetRange(ObjLoanApplicationStages."Loan No", Rec."Loan  No.");
        ObjLoanApplicationStages.SetFilter(ObjLoanApplicationStages."Stage Status", '<>%1', ObjLoanApplicationStages."stage status"::Succesful);
        ObjLoanApplicationStages.SetFilter(ObjLoanApplicationStages."Loan Stage", '<>%1', '015');
        if ObjLoanApplicationStages.FindSet then begin
            Error('This Loan Application has Loan Stages that are not Succesful. Kindly Review Before Posting the Loan');
        end;
    end;

    local procedure FnRunUpdateDisburesmentLoanStage()
    var
        ObjLoanApplicationStages: Record "Loan Application Stages";
    begin
        ObjLoanApplicationStages.Reset;
        ObjLoanApplicationStages.SetRange(ObjLoanApplicationStages."Loan No", Rec."Loan  No.");
        ObjLoanApplicationStages.SetFilter(ObjLoanApplicationStages."Loan Stage", '%1', '015');
        if ObjLoanApplicationStages.FindSet then begin
            ObjLoanApplicationStages."Stage Status" := ObjLoanApplicationStages."stage status"::Succesful;
            ObjLoanApplicationStages.Modify;
        end;
    end;

    local procedure FnAccrueInterestOneOffLoans(VarLoanNo: Code[30])
    var
        ObjLoans: Record "Loans Register";
        ObjInterestLedger: Record "Interest Due Ledger Entry";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange("Loan  No.", VarLoanNo);
        ObjLoans.SetRange("OneOff Loan Repayment", true);
        if ObjLoans.FindSet then begin

            ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
            ObjInterestLedger.Reset;
            ObjInterestLedger.SetCurrentkey(ObjInterestLedger."Entry No.");
            if ObjInterestLedger.FindLast then
                VarLineNo := ObjInterestLedger."Entry No." + 1;

            ObjInterestLedger.Init;
            ObjInterestLedger."Journal Batch Name" := 'INTRESTDUE';
            ObjInterestLedger."Entry No." := VarLineNo;
            ObjInterestLedger."Customer No." := ObjLoans."Client Code";
            ObjInterestLedger."Transaction Type" := ObjInterestLedger."transaction type"::"Interest Due";
            ObjInterestLedger."Document No." := SFactory.FnRunGetNextTransactionDocumentNo;
            ObjInterestLedger."Posting Date" := CalcDate(Format(ObjLoans.Installments + ObjLoans."Grace Period - Interest (M)") + 'M', ObjLoans."Loan Disbursement Date");
            ObjInterestLedger.Description := ObjLoans."Loan  No." + ' ' + 'Interest charged';
            ObjInterestLedger.Amount := ROUND(ObjLoans."Outstanding Balance" * (ObjLoans.Interest / 1200), 1, '>') * (ObjLoans.Installments + ObjLoans."Grace Period - Interest (M)");
            if ObjLoans.Source = ObjLoans.Source::" " then begin
                ObjInterestLedger."Global Dimension 2 Code" := ObjLoans."Branch Code";
            end;
            if ObjLoans.Source = ObjLoans.Source::BOSA then begin
                ObjInterestLedger."Global Dimension 2 Code" := ObjLoans."Branch Code";
            end;
            ObjInterestLedger."Global Dimension 1 Code" := FnProductSource(ObjLoans."Loan Product Type");
            ObjInterestLedger.Validate(ObjInterestLedger."Global Dimension 2 Code");
            ObjInterestLedger.Validate(ObjInterestLedger."Global Dimension 1 Code");
            ObjInterestLedger."Loan No" := ObjLoans."Loan  No.";
            ObjInterestLedger."Interest Accrual Date" := ObjLoans."Loan Disbursement Date";
            if ObjInterestLedger.Amount <> 0 then
                ObjInterestLedger.Insert;
        end;
    end;

    local procedure FnProductSource(Product: Code[50]) Source: Code[50]
    var
        ObjProducts: Record "Loan Products Setup";
    begin
        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts.Code, Product);
        if ObjProducts.Find('-') then begin
            if ObjProducts.Source = ObjProducts.Source::BOSA then
                Source := 'BOSA'
            else
                Source := 'FOSA';
        end;
        exit(Source);
    end;

    local procedure FnRunDisbursementSMS()
    var
        ObjAccount: Record Vendor;
        VarLoanProductName: Code[30];
        ObjCust: Record Customer;
        VarSMSBody: Text;
    begin
        ObjAccount.Reset;
        ObjAccount.SetRange(ObjAccount."No.", Rec."Account No");
        if ObjAccount.FindSet then
            VarLoanProductName := ObjAccount."Account Type Name";

        VarMemberName := SFactory.FnRunSplitString(Rec."Client Name", ' ');

        if ObjCust.Get(Rec."Client Code") then begin
            VarSMSBody := 'Dear ' + VarMemberName + ', your ' + Rec."Loan Product Type Name" + ' application of Ksh. ' + Format(Rec."Approved Amount")
              + ' has been disbursed to your Account No. ' + Rec."Account No" + ' and loan schedule sent via mail.';
            SFactory.FnSendSMS('LOANDIS', VarSMSBody, Rec."Client Code", ObjCust."Mobile Phone No");
        end;
    end;

    local procedure SetStyles()
    begin
        /*CoveragePercentStyle:='Strong';
        IF ("1 3rd of Basic" = 'Very Poor') OR ("1 3rd of Basic" = 'Poor') THEN
          BEGIN
           CoveragePercentStyle := 'Unfavorable';
          END;
        
        IF ("1 3rd of Basic" ='Good') OR ("1 3rd of Basic" ='Excellent') THEN
          BEGIN
            CoveragePercentStyle := 'Favorable';
          END;*/

    end;

    procedure SendLoanScheduleByEmail(LoanNo: Code[20])
    var
        LoanRec: Record "Loans Register";
        Cust: Record Customer;
        RecRef: RecordRef;
        OutStr: OutStream;
        InStr: InStream;
        TempBlob: Codeunit "Temp Blob";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        FileName: Text;
        EmailBody: Text;
        RecipientList: List of [Text];
        CCRecipients: List of [Text];
        BCCRecipients: List of [Text];
        CleanEmail: Text;
    begin
        // Find loan
        LoanRec.Reset();
        LoanRec.SetRange("Loan  No.", LoanNo);
        LoanRec.SetFilter("Loan Product Type", '<>%1', 'INSTANT');
        if not LoanRec.FindFirst() then
            Error('Loan %1 not found.', LoanNo);

        // Find customer
        if not Cust.Get(LoanRec."Client Code") then
            Error('Customer %1 not found.', LoanRec."Client Code");
        if Cust."E-Mail" = '' then
            Error('No email found for customer %1', Cust."No.");

        // Clean recipient email
        CleanEmail := DelChr(LowerCase(Cust."E-Mail"), '<>', ' ');

        // Export schedule to PDF
        TempBlob.CreateOutStream(OutStr);
        RecRef.GetTable(LoanRec);
        if not Report.SaveAs(Report::"Loans Repayment Schedule", '', ReportFormat::Pdf, OutStr, RecRef) then
            Error('Failed to generate loan repayment schedule PDF.');

        TempBlob.CreateInStream(InStr);
        FileName := LoanRec."Loan  No." + '_Schedule.pdf';

        // Build email body
        EmailBody := 'Dear ' + Cust.Name + ',' +
                     '<br/><br/>Please find attached the repayment schedule for your loan ' + LoanRec."Loan  No." + '.' +
                     '<br/><br/>Thank you.';

        // Recipients
        RecipientList.Add(CleanEmail);
        Clear(CCRecipients);
        Clear(BCCRecipients);


        // Create email (sender is forced by default Email Account setup in BC)
        EmailMessage.Create(RecipientList, 'Loan Repayment Schedule', '', true, CCRecipients, BCCRecipients);
        EmailMessage.AppendToBody(EmailBody);
        EmailMessage.AddAttachment(FileName, 'application/pdf', InStr);

        // Debug
        Message('About to send email to %1 with file %2', CleanEmail, FileName);

        // Send
        if not Email.Send(EmailMessage) then
            Error('Failed to send email to %1. Error: %2', CleanEmail, GetLastErrorText());
    end;

}