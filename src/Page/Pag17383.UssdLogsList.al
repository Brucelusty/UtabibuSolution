page 17383 UssdLogsList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'USSD Logs List';
    SourceTable = "USSD Logs";

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
                field(SESSIONID; Rec.SESSIONID)
                {
                    ToolTip = 'Specifies the value of the SESSIONID field.';
                }
                field(USSDCODE; Rec.USSDCODE)
                {
                    ToolTip = 'Specifies the value of the USSDCODE field.';
                }
                field(MSISDN; Rec.MSISDN)
                {
                    ToolTip = 'Specifies the value of the MSISDN field.';
                }
                field(INPUT; Rec.INPUT)
                {
                    ToolTip = 'Specifies the value of the INPUT field.';
                }
                field(NETWORK; Rec.NETWORK)
                {
                    ToolTip = 'Specifies the value of the NETWORK field.';
                }
                field(RequestCount; Rec.RequestCount)
                {
                    ToolTip = 'Specifies the value of the RequestCount field.';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.';
                }
                field(Response; Rec.Response)
                {
                    ToolTip = 'Specifies the value of the Response field.';
                }
                field(TransactionDate; Rec.TransactionDate)
                {
                    ToolTip = 'Specifies the value of the TransactionDate field.';
                }
                field(USSD_STRING; Rec.USSD_STRING)
                {
                    ToolTip = 'Specifies the value of the USSD_STRING field.';
                }
                field(ConcatString; Rec.ConcatString)
                {
                    ToolTip = 'Specifies the value of the ConcatString field.';
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
