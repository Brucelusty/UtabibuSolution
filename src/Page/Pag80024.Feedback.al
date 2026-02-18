page 80024 "Feedback"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Response;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Member No."; Rec.MemberNo)
                {
                    ApplicationArea = All;

                }
                field(Message; Rec.Message) { ApplicationArea = all; }
                field("Action Date"; Rec.ActionDate) { ApplicationArea = all; }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}