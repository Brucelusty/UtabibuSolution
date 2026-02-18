//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172998 "House Groups Registration List"
{
    CardPageID = "House Group Registration Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "House Groups Registration";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("House Group Code";Rec."House Group Code")
                {
                    ApplicationArea = Basic;
                }
                field("House Group Name";Rec."House Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Date Formed";Rec."Date Formed")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Date";Rec."Meeting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader";Rec."Group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Group Leader Name";Rec."Group Leader Name")
                {
                    ApplicationArea = Basic;
                }
                field("Assistant group Leader";Rec."Assistant group Leader")
                {
                    ApplicationArea = Basic;
                }
                field("Assistant Group Name";Rec."Assistant Group Name")
                {
                    ApplicationArea = Basic;
                }
                field("Meeting Place";Rec."Meeting Place")
                {
                    ApplicationArea = Basic;
                }
                field("No of Members";Rec."No of Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Credit Officer";Rec."Credit Officer")
                {
                    ApplicationArea = Basic;
                }
                field("Field Officer";Rec."Field Officer")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
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




