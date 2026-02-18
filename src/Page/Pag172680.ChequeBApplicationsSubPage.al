//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172680 "Cheque B. Applications SubPage"
{
    PageType = ListPart;
    SourceTable = "Cheque Book Application";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cheque Book Ordered"; Rec."Cheque Book Ordered")
                {
                    ApplicationArea = Basic;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Ordered On"; Rec."Ordered On")
                {
                    ApplicationArea = Basic;
                }
                field("Received On"; Rec."Received On")
                {
                    ApplicationArea = Basic;
                }
                field(Destroyed; Rec.Destroyed)
                {
                    ApplicationArea = Basic;
                }
                field(Collected; Rec.Collected)
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




