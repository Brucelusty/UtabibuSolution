//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172058 "Loan Application List Ver1"
{
    // CardPageID = "Loan Application Card";
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loans Register";
    SourceTableView = where(Posted = filter(false),
                            "Approval Status" = filter(Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No.";Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount";Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                }
                field("Client Name";Rec."Client Name")
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




