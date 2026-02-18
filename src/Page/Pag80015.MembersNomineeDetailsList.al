//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 80015 "Members Nominee Details List"
{
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Members Next of Kin";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field("Account No";Rec."Account No")
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
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = Basic;
                }
                field("%Allocation";Rec."%Allocation")
                {
                    ApplicationArea = Basic;
                }
                field("Next Of Kin Type";Rec."Next Of Kin Type")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Birth";Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                    Caption= 'Additional Information';
                }
                field(Email; Rec.Email)
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




