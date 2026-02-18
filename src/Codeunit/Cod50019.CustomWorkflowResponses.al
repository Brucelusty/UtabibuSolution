//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50019 "Custom Workflow Responses"
{

    trigger OnRun()
    begin
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        SurestepWFEvents: Codeunit "Custom Workflow Events";
        WFResponseHandler: Codeunit "Workflow Response Handling";


    procedure AddResponsesToLib()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', false, false)]

    procedure AddResponsePredecessors()
    begin

        //Payment Header
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPaymentDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPaymentDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPaymentDocForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPaymentApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPaymentApprovalRequestCode);

        //Membership Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMembershipApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMembershipApplicationApprovalRequestCode);
        //Loan Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanApplicationApprovalRequestCode);

        //Employee Requisition
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHREmployeeRequisitionForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHREmployeeRequisitionForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHREmployeeRequisitionForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHREmployeeRequisitionRequestCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHREmployeeRequisitionRequestCode());

        //Training  Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHRTrainingForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHRTrainingForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHRTrainingForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHRTrainingRequestCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHRTrainingRequestCode());

        //Guarantor Substitution
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorSubstitutionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelGuarantorSubstitutionApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelGuarantorSubstitutionApprovalRequestCode);

        //Loan Disbursement
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanDisbursementApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanDisbursementApprovalRequestCode);



        //Standing Order
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStandingOrderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStandingOrderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStandingOrderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStandingOrderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStandingOrderApprovalRequestCode);

        //Membership Withdrawal
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMWithdrawalApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMWithdrawalApprovalRequestCode);

        //ATM Card Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendATMCardForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelATMCardApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelATMCardApprovalRequestCode);

        //Guarantor Recovery
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendGuarantorRecoveryForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelGuarantorRecoveryApprovalRequestCode);

        //Change Request
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChangeRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChangeRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChangeRequestForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChangeRequestApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChangeRequestApprovalRequestCode);
        //boardpayment
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                     SurestepWFEvents.RunWorkflowOnSendboardpaymentForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendboardpaymentForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendboardpaymentForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelboardpaymentApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelboardpaymentApprovalRequestCode);
        //Treasury Transactions
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendTTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendTTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendTTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelTTransactionsApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelTTransactionsApprovalRequestCode);


        //FOSA Account Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFAccountApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFAccountApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFAccountApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFAccountApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFAccountApplicationApprovalRequestCode);



        //Stores Requisition

        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSReqApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSReqApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSReqApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSReqApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSReqApplicationApprovalRequestCode);

        //Sacco Transfer
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSaccoTransferForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSaccoTransferForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSaccoTransferForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSaccoTransferApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSaccoTransferApprovalRequestCode);
        //Cheque Discounting
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeDiscountingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChequeDiscountingApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChequeDiscountingApprovalRequestCode);

        //Imprest Requisition
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestRequisitionForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelImprestRequisitionApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelImprestRequisitionApprovalRequestCode);

        //Imprest Surrender
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendImprestSurrenderForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelImprestSurrenderApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelImprestSurrenderApprovalRequestCode);

        //Leave Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLeaveApplicationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLeaveApplicationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLeaveApplicationApprovalRequestCode);
        //Bulk Withdrawal
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendBulkWithdrawalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelBulkWithdrawalApprovalRequestCode);

        //Package Lodge
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageLodgeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageLodgeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageLodgeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPackageLodgeApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPackageLodgeApprovalRequestCode);

        //Package Retrieval
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageRetrievalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageRetrievalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPackageRetrievalForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPackageRetrievalApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPackageRetrievalApprovalRequestCode);

        //House Change
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHouseChangeApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHouseChangeApprovalRequestCode);

        //CRM Training
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendCRMTrainingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendCRMTrainingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendCRMTrainingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelCRMTrainingApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelCRMTrainingApprovalRequestCode);

        //Petty Cash
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPettyCashForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPettyCashForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendPettyCashForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPettyCashApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelPettyCashApprovalRequestCode);

        //Staff Claims
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendStaffClaimsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStaffClaimsApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelStaffClaimsApprovalRequestCode);

        //Member Agent/NOK Change
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendMemberAgentNOKChangeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelMemberAgentNOKChangeApprovalRequestCode);

        //House Registration
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendHouseRegistrationForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHouseRegistrationApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelHouseRegistrationApprovalRequestCode);

        //Loan Payoff
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanPayOffForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanPayOffApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanPayOffApprovalRequestCode);

        //Fixed Deposit
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendFixedDepositForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFixedDepositApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelFixedDepositApprovalRequestCode);

        //EFT/RTGS
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendEFTRTGSForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendEFTRTGSForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendEFTRTGSForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelEFTRTGSApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelEFTRTGSApprovalRequestCode);

        //LOAN DEMAND NOTICE
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendDemandNoticeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendDemandNoticeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendDemandNoticeForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCanceDemandNoticeApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCanceDemandNoticeApprovalRequestCode);

        //OVER DRAFT
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendOverDraftForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendOverDraftForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendOverDraftForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelOverDraftApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelOverDraftApprovalRequestCode);

        //Loan Restructure
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanRestructureForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanRestructureForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanRestructureForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanRestructureApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanRestructureApprovalRequestCode);

        //Sweeping Instructions
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSweepingInstructionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSweepingInstructionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSweepingInstructionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSweepingInstructionsApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSweepingInstructionsApprovalRequestCode);

        //Cheque Book Application
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeBookForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeBookForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendChequeBookForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChequeBookApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelChequeBookApprovalRequestCode);

        //Loan Trunch
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendLoanTrunchDisbursementForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelLoanTrunchDisbursementApprovalRequestCode);

        //Inward Cheque Clearing
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInwardChequeClearingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInwardChequeClearingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInwardChequeClearingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInwardChequeClearingApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInwardChequeClearingApprovalRequestCode);

        //Invalid Paybill Transactions
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInvalidPaybillTransactionsForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInvalidPaybillTransactionsApprovalRequestCode);


        //Internal PV
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInternalPVForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInternalPVForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendInternalPVForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInternalPVApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelInternalPVApprovalRequestCode);

        //Salary Processing
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSalaryProcessingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSalaryProcessingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendSalaryProcessingForApprovalCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSalaryProcessingApprovalRequestCode);
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelSalaryProcessingApprovalRequestCode);
        //JO APPLICATION
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SetStatusToPendingApprovalCode,
                                                     SurestepWFEvents.RunWorkflowOnSendJobApplicationForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CreateApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnSendJobApplicationForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.SendApprovalRequestForApprovalCode,
                                                 SurestepWFEvents.RunWorkflowOnSendJobApplicationForApprovalCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.OpenDocumentCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelJobApplicationApprovalRequestCode());
        WFResponseHandler.AddResponsePredecessor(WFResponseHandler.CancelAllApprovalRequestsCode,
                                                 SurestepWFEvents.RunWorkflowOnCancelJobApplicationApprovalRequestCode());

        //-----------------------------End AddOn--------------------------------------------------------------------------------------
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', true, true)]
    procedure SetStatusToPendingApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        IsHandled: Boolean;
        PaymentHeader: Record "Payments Header";
        MembershipApplication: Record "Membership Applications";
        LoanApplication: Record "Loans Register";
        LoanDisbursement: Record "Loan Disburesment-Batching";
        StandingOrder: Record "Standing Orders";
        MWithdrawal: Record "Membership Exist";
        ATMCard: Record "ATM Card Applications";
        GuarantorR: Record "Loan Recovery Header";
        ChangeRequest: Record "Change Request";
        Boardpayment: Record "Boad Payments Allowance";
        TTransactions: Record "Treasury Transactions";
        FAccount: Record "FOSA Account Applicat. Details";
        SReq: Record "Store Requistion Header";
        SaccoTransfers: Record "Sacco Transfers";
        ChequeDiscounting: Record "Cheque Discounting";
        ImprestRequisition: Record "Imprest Header";
        ImprestSurrender: Record "Imprest Surrender Header";
        LeaveApplication: Record "HR Leave Application";
        BulkWithdrawal: Record "Bulk Withdrawal Application";
        PackageLodge: Record "Safe Custody Package Register";
        PackageRetrieval: Record "Package Retrieval Register";
        HouseChange: Record "House Group Change Request";
        CRMTraining: Record "CRM Trainings";
        PettyCash: Record "Payment Header.";
        StaffClaims: Record "Staff Claims Header";
        MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang";
        HouseRegistration: Record "House Groups Registration";
        LoanPayOff: Record "Loan PayOff";
        FixedDeposit: Record "Fixed Deposit Placement";
        EFTRTGS: Record "EFT/RTGS Header";
        LDemand: Record "Default Notices Register";
        OverDraft: Record "OverDraft Application";
        LoanRestructure: Record "Loan Restructure";
        SweepingInstructions: Record "Member Sweeping Instructions";
        ChequeBook: Record "Cheque Book Application";
        LoanTrunch: Record "Loan trunch Disburesment";
        InwardChequeClearing: Record "Cheque Receipts-Family";
        InvalidPaybillTransactions: Record "Paybill Processing Header";
        InternalPV: Record "Internal PV Header";
        JournalBatch: Record "Gen. Journal Batch";
        SProcessing: Record "Salary Processing Headerr";
        // PaymentHeader: Record "Payments Header";
        HRJOBS: Record "HR Jobss";
        GuarantorshipSubstitution: Record "Guarantorship Substitution H";
        HREmployeeRequisitions: Record "HR Employee Requisitions";
        HRTrainingApplications: Record "HR Training Applications";
    begin
        case RecRef.Number of
            //Payment Header
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    PaymentHeader.Validate(Status, PaymentHeader.Status::"Pending Approval");
                    PaymentHeader.Modify(true);
                    Variant := PaymentHeader;
                end;
            //HR JOBS 
            Database::"HR Jobss":
                begin
                    RecRef.SetTable(HRJOBS);
                    HRJOBS.Validate(Status, HRJOBS.Status::"Pending Approval");
                    HRJOBS.Modify(true);
                    Variant := HRJOBS;
                end;
            //hr training
            Database::"HR Training Applications":
                begin
                    RecRef.SetTable(HRTrainingApplications);
                    HRTrainingApplications.Validate(Status, HRTrainingApplications.Status::"Pending Approval");
                    HRTrainingApplications.Modify(true);
                    Variant := HRTrainingApplications;
                end;
            //hr employee requisition
            Database::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HREmployeeRequisitions);
                    HREmployeeRequisitions.Validate(Status, HREmployeeRequisitions.Status::"Pending Approval");
                    HREmployeeRequisitions.Modify(true);
                    Variant := HREmployeeRequisitions;
                end;

            //Membership Application
            Database::"Membership Applications":
                begin
                    //  Message('we here');
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate(Status, MembershipApplication.Status::"Pending Approval");
                    MembershipApplication.Modify(true);
                    Variant := MembershipApplication;
                end;
            //Loan Application
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoanApplication);
                    LoanApplication.Validate("Loan Status", LoanApplication."loan status"::Appraisal);
                    LoanApplication.Validate("Approval Status", LoanApplication."approval status"::Pending);
                    LoanApplication.Modify(true);
                    Variant := LoanApplication;
                end;
            //Guarantor substitutionn
            Database::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorshipSubstitution);
                    GuarantorshipSubstitution.Validate(Status, GuarantorshipSubstitution.Status::Pending);
                    GuarantorshipSubstitution.Modify;
                    Variant := GuarantorshipSubstitution;
                end;
            //Standing Order
            Database::"Standing Orders":
                begin
                    RecRef.SetTable(StandingOrder);
                    StandingOrder.Validate(Status, StandingOrder.Status::Pending);
                    StandingOrder.Modify(true);
                    Variant := StandingOrder;
                end;

            //Loan Disbursement
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanDisbursement);
                    LoanDisbursement.Validate(Status, LoanDisbursement.Status::"Pending Approval");
                    LoanDisbursement.Modify(true);
                    Variant := LoanDisbursement;
                end;

            //Membership Withdrawal
            Database::"Membership Exist":
                begin
                    RecRef.SetTable(MWithdrawal);
                    MWithdrawal.Validate(Status, MWithdrawal.Status::Pending);
                    MWithdrawal.Modify(true);
                    Variant := MWithdrawal;
                end;

            //ATM Card
            Database::"ATM Card Applications":
                begin
                    RecRef.SetTable(ATMCard);
                    ATMCard.Validate(Status, ATMCard.Status::Pending);
                    ATMCard.Modify(true);
                    Variant := ATMCard;
                end;

            //Guarantor Recovery
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(GuarantorR);
                    GuarantorR.Validate(Status, GuarantorR.Status::Pending);
                    GuarantorR.Modify(true);
                    Variant := GuarantorR;
                end;

            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Validate("Approval Status", ChangeRequest."Approval Status"::Pending);
                    ChangeRequest.Modify(true);
                    Variant := ChangeRequest;
                end;
            //boardpayment
            Database::"Boad Payments Allowance":
                begin
                    RecRef.SetTable(Boardpayment);
                    ChangeRequest.Validate("Approval Status", Boardpayment.Status::Pending);
                    ChangeRequest.Modify(true);
                    Variant := Boardpayment;
                end;

            //Treasury Transaction
            Database::"Treasury Transactions":
                begin
                    RecRef.SetTable(TTransactions);
                    TTransactions.Validate(Status, TTransactions.Status::"Pending Approval");
                    TTransactions.Modify(true);
                    Variant := TTransactions;
                end;
            //FOSA Account Application
            Database::"FOSA Account Applicat. Details":
                begin
                    RecRef.SetTable(FAccount);
                    FAccount.Validate(Status, FAccount.Status::Pending);
                    FAccount.Modify(true);
                    Variant := FAccount;
                end;

            //Stores Requisition
            Database::"Store Requistion Header":
                begin
                    RecRef.SetTable(SReq);
                    SReq.Validate(Status, SReq.Status::"Pending Approval");
                    SReq.Modify(true);
                    Variant := SReq;
                end;
            //Sacco Transfers
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Validate(Status, SaccoTransfers.Status::"Pending Approval");
                    SaccoTransfers.Modify(true);
                    Variant := SaccoTransfers;
                end;
            //Cheque Discounting
            Database::"Cheque Discounting":
                begin
                    RecRef.SetTable(ChequeDiscounting);
                    ChequeDiscounting.Validate(Status, ChequeDiscounting.Status::"Pending Approval");
                    ChequeDiscounting.Modify(true);
                    Variant := ChequeDiscounting;
                end;
            //Imprest Requisition
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ImprestRequisition.Validate(Status, ImprestRequisition.Status::"Pending Approval");
                    ImprestRequisition.Modify(true);
                    Variant := ImprestRequisition;
                end;
            //Imprest Surrender
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Validate(Status, ImprestSurrender.Status::"Pending Approval");
                    ImprestSurrender.Modify(true);
                    Variant := ImprestSurrender;
                end;
            //Leave Application
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Validate(Status, LeaveApplication.Status::"Pending Approval");
                    LeaveApplication.Modify(true);
                    Variant := LeaveApplication;
                end;
            //Bulk Withdrawal
            Database::"Bulk Withdrawal Application":
                begin
                    RecRef.SetTable(BulkWithdrawal);
                    BulkWithdrawal.Validate(Status, BulkWithdrawal.Status::"Pending Approval");
                    BulkWithdrawal.Modify(true);
                    Variant := BulkWithdrawal;
                end;
            //Package Lodge
            Database::"Safe Custody Package Register":
                begin
                    RecRef.SetTable(PackageLodge);
                    PackageLodge.Validate(Status, PackageLodge.Status::"Pending Approval");
                    PackageLodge.Modify(true);
                    Variant := PackageLodge;
                end;
            //Package Retrieval
            Database::"Package Retrieval Register":
                begin
                    RecRef.SetTable(PackageRetrieval);
                    PackageRetrieval.Validate(Status, PackageRetrieval.Status::"Pending Approval");
                    PackageRetrieval.Modify(true);
                    Variant := PackageRetrieval;
                end;

            //House Change
            Database::"House Group Change Request":
                begin
                    RecRef.SetTable(HouseChange);
                    HouseChange.Validate(Status, HouseChange.Status::"Pending Approval");
                    HouseChange.Modify(true);
                    Variant := HouseChange;
                end;

            //CRM
            Database::"CRM Trainings":
                begin
                    RecRef.SetTable(CRMTraining);
                    CRMTraining.Validate(Status, CRMTraining.Status::Pending);
                    CRMTraining.Modify(true);
                    Variant := CRMTraining;
                end;

            //Petty Cash
            Database::"Payment Header.":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Validate(Status, PettyCash.Status::"Pending Approval");
                    PettyCash.Modify(true);
                    Variant := PettyCash;
                end;

            //Staff Claims
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    StaffClaims.Validate(Status, StaffClaims.Status::"Pending Approval");
                    StaffClaims.Modify(true);
                    Variant := StaffClaims;
                end;

            //Member Agent/NOK Change
            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    MemberAgentNOKChange.Validate(Status, MemberAgentNOKChange.Status::"Pending Approval");
                    MemberAgentNOKChange.Modify(true);
                    Variant := MemberAgentNOKChange;
                end;

            //House Registration
            Database::"House Groups Registration":
                begin
                    RecRef.SetTable(HouseRegistration);
                    HouseRegistration.Validate(Status, HouseRegistration.Status::"Pending Approval");
                    HouseRegistration.Modify(true);
                    Variant := HouseRegistration;
                end;

            //Loan PayOff
            Database::"Loan PayOff":
                begin
                    RecRef.SetTable(LoanPayOff);
                    LoanPayOff.Validate(Status, LoanPayOff.Status::"Pending Approval");
                    LoanPayOff.Modify(true);
                    Variant := LoanPayOff;
                end;

            //Fixed Deposit
            Database::"Fixed Deposit Placement":
                begin
                    RecRef.SetTable(FixedDeposit);
                    FixedDeposit.Validate(Status, FixedDeposit.Status::"Pending Approval");
                    FixedDeposit.Modify(true);
                    Variant := FixedDeposit;
                end;

            //EFTRTGS
            Database::"EFT/RTGS Header":
                begin
                    RecRef.SetTable(EFTRTGS);
                    EFTRTGS.Validate(Status, EFTRTGS.Status::"Pending Approval");
                    EFTRTGS.Modify(true);
                    Variant := EFTRTGS;
                end;

            //Loan Demand Notices
            Database::"Default Notices Register":
                begin
                    RecRef.SetTable(LDemand);
                    LDemand.Validate(Status, LDemand.Status::"Pending Approval");
                    LDemand.Modify(true);
                    Variant := LDemand;
                end;

            //Over Draft
            Database::"OverDraft Application":
                begin
                    RecRef.SetTable(OverDraft);
                    OverDraft.Validate(Status, OverDraft.Status::"Pending Approval");
                    OverDraft.Modify(true);
                    Variant := OverDraft;
                end;

            //Loan Restructure
            Database::"Loan Restructure":
                begin
                    RecRef.SetTable(LoanRestructure);
                    LoanRestructure.Validate(Status, LoanRestructure.Status::"Pending Approval");
                    LoanRestructure.Modify(true);
                    Variant := LoanRestructure;
                end;

            //Sweeping Instructions
            Database::"Member Sweeping Instructions":
                begin
                    RecRef.SetTable(SweepingInstructions);
                    SweepingInstructions.Validate(Status, SweepingInstructions.Status::"Pending Approval");
                    SweepingInstructions.Modify(true);
                    Variant := SweepingInstructions;
                end;

            //Cheque Book Application
            Database::"Cheque Book Application":
                begin
                    RecRef.SetTable(ChequeBook);
                    ChequeBook.Validate(Status, ChequeBook.Status::"Pending Approval");
                    ChequeBook.Modify(true);
                    Variant := ChequeBook;
                end;


            //Loan Trunch
            Database::"Loan trunch Disburesment":
                begin
                    RecRef.SetTable(LoanTrunch);
                    LoanTrunch.Validate(Status, LoanTrunch.Status::"Pending Approval");
                    LoanTrunch.Modify(true);
                    Variant := LoanTrunch;
                end;

            //Inward Cheque Clearing
            Database::"Cheque Receipts-Family":
                begin
                    RecRef.SetTable(InwardChequeClearing);
                    InwardChequeClearing.Validate(Status, InwardChequeClearing.Status::"Pending Approval");
                    InwardChequeClearing.Modify(true);
                    Variant := InwardChequeClearing;
                end;

            //Invalid Paybill Transactions
            Database::"Paybill Processing Header":
                begin
                    RecRef.SetTable(InvalidPaybillTransactions);
                    InvalidPaybillTransactions.Validate(Status, InvalidPaybillTransactions.Status::"Pending Approval");
                    InvalidPaybillTransactions.Modify(true);
                    Variant := InvalidPaybillTransactions;
                end;

            //Internal PV
            Database::"Internal PV Header":
                begin
                    RecRef.SetTable(InternalPV);
                    InternalPV.Validate(Status, InternalPV.Status::"Pending Approval");
                    InternalPV.Modify(true);
                    Variant := InternalPV;
                end;

            //Journal Batch
            Database::"Gen. Journal Batch":
                begin
                    RecRef.SetTable(JournalBatch);
                    JournalBatch.Validate(Status, JournalBatch.Status::"Pending Approval");
                    JournalBatch.Modify(true);
                    Variant := JournalBatch;
                end;

            //Salary Processing
            Database::"Salary Processing Headerr":
                begin
                    RecRef.SetTable(SProcessing);
                    SProcessing.Validate(Status, SProcessing.Status::"Pending Approval");
                    SProcessing.Modify(true);
                    Variant := SProcessing;
                end;
        end;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PaymentHeader: Record "Payments Header";
        SaccoTransfers: Record "Sacco Transfers";
        ObjMembership: Record "Membership Applications";
        ObjLoans: Record "Loans Register";
        ObjLoanPayoff: Record "Loan PayOff";
        ObjLoanRestructure: Record "Loan Restructure";
        ObjSalaryProcessing: Record "Salary Processing Headerr";
        BulkWithdrawal: Record "Bulk Withdrawal Application";
        PackageLodge: Record "Safe Custody Package Register";
        PackageRetrieval: Record "Package Retrieval Register";
        HouseChange: Record "House Group Change Request";
        CRMTraining: Record "CRM Trainings";
        PettyCash: Record "Payment Header.";
        StaffClaims: Record "Staff Claims Header";
        MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang";
        HouseRegistration: Record "House Groups Registration";
        LoanPayOff: Record "Loan PayOff";
        FixedDeposit: Record "Fixed Deposit Placement";
        EFTRTGS: Record "EFT/RTGS Header";
        LDemand: Record "Default Notices Register";
        OverDraft: Record "OverDraft Application";
        LoanRestructure: Record "Loan Restructure";
        SweepingInstructions: Record "Member Sweeping Instructions";
        ChequeBook: Record "Cheque Book Application";
        LoanTrunch: Record "Loan trunch Disburesment";
        InwardChequeClearing: Record "Cheque Receipts-Family";
        InvalidPaybillTransactions: Record "Paybill Processing Header";
        InternalPV: Record "Internal PV Header";
        ObjStanding: Record "Standing Orders";
        ObjMembershipExit: Record "Membership Exist";
        ObjInternalTransfer: Record "Sacco Transfers";
        ObjChangeRequest: Record "Change Request";
        boardpayment: Record "Boad Payments Allowance";
        GuarantorshipSubstitution: Record "Guarantorship Substitution H";
        MembershipApp: Record "Membership Applications";
        LoanApplication: Record "Loans Register";
        StandingOrder: Record "Standing Orders";
        MWithdrawal: Record "Membership Exist";
        ImprestSurrender: Record "Imprest Surrender Header";
        ImprestRequisition: Record "Imprest Header";
        PRequest: Record "Purchase Header";
        GuarantorRecovery: Record "Loan Recovery Header";
        LeaveApplication: Record "HR Leave Application";
        HRJOBS: Record "HR Jobss";
        HREmployeeRequisitions: Record "HR Employee Requisitions";
        HRTA: Record "HR Training Applications";
        TreasuaryTransaction: Record "Treasury Transactions";
    begin
        case RecRef.Number of
            DATABASE::"Membership Applications":
                begin
                    RecRef.SetTable(MembershipApp);
                    MembershipApp.Status := MembershipApp.Status::Open;
                    MembershipApp.Modify(true);
                    Handled := true;
                end;


            DATABASE::"Treasury Transactions":
                begin
                    RecRef.SetTable(TreasuaryTransaction);
                    TreasuaryTransaction.Status := TreasuaryTransaction.Status::Open;
                    TreasuaryTransaction.Modify(true);
                    Handled := true;
                end;
            DATABASE::"HR Jobss":
                begin
                    RecRef.SetTable(HRJOBS);
                    HRJOBS.Status := HRJOBS.Status::New;
                    HRJOBS.Modify(true);
                    Handled := true;
                end;
            DATABASE::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HREmployeeRequisitions);
                    HREmployeeRequisitions.Status := HREmployeeRequisitions.Status::New;
                    HREmployeeRequisitions.Modify(true);
                    Handled := true;
                end;

            DATABASE::"HR Training Applications":
                begin
                    RecRef.SetTable(HRTA);
                    HRTA.Status := HRTA.Status::New;
                    HRTA.Modify(true);
                    Handled := true;
                end;
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Status := SaccoTransfers.Status::Open;
                    SaccoTransfers.Modify(true);
                    Handled := true;
                end;
            Database::"HR Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Status := LeaveApplication.Status::New;
                    LeaveApplication.Modify(true);
                    Handled := true;
                end;

            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    MemberAgentNOKChange.Status := MemberAgentNOKChange.Status::Open;
                    MemberAgentNOKChange.Modify(true);
                    Handled := true;
                end;
            Database::"House Groups Registration":
                begin
                    RecRef.SetTable(HouseRegistration);
                    HouseRegistration.Status := HouseRegistration.Status::Open;
                    HouseRegistration.Modify(true);
                    Handled := true;
                end;

            Database::"Loans Register":
                begin
                    RecRef.SetTable(LoanApplication);
                    LoanApplication."Approval Status" := LoanApplication."Approval Status"::Open;
                    LoanApplication.Modify(true);
                    Handled := true;
                end;
            Database::"Payment Header.":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Status := PettyCash.Status::New;
                    PettyCash.Modify(true);
                    Handled := true;
                end;
            Database::"Standing Orders":
                begin
                    RecRef.SetTable(StandingOrder);
                    StandingOrder.Status := StandingOrder.Status::Open;
                    StandingOrder.Modify(true);
                    Handled := true;
                end;
            Database::"Membership Exist":
                begin
                    RecRef.SetTable(MWithdrawal);
                    MWithdrawal.Status := MWithdrawal.Status::Open;
                    MWithdrawal.Modify(true);
                    Handled := true;
                end;
            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    StaffClaims.Status := StaffClaims.Status::Pending;
                    StaffClaims.Modify(true);
                    Handled := true;
                end;
            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Status := ImprestSurrender.Status::Open;
                    ImprestSurrender.Modify(true);
                    Handled := true;
                end;
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ImprestRequisition.Status := ImprestSurrender.Status::Open;
                    ImprestRequisition.Modify(true);
                    Handled := true;
                end;
            Database::"Purchase Header":
                begin
                    RecRef.SetTable(PRequest);
                    PRequest.Status := PRequest.Status::Open;
                    PRequest.Modify(true);
                    Handled := true;
                end;
            Database::"Loan PayOff":
                begin
                    RecRef.SetTable(LoanPayOff);
                    LoanPayOff.Status := LoanPayOff.Status::Open;
                    LoanPayOff.Modify(true);
                    Handled := true;
                end;
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(GuarantorRecovery);
                    GuarantorRecovery.Status := GuarantorRecovery.Status::Open;
                    GuarantorRecovery.Modify(true);
                    Handled := true;
                end;
        end

    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        MemberShipApp: Record "Membership Applications";
        SaccoTransfers: Record "Sacco Transfers";
        MemberAgentNOKChange: Record "Member Agent/Next Of Kin Chang";
        HouseRegistration: Record "House Groups Registration";
        LaonApplication: Record "Loans Register";
        PettyCash: Record "Payment Header.";
        StandingOrder: Record "Standing Orders";
        MWithdrawal: Record "Membership Exist";
        StaffClaims: Record "Staff Claims Header";
        ImprestSurrender: Record "Imprest Surrender Header";
        ImprestRequisition: Record "Imprest Header";
        PRequest: Record "Purchase Header";
        PaymentHeader: Record "Payments Header";
        LoanPayOff: Record "Loan PayOff";
        GuarantorRecovery: Record "Loan Recovery Header";
        LoanDisbursememnt: Record "Loan Disburesment-Batching";
        SalaryProcessingHeader: Record "Salary Processing Headerr";
        FosaAccountOpenning: Record "FOSA Account Applicat. Details";
        FAccount: Record "FOSA Account Applicat. Details";
        EFTRTGS: record "EFT/RTGS Header";
        LeaveApp: Record "HR Leave Application";
        ChangeRequest: Record "Change Request";
        boardpayment: Record "Boad Payments Allowance";
        HREmployeeRequisitions: Record "HR Employee Requisitions";
        GuarantorSubstitution: Record "Guarantorship Substitution H";
        HRJOBS: Record "HR Jobss";
        HRTrainingApplications: Record "HR Training Applications";
        TreasuaryTransaction: Record "Treasury Transactions";
        LoanTrunch: Record "Loan trunch Disburesment";
        LeaveApplication: Record "HR Leave Application";
        PostHeader: Page "Payment Voucher";
        Payments: Record "Payments Header";
    begin
        case RecRef.Number of
            database::"HR Leave Application":
                begin

                    RecRef.SetTable(LeaveApp);
                    LeaveApp.Status := LeaveApp.Status::Approved;

                    LeaveApp.Modify(true);
                    LeaveApp.Validate(Status);
                    Handled := true;
                end;
            database::"HR Jobss":
                begin
                    RecRef.SetTable(HRJOBS);
                    HRJOBS.Status := HRJOBS.Status::Approved;
                    HRJOBS.Modify(true);
                    Handled := true;
                end;

            database::"Loan trunch Disburesment":
                begin
                    RecRef.SetTable(LoanTrunch);
                    LoanTrunch.Status := LoanTrunch.Status::Approved;
                    LoanTrunch.Modify(true);
                    Handled := true;
                end;

            database::"HR Training Applications":
                begin
                    RecRef.SetTable(HRTrainingApplications);
                    HRTrainingApplications.Status := HRTrainingApplications.Status::Approved;
                    HRTrainingApplications.Modify(true);
                    Handled := true;
                end;
            database::"HR Employee Requisitions":
                begin
                    RecRef.SetTable(HREmployeeRequisitions);
                    HREmployeeRequisitions.Status := HREmployeeRequisitions.Status::Approved;
                    HREmployeeRequisitions.Modify(true);
                    Handled := true;
                end;
            database::"EFT/RTGS Header":
                begin
                    RecRef.SetTable(EFTRTGS);
                    EFTRTGS.Status := EFTRTGS.Status::Approved;
                    EFTRTGS.Modify(true);
                    Handled := true;
                end;
            DATABASE::"Membership Applications":
                begin
                    RecRef.SetTable(MemberShipApp);
                    MemberShipApp.Status := MemberShipApp.Status::Approved;
                    MemberShipApp.Modify(true);
                    Handled := true;
                end;

            DATABASE::"Treasury Transactions":
                begin
                    RecRef.SetTable(TreasuaryTransaction);
                    TreasuaryTransaction.Status := TreasuaryTransaction.Status::Approved;
                    TreasuaryTransaction.Modify(true);
                    Handled := true;
                end;
            Database::"FOSA Account Applicat. Details":
                begin
                    RecRef.SetTable(FAccount);
                    FAccount.Status := FAccount.status::Approved;
                    FAccount.Modify();
                    Handled := true;
                end;
            Database::"Sacco Transfers":
                begin
                    RecRef.SetTable(SaccoTransfers);
                    SaccoTransfers.Status := SaccoTransfers.Status::Approved;
                    SaccoTransfers.Modify(true);
                    Handled := true;
                end;
            Database::"Salary Processing Headerr":
                begin
                    RecRef.SetTable(SalaryProcessingHeader);
                    SalaryProcessingHeader.Status := SalaryProcessingHeader.Status::Approved;
                    SalaryProcessingHeader.Modify(true);
                    Handled := true;
                end;
            Database::"Member Agent/Next Of Kin Chang":
                begin
                    RecRef.SetTable(MemberAgentNOKChange);
                    MemberAgentNOKChange.Status := MemberAgentNOKChange.Status::Approved;
                    MemberAgentNOKChange.Modify(true);
                    Handled := true;
                end;
            Database::"Loan Disburesment-Batching":
                begin
                    RecRef.SetTable(LoanDisbursememnt);
                    LoanDisbursememnt.Status := LoanDisbursememnt.Status::Approved;
                    LoanDisbursememnt.Modify(true);
                    Handled := true;

                end;

            Database::"House Groups Registration":
                begin
                    RecRef.SetTable(HouseRegistration);
                    HouseRegistration.Status := HouseRegistration.Status::Approved;
                    HouseRegistration.Modify(true);
                    Handled := true;
                end;
            Database::"Loans Register":
                begin
                    RecRef.SetTable(LaonApplication);
                    LaonApplication.Validate("Approval Status", LaonApplication."Approval Status"::Approved);
                    LaonApplication.Modify(true);
                    Handled := true;

                end;

            Database::"Payment Header.":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Status := PettyCash.Status::Approved;
                    PettyCash.Modify(true);
                    Handled := true;
                end;
            Database::"Standing Orders":
                begin
                    RecRef.SetTable(StandingOrder);
                    StandingOrder.Status := StandingOrder.Status::Approved;
                    StandingOrder.Modify(true);
                    Handled := true;
                end;
            Database::"Membership Exist":
                begin
                    RecRef.SetTable(MWithdrawal);
                    MWithdrawal.Status := MWithdrawal.Status::Approved;
                    MWithdrawal.Modify(true);
                    Handled := true;
                end;

            Database::"Staff Claims Header":
                begin
                    RecRef.SetTable(StaffClaims);
                    StaffClaims.Status := StaffClaims.Status::Approved;
                    StaffClaims.Modify(true);
                    Handled := true;
                end;

            Database::"Imprest Surrender Header":
                begin
                    RecRef.SetTable(ImprestSurrender);
                    ImprestSurrender.Status := ImprestSurrender.Status::Approved;
                    ImprestSurrender.Modify(true);
                    Handled := true;
                end;
            Database::"Imprest Header":
                begin
                    RecRef.SetTable(ImprestRequisition);
                    ImprestRequisition.Status := ImprestRequisition.Status::Approved;
                    ImprestRequisition.Modify(true);
                    Handled := true;
                end;
            Database::"Purchase Header":
                begin
                    RecRef.SetTable(PRequest);
                    PRequest.Status := PRequest.Status::Released;
                    PRequest.Modify(true);
                    Handled := true;

                end;
            Database::"Loan PayOff":
                begin
                    RecRef.SetTable(LoanPayOff);
                    LoanPayOff.Status := LoanPayOff.Status::Approved;
                    LoanPayOff.Modify(true);
                    Handled := true;
                end;
            Database::"Payments Header":
                begin
                    RecRef.SetTable(PaymentHeader);
                    PaymentHeader.Status := PaymentHeader.Status::Approved;
                    PaymentHeader.Modify(true);

                    Handled := true;

                end;
            Database::"Loan Recovery Header":
                begin
                    RecRef.SetTable(GuarantorRecovery);
                    GuarantorRecovery.Status := GuarantorRecovery.Status::Approved;
                    GuarantorRecovery.Modify(true);
                    Handled := true;
                end;
            //Change Request
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeRequest);
                    ChangeRequest.Validate("Approval Status", ChangeRequest."Approval Status"::Approved);
                    ChangeRequest.Modify(true);
                    Handled := true;
                end;
            //boardpayment

            Database::"Boad Payments Allowance":
                begin
                    RecRef.SetTable(boardpayment);
                    boardpayment.Validate(Status, boardpayment.Status::Approved);
                    boardpayment.Modify(true);
                    Handled := true;
                end;
            Database::"Guarantorship Substitution H":
                begin
                    RecRef.SetTable(GuarantorSubstitution);
                    GuarantorSubstitution.Validate(Status, GuarantorSubstitution.Status::Approved);
                    GuarantorSubstitution.Modify(true);
                    Handled := true;
                end;


        end

    end;

}




