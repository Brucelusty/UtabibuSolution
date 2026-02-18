//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50063 "Checkoff Processing Lines-D"
{
    DelayedInsert = false;
    DeleteAllowed = true;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    //ApplicationArea = all;
    SourceTable = "Checkoff Lines-Distributed-NT";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll No";Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Employee Name";Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Checkoff No";Rec."Checkoff No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(REGFEE; Rec.REGFEE)
                {
                    ApplicationArea = Basic;
                    Caption = 'Entrance Fee';
                }
                field(Deposits; Rec.Deposits)
                {
                    ApplicationArea = Basic;
                    Caption = 'Share Capital';
                }

                field(SHARES; Rec.SHARES)
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposit Contribution';
                }
                field(DL_P; Rec.DL_P)
                {
                    ApplicationArea = Basic;
                }
                field(DL_I; Rec.DL_I)
                {
                    ApplicationArea = Basic;
                }
                field(NL_P; Rec.NL_P)
                {
                    ApplicationArea = Basic;
                }
                field(NL_I; Rec.NL_I)
                {
                    ApplicationArea = Basic;
                }
                field(SAdvanceL_P; Rec.SAdvanceL_P)
                {
                    ApplicationArea = Basic;
                }
                field(SAdvanceL_I; Rec.SAdvanceL_I)
                {
                    ApplicationArea = Basic;
                }
                field(EMER_P; Rec.EMER_P)
                {
                    ApplicationArea = basic;
                }
                field(EMER_I; Rec.EMER_I)
                { ApplicationArea = basic; }
                field(DeFL_P; Rec.DeFL_P)
                {
                    ApplicationArea = Basic;
                }
                field(DeFL_I; Rec.DeFL_I)
                {
                    ApplicationArea = Basic;
                }
                field(JumboL_P; Rec.JumboL_P)
                {
                    ApplicationArea = Basic;
                }
                field(JumboL_I; Rec.JumboL_I)
                {
                    ApplicationArea = Basic;
                }
                field(HouseHL_P; Rec.HouseHL_P)
                {
                    ApplicationArea = Basic;
                }
                field(HouseHL_I; Rec.HouseHL_I)
                {
                    ApplicationArea = Basic;
                }
                field(SAD; Rec.SAD)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(DependandSavings3;Rec."Dependand Savings 3")
                {
                    ApplicationArea = Basic;
                }
                field(SAI; Rec.SAI)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("SpecialL_P";Rec."SpecialL_P")
                {
                    ApplicationArea = Basic;
                }
                field("SpecialL_I";Rec."SpecialL_I")
                {
                    ApplicationArea = Basic;
                }
                field(HarakaL_P; Rec.HarakaL_P)
                {
                    ApplicationArea = Basic;
                }
                field(HarakaL_I; Rec.HarakaL_I)
                {
                    ApplicationArea = Basic;
                }
                field("PremiumL-P";Rec."PremiumL-P")
                {
                    ApplicationArea = Basic;
                }
                field("PremiumL-I";Rec."PremiumL-I")
                {
                    ApplicationArea = Basic;
                }
                field("Dependand Savings 2";Rec."Dependand Savings 2")
                {
                    ApplicationArea = Basic;
                }
                field("Housing Co-operative";Rec."JUNIOR SAVINGS")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Dependand Savings 1";Rec."Dependand Savings 1")
                {
                    ApplicationArea = basic;
                }
                field(SchoolF_P; Rec.SchoolF_P)
                {
                    ApplicationArea = Basic;
                }
                field(SchoolF_I; Rec.SchoolF_I)

                {
                    ApplicationArea = basic;
                }
                field(SuperSL_P; Rec.SuperSL_P)
                {
                    ApplicationArea = basic;
                }
                field(Mavuno_L; Rec.Mavuno_L) { ApplicationArea = basic; }
                field(Mavuna_I; Rec.Mavuna_I) { ApplicationArea = basic; }

                field(SuperSL_I; Rec.SuperSL_I) { ApplicationArea = basic; }
                field(DhamanaL_P; Rec.DhamanaL_P) { ApplicationArea = all; }
                field(DhamanaL_I; Rec.DhamanaL_I) { ApplicationArea = all; }
                field("Holiday Savings";Rec."Holiday Savings") { ApplicationArea = all; }
                field("Utafiti Housing";Rec."Utafiti Housing") { ApplicationArea = all; }
                field(UnallocatedFunds; Rec.BENEVOLENT)
                {
                    ApplicationArea = Basic;
                    Caption = 'Unallocated Funds';
                }
                field(TOTAL_DISTRIBUTED; Rec.TOTAL_DISTRIBUTED)
                {
                    ApplicationArea = Basic;
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

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member No" = '' then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member No" <> '' then
            CoveragePercentStyle := 'Favorable';
    end;
}




