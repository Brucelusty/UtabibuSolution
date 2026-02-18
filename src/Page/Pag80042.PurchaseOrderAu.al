page 80042 "Purchase OrderAu"
{
    Caption = 'Purchase Order';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Order,Request Approval,Print/Send,Navigate';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = Suite;
                    Caption = 'Vendor No.';
                    Importance = Additional;
                    NotBlank = true;
                    ToolTip = 'Specifies the number of the vendor who delivers the products.';

                    trigger OnValidate()
                    begin
                        Rec.OnAfterValidateBuyFromVendorNo(Rec, xRec);
                        CurrPage.Update();
                    end;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = Suite;
                    Caption = 'Vendor Name';
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the vendor who delivers the products.';

                    trigger OnValidate()
                    begin
                        Rec.OnAfterValidateBuyFromVendorNo(Rec, xRec);
                        CurrPage.Update();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        exit(Rec.LookupBuyFromVendorName(Text));
                    end;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies additional posting information for the document. After you post the document, the description can add detail to vendor and customer ledger entries.';
                    Visible = true;
                }
                group("Buy-from")
                {
                    Caption = 'Buy-from';
                    field("Buy-from Address"; Rec."Buy-from Address")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Address';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the vendor''s buy-from address.';
                    }
                    field("Buy-from Address 2"; Rec."Buy-from Address 2")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Address 2';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies an additional part of the vendor''s buy-from address.';
                    }
                    field("Buy-from City"; Rec."Buy-from City")
                    {
                        ApplicationArea = Suite;
                        Caption = 'City';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the city of the vendor on the purchase document.';
                    }
                    group(Control122)
                    {
                        ShowCaption = false;
                        Visible = IsBuyFromCountyVisible;
                        field("Buy-from County"; Rec."Buy-from County")
                        {
                            ApplicationArea = Suite;
                            Caption = 'County';
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the state, province or county of the address.';
                        }
                    }
                    field("Buy-from Post Code"; Rec."Buy-from Post Code")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Post Code';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Posting No. Series"; Rec."Posting No. Series")
                    {
                        ApplicationArea = basic;
                    }
                    field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Country/Region';
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies the country or region of the address.';

                        trigger OnValidate()
                        begin
                            IsBuyFromCountyVisible := FormatAddress.UseCounty(Rec."Buy-from Country/Region Code");
                        end;
                    }
                    field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Contact No.';
                        Importance = Additional;
                        ToolTip = 'Specifies the number of contact person of the vendor''s buy-from.';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            if not Rec.BuyfromContactLookup() then
                                exit(false);
                            Text := Rec."Buy-from Contact No.";
                            CurrPage.Update();
                            exit(true);
                        end;

                        trigger OnValidate()
                        begin
                            if xRec."Buy-from Contact No." <> Rec."Buy-from Contact No." then
                                CurrPage.Update();
                        end;
                    }
                    field(BuyFromContactPhoneNo; BuyFromContact."Phone No.")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Phone No.';
                        Importance = Additional;
                        Editable = false;
                        ExtendedDatatype = PhoneNo;
                        ToolTip = 'Specifies the telephone number of the vendor contact person.';
                    }
                    field(BuyFromContactMobilePhoneNo; BuyFromContact."Mobile Phone No.")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Mobile Phone No.';
                        Importance = Additional;
                        Editable = false;
                        ExtendedDatatype = PhoneNo;
                        ToolTip = 'Specifies the mobile telephone number of the vendor contact person.';
                    }
                    field(BuyFromContactEmail; BuyFromContact."E-Mail")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Email';
                        Importance = Additional;
                        Editable = false;
                        ExtendedDatatype = EMail;
                        ToolTip = 'Specifies the email address of the vendor contact person.';
                    }
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = Suite;
                    Caption = 'Contact';
                    Editable = Rec."Buy-from Vendor No." <> '';
                    ToolTip = 'Specifies the name of the person to contact about an order from this vendor.';
                }
                field("Purcahse Requisition No"; Rec."RFQ No")
                {
                    ApplicationArea = ALL;
                    trigger OnValidate()
                    var
                        PurchaseLine: Record "Purchase Line";
                        NewPurchaseline: Record "Purchase Line";
                        PurchaseHeader: Record "Purchase Header";
                        NewHeader: Record "Purchase Header";

                    begin

                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."RFQ No");
                        if PurchaseHeader.FindFirst() then begin

                            Rec."Currency Factor" := PurchaseHeader."Currency Factor";
                            Rec."Currency Code" := PurchaseHeader."Currency Code";

                            Rec.Modify(true);


                        end;
                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."RFQ No");
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
                                    NewPurchaseline."Unit of Measure" := PurchaseLine."Unit of Measure";

                                    NewPurchaseline.Description := PurchaseLine.Description;

                                    NewPurchaseline."Description 2" := PurchaseLine."Description 2";

                                    NewPurchaseline.remarks := PurchaseLine.remarks;
                                    NewPurchaseline.Quantity := PurchaseLine.Quantity;
                                    NewPurchaseline."Currency Code" := PurchaseLine."Currency Code";
                                    //NewPurchaseline.Amount := PurchaseLine.Amount;
                                    NewPurchaseline.Insert(true);
                                until PurchaseLine.Next() = 0;
                            end;
                        end;

                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the posting date of the record.';

                    trigger OnValidate()
                    begin
                        SaveInvoiceDiscountAmount;
                    end;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies when the related purchase invoice must be paid.';
                }
                field("Receiving No."; Rec."Receiving No.")
                {
                    ApplicationArea = basic;
                    Caption = 'Delivery Note No';
                    ShowMandatory = true;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = Suite;
                    ShowMandatory = VendorInvoiceNoMandatory;
                    ToolTip = 'Specifies the document number of the original document you received from the vendor. You can require the document number for posting, or let it be optional. By default, it''s required, so that this document references the original. Making document numbers optional removes a step from the posting process. For example, if you attach the original invoice as a PDF, you might not need to enter the document number. To specify whether document numbers are required, in the Purchases & Payables Setup window, select or clear the Ext. Doc. No. Mandatory field.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    Visible = false;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';

                    trigger OnValidate()
                    begin
                        PurchaserCodeOnAfterValidate;
                    end;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    Visible = false;
                    ToolTip = 'Specifies the number of archived versions for this document.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the date the order was created. The order date is also used to determine the prices and discounts on the document.';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the quote number for the purchase order.';
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    Importance = Additional;
                    ToolTip = 'Specifies the vendor''s order number.';
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                    ToolTip = 'Specifies the vendor''s shipment number.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group") { ApplicationArea = all; }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Alternate Vendor Address Code';
                    Importance = Additional;
                    Visible = false;
                    ToolTip = 'Specifies the order address of the related vendor.';
                    Enabled = Rec."Buy-from Vendor No." <> '';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    Visible = false;
                    ToolTip = 'Specifies the code of the responsibility center, such as a distribution hub, that is associated with the involved user, company, customer, or vendor.';
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    Visible = false;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    StyleExpr = StatusStyleTxt;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase orders.';
                    Visible = JobQueueUsed;
                }
            }
            part(PurchLines; "Purchase Order SubformAu")
            {
                ApplicationArea = Suite;
                Editable = Rec."Buy-from Vendor No." <> '';
                Enabled = Rec."Buy-from Vendor No." <> '';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group("Invoice Details")
            {
                Caption = 'Invoice Details';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the currency of amounts on the purchase document.';

                    trigger OnAssistEdit()
                    begin
                        Clear(ChangeExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WorkDate);
                        if ChangeExchangeRate.RunModal = ACTION::OK then begin
                            Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter);
                            SaveInvoiceDiscountAmount;
                        end;
                        Clear(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord;
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date you expect the items to be available in your warehouse. If you leave the field blank, it will be calculated as follows: Planned Receipt Date + Safety Lead Time + Inbound Warehouse Handling Time = Expected Receipt Date.';
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = VAT;
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = IsPostingGroupEditable;
                    Importance = Additional;
                    ToolTip = 'Specifies the vendor''s market type to link business transactions to.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                    Visible = IsPaymentMethodCodeVisible;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                }
                field("Journal Templ. Name"; Rec."Journal Templ. Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the journal template in which the purchase header is to be posted.';
                    Visible = IsJournalTemplNameVisible;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = SalesTax;
                    Importance = Additional;
                    ToolTip = 'Specifies if this vendor charges you sales tax for purchases.';

                    trigger OnValidate()
                    begin
                        SaveInvoiceDiscountAmount;
                    end;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = SalesTax;
                    Importance = Additional;
                    ToolTip = 'Specifies the tax area code used for this purchase to calculate and post sales tax.';

                    trigger OnValidate()
                    begin
                        SaveInvoiceDiscountAmount;
                    end;
                }

                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the payment of the purchase invoice.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the number of the vendor.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies that the related entry represents an unpaid invoice for which either a payment suggestion, a reminder, or a finance charge memo exists.';
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = Warehouse;
                    Importance = Additional;
                    ToolTip = 'Specifies the time it takes to make items part of available inventory, after the items have been posted as received.';
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the date that you want the vendor to deliver to the ship-to address.';
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ApplicationArea = OrderPromising;
                    ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
                }

            }
            group("Shipping and Payment")
            {
                Caption = 'Shipping and Payment';
                group(Control83)
                {
                    ShowCaption = false;
                    group(Control94)
                    {
                        ShowCaption = false;
                        field(ShippingOptionWithLocation; ShipToOptions)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Ship-to';
                            HideValue = NOT ShowShippingOptionsWithLocation AND (ShipToOptions = ShipToOptions::Location);
                            OptionCaption = 'Default (Company Address),Location,Customer Address,Custom Address';
                            ToolTip = 'Specifies the address that the products on the purchase document are shipped to. Default (Company Address): The same as the company address specified in the Company Information window. Location: One of the company''s location addresses. Customer Address: Used in connection with drop shipment. Custom Address: Any ship-to address that you specify in the fields below.';

                            trigger OnValidate()
                            begin
                                ValidateShippingOption;
                            end;
                        }
                        group(Control99)
                        {
                            ShowCaption = false;
                            group(Control98)
                            {
                                ShowCaption = false;
                                Visible = ShipToOptions = ShipToOptions::Location;
                                field("Location Code"; Rec."Location Code")
                                {
                                    ApplicationArea = Location;
                                    Importance = Promoted;
                                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                                }
                            }
                            group(Control101)
                            {
                                ShowCaption = false;
                                Visible = ShipToOptions = ShipToOptions::"Customer Address";
                                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                                {
                                    ApplicationArea = Suite;
                                    Caption = 'Customer';
                                    ToolTip = 'Specifies the number of the customer that the items are shipped to directly from your vendor, as a drop shipment.';
                                }
                                field("Ship-to Code"; Rec."Ship-to Code")
                                {
                                    ApplicationArea = Suite;
                                    Editable = Rec."Sell-to Customer No." <> '';
                                    ToolTip = 'Specifies the code for another delivery address than the vendor''s own address, which is entered by default.';
                                }
                            }
                            field("Ship-to Name"; Rec."Ship-to Name")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Name';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies the name of the company at the address that you want the items on the purchase document to be shipped to.';
                            }
                            field("Ship-to Address"; Rec."Ship-to Address")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the address that you want the items on the purchase document to be shipped to.';
                            }
                            field("Ship-to Address 2"; Rec."Ship-to Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Address 2';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies additional address information.';
                            }
                            field("Ship-to City"; Rec."Ship-to City")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'City';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the city of the vendor on the purchase document.';
                            }
                            group(Control124)
                            {
                                ShowCaption = false;
                                Visible = IsShipToCountyVisible;
                                field("Ship-to County"; Rec."Ship-to County")
                                {
                                    ApplicationArea = Basic, Suite;
                                    Caption = 'County';
                                    Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                    Importance = Additional;
                                    QuickEntry = false;
                                    ToolTip = 'Specifies the state, province or county of the address.';
                                }
                            }
                            field("Ship-to Post Code"; Rec."Ship-to Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Post Code';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the postal code of the address that you want the items on the purchase document to be shipped to.';
                            }
                            field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Country/Region';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the country/region code of the address that you want the items on the purchase document to be shipped to.';

                                trigger OnValidate()
                                begin
                                    IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
                                end;
                            }
                            field("Ship-to Contact"; Rec."Ship-to Contact")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'Contact';
                                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                                Importance = Additional;
                                ToolTip = 'Specifies the name of a contact person for the address of the address that you want the items on the purchase document to be shipped to.';
                            }

                        }
                    }
                }
                group(Control71)
                {
                    ShowCaption = false;
                    field(PayToOptions; PayToOptions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pay-to';
                        OptionCaption = 'Default (Vendor),Another Vendor,Custom Address';
                        ToolTip = 'Specifies the vendor that the purchase document will be paid to. Default (Vendor): The same as the vendor on the purchase document. Another Vendor: Any vendor that you specify in the fields below.';

                        trigger OnValidate()
                        begin
                            if PayToOptions = PayToOptions::"Default (Vendor)" then
                                Rec.Validate("Pay-to Vendor No.", Rec."Buy-from Vendor No.");
                        end;
                    }
                    group(Control95)
                    {
                        ShowCaption = false;
                        Visible = NOT (PayToOptions = PayToOptions::"Default (Vendor)");
                        field("Pay-to Name"; Rec."Pay-to Name")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Name';
                            Editable = (PayToOptions = PayToOptions::"Another Vendor") or ((PayToOptions = PayToOptions::"Custom Address") and not ShouldSearchForVendByName);
                            Enabled = (PayToOptions = PayToOptions::"Another Vendor") or ((PayToOptions = PayToOptions::"Custom Address") and not ShouldSearchForVendByName);
                            Importance = Promoted;
                            ToolTip = 'Specifies the name of the vendor sending the invoice.';

                            trigger OnValidate()
                            begin
                                if not ((PayToOptions = PayToOptions::"Custom Address") and not ShouldSearchForVendByName) then begin
                                    if Rec.GetFilter("Pay-to Vendor No.") = xRec."Pay-to Vendor No." then
                                        if Rec."Pay-to Vendor No." <> xRec."Pay-to Vendor No." then
                                            Rec.SetRange("Pay-to Vendor No.");

                                    CurrPage.Update();
                                end;
                            end;
                        }
                        field("Pay-to Address"; Rec."Pay-to Address")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the address of the vendor sending the invoice.';
                        }
                        field("Pay-to Address 2"; Rec."Pay-to Address 2")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Address 2';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies additional address information.';
                        }
                        field("Pay-to City"; Rec."Pay-to City")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'City';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the city of the vendor on the purchase document.';
                        }
                        group(Control123)
                        {
                            ShowCaption = false;
                            Visible = IsPayToCountyVisible;
                            field("Pay-to County"; Rec."Pay-to County")
                            {
                                ApplicationArea = Basic, Suite;
                                Caption = 'County';
                                Editable = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                                Enabled = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                                Importance = Additional;
                                QuickEntry = false;
                                ToolTip = 'Specifies the state, province or county of the address.';
                            }
                        }
                        field("Pay-to Post Code"; Rec."Pay-to Post Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Post Code';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the postal code.';
                        }
                        field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Country/Region';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Importance = Additional;
                            QuickEntry = false;
                            ToolTip = 'Specifies the country/region code of the vendor on the purchase document.';

                            trigger OnValidate()
                            begin
                                IsPayToCountyVisible := FormatAddress.UseCounty(Rec."Pay-to Country/Region Code");
                            end;
                        }
                        field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Contact No.';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Importance = Additional;
                            ToolTip = 'Specifies the number of contact person of the vendor''s buy-from.';
                        }
                        field("Pay-to Contact"; Rec."Pay-to Contact")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Contact';
                            Editable = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            Enabled = (PayToOptions = PayToOptions::"Custom Address") OR (Rec."Buy-from Vendor No." <> Rec."Pay-to Vendor No.");
                            ToolTip = 'Specifies the name of the person to contact about an order from this vendor.';
                        }
                        field(PayToContactPhoneNo; PayToContact."Phone No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Phone No.';
                            Editable = false;
                            Importance = Additional;
                            ExtendedDatatype = PhoneNo;
                            ToolTip = 'Specifies the telephone number of the person to contact about an order from this vendor.';
                        }
                        field(PayToContactMobilePhoneNo; PayToContact."Mobile Phone No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Mobile Phone No.';
                            Editable = false;
                            Importance = Additional;
                            ExtendedDatatype = PhoneNo;
                            ToolTip = 'Specifies the mobile telephone number of the person to contact about an order from this vendor.';
                        }
                        field(PayToContactEmail; PayToContact."E-Mail")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Email';
                            Editable = false;
                            Importance = Additional;
                            ExtendedDatatype = Email;
                            ToolTip = 'Specifies the email address of the person to contact about an order from this vendor.';
                        }
                    }
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = BasicEU;
                    ToolTip = 'Specifies a specification of the document''s transaction, for the purpose of reporting to INTRASTAT.';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = BasicEU;
                    ToolTip = 'Specifies the type of transaction that the document represents, for the purpose of reporting to INTRASTAT.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = BasicEU;
                    ToolTip = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.';
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = BasicEU;
                    ToolTip = 'Specifies the code of the port of entry where the items pass into your country/region, for reporting to Intrastat.';
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = BasicEU;
                    ToolTip = 'Specifies the destination country or region for the purpose of Intrastat reporting.';
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = Prepayments;
                    Importance = Promoted;
                    ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for sales.';

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies that prepayments on the purchase order are combined if they have the same general ledger account for prepayments or the same dimensions.';
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the code that represents the payment terms for prepayment invoices related to the purchase document.';
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    ApplicationArea = Prepayments;
                    Importance = Promoted;
                    ToolTip = 'Specifies when the prepayment invoice for this purchase order is due.';
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the payment discount percent granted on the prepayment if the vendor pays on or before the date entered in the Prepmt. Pmt. Discount Date field.';
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = Prepayments;
                    ToolTip = 'Specifies the last date the vendor can pay the prepayment invoice and still receive a payment discount on the prepayment amount.';
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the number that the vendor uses for the purchase order.';
                }

            }

        }
        area(factboxes)
        {
            part(PurchaseDocCheckFactbox; "Purch. Doc. Check Factbox")
            {
                ApplicationArea = All;
                Caption = 'Document Check';
                Visible = PurchaseDocCheckFactboxVisible;
                SubPageLink = "No." = FIELD("No."),
                              "Document Type" = FIELD("Document Type");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(38),
                              "No." = FIELD("No."),
                              "Document Type" = FIELD("Document Type");
            }
            part(Control23; "Pending Approval FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control1903326807; "Item Replenishment FactBox")
            {
                ApplicationArea = Suite;
                Provider = PurchLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(ApprovalFactBox; "Approval FactBox")
            {
                ApplicationArea = Suite;
                Visible = false;
            }
            part(Control1901138007; "Vendor Details FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = field("Date Filter");
                Visible = false;
            }
            part(Control1904651607; "Vendor Statistics FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Pay-to Vendor No."),
                              "Date Filter" = field("Date Filter");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Suite;
                ShowFilter = false;
                Visible = false;
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = field("Date Filter");
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                ApplicationArea = Suite;
                SubPageLink = "No." = FIELD("Pay-to Vendor No."),
                              "Date Filter" = field("Date Filter");
                Visible = false;
            }
            part(Control3; "Purchase Line FactBox")
            {
                ApplicationArea = Suite;
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = Suite;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Enabled = Rec."No." <> '';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                    trigger OnAction()
                    begin
                        Rec.PrepareOpeningDocumentStatistics();
                        OnBeforeCalculateSalesTaxStatistics(Rec, true);
                        Rec.ShowDocumentStatisticsPage();
                        CurrPage.PurchLines.Page.ForceTotalsCalculation();
                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = Suite;
                    Caption = 'Vendor';
                    Enabled = Rec."Buy-from Vendor No." <> '';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Category11;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No."),
                                  "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category8;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                      ApprovalsMgmt.OpenApprovalsPurchase(Rec);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'View or add comments for the record.';
                }
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category8;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal();
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Receipts)
                {
                    ApplicationArea = Suite;
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    Promoted = true;
                    PromotedCategory = Category11;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'View a list of posted purchase receipts for the order.';
                }
                action(Invoices)
                {
                    ApplicationArea = Suite;
                    Caption = 'Invoices';
                    Image = Invoice;
                    Promoted = true;
                    PromotedCategory = Category11;
                    PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ToolTip = 'View a list of ongoing purchase invoices for the order.';
                }
              
            
            }

        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                         ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group(Action13)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                        CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                        CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
                    end;
                }
            }

            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    PromotedIsBig = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }

            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    ApplicationArea = Suite;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Purch.-Post (Yes/No)", "Navigate After Posting"::"Posted Document");
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortCutKey = 'Ctrl+Alt+F9';
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    begin
                        ShowPreview;
                    end;
                }
                action("Post and &Print")
                {
                    ApplicationArea = Suite;
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Purch.-Post + Print", "Navigate After Posting"::"Do Nothing");
                    end;
                }
                action(PostAndNew)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and New';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ShortCutKey = 'Alt+F9';
                    ToolTip = 'Post the purchase document and create a new, empty one.';

                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Purch.-Post (Yes/No)", "Navigate After Posting"::"New Document");
                    end;
                }
                action("Test Report")
                {
                    ApplicationArea = Suite;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("LPO Print")
                {
                    ApplicationArea = Basic;
                    Caption = 'LPO Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin


                        Rec.Reset;
                        Rec.SetRange("No.", Rec."No.");
                        Report.Run(50019, true, true, Rec);

                    end;
                }
                action("Post &Batch")
                {
                    ApplicationArea = Suite;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    ToolTip = 'Post several documents at once. A report request window opens where you can specify which documents to post.';

                    trigger OnAction()
                    begin
                        REPORT.RunModal(REPORT::"Batch Post Purchase Orders", true, true, Rec);
                        CurrPage.Update(false);
                    end;
                }


            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;
                action("&Print")
                {
                    ApplicationArea = Suite;
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Category10;
                    ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader := Rec;
                        CurrPage.SetSelectionFilter(PurchaseHeader);
                        PurchaseHeader.PrintRecords(true);
                    end;
                }
                action(SendCustom)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send';
                    Ellipsis = true;
                    Image = SendToMultiple;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    ToolTip = 'Prepare to send the document according to the vendor''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseHeader := Rec;
                        CurrPage.SetSelectionFilter(PurchaseHeader);
                        PurchaseHeader.SendRecords;
                    end;
                }
                action(AttachAsPDF)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Attach as PDF';
                    Image = PrintAttachment;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Create a PDF file and attach it to the document.';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        DocPrint: Codeunit "Document-Print";
                    begin
                        PurchaseHeader := Rec;
                        PurchaseHeader.SetRecFilter();
                        DocPrint.PrintPurchaseHeaderToDocumentAttachment(PurchaseHeader);
                    end;
                }
            }
        }
    }



    trigger OnAfterGetCurrRecord()
    var
        NoseriesManagement: codeunit NoSeriesManagement;
    begin
        SetControlAppearance;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        CurrPage.ApprovalFactBox.PAGE.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId);
        StatusStyleTxt := Rec.GetStatusStyleText();
        if Rec."Posting No. Series" = '' then begin
            // Rec."Posting No. Series" := 'ORDER POSTING';
            Rec."Posting No. Series" := NoSeriesManagement.GetNextNo('ORDER POSTING', Today, true);
        end;


    end;

    trigger OnAfterGetRecord()
    begin
        CalculateCurrentShippingAndPayToOption;
        ShowOverReceiptNotification();
        BuyFromContact.GetOrClear(Rec."Buy-from Contact No.");
        PayToContact.GetOrClear(Rec."Pay-to Contact No.");

        OnAfterOnAfterGetRecord(Rec);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        JobQueueUsed := PurchSetup.JobQueueActive();
        SetExtDocNoMandatoryCondition();
        ShowShippingOptionsWithLocation := ApplicationAreaMgmtFacade.IsLocationEnabled() or ApplicationAreaMgmtFacade.IsAllDisabled();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;

        if (not DocNoVisible) and (Rec."No." = '') then
            Rec.SetBuyFromVendorFromFilter;

        CalculateCurrentShippingAndPayToOption;
    end;

    trigger OnOpenPage()
    begin
        SetOpenPage();

        ActivateFields();

        SetPostingGroupEditable();
        CheckShowBackgrValidationNotification();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        InstructionMgt: Codeunit "Instruction Mgt.";
        ShowConfirmCloseUnposted: Boolean;
    begin
        if ShowReleaseNotification then
            if not InstructionMgt.ShowConfirmUnreleased then
                exit(false);
        ShowConfirmCloseUnposted := not DocumentIsPosted;
        OnQueryClosePageOnAfterCalcShowConfirmCloseUnposted(Rec, ShowConfirmCloseUnposted);
        if ShowConfirmCloseUnposted then
            exit(Rec.ConfirmCloseUnposted);
    end;

    var
        BuyFromContact: Record Contact;
        PayToContact: Record Contact;
        PurchSetup: Record "Purchases & Payables Setup";
        GLSetup: Record "General Ledger Setup";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        FormatAddress: Codeunit "Format Address";
        ChangeExchangeRate: Page "Change Exchange Rate";
       
        JobQueueVisible: Boolean;
       
        JobQueueUsed: Boolean;
       
        StatusStyleTxt: Text;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        OpenPostedPurchaseOrderQst: Label 'The order is posted as number %1 and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        ShowShippingOptionsWithLocation: Boolean;
        IsSaaS: Boolean;
        IsBuyFromCountyVisible: Boolean;
        IsPayToCountyVisible: Boolean;
        IsShipToCountyVisible: Boolean;
        PurchaseDocCheckFactboxVisible: Boolean;
       
        IsJournalTemplNameVisible: Boolean;
       
        IsPaymentMethodCodeVisible: Boolean;
        IsPostingGroupEditable: Boolean;
        ShouldSearchForVendByName: Boolean;

    protected var
        ShipToOptions: Option "Default (Company Address)",Location,"Customer Address","Custom Address";
        PayToOptions: Option "Default (Vendor)","Another Vendor","Custom Address";

    local procedure SetOpenPage()
    var
        EnvironmentInfo: Codeunit "Environment Information";
    begin
        SetDocNoVisible();
        IsSaaS := EnvironmentInfo.IsSaaS();

        Rec.SetSecurityFilterOnRespCenter();

        if (Rec."No." <> '') and (Rec."Buy-from Vendor No." = '') then
            DocumentIsPosted := (not Rec.Get(Rec."Document Type", Rec."No."));

        Rec.SetRange("Date Filter", 0D, WorkDate());

        OnAfterSetOpenPage();
    end;

    local procedure ActivateFields()
    begin
        IsBuyFromCountyVisible := FormatAddress.UseCounty(Rec."Buy-from Country/Region Code");
        IsPayToCountyVisible := FormatAddress.UseCounty(Rec."Pay-to Country/Region Code");
        IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
        GLSetup.Get();
        IsJournalTemplNameVisible := GLSetup."Journal Templ. Name Mandatory";
        IsPaymentMethodCodeVisible := not GLSetup."Hide Payment Method Code";
    end;

    procedure CallPostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    begin
        PostDocument(PostingCodeunitID, Navigate);
    end;

    local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        IsScheduledPosting: Boolean;
        IsHandled: Boolean;
    begin
        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        IsScheduledPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not PurchaseHeader.Get(Rec."Document Type", Rec."No.")) or IsScheduledPosting;

        if IsScheduledPosting then
            CurrPage.Close;
        CurrPage.Update(false);

        IsHandled := false;
        OnPostDocumentBeforeNavigateAfterPosting(Rec, PostingCodeunitID, Navigate, DocumentIsPosted, IsHandled);
        if IsHandled then
            exit;

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        case Navigate of
            "Navigate After Posting"::"Posted Document":
                begin
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then
                        ShowPostedConfirmationMessage;

                    if IsScheduledPosting or DocumentIsPosted then
                        CurrPage.Close();
                end;
            "Navigate After Posting"::"New Document":
                if DocumentIsPosted then begin
                    Clear(PurchaseHeader);
                    PurchaseHeader.Init();
                    PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
                    OnPostDocumentOnBeforePurchaseHeaderInsert(PurchaseHeader);
                    PurchaseHeader.Insert(true);
                    PAGE.Run(PAGE::"Purchase Order", PurchaseHeader);
                end;
        end;
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure SaveInvoiceDiscountAmount()
    var
        DocumentTotals: Codeunit "Document Totals";
    begin
        CurrPage.SaveRecord;
        DocumentTotals.PurchaseRedistributeInvoiceDiscountAmountsOnDocument(Rec);
        CurrPage.Update(false);
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.Update();
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.Update();
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.PurchLines.Page.ForceTotalsCalculation();
        CurrPage.Update();
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.Update();
    end;

    local procedure ShowPreview()
    var
        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
    begin
        PurchPostYesNo.Preview(Rec);
    end;

    local procedure ShowPrepmtInvoicePreview()
    var
        PurchPostPrepmtYesNo: Codeunit "Purch.-Post Prepmt. (Yes/No)";
    begin
        PurchPostPrepmtYesNo.Preview(Rec, 2);
    end;

    local procedure ShowPrepmtCrMemoPreview()
    var
        PurchPostPrepmtYesNo: Codeunit "Purch.-Post Prepmt. (Yes/No)";
    begin
        PurchPostPrepmtYesNo.Preview(Rec, 3);
    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible("Purchase Document Type"::Order, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition()
    begin
        PurchSetup.GetRecordOnce();
        VendorInvoiceNoMandatory := PurchSetup."Ext. Doc. No. Mandatory";
    end;

    local procedure SetControlAppearance()
    var
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        DocumentErrorsMgt: Codeunit "Document Errors Mgt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition;

        /*  OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
         OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
         CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId); */

        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        ShouldSearchForVendByName := Rec.ShouldSearchForVendorByName(Rec."Buy-from Vendor No.");
        PurchaseDocCheckFactboxVisible := DocumentErrorsMgt.BackgroundValidationEnabled();

        OnAfterSetControlAppearance();
    end;

    procedure RunBackgroundCheck()
    begin
        CurrPage.PurchaseDocCheckFactbox.Page.CheckErrorsInBackground(Rec);
    end;

    local procedure CheckShowBackgrValidationNotification()
    var
        DocumentErrorsMgt: Codeunit "Document Errors Mgt.";
    begin
        if DocumentErrorsMgt.CheckShowEnableBackgrValidationNotification() then
            SetControlAppearance();
    end;

    procedure SetPostingGroupEditable()
    begin
        PurchSetup.GetRecordOnce();
        IsPostingGroupEditable := PurchSetup."Allow Multiple Posting Groups";
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        OrderPurchaseHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not OrderPurchaseHeader.Get(Rec."Document Type", Rec."No.") then begin
            PurchInvHeader.SetRange("No.", Rec."Last Posting No.");
            if PurchInvHeader.FindFirst() then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedPurchaseOrderQst, PurchInvHeader."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode)
                then
                    InstructionMgt.ShowPostedDocument(PurchInvHeader, Page::"Purchase Order");
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalculateSalesTaxStatistics(var PurchaseHeader: Record "Purchase Header"; ShowDialog: Boolean)
    begin
    end;

    local procedure ValidateShippingOption()
    begin
        case ShipToOptions of
            ShipToOptions::"Default (Company Address)",
            ShipToOptions::"Custom Address":
                begin
                    Rec.Validate("Sell-to Customer No.", '');
                    Rec.Validate("Location Code", '');
                end;
            ShipToOptions::Location:
                begin
                    Rec.Validate("Sell-to Customer No.", '');
                    Rec.Validate("Location Code");
                end;
            ShipToOptions::"Customer Address":
                begin
                    Rec.Validate("Sell-to Customer No.");
                    Rec.Validate("Location Code", '');
                end;
        end;
    end;

    local procedure ShowReleaseNotification(): Boolean
    var
        LocationsQuery: Query "Locations from items Purch";
    begin
        if Rec.TestStatusIsNotReleased then begin
            LocationsQuery.SetRange(Document_No, Rec."No.");
            LocationsQuery.SetRange(Require_Receive, true);
            LocationsQuery.Open;
            if LocationsQuery.Read then
                exit(true);
            LocationsQuery.SetRange(Document_No, Rec."No.");
            LocationsQuery.SetRange(Require_Receive);
            LocationsQuery.SetRange(Require_Put_away, true);
            LocationsQuery.Open;
            exit(LocationsQuery.Read);
        end;
        exit(false);
    end;

    local procedure CalculateCurrentShippingAndPayToOption()
    begin
        case true of
            Rec."Sell-to Customer No." <> '':
                ShipToOptions := ShipToOptions::"Customer Address";
            Rec."Location Code" <> '':
                ShipToOptions := ShipToOptions::Location;
            else
                if Rec.ShipToAddressEqualsCompanyShipToAddress then
                    ShipToOptions := ShipToOptions::"Default (Company Address)"
                else
                    ShipToOptions := ShipToOptions::"Custom Address";
        end;

        case true of
            (Rec."Pay-to Vendor No." = Rec."Buy-from Vendor No.") and Rec.BuyFromAddressEqualsPayToAddress:
                PayToOptions := PayToOptions::"Default (Vendor)";
            (Rec."Pay-to Vendor No." = Rec."Buy-from Vendor No.") and (not Rec.BuyFromAddressEqualsPayToAddress):
                PayToOptions := PayToOptions::"Custom Address";
            Rec."Pay-to Vendor No." <> Rec."Buy-from Vendor No.":
                PayToOptions := PayToOptions::"Another Vendor";
        end;

        OnAfterCalculateCurrentShippingAndPayToOption(ShipToOptions, PayToOptions, Rec);
    end;

    local procedure ShowOverReceiptNotification()
    var
        OverReceiptMgt: Codeunit "Over-Receipt Mgt.";
    begin
        OverReceiptMgt.ShowOverReceiptNotificationFromOrder(Rec."No.");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalculateCurrentShippingAndPayToOption(var ShipToOptions: Option "Default (Company Address)",Location,"Customer Address","Custom Address"; var PayToOptions: Option "Default (Vendor)","Another Vendor","Custom Address"; PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterOnAfterGetRecord(var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostDocumentOnBeforePurchaseHeaderInsert(var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnPostDocumentBeforeNavigateAfterPosting(var PurchaseHeader: Record "Purchase Header"; var PostingCodeunitID: Integer; var Navigate: Enum "Navigate After Posting"; DocumentIsPosted: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnQueryClosePageOnAfterCalcShowConfirmCloseUnposted(var PurchaseHeader: Record "Purchase Header"; var ShowConfirmCloseUnposted: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterSetOpenPage()
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterSetControlAppearance()
    begin
    end;
}

