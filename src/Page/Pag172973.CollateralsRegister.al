//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172973 "Collaterals Register"
{
    CardPageID = "Collateral Action Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loan Collateral Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No.";Rec."Member No.")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Description";Rec."Collateral Description")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Code";Rec."Collateral Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Collateral Type';
                }
                field("Registered Owner";Rec."Registered Owner")
                {
                    ApplicationArea = Basic;
                }
                field("File No";Rec."File No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Serial No';
                }
                field("Asset Value";Rec."Asset Value")
                {
                    ApplicationArea = Basic;
                }
                field("Market Value";Rec."Market Value")
                {
                    ApplicationArea = Basic;
                }
                field("Forced Sale Value";Rec."Forced Sale Value")
                {
                    ApplicationArea = Basic;
                }
                field("Date Received";Rec."Date Received")
                {
                    ApplicationArea = Basic;
                }
                field("Received By";Rec."Received By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Released";Rec."Date Released")
                {
                    ApplicationArea = Basic;
                }
                field("Released By";Rec."Released By")
                {
                    ApplicationArea = Basic;
                }
                field("Last Collateral Action";Rec."Last Collateral Action")
                {
                    ApplicationArea = Basic;
                }
                field("Collateral Registered";Rec."Collateral Registered")
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




