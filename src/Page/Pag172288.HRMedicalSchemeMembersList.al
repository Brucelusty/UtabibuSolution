//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172288 "HR Medical Scheme Members List"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Insurance Scheme Members";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Scheme No";Rec."Scheme No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No";Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("First Name";Rec."First Name")
                {
                    ApplicationArea = Basic;
                }
                field("Last Name";Rec."Last Name")
                {
                    ApplicationArea = Basic;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Scheme Join Date";Rec."Scheme Join Date")
                {
                    ApplicationArea = Basic;
                }
                field("Out-Patient Limit";Rec."Out-Patient Limit")
                {
                    ApplicationArea = Basic;
                }
                field("In-patient Limit";Rec."In-patient Limit")
                {
                    ApplicationArea = Basic;
                }
                field("Maximum Cover";Rec."Maximum Cover")
                {
                    ApplicationArea = Basic;
                }
                field("Cumm.Amount Spent";Rec."Cumm.Amount Spent")
                {
                    ApplicationArea = Basic;
                }
                field("No Of Dependants";Rec."No Of Dependants")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(Dependants)
            {
                ApplicationArea = Basic;
                Caption = 'Dependants';
                Image = Relatives;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "HR Employee Kin";
                RunPageLink = "No." = field("Employee No");
            }
        }
    }
}




