//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50016 "Loan Application Card(BOSA)"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Appraisal,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loans Register";
    SourceTableView = where(Source = const(BOSA),
                            Posted = const(false));

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
                    Caption = 'Member No.';
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
                    Editable = True;
                    Importance = Additional;
                }
                field("1st Time Loanee"; Rec."1st Time Loanee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                    Importance = Additional;
                }
                field("Private Member"; Rec."Private Member")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    visible = false;
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
                field("Is Offset"; Rec."Is Offset")
                { }
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
                field("Deposit Boosting"; Rec."Deposit Boosting") { Visible = false; }
                field("Deposit Boosting Commision"; Rec."Deposit Boosting Commision") { Visible = false; }
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
                field("Sacco Decision"; Rec."Sacco Decision")
                {

                    Visible = false;
                    ApplicationArea = Basic;
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
                field("Disburesment Type"; Rec."Disburesment Type")
                {
                    Visible = false;
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
                    Caption = 'Trunch Details';
                    Visible = TrunchDetailsVisible;
                    field("Amount to Disburse on Tranch 1"; Rec."Amount to Disburse on Trunch 1")
                    {
                        ApplicationArea = Basic;
                    }
                    field("No of Tranch Disbursment"; Rec."No of Tranch Disbursment")
                    {
                        ApplicationArea = Basic;
                        Caption = 'No of Trunch Disbursement';
                    }
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = true;
                }


                field("Sector Specific"; Rec."Sector Specific")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }


                field("Sub Sector"; Rec."Sub Sector")
                {
                    ApplicationArea = Basic;

                }
                field("Main Sector"; Rec."Main Sector")
                {
                    ApplicationArea = Basic;

                }
                field("Main-Sector Discription"; Rec."Main-Sector Discription")
                {
                    ApplicationArea = all;
                }
                field("Sub-Sector Discription"; Rec."Sub-Sector Discription")
                {
                    ApplicationArea = all;
                    Caption = 'Sector Discription';
                }
                field("Specific-Sector Discription"; Rec."Specific-Sector Discription")
                {
                    ApplicationArea = all;
                }



                field("Income Type"; Rec."Income Type")
                {
                    ApplicationArea = Basic;
                    visible = false;
                    trigger OnValidate()
                    begin
                        FnVisibility();
                    end;
                }

                field("Received Copy Of ID"; Rec."Received Copy Of ID")
                {
                    ApplicationArea = Basic;
                    Editable = CopyofIDEditable;
                    visible = false;
                }
                field("Received Payslip/Bank Statemen"; Rec."Received Payslip/Bank Statemen")
                {
                    ApplicationArea = Basic;
                    Editable = CopyofPayslipEditable;
                    visible = false;
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
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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

                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Deposit Contrib"; Rec."Deposit Contrib") { }
                field("Share Capital Contrib"; Rec."Share Capital Contrib") { }
                field("Programmed Deposit Contrib"; Rec."Programmed Deposit Contrib") { }
                field("Benevolent Fund Contrib"; Rec."Benevolent Fund Contrib") { }
                field("CRB Querry Charge"; Rec.CRBQuerryCharge) { }

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
                    Editable = true;
                    Visible = false;
                }
                field("Account No"; Rec."Account No")
                {
                    applicationArea = all;
                    Visible = false;
                }

                // field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                // {
                //     ApplicationArea = Basic;
                //     //Editable = DisbursmentDate;

                // }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;

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
                    field(NHIF; Rec.NHIF) { ApplicationArea = all; Caption = 'SHIF'; }
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
                Visible = RejectionDetailsVisible;
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
            group("CRB Details")
            {

                field("CRB Metro"; Rec."CRB Metro")
                {
                    ApplicationArea = Basic;
                }
                field(PPP1; Rec.PPP1)
                {
                    ApplicationArea = Basic;
                }
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = Basic;

                }
            }

            part(Control4; "Loans Guarantee Details")
            {
                Caption = 'Guarantors  Detail';
                SubPageLink = "Loan No" = field("Loan  No.");
                ApplicationArea = all;
            }


            part(Control3; "Loan Collateral Security")
            {
                Caption = 'Other Securities';
                SubPageLink = "Loan No" = field("Loan  No."), "Member No" = field("Client Code");
                ApplicationArea = all;
            }
        }
        area(factboxes)
        {
            part(Control1; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
                ApplicationArea = all;
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
                action("Reset Loan Application")
                {
                    ApplicationArea = Basic;
                    Image = RefreshExcise;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Rec."Client Code" := '';
                            Rec."Client Name" := '';
                            Rec."ID NO" := '';
                            Rec."Staff No" := '';
                            Rec.Installments := 0;
                            Rec.Interest := 0;
                            Rec."Requested Amount" := 0;
                            Rec."Approved Amount" := 0;
                        end;
                    end;
                }
                action("Loan Application Form")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(172913, true, false, LoanApp);
                        end;
                    end;
                }
                action("Reject Loan Application")
                {
                    ApplicationArea = Basic;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    trigger OnAction()


                    begin
                        if Confirm('Confirm Rejection?', false) = true then begin
                            Rec."Intent to Reject" := true;

                            RejectionDetailsVisible := false;
                            if Rec."Intent to Reject" = true then begin
                                RejectionDetailsVisible := true;
                            end;

                            if Rec."Rejection  Remark" = '' then begin
                                Error('Specify the Rejection Remarks/Reason on the Rejection Details Tab');
                            end else
                                Rec."Rejected By" := UserId;
                            Rec."Date of Rejection" := WorkDate;
                            Rec."Approval Status" := Rec."approval status"::Rejected;
                            Rec."Loan Status" := Rec."loan status"::Rejected;

                            //=========================================================================================Loan Stages Common On All Applications
                            ObjLoanStages.Reset;
                            ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::Declined);
                            ObjLoanStages.SetFilter("Min Loan Amount", '=%1', 0);
                            if ObjLoanStages.FindSet then begin
                                repeat
                                    ObjLoanApplicationStages.Init;
                                    ObjLoanApplicationStages."Loan No" := Rec."Loan  No.";
                                    ObjLoanApplicationStages."Member No" := Rec."Client Code";
                                    ObjLoanApplicationStages."Member Name" := Rec."Client Name";
                                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                                    ObjLoanApplicationStages.Insert;
                                until ObjLoanStages.Next = 0;
                            end;

                        end;

                        CurrPage.Close;
                    end;
                }
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
                action("Re-Open Loan")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    Visible = false;


                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            LoanApp."Loan Status" := LoanApp."Loan Status"::Appraisal;
                            LoanApp."Approval Status" := LoanApp."Approval Status"::Open;
                            LoanApp.Modify(true);
                        end;
                    end;


                }
                action("Mark As Rejected")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;


                    trigger OnAction()
                    var
                        UserSetup: Record "User Setup";
                    begin

                        if UserSetup.Get(UserId) then
                            if UserSetup."Post Pv" = false then error('You dont have this right. Contact System admin for further assistance.');
                        if Confirm('Are you sure you want to mark this loan as rejected?') = false then exit;
                        rec."Loan Status" := Rec."Loan Status"::Rejected;
                        Rec."Approval Status" := Rec."Approval Status"::Rejected;
                        Message('Loan rejected Succesfully');
                        rec.Modify;
                    end;
                }
                action("Send Loan to Committee Approval")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    Visible = false;


                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            LoanApp."Committee Approval" := LoanApp."Committee Approval"::Pending;
                            //LoanApp."Approval Status" := LoanApp."Approval Status"::Open;
                            LoanApp.Modify(true);
                        end;
                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Enabled = true;
                    Image = GanttChart;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        ProvidedGuarantors := 0;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.", Rec."Loan  No.");
                        if LoanApp.Find('-') then begin
                            Report.Run(50084, true, false, LoanApp)
                        end;

                        FnRunCreateLoanStages;
                    end;
                }
                action("Go to FOSA Accounts")
                {
                    ApplicationArea = Basic;
                    Image = List;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Accounts List";
                    RunPageLink = "BOSA Account No" = field("Client Code");
                }
                action("Update PAYE")
                {
                    ApplicationArea = Basic;
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        loansregister: Record "Loans Register";
                        Repayment: Decimal;
                        Interest: Decimal;

                        twothirds: Decimal;
                        NHIFRElief: Decimal;
                        AupayrollPr: Codeunit "AU Payroll Processing";
                    begin
                        GenSetUp.Get();
                        Nettakehome := Rec."Basic Pay H" * 1 / 3;


                        twothirds := 0;
                        //NHIFRElief := 0;
                        //NHIFRElief := 0.015 * Rec.NHIF;
                        GrossPay := Rec."Basic Pay H" + Rec."Medical AllowanceH" + Rec."House AllowanceH" + Rec."Other Income" + Rec."Transport Allowance";
                        Rec."Gross Pay" := GrossPay;

                        Rec."Housing Levy" := Rec."Gross Pay" * 1.5 / 100;
                        Nettakehome := Rec."Gross Pay" * 1 / 3;

                        Rec.CalcFields("Bridge Amount Release");

                        Rec."Utilizable Amount" := 0;
                        NetUtilizable := 0;

                        OTrelief := Rec."Other Tax Relief";
                        Rec."Chargeable Pay" := Rec."Gross Pay" + Rec."Other Tax Relief" - Rec."Provident Fund" - Rec."Pension Scheme" - Rec.NSSF - Rec.NHIF - Rec."Housing Levy";
                        Rec.Modify(true);

                        if Rec.PayPayee then begin

                            if Rec.Disabled <> true then begin
                                Rec.PAYE := AupayrollPr.fnGetEmployeePaye(Rec."Chargeable Pay") - 2400;

                                Rec.Modify(true);

                            end;

                        end;

                        twothirds := (Rec."Gross Pay" - PAYE) * 2 / 3;
                        Rec."2 thirds Amount" := twothirds;
                        Rec."Total DeductionsH" := 0;
                        Rec."Other Loans Repayments" := 0;
                        Rec.Modify(true);
                        RepaymentMent := 0;
                        Interest := 0;
                        loansregister.reset;
                        loansregister.SetRange(loansregister."Client Code", Rec."Client Code");
                        loansregister.SetFilter(loansregister."Outstanding Balance", '>%1', 0);
                        if loansregister.Find('-') then begin
                            loansregister.CalcSums("Loan Principle Repayment", "Loan Interest Repayment");
                            Repayment := loansregister.FnRungetexistingLoansRepayment(loansregister."Client Code");
                            Interest := loansregister."Loan Interest Repayment";
                            RepaymentMent := Repayment;
                        end;
                        Rec."Other Loans Repayments" := Rec.Repayment;//II

                        TotalDeductions := Rec."Monthly Contribution" + Rec.NSSF + Rec.NHIF + Rec.PAYE + Rec."Sacco Deductions" + Rec."Pension Scheme" + Rec."Housing Levy" + rec."risk Mgt";                                                                                                                                                                                           // Message('TotalDeductions %1', TotalDeductions);
                        Rec."Net Salary" := GrossPay - (Rec."Monthly Contribution" + Rec.NSSF + Rec.NHIF + Rec.PAYE + Rec."Sacco Deductions" + Rec."Pension Scheme" + Rec."Housing Levy" + rec."risk Mgt");
                        Rec."Net take home 2" := GrossPay - (TotalDeductions);
                        Rec."Utilizable Amount" := ROUND((Rec."Gross Pay" - TotalDeductions - (1 / 3 * Rec."Gross Pay")), 0.5, '<');
                        NetUtilizable := ROUND((Rec."Gross Pay" - TotalDeductions - (1 / 3 * Rec."Gross Pay")), 0.5, '<');
                        Rec."Net Utilizable Amount" := NetUtilizable;
                        Rec."Total DeductionsH" := TotalDeductions;
                        Rec."Net take Home" := Nettakehome;
                        Rec.Modify;
                    end;
                }
                action("View Loan Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        Rec.TestField("Loan Disbursement Date");
                        SFactory.FnGenerateLoanRepaymentSchedule(Rec."Loan  No.");
                        LoanApp.reset;
                        LoanApp.SetRange(loanapp."Loan  No.", Rec."Loan  No.");
                        if loanapp.Find('-') then begin
                            Report.Run(80014, true, false, LoanApp);
                        end
                    end;

                }

                action("Account Statement Transactions ")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Appraisal Statement Buffe";
                    RunPageLink = "Loan No" = field("Loan  No.");
                }
                action("Member Deposit Saving History")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Deposit Saving History";
                    RunPageLink = "Loan No" = field("Loan  No.");
                }
                action("Load Account Statement Details")
                {
                    ApplicationArea = Basic;
                    Image = InsertAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    trigger OnAction()
                    begin
                        //Clear Buffer
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."Loan  No.");
                        if ObjStatementB.FindSet then begin
                            ObjStatementB.DeleteAll;
                        end;



                        //Initialize Variables
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;
                        VerMonth2CreditAmount := 0;
                        VerMonth2DebitAmount := 0;
                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        GenSetUp.Get();

                        //Month 1
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth1Date := Date2dmy(StatementStartDate, 1);
                        VerMonth1Month := Date2dmy(StatementStartDate, 2);
                        VerMonth1Year := Date2dmy(StatementStartDate, 3);


                        VerMonth1StartDate := Dmy2date(1, VerMonth1Month, VerMonth1Year);
                        VerMonth1EndDate := CalcDate('CM', VerMonth1StartDate);

                        VarMonth1Datefilter := Format(VerMonth1StartDate) + '..' + Format(VerMonth1EndDate);
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth1Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth1DebitAmount := VerMonth1DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth1CreditAmount := VerMonth1CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth1EndDate;
                            ObjStatementB."Transaction Description" := 'Month 1 Transactions';
                            ObjStatementB."Amount Out" := VerMonth1DebitAmount;
                            ObjStatementB."Amount In" := VerMonth1CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;


                        //Month 2
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth2Date := Date2dmy(StatementStartDate, 1);
                        VerMonth2Month := (VerMonth1Month + 1);
                        VerMonth2Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth2Month > 12 then begin
                            VerMonth2Month := VerMonth2Month - 12;
                            VerMonth2Year := VerMonth2Year + 1;
                        end;

                        VerMonth2StartDate := Dmy2date(1, VerMonth2Month, VerMonth1Year);
                        VerMonth2EndDate := CalcDate('CM', VerMonth2StartDate);
                        VarMonth2Datefilter := Format(VerMonth2StartDate) + '..' + Format(VerMonth2EndDate);
                        VerMonth2CreditAmount := 0;
                        VerMonth2DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth2Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth2DebitAmount := VerMonth2DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth2CreditAmount := VerMonth2CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth2EndDate;
                            ObjStatementB."Transaction Description" := 'Month 2 Transactions';
                            ObjStatementB."Amount Out" := VerMonth2DebitAmount;
                            ObjStatementB."Amount In" := VerMonth2CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;

                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        //Month 3
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth3Date := Date2dmy(StatementStartDate, 1);
                        VerMonth3Month := (VerMonth1Month + 2);
                        VerMonth3Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth3Month > 12 then begin
                            VerMonth3Month := VerMonth3Month - 12;
                            VerMonth3Year := VerMonth3Year + 1;
                        end;

                        VerMonth3StartDate := Dmy2date(1, VerMonth3Month, VerMonth3Year);
                        VerMonth3EndDate := CalcDate('CM', VerMonth3StartDate);
                        VarMonth3Datefilter := Format(VerMonth3StartDate) + '..' + Format(VerMonth3EndDate);
                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth3Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth3DebitAmount := VerMonth3DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth3CreditAmount := VerMonth3CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth3EndDate;
                            ObjStatementB."Transaction Description" := 'Month 3 Transactions';
                            ObjStatementB."Amount Out" := VerMonth3DebitAmount;
                            ObjStatementB."Amount In" := VerMonth3CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 4
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth4Date := Date2dmy(StatementStartDate, 1);
                        VerMonth4Month := (VerMonth1Month + 3);
                        VerMonth4Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth4Month > 12 then begin
                            VerMonth4Month := VerMonth4Month - 12;
                            VerMonth4Year := VerMonth4Year + 1;
                        end;

                        VerMonth4StartDate := Dmy2date(1, VerMonth4Month, VerMonth4Year);
                        VerMonth4EndDate := CalcDate('CM', VerMonth4StartDate);
                        VarMonth4Datefilter := Format(VerMonth4StartDate) + '..' + Format(VerMonth4EndDate);

                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth4Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth4DebitAmount := VerMonth4DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth4CreditAmount := VerMonth4CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth4EndDate;
                            ObjStatementB."Transaction Description" := 'Month 4 Transactions';
                            ObjStatementB."Amount Out" := VerMonth4DebitAmount;
                            ObjStatementB."Amount In" := VerMonth4CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 5
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth5Date := Date2dmy(StatementStartDate, 1);
                        VerMonth5Month := (VerMonth1Month + 4);
                        VerMonth5Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth5Month > 12 then begin
                            VerMonth5Month := VerMonth5Month - 12;
                            VerMonth5Year := VerMonth5Year + 1;
                        end;

                        VerMonth5StartDate := Dmy2date(1, VerMonth5Month, VerMonth5Year);
                        VerMonth5EndDate := CalcDate('CM', VerMonth5StartDate);
                        VarMonth5Datefilter := Format(VerMonth5StartDate) + '..' + Format(VerMonth5EndDate);

                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth5Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth5DebitAmount := VerMonth5DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth5CreditAmount := VerMonth5CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth5EndDate;
                            ObjStatementB."Transaction Description" := 'Month 5 Transactions';
                            ObjStatementB."Amount Out" := VerMonth5DebitAmount;
                            ObjStatementB."Amount In" := VerMonth5CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 6
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth6Date := Date2dmy(StatementStartDate, 1);
                        VerMonth6Month := (VerMonth1Month + 5);
                        VerMonth6Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth6Month > 12 then begin
                            VerMonth6Month := VerMonth6Month - 12;
                            VerMonth6Year := VerMonth6Year + 1;
                        end;

                        VerMonth6StartDate := Dmy2date(1, VerMonth6Month, VerMonth6Year);
                        VerMonth6EndDate := CalcDate('CM', VerMonth6StartDate);
                        VarMonth6Datefilter := Format(VerMonth6StartDate) + '..' + Format(VerMonth6EndDate);

                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", Rec."Statement Account");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth6Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat

                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth6DebitAmount := VerMonth6DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth6CreditAmount := VerMonth6CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := Rec."Loan  No.";
                            ObjStatementB."Transaction Date" := VerMonth6EndDate;
                            ObjStatementB."Transaction Description" := 'Month 6 Transactions';
                            ObjStatementB."Amount Out" := VerMonth6DebitAmount;
                            ObjStatementB."Amount In" := VerMonth6CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;

                        VerStatementAvCredits := 0;
                        //Get Statement Avarage Credits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."Loan  No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'<%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementAvCredits := VerStatementAvCredits + ObjStatementB."Amount In";
                                Rec."Bank Statement Avarage Credits" := VerStatementAvCredits / 6;
                                Rec.Modify;
                            until ObjStatementB.Next = 0;
                        end;

                        VerStatementsAvDebits := 0;
                        //Get Statement Avarage Debits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", Rec."Loan  No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'>%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementsAvDebits := VerStatementsAvDebits + ObjStatementB."Amount Out";
                                Rec."Bank Statement Avarage Debits" := VerStatementsAvDebits / 6;
                                Rec.Modify;
                            until ObjStatementB.Next = 0;
                        end;

                        Rec."Bank Statement Net Income" := Rec."Bank Statement Avarage Credits" - Rec."Bank Statement Avarage Debits";
                        Rec.Modify;
                    end;
                }

                action("Loans Top Up")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Top Up';
                    Image = AddAction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loan Offset Detail List";
                    RunPageLink = "Loan No." = field("Loan  No."),
                                  "Client Code" = field("Client Code");
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    //Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This transaction is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                        Workflowintegration: Codeunit WorkflowIntegration;
                    begin

                        if Rec."Approved Amount" = 0 then Error('Kindly appraise your loan application before sending approval request');
                        if Rec."Loan Product Type" <> 'QF' then begin
                            Rec.TestField("Loan Product Type");
                            Rec.TestField("Recovery Mode");
                            Rec.TestField("Notify Guarantor SMS", true);
                            //  Rec.TestField("Mode of Disbursement");
                        end;


                        LoanGuar.Reset;
                        LoanGuar.SetRange("Loan No", Rec."Loan  No.");
                        if LoanGuar.Find('-') then begin
                            if LoanType.Get(Rec."Loan Product Type") then begin
                                if LoanGuar.Count < LoanType."Min No. Of Guarantors" then
                                    Error('You must capture atleast ' + Format(LoanType."Min No. Of Guarantors") + ' for ' + Rec."Loan Product Type");
                            end;
                        end;


                        if Rec."Approval Status" <> Rec."approval status"::Open then
                            Error(Text001);

                        //End allocate batch number
                        Doc_Type := Doc_type::LoanApplication;
                        Table_id := Database::"Loans Register";
                        Rec.TestField("Sector Specific");
                        if Workflowintegration.CheckLoanApplicationApprovalsWorkflowEnabled(Rec) then
                            Workflowintegration.OnSendLoanApplicationForApproval(Rec);
                        Rec.TestField("Requested Amount");

                        Rec.TestField("Requested Amount");
                        CurrPage.Close;
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
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalMgt.SendLoanApprRequest(Rec);
                        if Confirm('Are you sure you want to cancel the approval request', false) = true then begin
                            Rec."Loan Status" := Rec."loan status"::Application;
                            Rec."Approval Status" := Rec."approval status"::Open;
                            //ApprovalsMgmt.OnCancelLoanApplicationApprovalRequest(Rec);
                            Rec.Modify;
                        end;
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
                        ApprovalEntries.Setrecordfilters(Database::"Loans Register", DocumentType, Rec."Loan  No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("CRB Check Charge")
                {
                    ApplicationArea = Basic;
                    Image = Calculate;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "CRB Check Charge List";
                    RunPageLink = "Member No" = field("Client Code"),
                                  "Loan No" = field("Loan  No.");
                }
                action("Notify Guarantors")
                {
                    ApplicationArea = Basic;
                    Caption = 'Notify Guarantors';
                    Image = Archive;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    var
                        paybill: Codeunit "AU Paybill Automations";
                    begin
                        //SFactory.FnGenerateLoanRepaymentSchedule("Loan  No.");
                        compinfo.get();
                        LoanApp.reset;
                        LoanApp.SetRange(loanapp."Loan  No.", Rec."Loan  No.");
                        if loanapp.Find('-') then begin
                            LoanGuar.Reset();
                            LoanGuar.setrange("Loan No", LoanApp."Loan  No.");
                            if LoanGuar.findset then begin
                                repeat
                                    CustomerRecord.Reset();
                                    CustomerRecord.Setrange("No.", LoanGuar."Member No");
                                    if CustomerRecord.find('-') then begin
                                        SMSMessage.Reset;
                                        if SMSMessage.Find('+') then begin
                                            iEntryNo := SMSMessage."Entry No";
                                            iEntryNo := iEntryNo + 1;
                                        end
                                        else begin
                                            iEntryNo := 1;
                                        end;

                                        SMSMessage."SMS Message" := 'Dear Member' + ',' + 'You have guaranteed ' + Format(Rec."Client Name")
                                        + ' ' + Rec."Loan Product Type" + ' of KES. ' + Format(Rec."Approved Amount") + ',' + ' ' + 'Call,' + '' + compinfo."Phone No." + ',if in dispute.' + ' ' + compinfo.Name;// + ' ' + GenSetUp."Customer Care No";


                                        SmsManagement.SendSmsResponse(CustomerRecord."Mobile Phone No", 'Dear Member' + ',' + 'You have guaranteed ' + Format(Rec."Client Name")
                                          + ' ' + Rec."Loan Product Type Name" + ' ' + ' of KES. ' + Format(Rec."Approved Amount") + ' ' + 'having commited Deposits of' + ' ' + Format(LoanGuar."Amont Guaranteed") + ' ' + 'Call,' + '' + Format(compinfo."Phone No.") + ',if in dispute.' + ' ' + compinfo.Name);//+ ' ' + GenSetUp."Customer Care No");

                                    end

                                until LoanGuar.next() = 0
                            end;
                            if CustomerRecord.Get(Rec."Client Code") then begin
                                SmsManagement.SendSmsResponse(CustomerRecord."Mobile Phone No", 'Dear ' + paybill.SplitString(Rec."Client Name", ' ') + ', your  ' + Rec."Loan Product Type Name" + ' of amount Kshs. ' + format(Rec."Requested Amount") + ' been received and is being processed. Thank you for choosing Utabibu sacco.')
                            end;

                            LoanApp."Notify Guarantor SMS" := true;
                            LoanApp.modify;

                        end;
                        Message('Guarantors have been notified sucessfully.');
                    end;

                }
                action("Archive Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Archive Loan';
                    Image = Archive;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        //  SFactory.FnGenerateLoanRepaymentSchedule("Loan  No.");
                        LoanApp.reset;
                        LoanApp.SetRange(loanapp."Loan  No.", Rec."Loan  No.");
                        if loanapp.Find('-') then begin
                            LoanApp."Archive Loan" := true;
                            LoanApp.modify;
                            //Report.Run(80014, true, false, LoanApp);
                        end
                    end;

                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        EnableCreateMember := false;
        EditableAction := true;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec."Approval Status" = Rec."approval status"::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec."Approval Status" = Rec."approval status"::Approved) then
            EnableCreateMember := true;

        if Rec."Approval Status" <> Rec."approval status"::Open then
            EditableAction := false;
        if Rec."Approval Status" = Rec."approval status"::Pending then
            CanCancelApprovalForRecord := true; //to correct
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.Source := Rec.Source::BOSA;
        FnVisibility();

        TrunchDetailsVisible := false;

        if (Rec."Disburesment Type" = Rec."disburesment type"::"Full/Single disbursement") or (Rec."Disburesment Type" = Rec."disburesment type"::" ") then begin
            TrunchDetailsVisible := false;
        end else
            TrunchDetailsVisible := true;

        If Rec."Committee Approval" = Rec."Committee Approval"::Approved then begin
            StyleExprTxt := 'Favorable'
        end

        else
            StyleExprTxt := 'Unfavorable';


    end;

    trigger OnModifyRecord(): Boolean
    begin
        LoanAppPermisions();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Source := Rec.Source::BOSA;
        Rec."Mode of Disbursement" := Rec."mode of disbursement"::" ";
        Rec.Discard := true;
        LoansR.reset;
        LoansR.SetRange(LoansR."Captured By", UserId);
        LoansR.Setrange("Loan Status", LoansR."Loan Status"::Application);
        if LoansR.Find('-') Then begin
            if LoansR.Count > 2 then begin
                if LoansR."Loan  No." = '' then
                    Error('There are still some Unused member Nos. Please utilise them first');
            end;
        end;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        if Rec."Loan Status" = Rec."loan status"::Disbursed then
            CurrPage.Editable := false;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange(Posted, false);

        FnVisibility();
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
        RunningDate: Date;
        G: Integer;
        LoanGuar: Record "Loans Guarantee Details";
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        Vend1: Record Vendor;
        InstalmentEnddate: Date;
        SMSMessage: Record "SMS Messages";
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        SMSMessages: Record "SMS Messages";
        NoOfGracePeriod: Integer;
        iEntryNo: Integer;
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
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        TotalTopupComm: Decimal;
        RepaymentMent: Decimal;
        CustE: Record Customer;
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Register";
        SpecialComm: Decimal;
        FOSAName: Text[150];
        IDNo: Code[50];
        MovementTracker: Record "File Movement Tracker";
        DiscountingAmount: Decimal;
        StatusPermissions: Record "Status Change Permision";
        BridgedLoans: Record "Loan Offset Details";
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
        LBatches: Record "Loan Disburesment-Batching";
        SalDetails: Record "Loan Appraisal Salary Details";
        LGuarantors: Record "Loan GuarantorsFOSA";
        DocumentType: Enum "Document Type";
        //DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
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
        Interrest: Boolean;
        InterestSal: Decimal;
        EndMonth: Date;
        RemainingDays: Integer;
        PrincipalRepay: Decimal;
        InterestRepay: Decimal;
        TMonthDays: Integer;
        ReceiptAllocations: Record "HISA Allocation";
        ReceiptAllocation: Record "HISA Allocation";
        ApprovalEntry: Record "Approval Entry";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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
        GrossPay: Decimal;
        FOSASet: Record "FOSA Guarantors Setup";
        MinGNo: Integer;
        ProvidedGuarantors: Integer;
        LoansRec: Record "Loans Register";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        EditableAction: Boolean;
        SFactory: Codeunit "Au Factory";

        SmsManagement: Codeunit "Sms Management";
        compinfo: Record "Company Information";
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
        DisbursmentDate: Boolean;
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
        ObjMemberCellG: Record "Member House Groups";
        TrunchDetailsVisible: Boolean;
        AccountNoEditable: Boolean;
        Remarkseditable: Boolean;
        LoanPurposeEditable: Boolean;
        CopyofIDEditable: Boolean;
        CopyofPayslipEditable: Boolean;
        RejectionRemarkEditable: Boolean;
        RecoveryModeEditable: Boolean;
        StyleExpr: Text[2048];
        Text001: label 'Status Must Be Open';
        LoanAppMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your Loan Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        SMSMessageText: label 'Your loan application of KSHs.%1 has been received and your qualification is KSHs.%2 The application is being processed.%3.';
        ErrorApproval: label 'Approved Amount of Zero or Less Can not be sent for Approval';
        RejectionDetailsVisible: Boolean;
        ObjLoanStages: Record "Loan Stages";
        ObjLoanApplicationStages: Record "Loan Application Stages";
        ErrorPostingAccount: label 'Specify the Loan Disburesment Account';


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


    procedure FnSendReceivedApplicationSMS()
    begin

        GenSetUp.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := Rec."Batch No.";
        SMSMessage."Document No" := Rec."Loan  No.";
        SMSMessage."Account No" := Rec."Account No";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'LOANAPP';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member, Your Loan of amount ' + Format(Rec."Requested Amount") + ' for ' +
        Rec."Client Code" + ' ' + Rec."Client Name" + ' has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        Cust.Reset;
        Cust.SetRange(Cust."No.", Rec."Client Code");
        if Cust.Find('-') then begin
            SMSMessage."Telephone No" := Cust."Mobile Phone No";
        end;
        if Cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FnSendReceivedLoanApplEmail(LoanNo: Code[20])
    var
        LoanRec: Record "Loans Register";
        //  SMTPMail: Codeunit "SMTP Mail";
        // SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        Email: Text[50];
        Recipient: List of [Text];
    begin
        //  SMTPSetup.Get();

        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Loan  No.", LoanNo);
        if LoanRec.Find('-') then begin
            if Cust.Get(LoanRec."Client Code") then begin
                Email := Cust."E-Mail (Personal)";
                if Cust."E-Mail (Personal)" <> '' then begin

                    if Email = '' then begin
                        Error('Email Address Missing for LoanRecer Application number' + '-' + LoanRec."Loan  No.");
                    end;
                    // if Email <> '' then
                    //     Recipient.Add(Email);
                    // SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Recipient, 'Loan Application', '', true);
                    // SMTPMail.AppendBody(StrSubstNo(LoanAppMessage, LoanRec."Client Name", IDNo, UserId));
                    // SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                    // SMTPMail.AppendBody('<br><br>');
                    // SMTPMail.AddAttachment(FileName, Attachment);
                    // SMTPMail.Send;
                end;
            end;
        end;
    end;

    local procedure FnSendGuarantorAppSMS(LoanNo: Code[20])
    var
        Cust: Record Customer;
        Sms: Record "SMS Messages";

    begin
        LGuarantors.Reset;
        LGuarantors.SetRange(LGuarantors."Loan No", Rec."Loan  No.");
        if LGuarantors.FindFirst then begin
            repeat
                if Cust.Get(LGuarantors."Account No.") then
                    if Cust."Mobile Phone No" <> '' then


                        //SMS MESSAGE
                        SMSMessage.Reset;
                if SMSMessage.Find('+') then begin
                    iEntryNo := SMSMessage."Entry No";
                    iEntryNo := iEntryNo + 1;
                end
                else begin
                    iEntryNo := 1;
                end;


                SMSMessage.Init;
                SMSMessage."Entry No" := iEntryNo;
                SMSMessage."Batch No" := Rec."Batch No.";
                SMSMessage."Document No" := Rec."Loan  No.";
                SMSMessage."Account No" := Rec."Account No";
                SMSMessage."Date Entered" := Today;
                SMSMessage."Time Entered" := Time;
                SMSMessage.Source := 'GUARANTORSHIP';
                SMSMessage."Entered By" := UserId;
                SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                SMSMessage."SMS Message" := 'Dear Member,You have guaranteed ' + Format(Rec."Client Name")
                + ' ' + Rec."Loan Product Type" + ' of KES. ' + Format(Rec."Approved Amount") + ',' + ' ' + 'Call,' + ' ' + compinfo."Phone No." + ',if in dispute .' + ' ' + compinfo.Name + ' ' + GenSetUp."Customer Care No";
                Cust.Reset;
                Cust.SetRange(Cust."No.", Rec."Client Code");
                if Cust.Find('-') then begin
                    SMSMessage."Telephone No" := Cust."Mobile Phone No";
                end;
                if Cust."Mobile Phone No" <> '' then
                    SMSMessage.Insert;

            until LGuarantors.Next = 0;
        end
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

    local procedure FnRunCreateLoanStages()
    var
        ObjLoanStages: Record "Loan Stages";
        ObjLoanApplicationStages: Record "Loan Application Stages";
        ObjLoanGuarantors: Record "Loans Guarantee Details";
        ObjLoanCollateral: Record "Loan Collateral Details";
    begin
        ObjLoanApplicationStages.Reset;
        ObjLoanApplicationStages.SetRange("Loan No", Rec."Loan  No.");
        if ObjLoanApplicationStages.FindSet then begin
            ObjLoanApplicationStages.DeleteAll;
        end;

        //=========================================================================================Loan Stages Based On Amount
        ObjLoanStages.Reset;
        ObjLoanStages.SetRange("Mobile App Specific", false);
        if ObjLoanStages.Find('-') then begin
            repeat
                if (Rec."Requested Amount" >= ObjLoanStages."Min Loan Amount") and (Rec."Requested Amount" <= ObjLoanStages."Max Loan Amount") then begin

                    ObjLoanApplicationStages.Init;
                    ObjLoanApplicationStages."Loan No" := Rec."Loan  No.";
                    ObjLoanApplicationStages."Member No" := Rec."Client Code";
                    ObjLoanApplicationStages."Member Name" := Rec."Client Name";
                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                    ObjLoanApplicationStages.Insert;
                end;
            until ObjLoanStages.Next = 0;
        end;

        //=========================================================================================Loan Stages Based On Group Guarantorship
        ObjLoanGuarantors.Reset;
        ObjLoanGuarantors.SetRange(ObjLoanGuarantors."Loan No", Rec."Loan  No.");
        if ObjLoanGuarantors.Find('-') = true then begin
            if Rec."Member House Group" <> '' then begin
                ObjLoanStages.Reset;
                ObjLoanStages.SetRange("Mobile App Specific", false);
                ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::"Group Guarantorship");
                if ObjLoanStages.FindSet then begin
                    repeat
                        ObjLoanApplicationStages.Init;
                        ObjLoanApplicationStages."Loan No" := Rec."Loan  No.";
                        ObjLoanApplicationStages."Member No" := Rec."Client Code";
                        ObjLoanApplicationStages."Member Name" := Rec."Client Name";
                        ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                        ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                        ObjLoanApplicationStages.Insert;
                    until ObjLoanStages.Next = 0;
                end;
            end;
        end;

        //=========================================================================================Loan Stages Based On Collateral Security
        ObjLoanCollateral.Reset;
        ObjLoanCollateral.SetRange(ObjLoanCollateral."Loan No", Rec."Loan  No.");
        if ObjLoanCollateral.Find('-') = true then begin

            ObjLoanStages.Reset;
            ObjLoanStages.SetRange("Mobile App Specific", false);
            ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::"Collateral Security");
            if ObjLoanStages.FindSet then begin
                repeat
                    ObjLoanApplicationStages.Init;
                    ObjLoanApplicationStages."Loan No" := Rec."Loan  No.";
                    ObjLoanApplicationStages."Member No" := Rec."Client Code";
                    ObjLoanApplicationStages."Member Name" := Rec."Client Name";
                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                    ObjLoanApplicationStages.Insert;
                until ObjLoanStages.Next = 0;
            end;
        end;

        //=========================================================================================Loan Stages Common On All Applications
        ObjLoanStages.Reset;
        ObjLoanStages.SetRange("Mobile App Specific", false);
        ObjLoanStages.SetFilter("Loan Purpose", '=%1', '');
        ObjLoanStages.SetRange(ObjLoanStages."Loan Security Applicable", ObjLoanStages."loan security applicable"::All);
        ObjLoanStages.SetFilter("Min Loan Amount", '=%1', 0);
        if ObjLoanStages.FindSet then begin
            repeat
                ObjLoanApplicationStages.Init;
                ObjLoanApplicationStages."Loan No" := Rec."Loan  No.";
                ObjLoanApplicationStages."Member No" := Rec."Client Code";
                ObjLoanApplicationStages."Member Name" := Rec."Client Name";
                ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                ObjLoanApplicationStages.Insert;
            until ObjLoanStages.Next = 0;
        end;

        //=========================================================================================Loan Stages Based On Education Finance
        if Rec."Loan Purpose" <> '' then begin
            ObjLoanStages.Reset;
            ObjLoanStages.SetRange("Mobile App Specific", false);
            ObjLoanStages.SetFilter("Loan Purpose", '<>%1', '');
            ObjLoanStages.SetRange(ObjLoanStages."Loan Purpose", Rec."Loan Purpose");
            if ObjLoanStages.FindSet then begin
                repeat
                    ObjLoanApplicationStages.Init;
                    ObjLoanApplicationStages."Loan No" := Rec."Loan  No.";
                    ObjLoanApplicationStages."Member No" := Rec."Client Code";
                    ObjLoanApplicationStages."Member Name" := Rec."Client Name";
                    ObjLoanApplicationStages."Loan Stage" := ObjLoanStages."Loan Stage";
                    ObjLoanApplicationStages."Loan Stage Description" := ObjLoanStages."Loan Stage Description";
                    ObjLoanApplicationStages.Insert;
                until ObjLoanStages.Next = 0;
            end;
        end;
    end;

    procedure StyleExpession() StyleExprTxt: Text[20];
    var
        myInt: Integer;

    begin
        If Rec."Committee Approval" = Rec."Committee Approval"::Approved then begin
            StyleExprTxt := 'Favorable'
        end

        else
            StyleExprTxt := 'Unfavorable';

        exit(StyleExprTxt);
    end;

    var
        StyleExprTxt: Text;

}