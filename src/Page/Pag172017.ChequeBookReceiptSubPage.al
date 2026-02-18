//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172017 "Cheque Book Receipt SubPage"
{
    PageType = ListPart;
    SourceTable = "Cheque Book Receipt Lines";

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
                    Editable = false;
                }
                field("Cheque Book Application Date";Rec."Cheque Book Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Received; Rec.Received)
                {
                    ApplicationArea = Basic;
                }
                field("Received By";Rec."Received By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Received On";Rec."Received On")
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




