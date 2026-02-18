page 50008 "InterestCharged"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Interest Buffer Table";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = All;

                }
                field("Member No"; Rec."Member No") { ApplicationArea = all; }
                field("Member Name"; Rec."Member Name") { ApplicationArea = all; }
                field("Interest Amount"; Rec."Interest Amount") { ApplicationArea = all; }
                field("Transaction Date"; Rec."Transaction Date") { ApplicationArea = all; }
                field(Time; Time) { ApplicationArea = all; }
                field(Description; Rec.Description) { ApplicationArea = all; }
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