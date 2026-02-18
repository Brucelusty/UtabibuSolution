//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172654 "Finance UpLoads Lines"
{
    DelayedInsert = false;
    PageType = ListPart;
    SourceTable = "Finance Uploads Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("Debit Account Type";Rec."Debit Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Account No";Rec."Debit Account No")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Debit Narration";Rec."Debit Narration")
                {
                    ApplicationArea = Basic;
                }
                field("Debit Account Balance Status";Rec."Debit Account Balance Status")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Debit Account Status";Rec."Debit Account Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = CoveragePercentStyleII;
                }
                field("Reference No";Rec."Reference No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Credit Account Type";Rec."Credit Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Account No";Rec."Credit Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Narration";Rec."Credit Narration")
                {
                    ApplicationArea = Basic;
                }
                field("Credit Account Status";Rec."Credit Account Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    StyleExpr = CoveragePercentStyleIII;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    trigger OnOpenPage()
    begin

        //SETRANGE(USER,USERID);
    end;

    var
        CoveragePercentStyle: Text;
        CoveragePercentStyleII: Text;
        CoveragePercentStyleIII: Text;

    local procedure SetStyles()
    begin
        if Rec."Debit Account Balance Status" = Rec."debit account balance status"::" " then
            CoveragePercentStyle := 'Strong';
        if Rec."Debit Account Balance Status" = Rec."debit account balance status"::"Insufficient Balance" then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Debit Account Balance Status" = Rec."debit account balance status"::"Sufficient Balance" then
            CoveragePercentStyle := 'Favorable';

    end;

    local procedure SetStylesII()
    begin
        CoveragePercentStyleII := 'Strong';
        if Rec."Debit Account Status" <> Rec."debit account status"::Active then
            CoveragePercentStyleII := 'Unfavorable';
        if Rec."Debit Account Status" = Rec."debit account status"::Active then
            CoveragePercentStyleII := 'Favorable';

    end;

    local procedure SetStylesIII()
    begin
        CoveragePercentStyleIII := 'Strong';
        if Rec."Credit Account Status" <> Rec."credit account status"::Active then
            CoveragePercentStyleIII := 'Unfavorable';
        if Rec."Credit Account Status" = Rec."credit account status"::Active then
            CoveragePercentStyleIII := 'Favorable';

    end;
}




