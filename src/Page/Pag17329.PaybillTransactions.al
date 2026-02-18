page 17329 "Paybill Transactions"
{
    ApplicationArea = All;
    Caption = 'Paybill Transactions';
    PageType = List;
    SourceTable = "Paybill Transactions";
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(FirstName; Rec.FirstName)
                {
                    ToolTip = 'Specifies the value of the FirstName field.';
                }
                field(BillRefNumber; Rec.BillRefNumber)
                {
                    ToolTip = 'Specifies the value of the bill ref field.';
                }

                field(MSIDN; Rec.MSIDN)
                {
                    ToolTip = 'Specifies the value of the MSIDN field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(TransID; Rec.TransID)
                {
                    ToolTip = 'Specifies the value of the TransID field.';
                }
                field(TransTime; Rec.TransTime)
                {
                    ToolTip = 'Specifies the value of the TransTime field.';
                }
                field(TransAmount; Rec.TransAmount)
                {
                    ToolTip = 'Specifies the value of the TransAmount field.';
                }
            }
        }
    }
}
