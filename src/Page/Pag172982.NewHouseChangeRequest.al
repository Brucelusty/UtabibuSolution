//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172982 "New House Change Request"
{
    CardPageID = "House Change Request Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "House Group Change Request";
    SourceTableView = where("Change Effected" = filter(false));

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
                field("House Group";Rec."House Group")
                {
                    ApplicationArea = Basic;
                }
                field("House Group Name";Rec."House Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Destination House";Rec."Destination House")
                {
                    ApplicationArea = Basic;
                }
                field("Destination House Group Name";Rec."Destination House Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Changing Groups";Rec."Reason For Changing Groups")
                {
                    ApplicationArea = Basic;
                }
                field("Deposits on Date of Change";Rec."Deposits on Date of Change")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By";Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }
                field("Captured On";Rec."Captured On")
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




