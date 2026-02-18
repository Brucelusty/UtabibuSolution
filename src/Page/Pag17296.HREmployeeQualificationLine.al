//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17296 "HR Employee Qualification Line"
{
    Caption = 'Employee Qualification Lines';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Employee Qualifications";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {

                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = Basic;
                }
                field("Qualification Description"; Rec."Qualification Description")
                {
                    ApplicationArea = Basic;
                }
                field("Field of Study"; Rec."Field of Study")
                {
                    ApplicationArea = Basic;
                }
                field("Education Level"; Rec."Education Level") { ApplicationArea = all; }
                field("Institution Type"; Rec."Institution Type") { ApplicationArea = all; }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = Basic;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = Basic;
                }

                field("Institution/Company"; Rec."Institution/Company")
                {
                    ApplicationArea = Basic;
                }
                field("Course Grade"; Rec."Course Grade")
                {
                    ApplicationArea = Basic;
                }
                field("Proficiency Level"; Rec."Proficiency Level") { ApplicationArea = all; }
                field(Country; Rec.Country) { ApplicationArea = all; }
                field(Score; Rec.Score) { ApplicationArea = all; }

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Q&ualification")
            {
                Caption = 'Q&ualification';
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = const("Employee Qualification"),
                                  "No." = field("Employee No."),
                                  "Table Line No." = field("Line No.");
                }
                separator(Action1102755021)
                {
                }
                action("Q&ualification Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Q&ualification Overview';
                    RunObject = Page "Qualification Overview";
                }
            }
        }
    }
}




