//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172418 "Paybill Processing Line"
{
    PageType = ListPart;
    SourceTable = "Paybill Processing Lines";

    layout
    {
        area(content)
        {
            repeater(Control21)
            {
                Editable = true;
                field("Document No.";Rec."Document No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receipt Number';
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                    Caption = 'Trans Date';
                    Editable = false;
                }
                field("Mobile Phone Number";Rec."Mobile Phone Number")
                {
                    ApplicationArea = Basic;
                    Caption = 'Phone Number';
                    Editable = false;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Depositor Name';
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No.";Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Invalid Account';
                    Editable = false;
                    //Image = Person;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Correct Account No";Rec."Correct Account No")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Name';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetStyles;
    end;

    trigger OnAfterGetRecord()
    begin
        SetStyles;
    end;

    trigger OnOpenPage()
    begin
        SetStyles;
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Correct Account No" = '' then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Correct Account No" <> '' then
            CoveragePercentStyle := 'Favorable';
    end;
}




