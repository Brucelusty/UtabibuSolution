//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172164 "HR Carryover Request List"
{
    CardPageID = "HR Leave Carryover Request";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Leave Carry Allocation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application Code"; Rec."Application Code")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Applicant Comments"; Rec."Applicant Comments")
                {
                    ApplicationArea = Basic;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Job Tittle"; Rec."Job Tittle")
                {
                    ApplicationArea = Basic;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field(Attachments; Rec.Attachments)
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




