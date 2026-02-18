//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172645 "MPESA C2B Transaction"
{
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = MPESAC2BTransactions;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ColumnID; Rec.ColumnID)
                {
                    ApplicationArea = Basic;
                }
                field(ReceiptNumber; Rec.ReceiptNumber)
                {
                    ApplicationArea = Basic;
                }
                field(CustomerName; Rec.CustomerName)
                {
                    ApplicationArea = Basic;
                }
                field(PhoneNumber; Rec.PhoneNumber)
                {
                    ApplicationArea = Basic;
                }
                field(AccountNumber; Rec.AccountNumber)
                {
                    ApplicationArea = Basic;
                }
                field(TrxAmount; Rec.TrxAmount)
                {
                    ApplicationArea = Basic;
                }
                field(TrxStatus; Rec.TrxStatus)
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Validated; Rec.Validated)
                {
                    ApplicationArea = Basic;
                }
                field(DateValidated; Rec.DateValidated)
                {
                    ApplicationArea = Basic;
                }
                field(DateCompleted; Rec.DateCompleted)
                {
                    ApplicationArea = Basic;
                }
                field("Un Identified Payments"; Rec."Un Identified Payments")
                {
                    ApplicationArea = Basic;
                }
                field(TrxDetails; Rec.TrxDetails)
                {
                    ApplicationArea = Basic;
                }
                field(DatePosted; Rec.DatePosted)
                {
                    ApplicationArea = Basic;
                }
                field(Alerted; Rec.Alerted)
                {
                    ApplicationArea = Basic;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic;
                }
                field("Un Identified Payment Posted"; Rec."Un Identified Payment Posted")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}




