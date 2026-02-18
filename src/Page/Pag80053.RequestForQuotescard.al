page 80053 "Request For Quotes card"
{
    PageType = Card;
    DeleteAllowed = false;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Purchase Header";
    SourceTableView = where("AU Form Type" = filter('RFQ'));

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Enabled = false;

                }
                field("Purcahse Requisition No"; Rec."RFQ No.")
                {
                    ApplicationArea = ALL;
                    trigger OnValidate()
                    var
                        PurchaseLine: Record "Purchase Line";
                        NewPurchaseline: Record "Purchase Line";
                        PurchaseHeader: Record "Purchase Header";
                        NewHeader: Record "Purchase Header";

                    begin

                        if Confirm('Are you sure you want to replace the lines ? ') = false then exit;
                        PurchaseLine.Reset();
                        PurchaseLine.SetRange("Document No.", Rec."No.");
                        if PurchaseLine.Find('-') then begin
                            PurchaseLine.DeleteAll();
                        end;
                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."RFQ No.");
                        if PurchaseHeader.FindFirst() then begin

                            Rec."Currency Factor" := PurchaseHeader."Currency Factor";
                            Rec."Currency Code" := PurchaseHeader."Currency Code";
                            if not Rec.Insert(true) then
                                Rec.Modify(true);


                        end;
                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."RFQ No.");
                        if PurchaseHeader.FindFirst() then begin
                            PurchaseLine.Reset();
                            PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                            if PurchaseLine.Find('-') then begin
                                repeat
                                    NewPurchaseline.Init();
                                    NewPurchaseline."Document No." := Rec."No.";

                                    NewPurchaseline.Reset();
                                    NewPurchaseline.SetRange("Document Type", Rec."Document Type");
                                    NewPurchaseline.SetRange("Document No.", NewPurchaseline."Document No.");
                                    if NewPurchaseline.FindLast() then
                                        NewPurchaseline."Line No." := NewPurchaseline."Line No." + 1
                                    else
                                        NewPurchaseline."Line No." := 0;
                                    NewPurchaseline.Type := PurchaseLine.Type;
                                    NewPurchaseline."No." := PurchaseLine."No.";


                                    NewPurchaseline.Description := PurchaseLine.Description;

                                    NewPurchaseline."Description 2" := PurchaseLine."Description 2";
                                    NewPurchaseline.remarks := PurchaseLine.remarks;
                                    NewPurchaseline.Quantity := PurchaseLine.Quantity;
                                    NewPurchaseline."Unit of Measure" := PurchaseLine."Unit of Measure";
                                    NewPurchaseline."Currency Code" := PurchaseLine."Currency Code";
                                    //NewPurchaseline.Amount := PurchaseLine.Amount;
                                    NewPurchaseline.Insert(true);
                                until PurchaseLine.Next() = 0;
                            end;
                        end;

                    end;
                }


                field(Status; Rec.Status) { ApplicationArea = all; }


            }
       
            part(RFQLines; "RFQ Lines")
            {
                SubPageLink = "Document No." = field("No.");
                Caption = 'RFQ  Lines';
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    // ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                end;
            }

            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    // ApprovalMgt.OnCancelPurchaseApprovalRequest(Rec);
                end;
            }
            action("Attachment Document")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page Documents;
                RunPageLink = "Doc No." = field("No.");
            }
            action("RFQ Vendors")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "RFQ Vendors";
                RunPageLink = No = field("No.");
            }

            action("Bid Analysis Committee")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Bid Analysis Committee";
                RunPageLink = No = field("No.");
            }
            action("Bid Analysis Comment")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Bid Analysis Comment";
                RunPageLink = No = field("No.");
            }
            action("&Print")
            {
                ApplicationArea = Basic;
                Caption = 'Bid Analysis Matrix';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    //Message('%1|%2', Rec."RFQ No", Rec."No.");
                    Purchheader.Reset();
                    Purchheader.SetRange(Purchheader."No.", Rec."No.");

                    Report.Run(80037, true, true, Purchheader);

                end;
            }
            action("&Print2")
            {
                ApplicationArea = Basic;
                Caption = 'Request For Quotation Template';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    //Message('%1|%2', Rec."RFQ No", Rec."No.");
                    Purchheader.Reset();
                    Purchheader.SetRange(Purchheader."No.", Rec."No.");

                    Report.Run(50006, true, true, Purchheader);

                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        usersetup3: Record "User Setup";
        Customer: Record Customer;
    begin
        PurchasesPayablesSetup.Get();
        Rec."AU Form Type" := Rec."AU Form Type"::RFQ;
        Rec."Assigned User ID" := UserId;
        Rec.Status := Rec.Status::Open;
        PurchasesPayablesSetup.Get();
        Rec."User ID" := UserId;

        Rec."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Quotation Request No", Today, true);


    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        usersetup3: Record "User Setup";
        Customer: Record Customer;
    //PayablesSetup: Record payable
    begin
        PurchasesPayablesSetup.Get();
        Rec."AU Form Type" := Rec."AU Form Type"::RFQ;
        Rec."Assigned User ID" := UserId;
        Rec.Status := Rec.Status::Open;
        PurchasesPayablesSetup.Get();
        Rec."User ID" := UserId;

        ///Rec."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Quotation Request No", Today, true);
        Rec."Buy-from Vendor No." := PurchasesPayablesSetup."Requisition Default Vendor";
        Rec."Vendor Posting Group" := PurchasesPayablesSetup."Vendor Posting Group";

    end;

    trigger OnOpenPage()
    begin
        // Rec.SetRange("User ID", UserId);
    end;

    var
        myInt: Integer;
        //ApprovalMgt: Codeunit "Approvals Mgmt.";
        Purchheader: Record "Purchase Header";
}