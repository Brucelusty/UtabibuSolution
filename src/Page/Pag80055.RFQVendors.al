page 80055 "RFQ Vendors"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = RFQ;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;

                }
                field("Vendor No"; Rec."Vendor No") { ApplicationArea = all; }
                field("Vendor Name"; Rec."Vendor Name") { ApplicationArea = all;Editable=true; }
                field(Email;Rec.Email){ApplicationArea=all;}
                field("Captured by"; Rec."Captured by") { ApplicationArea = all; }
                field("Date Time"; Rec."Date Time") { ApplicationArea = all; }
            }
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
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Captured by" := UserId;
        Rec."Date Time" := CurrentDateTime;
    end;
}