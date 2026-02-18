//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172814 "ATM Cards Application - New"
{
    CardPageID = "ATM Applications Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "ATM Card Applications";
    SourceTableView = where("Order ATM Card" = filter(false));

    layout
    {
        area(content)
        {
            repeater(Control15)
            {
                Editable = false;
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Request Type";Rec."Request Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code";Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch';
                }
                field("Card No";Rec."Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.";Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("ID No";Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Captured By";Rec."Captured By")
                {
                    ApplicationArea = Basic;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee Charged";Rec."ATM Card Fee Charged")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee Charged On";Rec."ATM Card Fee Charged On")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Fee Charged By";Rec."ATM Card Fee Charged By")
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




