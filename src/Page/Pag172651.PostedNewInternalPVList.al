//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172651 "Posted New Internal PV List"
{
    CardPageID = "Posted Internal PV Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Internal PV Header";
    SourceTableView = where(Posted = filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered";Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered";Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Entered By";Rec."Entered By")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted";Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Time Posted";Rec."Time Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By";Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Total Debits";Rec."Total Debits")
                {
                    ApplicationArea = Basic;
                }
                field("Total Count";Rec."Total Count")
                {
                    ApplicationArea = Basic;
                }
                field("Total Credits";Rec."Total Credits")
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




