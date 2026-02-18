page 17374 "Board payments Lines"
{
    ApplicationArea = All;
    Caption = 'Board payments Lines';
    PageType = ListPart;
    SourceTable = "Boarb Payments Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("G/L Account"; Rec."G/L Account")
                {
                    ToolTip = 'Specifies the value of the G/L Account field.';
                }
                field("Board No"; Rec."Board No")
                { }
                field(Name; Rec.Name)
                { }
                Field("Staff\Board"; Rec."Staff\Board") { }
                field("Payment Descrition"; Rec."Payment Descrition")
                {
                    ToolTip = 'Specifies the value of the Payment Descrition field.';
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    ToolTip = 'Specifies the value of the Amount Paid field.';
                }
                field("Paye Amount"; Rec."Paye Amount")
                {
                    ToolTip = 'Specifies the value of the Paye Amount field.';
                }
                field("Housing Leavy"; Rec."Housing Leavy")
                {
                    ToolTip = 'Specifies the value of the Housing Leavy field.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {

                }
                field("Loan No"; Rec."Loan No")
                {

                }
                field("Member Amount"; Rec."Member Amount")
                {
                    Caption = 'Back office Payment';
                }
                field("Net  Amount"; Rec."Net  Amount")
                {

                }

            }
        }
    }
}
