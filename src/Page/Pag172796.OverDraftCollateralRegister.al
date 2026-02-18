//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172796 "OverDraft Collateral Register"
{
    PageType = ListPart;
    SourceTable = "OD Collateral Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                    Caption = 'Collateral Type';
                }
                field("Collateral Registe Doc";Rec."Collateral Registe Doc")
                {
                    ApplicationArea = Basic;
                    Caption = 'Collateral Details Register';
                }
                field("Security Details";Rec."Security Details")
                {
                    ApplicationArea = Basic;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Multiplier";Rec."Collateral Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Guarantee Value";Rec."Guarantee Value")
                {
                    ApplicationArea = Basic;
                }
                field("Motor Vehicle Registration No";Rec."Motor Vehicle Registration No")
                {
                    ApplicationArea = Basic;
                }
                field("Title Deed No.";Rec."Title Deed No.")
                {
                    ApplicationArea = Basic;
                }
                field("Comitted Collateral Value";Rec."Comitted Collateral Value")
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




