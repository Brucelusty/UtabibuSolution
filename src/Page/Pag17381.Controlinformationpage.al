//************************************************************************
page 17381 "Controlinformationpage"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Control-Information.";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Primary Key";Rec."Primary Key")
                {
                    ApplicationArea = All;

                }
                field("Payslip Message";Rec."Payslip Message")
                {

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


