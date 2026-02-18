//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17305 "Bosa Receipt line-Checkoff"
{
    PageType = ListPart;
    SourceTable = "ReceiptsProcessing_L-Checkoff";

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Receipt Header No"; Rec."Receipt Header No") { }

                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Trans Type";Rec."Trans Type")
                {                    
                }
                field("Staff/Payroll No"; Rec."Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }

                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }

                field("Member Found"; Rec."Member Found")
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




