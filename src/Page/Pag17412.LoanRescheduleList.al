//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17412 "Loan Reschedule List"
{
    CardPageID = "Loan Reschedule Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loan Rescheduling";
    SourceTableView = where(Rescheduled = filter(false));

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
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No";Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field("Rescheduled By";Rec."Rescheduled By")
                {
                    ApplicationArea = Basic;
                }
                field("Rescheduled Date";Rec."Rescheduled Date")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Amount";Rec."Repayment Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Principle Repayment";Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Interest Repayment";Rec."Loan Interest Repayment")
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




