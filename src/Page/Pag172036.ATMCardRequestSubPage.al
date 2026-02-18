//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172036 "ATM Card Request SubPage"
{
    PageType = ListPart;
    SourceTable = "ATM Card Request Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ATM Application No";Rec."ATM Application No")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Account No";Rec."ATM Card Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Application Date";Rec."ATM Card Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Request Type";Rec."Request Type")
                {
                    ApplicationArea = Basic;
                }
                field(Ordered; Rec.Ordered)
                {
                    ApplicationArea = Basic;
                }
                field("Ordered On";Rec."Ordered On")
                {
                    ApplicationArea = Basic;
                }
                field("Ordered By";Rec."Ordered By")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card No";Rec."ATM Card No")
                {
                    ApplicationArea = Basic;
                }
                field("ID No";Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No";Rec."Phone No")
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




