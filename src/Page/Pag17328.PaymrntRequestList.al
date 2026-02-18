page 17328 "Paymrnt Request List"
{
    ApplicationArea = All;
    Caption = 'Paymrnt Request List';
    CardPageID = "Payment Request Card";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Payments Header";
    SourceTableView = where("Payment Type" = filter("Payment Request"));


    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }

                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic;
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = Basic;
                }
                field("Total Payment Amount"; Rec."Total Payment Amount")
                {
                    ApplicationArea = Basic;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PrintNew)
            {
                ApplicationArea = Basic;
                Caption = 'Print/Preview';
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //TESTFIELD(Status,Status::Approved);
                    /*IF (Status=Status::Pending) OR  (Status=Status::"Pending Approval") THEN
                       ERROR('You cannot Print until the document is Approved'); */

                    PHeader2.Reset;
                    PHeader2.SetRange(PHeader2."No.", Rec."No.");
                    if PHeader2.FindFirst then
                        Report.run(172125, true, true, PHeader2);

                    /*RESET;
                    SETRANGE("No.","No.");
                    IF "No." = '' THEN
                      REPORT.RUNMODAL(51516000,TRUE,TRUE,Rec)
                    ELSE
                      REPORT.RUNMODAL(51516344,TRUE,TRUE,Rec);
                    RESET;
                    */

                end;
            }
        }
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange(Cashier, UserId);
    end;

    var
        PHeader2: Record "Payments Header";
}


