//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172801 "Loan Recovery Logs Card"
{
    PageType = Card;
    SourceTable = "Loan Recovery Logs";

    layout
    {
        area(content)
        {
            group(Control11)
            {
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Name";Rec."Member Name")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Loan No";Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Product Name";Rec."Loan Product Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Balance";Rec."Loan Balance")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Loan Amount In Arrears";Rec."Loan Amount In Arrears")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Loan Arrears Days";Rec."Loan Arrears Days")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("Log Description";Rec."Log Description")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Log Date";Rec."Log Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("User ID";Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control10;"Loans Recovery Logs History")
            {
                Editable = false;
                SubPageLink = "Loan No" = field("Loan No");
            }
        }
    }

    actions
    {
    }
}




