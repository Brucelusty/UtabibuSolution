//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17414 "MOBILE Transactions"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Mobile Banking Transactions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Entry; Rec.Entry)
                {
                    ApplicationArea = Basic;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Acc Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Name';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Telephone Number"; Rec."Telephone Number")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic;
                }
                field("Account No2"; Rec."Account No2")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field(Charge; Rec.Charge)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Client; Rec.Client)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(ConversationID; Rec.ConversationID)
                {
                    ApplicationArea = Basic;
                }
                field(OriginatorConversationID; Rec.OriginatorConversationID)
                {
                    ApplicationArea = Basic;
                }
                field(ResponseCode; Rec.ResponseCode)
                {
                    ApplicationArea = Basic;
                }
                field(ResponseDescription; Rec.ResponseDescription)
                {
                    ApplicationArea = Basic;
                }
                field(ReceiptNo; Rec.ReceiptNo)
                {
                    ApplicationArea = Basic;
                }
                field(ReceiverPartyPublicName; Rec.ReceiverPartyPublicName)
                {
                    ApplicationArea = Basic;
                }
                field(Response; Rec.Response)
                {
                    ApplicationArea = Basic;
                }
                field(ResultDesc; Rec.ResultDesc)
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




