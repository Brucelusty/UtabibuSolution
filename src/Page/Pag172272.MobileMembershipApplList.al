//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172272 "Mobile Membership Appl List"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = MobileAppMembershipApplication;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(MobileNo; Rec.MobileNo)
                {
                    ApplicationArea = Basic;
                }
                field(IDNumber; Rec.IDNumber)
                {
                    ApplicationArea = Basic;
                }
                field(FirstName; Rec.FirstName)
                {
                    ApplicationArea = Basic;
                }
                field(MiddleName; Rec.MiddleName)
                {
                    ApplicationArea = Basic;
                }
                field(LastName; Rec.LastName)
                {
                    ApplicationArea = Basic;
                }
                field(FosaAccountOpened; Rec.FosaAccountOpened)
                {
                    ApplicationArea = Basic;
                }
                field(NextOfKinDOB; Rec.NextOfKinDOB)
                {
                    ApplicationArea = Basic;
                }
                field(BosaAccountOpened; Rec.BosaAccountOpened)
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationReceivedOn; Rec.ApplicationReceivedOn)
                {
                    ApplicationArea = Basic;
                }
                field(ApplicationMaintained; Rec.ApplicationMaintained)
                {
                    ApplicationArea = Basic;
                }
                field(RefereeName; Rec.RefereeName)
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




