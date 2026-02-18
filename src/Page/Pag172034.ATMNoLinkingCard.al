//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172034 "ATM No Linking Card"
{
    PageType = Card;
    SourceTable = "ATM Card Applications";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Branch Code";Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Card No";Rec."Card No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Linked";Rec."ATM Card Linked")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Linked By";Rec."ATM Card Linked By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Card Linked On";Rec."ATM Card Linked On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Link ATM Card")
            {
                ApplicationArea = Basic;
                Caption = 'Link ATM Card';
                Enabled = true;
                Image = Link;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Approved then
                        Error('This ATM Card application has not been approved');
                end;

            }
        }
    }
}