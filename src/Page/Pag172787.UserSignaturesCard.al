//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172787 "User Signatures Card"
{
    PageType = Card;
    SourceTable = "User Signatures";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("User ID";Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            // part(Control5;"Signatureser Approval Signature")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Signature';
            //     SubPageLink = "User ID" = field("User ID");
            // }
        }
    }

    actions
    {
    }
}




