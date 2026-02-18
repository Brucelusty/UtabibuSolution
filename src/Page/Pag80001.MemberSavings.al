page 80001 "MemberSavings"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = MemberSavings;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(MemberNo; rec.MemberNo)
                {
                    ApplicationArea = All;

                }
                field(Type; rec.Type)
                {
                    ApplicationArea = all;
                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Amount On"; rec."Amount On")
                {
                    ApplicationArea = all;
                }
                field("Amount Off"; rec."Amount Off")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
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