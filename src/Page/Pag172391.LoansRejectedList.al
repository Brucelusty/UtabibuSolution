//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172391 "Loans Rejected List"
{
    CardPageID = "Loans Rejected Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loans Register";
    SourceTableView = where("Approval Status" = const(Rejected));

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
                    Caption = 'Member No';
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
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic;
                }
                field(Insurance; Rec.Insurance)
                {
                    ApplicationArea = Basic;
                }
                field("Source of Funds";Rec."Source of Funds")
                {
                    ApplicationArea = Basic;
                }
                field("Client Cycle";Rec."Client Cycle")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status";Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date";Rec."Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                }
                field("Rejected By";Rec."Rejected By")
                {
                    ApplicationArea = Basic;
                }
                field("Rejection  Remark";Rec."Rejection  Remark")
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




