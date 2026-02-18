//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172949 "ATM Card Applications SubPage"
{
    PageType = ListPart;
    SourceTable = "ATM Card Applications";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Order ATM Card";Rec."Order ATM Card")
                {
                    ApplicationArea = Basic;
                }
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code";Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Request Type";Rec."Request Type")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Card No";Rec."Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Issued";Rec."Date Issued")
                {
                    ApplicationArea = Basic;
                }
                field("Card Status";Rec."Card Status")
                {
                    ApplicationArea = Basic;
                }
                field("Ordered By";Rec."Ordered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Ordered On";Rec."Ordered On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}




