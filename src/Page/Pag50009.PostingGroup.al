page 50009 "Posting Group"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Payroll Posting Groups.";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Posting Code"; Rec."Posting Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Salary Account"; Rec."Salary Account")
                {
                    ApplicationArea = All;

                }
                field(SalaryExpenseAC; Rec.SalaryExpenseAC)
                {
                    ApplicationArea = All;

                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = All;

                }
                field("NHIF Employee Account"; Rec."NHIF Employee Account")
                {
                    ApplicationArea = All;

                }
                field("Pension Employee Acc"; Rec."Pension Employee Acc")
                {
                    ApplicationArea = All;

                }
                field("Pension Employer Acc"; Rec."Pension Employer Acc")
                {
                    ApplicationArea = All;

                }
                field("Employee Provident Fund Acc."; Rec."Employee Provident Fund Acc.")
                {
                    ApplicationArea = All;

                }
                field("Tax Relief"; Rec."Tax Relief")
                {
                    ApplicationArea = All;

                }
                field("Net Salary Payable"; Rec."Net Salary Payable")
                {
                    ApplicationArea = All;

                }
                field("SSF Employee Account"; Rec."SSF Employee Account")
                {
                    ApplicationArea = All;

                }
                field("SSF Employer Account"; Rec."SSF Employer Account")
                {
                    ApplicationArea = All;

                }
                field("PAYE Account"; Rec."PAYE Account")
                {
                    ApplicationArea = All;

                }
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