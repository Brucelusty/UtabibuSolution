//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172137 "Issued Piggy Bank Issuance"
{
    CardPageID = "Piggy Bank Issuance Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Piggy Bank Issuance";
    SourceTableView = where(Issued = filter(true));

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
                field("Member Account No";Rec."Member Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Piggy Bank Account";Rec."Piggy Bank Account")
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




