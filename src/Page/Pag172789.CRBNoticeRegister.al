//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172789 "CRB Notice Register"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "CRB Notice Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No";Rec."Loan No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Name";Rec."Loan Product Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Issued Date";Rec."Issued Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Principle Outstanding";Rec."Principle Outstanding")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Amount In Arrears";Rec."Amount In Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Days In Arrears";Rec."Days In Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("CRB Listed";Rec."CRB Listed")
                {
                    ApplicationArea = Basic;
                }
                field("Date Listed";Rec."Date Listed")
                {
                    ApplicationArea = Basic;
                }
                field("Listed By";Rec."Listed By")
                {
                    ApplicationArea = Basic;
                }
                field(Delist; Rec.Delist)
                {
                    ApplicationArea = Basic;
                }
                field("DeListed On";Rec."DeListed On")
                {
                    ApplicationArea = Basic;
                }
                field("Delisted By";Rec."Delisted By")
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




