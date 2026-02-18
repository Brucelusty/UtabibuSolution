page 80074 AGMMemberlist
{
    Caption = ' AGM Member List';
    // CardPageID = "Member Account Card";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Member Reports';
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Customer;
    SourceTableView = order(ascending) where(ISNormalMember = filter(true), "Account Category" = filter(Individual));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                }

                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }

                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {

                }

                // field("Group No"; Rec."Group No")
                // {
                //     ApplicationArea = basic;

                // }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;

                }
                field("Agm Present"; Rec."Agm Present")
                { ApplicationArea = Basic; }
            }
        }
    }
}