//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172350 "Effected Sweeping Instructions"
{
    CardPageID = "Effected Sweeping Instruc Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Member Sweeping Instructions";
    SourceTableView = where(Effected = filter(true));

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
                field("Monitor Account";Rec."Monitor Account")
                {
                    ApplicationArea = Basic;
                }
                field("Monitor Account Type Desc";Rec."Monitor Account Type Desc")
                {
                    ApplicationArea = Basic;
                }
                field("Minimum Account Threshold";Rec."Minimum Account Threshold")
                {
                    ApplicationArea = Basic;
                    Caption = 'Minimum  Threshold';
                }
                field("Maximum Account Threshold";Rec."Maximum Account Threshold")
                {
                    ApplicationArea = Basic;
                    Caption = 'Maximum  Threshold';
                }
                field("Investment Account";Rec."Investment Account")
                {
                    ApplicationArea = Basic;
                }
                field("Investment Account Type Desc";Rec."Investment Account Type Desc")
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




