page 17261 "Members Group List"
{
    ApplicationArea = All;
    Caption = 'Members Group List';
    PageType = ListPart;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.") { ApplicationArea = all; }
                field(Name; Rec.Name) { ApplicationArea = all; }
                field("Group No"; Rec."Group No") { ApplicationArea = all; }
                field("Current Shares"; Rec."Current Shares") { ApplicationArea = all; }
                field("Shares Retained"; Rec."Shares Retained") { ApplicationArea = all; }
                field("Outstanding Balance"; Rec."Outstanding Balance") { ApplicationArea = all; }
            }
        }
    }
}
