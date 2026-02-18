page 17336 "Coop B2B Transactions"
{
    ApplicationArea = All;
    Caption = 'Coop B2B Transactions';
    PageType = List;
    SourceTable = "Coop Bank B2B Deposits";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Entry; Rec.Entry)
                {
                    ToolTip = 'Specifies the value of the Entry field.', Comment = '%';
                }
                field(AccountNumber; Rec.AccountNumber)
                {
                    ToolTip = 'Specifies the value of the AccountNumber field.', Comment = '%';
                }
                field(AccountName; Rec.AccountName)
                {
                    ToolTip = 'Specifies the value of the AccountName field.', Comment = '%';
                }
                field(TotalAmount; Rec.TotalAmount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field(TransactionDate; Rec.TransactionDate)
                {
                    ToolTip = 'Specifies the value of the Trans Date field.', Comment = '%';
                }
                field(TransactionReferenceCode; Rec.TransactionReferenceCode)
                {
                    ToolTip = 'Specifies the value of the TransactionReferenceCode field.', Comment = '%';
                }
                field(PaymentAmount; Rec.PaymentAmount)
                {
                    ToolTip = 'Specifies the value of the PaymentAmount field.', Comment = '%';
                }
                field(Status;Rec.Status)
                {
                    
                }
                field(PaymentCode; Rec.PaymentCode)
                {
                    ToolTip = 'Specifies the value of the PaymentCode field.', Comment = '%';
                }
                field(PaymentMode; Rec.PaymentMode)
                {
                    ToolTip = 'Specifies the value of the PaymentMode field.', Comment = '%';
                }
                field(PaymentReferenceCode; Rec.PaymentReferenceCode)
                {
                    ToolTip = 'Specifies the value of the AccountName field.', Comment = '%';
                }
                field(AdditionalInfo; Rec.AdditionalInfo)
                {
                    ToolTip = 'Specifies the value of the AdditionalInfo field.', Comment = '%';
                }
                field(BankCode; Rec.BankCode)
                {
                    ToolTip = 'Specifies the value of the BankCode field.', Comment = '%';
                }
                field(BranchCode; Rec.BranchCode)
                {
                    ToolTip = 'Specifies the value of the BranchCode field.', Comment = '%';
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field.', Comment = '%';
                }
                field(DocumentReferenceNumber; Rec.DocumentReferenceNumber)
                {
                    ToolTip = 'Specifies the value of the DocumentReferenceNumber field.', Comment = '%';
                }
                field(Document_Date; Rec.Document_Date)
                {
                    ToolTip = 'Specifies the value of the InstitutionCode field.', Comment = '%';
                }
                field(InstitutionCode; Rec.InstitutionCode)
                {
                    ToolTip = 'Specifies the value of the InstitutionCode field.', Comment = '%';
                }
                field(InstitutionName; Rec.InstitutionName)
                {
                    ToolTip = 'Specifies the value of the InstitutionName field.', Comment = '%';
                }
            }
        }
    }
}
