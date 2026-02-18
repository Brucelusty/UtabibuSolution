//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172984 "CRM Trainings"
{
    CardPageID = "CRM Training Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "CRM Trainings";
    SourceTableView = where("Training Status" = filter(Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field("Start Date";Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date";Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                }
                field(Provider; Rec.Provider)
                {
                    ApplicationArea = Basic;
                }
                field("Need Source";Rec."Need Source")
                {
                    ApplicationArea = Basic;
                }
                field(Closed; Rec.Closed)
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




