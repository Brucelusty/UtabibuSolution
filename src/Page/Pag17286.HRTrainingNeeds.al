//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17286 "HR Training Needs"
{
    CardPageID = "HR Training Needs Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Training Needs";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                Editable = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = Basic;
                }
                field("Duration Units"; Rec."Duration Units")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Re-Assessment Date"; Rec."Re-Assessment Date")
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
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755003; Outlook)
            {
            }
            systempart(Control1102755005; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Training Needs")
            {
                Caption = 'Training Needs';
                action("&Card")
                {
                    ApplicationArea = Basic;
                    Caption = '&Card';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // RunObject = Page "HR Training Needs";
                    // RunPageLink = Code = field(Code);
                }
            }
           
        }
        area(reporting)
        {
            action(Action1102755006)
            {
                ApplicationArea = Basic;
                Caption = 'Training Needs';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                //   RunObject = Report UnknownReport55595;
            }
        }
    }
}




