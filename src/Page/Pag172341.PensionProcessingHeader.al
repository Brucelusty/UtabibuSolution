//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172341 "Pension Processing Header"
{
    PageType = Card;
    SourceTable = "Pension Processing Headerr";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By";Rec."Entered By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Entered";Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date";Rec."Posting date")
                {
                    ApplicationArea = Basic;
                }
                field("Document No";Rec."Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count";Rec."Total Count")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By";Rec."Posted By")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No.";Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Amount";Rec."Scheduled Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code";Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Pre-Post Blocked Status Update";Rec."Pre-Post Blocked Status Update")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Post-Post Blocked Statu Update";Rec."Post-Post Blocked Statu Update")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("172000";"Pension Processing Lines")
            {
                Caption = 'Salary Processing Lines';
                SubPageLink = "Salary Header No." = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Salaries")
            {
                ApplicationArea = Basic;
                Caption = 'Import Salaries';
                //   RunObject = XMLport UnknownXMLport172025;
            }
            group(ActionGroup1102755021)
            {
                action("UnBlocked Accounts Status")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then
                            Report.run(172862, true, false, salarybuffer);

                        Rec."Pre-Post Blocked Status Update" := true;
                        Rec.Modify;
                    end;
                }
                action("Block Blocked Accounts Status")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then
                            Report.run(172863, true, false, salarybuffer);

                        Rec."Post-Post Blocked Statu Update" := true;
                        Rec.Modify;
                    end;
                }
                action("Validate Salary ")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then
                            Report.run(172353, true, false, salarybuffer);
                    end;
                }
                action("Generate Pension Batch")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Pension Batch';

                    trigger OnAction()
                    begin
                        Rec.TestField(Amount);



                        salarybuffer.Reset;
                        salarybuffer.SetRange(salarybuffer."Salary Header No.", Rec.No);
                        if salarybuffer.Find('-') then
                            Report.run(172532, true, false, salarybuffer);
                        // Report.run(172539,TRUE,FALSE,salarybuffer);
                        //Posted:=TRUE;
                        //"Posted By":=USERID;
                        //MODIFY;
                    end;
                }
                action("Mark as processed")
                {
                    ApplicationArea = Basic;
                    //  RunObject = Report UnknownReport39004375;
                }
            }
            group(ActionGroup1102755019)
            {
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
       Rec. Pension := true;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record "Members Register";
        salarybuffer: Record "Pension Processing Lines";
        SalHeader: Record "Pension Processing Headerr";
        Sto: Record "Standing Orders";
}




