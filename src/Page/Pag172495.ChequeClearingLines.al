//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172495 "Cheque Clearing Lines"
{
    Editable = true;
    PageType = ListPart;
    SourceTable = "Cheque Clearing Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = true;
                field("Transaction No";Rec."Transaction No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque No";Rec."Cheque No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Maturity Date";Rec."Expected Maturity Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Clearing Status";Rec."Cheque Clearing Status")
                {
                    ApplicationArea = Basic;
                }
                field("Ledger Entry No";Rec."Ledger Entry No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Ledger Transaction No.";Rec."Ledger Transaction No.")
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

    trigger OnOpenPage()
    begin

        //SETRANGE(USER,USERID);
    end;
}




