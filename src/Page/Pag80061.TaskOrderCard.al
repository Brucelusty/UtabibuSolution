Page 80061 "Task Order Card"
{
    Caption = 'Purchase Requisition';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = const(Quote),
                            DocApprovalType = const(Requisition));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = statuseditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        //if AssistEdit(xRec) then
                        CurrPage.Update;
                    end;
                }


                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Request Date';
                    Editable = true;

                    trigger OnValidate()
                    begin
                        Rec."Requested Receipt Date" := Today;
                    end;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Required';

                    trigger OnValidate()
                    begin


                    end;
                }


                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Basic;

                }

                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                    Visible = true;
                    Caption = 'System User ID';
                }


                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;

                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.") 
                { 
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }




                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Visible = false;
                    trigger OnAssistEdit()
                    begin
                        Clear(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WorkDate);
                        if ChangeExchangeRate.RunModal = Action::OK then begin
                            Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.Update;
                        end;
                        Clear(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate;
                    end;
                }
            }
            part(PurchLines; "Requisition Subform")
            {
                Editable = statuseditable;
                SubPageLink = "Document No." = field("No.");
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false;
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = Basic;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = Basic;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = Basic;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control5; Notes)
            {
                Visible = false;
            }
            part(Control20; "Approval FactBox")
            {

                SubPageLink = "Table ID" = const(50000),
                              "Document Type" = field("Document Type"),
                              "Document No." = field("No.");
                Visible = false;
            }
            systempart(Control17; Links)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Quote")
            {
                Caption = '&Quote';
                Image = Quote;
                action(Statistics)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    Visible = false;
                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        Commit;
                        Page.RunModal(Page::"Purchase Statistics", Rec);
                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = field("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Visible = false;
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    Visible = false;
                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(Database::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Attachments)
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                RunObject = Page Documents;
                RunPageLink = "Doc No." = field("No.");
            }
            action("Send Approval Request")
            {

                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                Enabled = StatusEditable;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Request approval of the document.';

                trigger OnAction()
                var
                    //ApprovalsMgmt: Codeunit WorkflowIntegration;
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    if ApprovalMgt.CheckPurchaseApprovalPossible(Rec) then
                        ApprovalMgt.OnSendPurchaseDocForApproval(Rec);


                end;
            }
            action("&Print")
            {
                ApplicationArea = Basic;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    if LinesCommitted then
                        Error('All Lines should be committed');
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(80032, true, true, Rec);
                    //Reset;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action("Mark As Completed")
            {
                ApplicationArea = Basic;
                Caption = 'Mark As Completed';
                Image = Archive;

                trigger OnAction()
                begin

                    if Confirm('Are you sure you want to mark the requisition as Completed?') then begin
                        Rec.Completed := true;
                        Rec.Modify;
                    end;

                end;
            }
            group(ActionGroup3)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(Action148)
                {
                }
                action(Release)
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Award Schedule")
                {
                    ApplicationArea = Basic;
                    //RunObject = Page UnknownPage55947;
                }
                action("Re&open")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        // ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                Visible = false;
                action("Calculate &Invoice Discount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    Visible = false;
                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                separator(Action144)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    ApplicationArea = Basic;
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = VendorCode;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        // StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(Action146)
                {
                }
                action(CopyDocument)
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RunModal;
                        Clear(CopyPurchDoc);
                    end;
                }
                action("Archive Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        //ArchiveManagement.ArchivePurchDocument(Rec);
                        //CurrPage.UPDATE(FALSE);
                        if Confirm('Are you sure you want to archive the requisition') then begin
                            Rec.Archived := true;
                            Rec.Modify;
                        end;
                        Message('Document Archived');
                    end;
                }

                separator(Action147)
                {
                }
                action(SendApprovalRequest)
                {

                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin


                        if ApprovalMgt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalMgt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                separator(Action10)
                {
                }
            }

        }
    }

    trigger OnAfterGetCurrRecord()
    begin

    end;

    trigger OnAfterGetRecord()
    begin
        CurrPageUpdate;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        //exit(ConfirmDeletion);
        Error('Not Allowed!');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.DocApprovalType := Rec.Docapprovaltype::Requisition;


    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        PurchasesPayablesSetup.Get;
        Rec."Doc Type" := Rec."doc type"::PurchReq;
        REC."AU Form Type" := REC."AU Form Type"::"Purchase Request";
        Rec."No." := NoSeriesManagement.GetNextNo(PurchasesPayablesSetup."Requisition No", Today, true);
        Rec."Assigned User ID" := UserId;
        Rec."User ID" := UserId;
        Rec."Buy-from Vendor No." := PurchasesPayablesSetup."Requisition Default Vendor";
        Rec."Pay-to Vendor No." := PurchasesPayablesSetup."Requisition Default Vendor";
        Rec."Vendor Posting Group" := PurchasesPayablesSetup."Vendor Posting Group";
        Rec."Requested Receipt Date" := Today;



        Rec.PR := true;
        // Rec.Requisition := true;
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.", '.');
        if Vendor.FindFirst then begin
            Rec."Buy-from Vendor No." := Vendor."No.";
            Rec.Validate("Buy-from Vendor No.");
        end;


        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin

        if UserMgt.GetPurchasesFilter <> '' then begin
            Rec.FilterGroup(2);
            //Rec.SetRange("Responsibility Center", UserMgt.GetPurchasesFilter);
            Rec.FilterGroup(0);
        end;
        Rec."Doc Type" := Rec."doc type"::PurchReq;
        Rec."Assigned User ID" := UserId;

        //SETRANGE("User ID",USERID);
    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchLine: Record "Purchase Line";
        StatusEditable: Boolean;
        Vendor: Record Vendor;
        HREmployee: Record "HR Employees";
        PurchHeader: Record "Purchase Header";
        SHeader: Record "Purchase Header";
        //ApprovalMgt: Codeunit "Approvals Mgmt.";
        UserSetup: Record "User Setup";
        HREmployees: Record "HR Employees";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        PurchLine2: Record "Purchase Line";
        PurchaseLine3: Record "Purchase Line";
        PurchaseHeader: Record "Purchase Header";
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";

    local procedure ApproveCalcInvDisc()
    begin
        //CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        if Rec.GetFilter("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                Rec.SetRange("Buy-from Vendor No.");
        CurrPage.Update;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.Update;
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;


    procedure LinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
    end;


    procedure SomeLinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
    end;


    procedure UpdateControls()
    begin
        if Rec.Status = Rec.Status::Open then
            StatusEditable := true
        else
            StatusEditable := false;
    end;


    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        UpdateControls;
        CurrPage.Update;
    end;

    procedure UpdateControl()
    begin
        if Rec.Status = Rec.Status::Open then begin

        end;
    end;
}

