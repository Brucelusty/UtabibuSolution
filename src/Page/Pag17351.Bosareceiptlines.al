Page 17351 "Bosa receipt lines"
{
    PageType = ListPart;
    SourceTable = "Receipts Processing Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Receipt Line No";Rec."Receipt Line No")
                {
                    ApplicationArea = Basic;
                }
                field("Trans Type";Rec."Trans Type")
                {
                    ApplicationArea = Basic;
                }
                field("Principle/Interest";Rec."Principle/Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = ShouldStyle;
                }
                field("Staff/Payroll No";Rec."Staff/Payroll No")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code";Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan No";Rec."Loan No")
                {
                    ApplicationArea = Basic;
                }
                field(Amount;Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Interest Due to Be Paid";Rec."Interest Due to Be Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Not Found";Rec."Staff Not Found")
                {
                    ApplicationArea = Basic;
                }
                field("Member Found";Rec."Member Found")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Search Index";Rec."Search Index")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Found";Rec."Loan Found")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Expected Payment";Rec."Expected Payment")
                {
                    ApplicationArea = Basic;
                }
                field(Variance;Rec.Variance)
                {
                    ApplicationArea = Basic;
                }
                field(Outbalance;Rec.Outbalance)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ShouldStyle := (Rec.Variance<>0);
    end;

    var
        ColorCode: Boolean;
     
        ShouldStyle: Boolean;
}

