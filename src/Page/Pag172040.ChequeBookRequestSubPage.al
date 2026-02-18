//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172040 "Cheque Book Request SubPage"
{
    PageType = ListPart;
    SourceTable = "Cheque Book Request Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Book Application No";Rec."Cheque Book Application No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Account No";Rec."Cheque Book Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book No";Rec."Cheque Book No")
                {
                    ApplicationArea = Basic;
                }
                field(Ordered; Rec.Ordered)
                {
                    ApplicationArea = Basic;
                }
                field("Ordered By";Rec."Ordered By")
                {
                    ApplicationArea = Basic;
                }
                field("Ordered On";Rec."Ordered On")
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




