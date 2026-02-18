//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172530 "Cheque Book Application - New"
{
    CardPageID = "Cheque Application";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Cheque Book Application";
    SourceTableView = where("Cheque Book Ordered" = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No.";Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Account No.";Rec."Cheque Book Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Requested By";Rec."Requested By")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Fee Charged";Rec."Cheque Book Fee Charged")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Fee Charged On";Rec."Cheque Book Fee Charged On")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Fee Charged By";Rec."Cheque Book Fee Charged By")
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




