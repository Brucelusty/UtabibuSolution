//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172299 "Hr Asset Transfer Lines"
{
    DeleteAllowed = false;
    PageType = ListPart;
    SourceTable = "HR Asset Transfer Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Asset No.";Rec."Asset No.")
                {
                    ApplicationArea = Basic;
                }
                field("Asset Bar Code";Rec."Asset Bar Code")
                {
                    ApplicationArea = Basic;
                }
                field("Asset Description";Rec."Asset Description")
                {
                    ApplicationArea = Basic;
                }
                field("FA Location";Rec."FA Location")
                {
                    ApplicationArea = Basic;
                }
                field("Asset Serial No";Rec."Asset Serial No")
                {
                    ApplicationArea = Basic;
                }
                field("Responsible Employee Code";Rec."Responsible Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name";Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("New Responsible Employee Code";Rec."New Responsible Employee Code")
                {
                    ApplicationArea = Basic;
                }
                field("New Employee Name";Rec."New Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 1 Name";Rec."Dimension 1 Name")
                {
                    ApplicationArea = Basic;
                }
                field("New Global Dimension 1 Code";Rec."New Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("New  Dimension 1 Name";Rec."New  Dimension 1 Name")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 2 Name";Rec."Dimension 2 Name")
                {
                    ApplicationArea = Basic;
                }
                field("New Global Dimension 2 Code";Rec."New Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("New  Dimension 2 Name";Rec."New  Dimension 2 Name")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 3 Code";Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension 3 Name";Rec."Dimension 3 Name")
                {
                    ApplicationArea = Basic;
                }
                field("New Global Dimension 3 Code";Rec."New Global Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                }
                field("New  Dimension 3 Name";Rec."New  Dimension 3 Name")
                {
                    ApplicationArea = Basic;
                }
                field("Is Asset Expected Back?";Rec."Is Asset Expected Back?")
                {
                    ApplicationArea = Basic;
                }
                field("New Asset Location";Rec."New Asset Location")
                {
                    ApplicationArea = Basic;
                }
                field("Reason for Transfer";Rec."Reason for Transfer")
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




