//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172800 "Loan Recovery Logs List"
{
    CardPageID = "Loan Recovery Logs Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loan Recovery Logs";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No";Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Name";Rec."Loan Product Name")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Balance";Rec."Loan Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Log Date";Rec."Log Date")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";Rec."User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Log Description";Rec."Log Description")
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




