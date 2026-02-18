//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172678 "Cheque Book Receipt Batch Card"
{
    PageType = Card;
    SourceTable = "Cheque Book  Receipt Batch";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Batch No."; Rec."Batch No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Description/Remarks"; Rec."Description/Remarks")
                {
                    ApplicationArea = Basic;
                }
                field(Requested; Rec.Requested)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                }
                field("Date Requested"; Rec."Date Requested")
                {
                    ApplicationArea = Basic;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = Basic;
                }
                field("Prepared By"; Rec."Prepared By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part(Control11; "Cheque Book Receipt SubPage")
            {
                SubPageLink = "Batch No." = field("Batch No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(LoadChequBookApplications)
            {
                ApplicationArea = Basic;
                Caption = 'Load Applied and Not Received Cheque Books';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjChequeBookApplied.Reset;
                    ObjChequeBookApplied.SetRange(ObjChequeBookApplied."Cheque Book Ordered", true);
                    ObjChequeBookApplied.SetRange(ObjChequeBookApplied."Cheque Book Received", false);
                    if ObjChequeBookApplied.FindSet then begin
                        repeat
                            ObjChequeBookReceipts.Init;
                            ObjChequeBookReceipts."Batch No." := Rec."Batch No.";
                            ObjChequeBookReceipts."Cheque Book Application No" := ObjChequeBookApplied."No.";
                            ObjChequeBookReceipts."Cheque Book Account No" := ObjChequeBookApplied."Account No.";
                            ObjChequeBookReceipts."Account Name" := ObjChequeBookApplied.Name;
                            ObjChequeBookReceipts."Cheque Book Application Date" := ObjChequeBookApplied."Application Date";
                            ObjChequeBookReceipts.Insert;
                        until ObjChequeBookApplied.Next = 0;
                    end;
                end;
            }
        }
    }

    var
        ObjChequeBookReceipts: Record "Cheque Book Receipt Lines";
        ObjChequeBookApplied: Record "Cheque Book Application";
}




