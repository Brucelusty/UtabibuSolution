page 17317 "Rejected Loans"
{
    ApplicationArea = All;
    Caption = 'Rejected Loans';
    PageType = List;
    SourceTable = "Loans Register";
    UsageCategory = History;

    CardPageID = "Loan Application Card(BOSA)";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;

    SourceTableView = where(Posted = filter(false),
                            Source = const(BOSA),
                            "Approval Status" = filter(Rejected), "Loan Status" = filter(Rejected));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Loan  No."; Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code"; Rec."Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("ID NO"; Rec."ID NO")
                {
                    ApplicationArea = Basic;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }
                field(Source; rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
            }
        }
    }

}

