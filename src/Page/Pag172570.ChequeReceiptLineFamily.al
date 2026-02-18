//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172570 "Cheque Receipt Line-Family"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = "Cheque Issue Lines-Family";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Serial No";Rec."Cheque Serial No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque No";Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No.";Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("Account Balance";Rec."Account Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Charge Amount";Rec."Charge Amount")
                {
                    ApplicationArea = Basic;
                    Style = AttentionAccent;
                    StyleExpr = true;
                }
                field("Un pay Code";Rec."Un pay Code")
                {
                    ApplicationArea = Basic;
                }
                field(Interpretation; Rec.Interpretation)
                {
                    ApplicationArea = Basic;
                }
                field("Verification Status";Rec."Verification Status")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        Rec.Modify;
                    end;
                }
                field("Transaction Date";Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Un Pay Charge Amount";Rec."Un Pay Charge Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Family Account No.";Rec."Family Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Code";Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Refference";Rec."Transaction Refference")
                {
                    ApplicationArea = Basic;
                }
                field("Unpay Date";Rec."Unpay Date")
                {
                    ApplicationArea = Basic;
                }
                field(FrontImage; Rec.FrontImage)
                {
                    ApplicationArea = Basic;
                }
                field(FrontGrayImage; Rec.FrontGrayImage)
                {
                    ApplicationArea = Basic;
                }
                field(BackImages; Rec.BackImages)
                {
                    ApplicationArea = Basic;
                }
                field("Un pay User Id";Rec."Un pay User Id")
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




