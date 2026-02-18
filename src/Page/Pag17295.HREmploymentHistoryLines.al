//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17295 "HR Employment History Lines"
{
    Caption = 'Employment History Lines';
    PageType = ListPart;
    SourceTable = "HR Employment History";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {

                field(Industry; Rec.Industry) { ApplicationArea = all; }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = Basic;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = Basic;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Years"; Rec."No. of Years") { ApplicationArea = all; }
                field("Hierarchy Level"; Rec."Hierarchy Level") { ApplicationArea = all; }
                field("Job Title"; Rec."Job Title")
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




