//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172590 "Posted Loan PayOff List"
{
    CardPageID = "Loan Posted PayOff Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loan PayOff";
    SourceTableView = where(Posted = filter(true));

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
                field("Requested PayOff Amount";Rec."Requested PayOff Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved PayOff Amount";Rec."Approved PayOff Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch Name';
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Created By";Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Posted By";Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'Member Statistics';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Member No");
            }
        }
    }
}




