//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50039 "Updated Change Request List"
{
    CardPageID = "Updated Change Request Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    DelayedInsert = false;
    ApplicationArea = All;
    SourceTable = "Change Request";
    SourceTableView = where(Changed = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile No"; rec."Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("KRA Pin(Old)"; Rec."KRA Pin(Old)")
                {
                    ApplicationArea = Basic;
                }
                field("KRA Pin(New)"; Rec."KRA Pin(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("No. Series"; rec."No. Series")
                {
                    ApplicationArea = Basic;
                }
                field(Address; rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(Branch; rec.Branch)
                {
                    ApplicationArea = Basic;
                }
                field(Picture; rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field(signinature; rec.signinature)
                {
                    ApplicationArea = Basic;
                }
                field(City; rec.City)
                {
                    ApplicationArea = Basic;
                }
                field("E-mail"; rec."E-mail")
                {
                    ApplicationArea = Basic;
                }
                field("Personal No"; rec."Personal No")
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                }
                field("Approval Status";Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                }
                field(Email; rec.Email)
                {
                    ApplicationArea = Basic;
                }
                field(Section; rec.Section)
                {
                    ApplicationArea = Basic;
                }
                field("Card No"; Rec."Card No")
                {
                    ApplicationArea = Basic;
                }
                field("Home Address"; Rec."Home Address")
                {
                    ApplicationArea = Basic;
                }
                field(Loaction; rec.Loaction)
                {
                    ApplicationArea = Basic;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    ApplicationArea = Basic;
                }
                field(District; rec.District)
                {
                    ApplicationArea = Basic;
                }
                field("Reason for change"; Rec."Reason for change")
                {
                    ApplicationArea = Basic;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                }
                field("S-Mobile No"; Rec."S-Mobile No")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Approve"; Rec."ATM Approve")
                {
                    ApplicationArea = Basic;
                }
                field("Card Expiry Date"; Rec."Card Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("Card Valid From"; Rec."Card Valid From")
                {
                    ApplicationArea = Basic;
                }
                field("Card Valid To"; Rec."Card Valid To")
                {
                    ApplicationArea = Basic;
                }
                field("Date ATM Linked"; Rec."Date ATM Linked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM No."; Rec."ATM No.")
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




