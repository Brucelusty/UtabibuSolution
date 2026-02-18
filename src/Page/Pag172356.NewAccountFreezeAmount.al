//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172356 "New Account Freeze Amount"
{
    CardPageID = "Account Freeze Amount Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Member Account Freeze Details";
    SourceTableView = where(Frozen = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Amount to Freeze";Rec."Amount to Freeze")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Freezing";Rec."Reason For Freezing")
                {
                    ApplicationArea = Basic;
                }
                field("Captured On";Rec."Captured On")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By";Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                field(Frozen; Rec.Frozen)
                {
                    ApplicationArea = Basic;
                }
                field("Frozen On";Rec."Frozen On")
                {
                    ApplicationArea = Basic;
                }
                field("Frozen By";Rec."Frozen By")
                {
                    ApplicationArea = Basic;
                }
                field(Unfrozen; Rec.Unfrozen)
                {
                    ApplicationArea = Basic;
                }
                field("Unfrozen On";Rec."Unfrozen On")
                {
                    ApplicationArea = Basic;
                }
                field("Unfrozen By";Rec."Unfrozen By")
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




