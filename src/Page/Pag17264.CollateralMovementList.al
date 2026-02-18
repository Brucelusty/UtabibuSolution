//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17264 "Collateral Movement List"
{
    CardPageID = "Collateral Movement Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Collateral Movement  Register";
    SourceTableView = where("Action Effected" = filter(false));

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
                field("Collateral ID";Rec."Collateral ID")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Description";Rec."Collateral Description")
                {
                    ApplicationArea = Basic;
                }
                field("Registered Owner";Rec."Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field("Member No.";Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Type";Rec."Collateral Type")
                {
                    ApplicationArea = Basic;
                }
                field("Action Type";Rec."Action Type")
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




