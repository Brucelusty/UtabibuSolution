page 17377 "STK PUSH"
{
    ApplicationArea = All;
    Caption = 'STK PUSH LOGS';
    PageType = List;
    SourceTable = "STK PUSH Logs";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Entry; Rec.Entry)
                {
                    ToolTip = 'Specifies the value of the Entry field.';
                }
                field(MerchantRequestID; Rec.MerchantRequestID)
                {
                    ToolTip = 'Specifies the value of the MerchantRequestID field.';
                }
                field(CheckoutRequestID; Rec.CheckoutRequestID)
                {
                    ToolTip = 'Specifies the value of the CheckoutRequestID field.';
                }
                field(amount; Rec.amount)
                {
                    ToolTip = 'Specifies the value of the amount field.';
                }
                field(paybillno; Rec.paybillno)
                {
                    ToolTip = 'Specifies the value of the paybillno field.';
                }
                field(ResultCode; Rec.ResultCode)
                {
                    ToolTip = 'Specifies the value of the ResultCode field.';
                }
                field(ResultDesc; Rec.ResultDesc)
                {
                    ToolTip = 'Specifies the value of the ResultDesc field.';
                }
                field(telephone; Rec.telephone)
                {
                    ToolTip = 'Specifies the value of the telephone field.';
                }
                field(receiptno; Rec.receiptno)
                {
                    ToolTip = 'Specifies the value of the receiptno field.';
                }
                field(phonenumber; Rec.phonenumber)
                {
                    ToolTip = 'Specifies the value of the phonenumber field.';
                }
                field(ResponseDescription; Rec.ResponseDescription)
                {
                    ToolTip = 'Specifies the value of the ResponseDescription field.';
                }
                field("Account No"; Rec."Account No")
                {
                    ToolTip = 'Specifies the value of the Account No field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
            }
        }
    }
}
