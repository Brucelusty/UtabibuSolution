//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50054 "Loans  List- pending approval"
{
    CardPageID = "Loan Application Card(Pending)";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loans Register";
    SourceTableView = where(Posted = filter(false),
    Source = filter(BOSA),
                            "Approval Status" = filter(Pending));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No.";Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Product';
                }
                field("Client Code";Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member  No';
                }
                field("Client Name";Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount";Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount";Rec."Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Branch Code";Rec."Branch Code")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status";Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date";Rec."Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Date of Completion";Rec."Expected Date of Completion")
                {
                    ApplicationArea = Basic;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic;
                }
                field("Rejection  Remark";Rec."Rejection  Remark")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance";Rec."Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest";Rec."Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001;"Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'Member Statistics';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Client Code");
            }
        }
    }

    trigger OnOpenPage()
    begin
        //IF UserSet.GET(USERID) THEN BEGIN
        //SETRANGE("Captured By",USERID);
        //END;
    end;

    var
        UserSet: Record User;
}




