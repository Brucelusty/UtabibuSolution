//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172914 "Crm Log List"
{
    CardPageID = "Crm log card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "General Equiries.";
    SourceTableView = where(Send = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Balance"; Rec."Loan Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Current Deposits"; Rec."Current Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Holiday Savings"; Rec."Holiday Savings")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No." = field("Member No");
            }
            part(Control1; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("Fosa account");
                Visible = false;
            }
        }
    }

    actions
    {
    }
}




