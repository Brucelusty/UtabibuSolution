//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172461 "ATM Cards Appl. - Processed"
{
    CardPageID = "ATM Applications Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "ATM Card Applications";
    SourceTableView = where("Order ATM Card" = filter(true));

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
                field("Order ATM Card";Rec."Order ATM Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ordered';
                }
                field("Ordered On";Rec."Ordered On")
                {
                    ApplicationArea = Basic;
                }
                field("Ordered By";Rec."Ordered By")
                {
                    ApplicationArea = Basic;
                }
                field("Card Received";Rec."Card Received")
                {
                    ApplicationArea = Basic;
                }
                field("Card Received On";Rec."Card Received On")
                {
                    ApplicationArea = Basic;
                }
                field("Card Received By";Rec."Card Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Pin Received";Rec."Pin Received")
                {
                    ApplicationArea = Basic;
                    Caption = 'PIN Received';
                }
                field("Pin Received On";Rec."Pin Received On")
                {
                    ApplicationArea = Basic;
                    Caption = 'PIN Received On';
                }
                field("Pin Received By";Rec."Pin Received By")
                {
                    ApplicationArea = Basic;
                    Caption = 'PIN Received By';
                }
                field("ATM Card Linked";Rec."ATM Card Linked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Linked By";Rec."ATM Card Linked By")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Card Linked On";Rec."ATM Card Linked On")
                {
                    ApplicationArea = Basic;
                }
                field(Collected; Rec.Collected)
                {
                    ApplicationArea = Basic;
                }
                field("Date Collected";Rec."Date Collected")
                {
                    ApplicationArea = Basic;
                }
                field("Card Issued By";Rec."Card Issued By")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Delinked";Rec."ATM Delinked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Delinked By";Rec."ATM Delinked By")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Delinked On";Rec."ATM Delinked On")
                {
                    ApplicationArea = Basic;
                }
                field(Destroyed; Rec.Destroyed)
                {
                    ApplicationArea = Basic;
                }
                field("Destroyed On";Rec."Destroyed On")
                {
                    ApplicationArea = Basic;
                }
                field("Destroyed By";Rec."Destroyed By")
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




