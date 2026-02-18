//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172778 "CRB Check Charge List"
{
    CardPageID = "CRB Charge Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "CRB Check Charge";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("FOSA Account to Charge";Rec."FOSA Account to Charge")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No";Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Effected";Rec."Charge Effected")
                {
                    ApplicationArea = Basic;
                }
                field("Charged By";Rec."Charged By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Charged Effected By';
                }
                field("Charged On";Rec."Charged On")
                {
                    ApplicationArea = Basic;
                    Caption = 'Charged Effected On';
                }
            }
        }
    }

    actions
    {
    }
}




