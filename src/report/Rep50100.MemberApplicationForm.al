report 50100 MemberApplicationForm
{
    ApplicationArea = All;
    Caption = 'MemberApplicationForm';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(MembershipApplications; "Membership Applications")
        {
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
