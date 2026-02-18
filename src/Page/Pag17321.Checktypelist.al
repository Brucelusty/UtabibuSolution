page 17321 Checktypelist
{
    ApplicationArea = All;
    Caption = 'Checktypelist';
    PageType = List;
    SourceTable = "Cheque Types";
    UsageCategory = Tasks;
    CardPageId = "Cheque Types";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("% Of Amount"; Rec."% Of Amount")
                {
                    ToolTip = 'Specifies the value of the % Of Amount field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field("Bankers Cheque Fee"; Rec."Bankers Cheque Fee")
                {
                    ToolTip = 'Specifies the value of the Bankers Cheque Fee field.';
                }
                field("Bankers Cheque Fee Account"; Rec."Bankers Cheque Fee Account")
                {
                    ToolTip = 'Specifies the value of the Bankers Cheque Fee Account field.';
                }
                field("Bounced Charges"; Rec."Bounced Charges")
                {
                    ToolTip = 'Specifies the value of the Bounced Charges field.';
                }
                field("Bounced Charges GL Account"; Rec."Bounced Charges GL Account")
                {
                    ToolTip = 'Specifies the value of the Bounced Charges GL Account field.';
                }
                field("Bounced Cheque Bank Charge"; Rec."Bounced Cheque Bank Charge")
                {
                    ToolTip = 'Specifies the value of the Bounced Cheque Bank Charge field.';
                }
                field("Bounced Cheque Sacco Income"; Rec."Bounced Cheque Sacco Income")
                {
                    ToolTip = 'Specifies the value of the Bounced Cheque Sacco Income field.';
                }
                field("Clearing  Days"; Rec."Clearing  Days")
                {
                    ToolTip = 'Specifies the value of the Clearing  Days field.';
                }
                field("Clearing Bank Account"; Rec."Clearing Bank Account")
                {
                    ToolTip = 'Specifies the value of the Clearing Bank Account field.';
                }
                field("Clearing Charge Code"; Rec."Clearing Charge Code")
                {
                    ToolTip = 'Specifies the value of the Clearing Charge Code field.';
                }
                field("Clearing Charges"; Rec."Clearing Charges")
                {
                    ToolTip = 'Specifies the value of the Clearing Charges field.';
                }
                field("Clearing Charges GL Account"; Rec."Clearing Charges GL Account")
                {
                    ToolTip = 'Specifies the value of the Clearing Charges GL Account field.';
                }
                field("Clearing Days"; Rec."Clearing Days")
                {
                    ToolTip = 'Specifies the value of the Clearing Days field.';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Percentage; Rec.Percentage)
                {
                    ToolTip = 'Specifies the value of the Percentage field.';
                }
                field("Special Clearing Charges"; Rec."Special Clearing Charges")
                {
                    ToolTip = 'Specifies the value of the Special Clearing Charges field.';
                }
                field("Special Clearing Days"; Rec."Special Clearing Days")
                {
                    ToolTip = 'Specifies the value of the Special Clearing Days field.';
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Use %"; Rec."Use %")
                {
                    ToolTip = 'Specifies the value of the Use % field.';
                }
            }
        }
    }
}
