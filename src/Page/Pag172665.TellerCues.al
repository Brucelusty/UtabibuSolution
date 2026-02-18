//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172665 "Teller Cues"
{
    PageType = CardPart;
    SourceTable = "Membership Cue";

    layout
    {
        area(content)
        {
            cuegroup("Uncleared Cheques")
            {
                Caption = 'Uncleared Cheques';
                field(Control3;Rec."Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                }
                field("Cleared Cheques";Rec."Cleared Cheques")
                {
                    ApplicationArea = Basic;
                    Image = "None";
                }
                field("Bounced Cheques";Rec."Bounced Cheques")
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




