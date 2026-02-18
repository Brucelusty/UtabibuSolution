//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 80060 "Group/Corporate Applic Card"
{
    Editable = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Attachment,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'General Info';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'No.';
                    Editable = false;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                    OptionCaption = 'Single,Joint,Corporate,Group,Parish,Church,Church Department';

                    trigger OnValidate()
                    var
                        Joint2DetailsVisible: Boolean;
                    begin
                        Joint2DetailsVisible := false;

                        if Rec."Account Category" = Rec."account category"::Corporate then begin
                            Joint2DetailsVisible := true;
                        end;
                        if Rec."Account Category" <> Rec."account category"::Group then begin
                            NumberofMembersEditable := false
                        end else
                            NumberofMembersEditable := true;
                    end;
                }
                field("Name of the Group/Corporate"; Rec."Name of the Group/Corporate")
                {
                    ApplicationArea = Basic;
                    // Editable = EditableField;
                    ShowMandatory = true;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = EditableField;
                    ShowMandatory = true;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = CountryEditable;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic;
                    LookupPageId = County;
                }
                field(District; Rec.District)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Date of Registration"; Rec."Date of Registration")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("No of Members"; Rec."No of Members")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                }
                field("Group/Corporate Trade"; Rec."Group/Corporate Trade")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                    LookupPageId = TRADE;
                }
                field("Average Turn Over"; Rec."Average Turn Over")
                {

                }
                field("Certificate No"; Rec."Certificate No")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                    ShowMandatory = true;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                }
                field("Need a Cheque book"; Rec."Need a Cheque book")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    Visible = false;
                }
                field("Application Category"; Rec."Application Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = EditableField;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = CustPostingGroupEdit;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Referee Details")
            {
                field("Referee Member No"; Rec."Referee Member No")
                {
                    ApplicationArea = Basic;
                    Editable = RefereeEditable;
                }
                field("Referee Name"; Rec."Referee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Referee ID No"; Rec."Referee ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Referee Mobile Phone No"; Rec."Referee Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Communication Info")
            {
                Caption = 'Communication Info';
                Editable = EditableField;
                field("Office Telephone No."; Rec."Office Telephone No.")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                }
                field("Office Extension"; Rec."Office Extension")
                {
                    ApplicationArea = Basic;
                    Enabled = EditableField;
                }

                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = EmailEdiatble;
                    Enabled = EditableField;
                }
                field("Home Address"; Rec."Home Address")
                {
                    ApplicationArea = Basic;
                }
                field("Home Postal Code"; Rec."Home Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = HomeAddressPostalCodeEditable;
                }
                field("Home Town"; Rec."Home Town")
                {
                    ApplicationArea = Basic;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPEditable;
                    ShowMandatory = true;
                }
                field("Contact Person Phone"; Rec."Contact Person Phone")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPPhoneEditable;
                    ShowMandatory = true;
                }
                field("ContactPerson Relation"; Rec."ContactPerson Relation")
                {
                    ApplicationArea = Basic;
                    Editable = ContactPRelationEditable;
                    Visible = false;
                }
            }
            group("Trade Information")
            {
                Caption = 'Trade Information';
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = Basic;
                }
                field("Others Details"; Rec."Others Details")
                {
                    ApplicationArea = Basic;
                    // Editable = OthersEditable;
                }
            }
            group("Member Risk Ratings")
            {
                Visible = false;
                group("Member Risk Rate")
                {
                    field("Individual Category"; Rec."Individual Category")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Member Residency Status"; Rec."Member Residency Status")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field(Entities; Rec.Entities)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Industry Type"; Rec."Industry Type")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Length Of Relationship"; Rec."Length Of Relationship")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("International Trade"; Rec."International Trade")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                }
                group("Product Risk Rating")
                {
                    field("Electronic Payment"; Rec."Electronic Payment")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Accounts Type Taken"; Rec."Accounts Type Taken")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Cards Type Taken"; Rec."Cards Type Taken")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Others(Channels)"; Rec."Others(Channels)")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
                    field("Member Risk Level"; Rec."Member Risk Level")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Risk Level';
                        Editable = false;
                        // Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                    field("Due Diligence Measure"; Rec."Due Diligence Measure")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        //  Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                }

            }
            part(Control35; "Group Members Snop")
            {
                ApplicationArea = All;
                Caption = 'Members SnapShot';
                Editable = MobileEditable;
                SubPageLink = "No." = field("No.");
            }
        }

    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Select Products")
                {
                    ApplicationArea = Basic;
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Products";
                    RunPageLink = "Membership Applicaton No" = field("No.");
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Member Agent Details")
                {
                    ApplicationArea = Basic;
                    Image = Group;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Agent App  List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Member Sanction Information")
                {
                    ApplicationArea = Basic;
                    Image = ErrorLog;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Membership Application Saction";
                    RunPageLink = "Document No" = field("No.");
                }
                action("Member Risk Rating")
                {
                    ApplicationArea = Basic;
                    Caption = 'Get Member Risk Rating';
                    Image = Reconcile;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    RunObject = Page "Entities Risk Rating";
                    RunPageLink = "Membership Application No" = field("No.");

                    trigger OnAction()
                    begin
                        SFactory.FnGetEntitiesApplicationAMLRiskRating(Rec."No.");



                    end;
                }
                separator(Action6)
                {
                    Caption = '-';
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                    //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin


                        if (Rec."Account Category" = Rec."account category"::Group) or (Rec."Account Category" = Rec."account category"::Joint) then begin
                            Rec.TestField(Name);
                            //TESTFIELD("Registration No");
                            Rec.TestField("Contact Person");
                            Rec.TestField("Contact Person Phone");
                            Rec.TestField("Date of Registration");
                            //TESTFIELD("Group/Corporate Trade");
                            Rec.TestField("Customer Posting Group");
                            //TESTFIELD("Global Dimension 1 Code");
                            Rec.TestField("Global Dimension 2 Code");
                            Rec.TestField("Contact Person Phone");
                            Rec.TestField("Monthly Contribution");

                        end;


                        if (Rec."Account Category" = Rec."account category"::Group) or (Rec."Account Category" = Rec."account category"::Joint) then begin
                            ObjAccountSignApp.Reset;
                            ObjAccountSignApp.SetRange(ObjAccountSignApp."Account No", Rec."No.");
                            if ObjAccountSignApp.Find('-') = false then begin
                                Error('Please insert Account Signatories');
                            end;
                        end;



                        if Rec.Status <> Rec.Status::Open then
                            Error(Text001);

                        //End allocate batch number
                        Doc_Type := Doc_type::"Account Opening";
                        Table_id := Database::"Membership Applications";
                        //IF Approvalmgt.SendApproval(Table_id,"No.",Doc_Type,Status)THEN;

                        if WkFlwIntegration.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) then
                            WkFlwIntegration.OnSendMembershipApplicationForApproval(Rec);



                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                    //Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Confirm('Are you sure you want to cancel this approval request', false) = true then
                            WkFlwIntegration.OnCancelMembershipApplicationApprovalRequest(Rec);
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::MembershipApplication;
                        ApprovalEntries.Setrecordfilters(Database::"Membership Applications", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                separator(Action2)
                {
                    Caption = '       -';
                }
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category7;
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
                action("Create Account ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Accounts';
                    Enabled = EnableCreateMember;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ObjAccountType: Record "Account Types-Saving Products";
                        VarAccounts: Text;
                        Usersetup: Record "User Setup";
                        SaccoNoSeries: record "Sacco No. Series";
                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Error('This application has not been approved');
                        Rec.TestField("Monthly Contribution");


                    


                        if Confirm('Are you sure you want to create account application?', false) = true then begin



                            ObjSaccosetup.Get();

                            ObjProductsApp.Reset;
                            ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                            ObjProductsApp.SetRange(ObjProductsApp."Product Source", ObjProductsApp."product source"::BOSA);
                            if ObjProductsApp.FindSet then begin
                                SaccoNoSeries.Get();
                                VarNewMembNo := NoSeriesMgt.GetNextNo(SaccoNoSeries."Members Nos", Today, true);
                            end;



                            //Create BOSA account

                            ObjCust."No." := Format(VarNewMembNo);
                            ObjCust.Name := Rec.Name;
                            ObjCust.Address := Rec.Address;
                            ObjCust."Post Code" := Rec."Postal Code";
                            ObjCust.County := Rec.County;
                            ObjCust.City := Rec.City;
                            ObjCust."Country/Region Code" := Rec."Country/Region Code";
                            ObjCust."Phone No." := Rec."Mobile Phone No";
                            ObjCust."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                            ObjCust."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                            ObjCust."Customer Posting Group" := Rec."Customer Posting Group";
                            ObjCust."Registration Date" := Today;
                            ObjCust."Mobile Phone No" := Rec."Mobile Phone No";
                            ObjCust.Status := ObjCust.Status::Active;
                            ObjCust."Employer Code" := Rec."Employer Code";
                            ObjCust."Date of Birth" := Rec."Date of Birth";
                            ObjCust.Piccture := Rec.Picture;
                            ObjCust.ISNormalMember := true;
                            ObjCust.Signature := Rec.Signature;
                            ObjCust."Station/Department" := Rec."Station/Department";
                            ObjCust."E-Mail" := Rec."E-Mail (Personal)";
                            ObjCust.Location := Rec.Location;
                            ObjCust.Title := Rec.Title;
                            ObjCust."Home Address" := Rec."Home Address";
                            ObjCust."Home Postal Code" := Rec."Home Postal Code";
                            ObjCust."Home Town" := Rec."Home Town";
                            ObjCust."Recruited By" := Rec."Recruited By";
                            ObjCust."Contact Person" := Rec."Contact Person";
                            ObjCust."ContactPerson Relation" := Rec."ContactPerson Relation";
                            ObjCust."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                            ObjCust."Member Share Class" := Rec."Member Share Class";
                            ObjCust."Member's Residence" := Rec."Member's Residence";
                            ObjCust."Employer Address" := Rec."Employer Address";
                            ObjCust."Member House Group" := Rec."Member House Group";
                            ObjCust."Member House Group Name" := Rec."Member House Group Name";
                            ObjCust."Nature Of Business" := Rec."Nature Of Business";
                            ObjCust."Date of Employment" := Rec."Date of Employment";
                            ObjCust."Position Held" := Rec."Position Held";
                            ObjCust.Industry := Rec.Industry;
                            ObjCust."Business Name" := Rec."Business Name";
                            ObjCust."Physical Business Location" := Rec."Physical Business Location";
                            ObjCust."Year of Commence" := Rec."Year of Commence";
                            ObjCust."Identification Document" := Rec."Identification Document";
                            ObjCust."Referee Member No" := Rec."Referee Member No";
                            ObjCust."Referee Name" := Rec."Referee Name";
                            ObjCust."Referee ID No" := Rec."Referee ID No";
                            ObjCust."Referee Mobile Phone No" := Rec."Referee Mobile Phone No";
                            ObjCust."Email Indemnified" := Rec."E-mail Indemnified";
                            ObjCust."Created By" := UserId;
                            ObjCust."Member Needs House Group" := Rec."Member Needs House Group";
                            ObjCust."Account Category" := Rec."Account Category";
                            ObjCust."Name of the Group/Corporate" := Rec."Name of the Group/Corporate";
                            ObjCust."Post Code" := Rec."Postal Code";
                            ObjCust."Date of Registration" := Rec."Date of Registration";
                            ObjCust."No of Members" := Rec."No of Members";
                            ObjCust."Group/Corporate Trade" := Rec."Group/Corporate Trade";
                            ObjCust."Certificate No" := Rec."Certificate No";
                            ObjCust."Recruited By" := Rec."Recruited By";
                            ObjCust."Average Turn Over":=Rec."Average Turn Over";

                            if ObjCust."Account Category" = ObjCust."account category"::Group then
                                ObjCust."Account Category" := Rec."Account Category";

                            ObjCust."Office Branch" := Rec."Office Branch";
                            ObjCust.Department := Rec.Department;
                            ObjCust.Occupation := Rec.Occupation;
                            ObjCust.Designation := Rec.Designation;
                            ObjCust."Bank Code" := Rec."Bank Code";
                            ObjCust."Group Members Snapshort" := Rec."Group Members Snapshort";
                            ObjCust."Bank Branch Code" := Rec."Bank Name";
                            ObjCust."Bank Account No." := Rec."Bank Account No";
                            //**
                            ObjCust."Sub-Location" := Rec."Sub-Location";
                            ObjCust.District := Rec.District;
                            ObjCust."Payroll No" := Rec."Payroll No";
                            ObjCust."ID No." := Rec."ID No.";
                            ObjCust."Mobile Phone No" := Rec."Mobile Phone No";
                            ObjCust."Marital Status" := Rec."Marital Status";
                            ObjCust."Customer Type" := ObjCust."customer type"::Member;
                            ObjCust.Gender := Rec.Gender;

                            ObjCust.Piccture := Rec.Picture;
                            ObjCust.Signature := Rec.Signature;

                            ObjCust."Monthly Contribution" := Rec."Monthly Contribution";
                            ObjCust."Contact Person" := Rec."Contact Person";
                            ObjCust."Contact Person Phone" := Rec."Contact Person Phone";
                            ObjCust."ContactPerson Relation" := Rec."ContactPerson Relation";
                            ObjCust."Recruited By" := Rec."Recruited By";
                            ObjCust."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                            ObjCust."Village/Residence" := Rec."Village/Residence";
                            ObjCust.Pin := Rec."KRA PIN";
                            ObjCust."Account Category" := Rec."Account Category";
                            //========================================================================Member Risk Rating
                            ObjCust."Individual Category" := Rec."Individual Category";
                            ObjCust.Entities := Rec.Entities;
                            ObjCust."Member Residency Status" := Rec."Member Residency Status";
                            ObjCust."Industry Type" := Rec."Industry Type";
                            ObjCust."Length Of Relationship" := Rec."Length Of Relationship";
                            ObjCust."International Trade" := Rec."International Trade";
                            ObjCust."Electronic Payment" := Rec."Electronic Payment";
                            ObjCust."Accounts Type Taken" := Rec."Accounts Type Taken";
                            ObjCust."Cards Type Taken" := Rec."Cards Type Taken";
                            ObjCust.Insert(true);
                            //========================================================================End Member Risk Rating
                            ObjAccountSignApp.Reset;
                            ObjAccountSignApp.SetRange(ObjAccountSignApp."Account No", Rec."No.");
                            if ObjAccountSignApp.Find('-') then begin
                                repeat
                                    if ObjNoSeries.Get then begin
                                        ObjNoSeries.TestField(ObjNoSeries."Signatories Document No");
                                        VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Signatories Document No", 0D, true);
                                        if VarDocumentNo <> '' then begin
                                            ObjAccountSign.Init;
                                            ObjAccountSign."Document No" := VarDocumentNo;
                                            ObjAccountSign."Account No" := VarNewMembNo;
                                            ObjAccountSign.Names := ObjAccountSignApp.Names;
                                            ObjAccountSign."Date Of Birth" := ObjAccountSignApp."Date Of Birth";
                                            ObjAccountSign."Staff/Payroll" := ObjAccountSignApp."Staff/Payroll";
                                            ObjAccountSign."ID No." := ObjAccountSignApp."ID No.";
                                            ObjAccountSign."Mobile No" := ObjAccountSignApp."Mobile No.";
                                            ObjAccountSign."Member No." := ObjAccountSignApp."BOSA No.";
                                            ObjAccountSign."Email Address" := ObjAccountSignApp."Email Address";
                                            ObjAccountSign.Signatory := ObjAccountSignApp.Signatory;
                                            ObjAccountSign."Must Sign" := ObjAccountSignApp."Must Sign";
                                            ObjAccountSign."Must be Present" := ObjAccountSignApp."Must be Present";
                                            ObjAccountSign.Picture := ObjAccountSignApp.Picture;
                                            ObjAccountSign.Signature := ObjAccountSignApp.Signature;
                                            ObjAccountSign."Expiry Date" := ObjAccountSignApp."Expiry Date";
                                            ObjAccountSign.Insert;
                                        end;
                                    end;
                                until ObjAccountSignApp.Next = 0;
                            end;

                            ObjNextOfKinApp.Reset;
                            ObjNextOfKinApp.SetRange(ObjNextOfKinApp."Account No", Rec."No.");
                            if ObjNextOfKinApp.Find('-') then begin
                                repeat
                                    ObjNextOfKin.Init;
                                    ObjNextOfKin."Account No" := ObjCust."No.";
                                    ObjNextOfKin.Name := ObjNextOfKinApp.Name;
                                    ObjNextOfKin.Relationship := ObjNextOfKinApp.Relationship;
                                    ObjNextOfKin.Beneficiary := ObjNextOfKinApp.Beneficiary;
                                    ObjNextOfKin."Date of Birth" := ObjNextOfKinApp."Date of Birth";
                                    ObjNextOfKin.Address := ObjNextOfKinApp.Address;
                                    ObjNextOfKin.Telephone := ObjNextOfKinApp.Telephone;
                                    ObjNextOfKin.Email := ObjNextOfKinApp.Email;
                                    ObjNextOfKin."ID No." := ObjNextOfKinApp."ID No.";
                                    ObjNextOfKin."%Allocation" := ObjNextOfKinApp."%Allocation";
                                    ObjNextOfKin.Description := ObjNextOfKinApp.Description;
                                    ObjNextOfKin."Next Of Kin Type" := ObjNextOfKinApp."Next Of Kin Type";
                                    ObjNextOfKin.Insert;
                                until ObjNextOfKinApp.Next = 0;
                            end;

                            //==================================================================================Insert Member Agents
                            ObjMemberAppAgent.Reset;
                            ObjMemberAppAgent.SetRange(ObjMemberAppAgent."Account No", Rec."No.");
                            if ObjMemberAppAgent.Find('-') then begin
                                repeat
                                    ObjMemberAgent.Init;
                                    ObjMemberAgent."Account No" := ObjCust."No.";
                                    ;
                                    ObjMemberAgent.Names := ObjMemberAppAgent.Names;
                                    ObjMemberAgent."Date Of Birth" := ObjMemberAppAgent."Date Of Birth";
                                    ObjMemberAgent."Staff/Payroll" := ObjMemberAppAgent."Staff/Payroll";
                                    ObjMemberAgent."ID No." := ObjMemberAppAgent."ID No.";
                                    ObjMemberAgent."Allowed  Correspondence" := ObjMemberAppAgent."Allowed  Correspondence";
                                    ObjMemberAgent."Allowed Balance Enquiry" := ObjMemberAppAgent."Allowed Balance Enquiry";
                                    ObjMemberAgent."Allowed FOSA Withdrawals" := ObjMemberAppAgent."Allowed FOSA Withdrawals";
                                    ObjMemberAgent."Allowed Loan Processing" := ObjMemberAppAgent."Allowed Loan Processing";
                                    ObjMemberAgent."Must Sign" := ObjMemberAppAgent."Must Sign";
                                    ObjMemberAgent."Must be Present" := ObjMemberAppAgent."Must be Present";
                                    ObjMemberAgent.Picture := ObjMemberAppAgent.Picture;
                                    ObjMemberAgent.Signature := ObjMemberAppAgent.Signature;
                                    ObjMemberAgent."Expiry Date" := ObjMemberAppAgent."Expiry Date";
                                    ObjMemberAgent.Insert;
                                until ObjMemberAppAgent.Next = 0;
                            end;
                            //==================================================================================End Insert Member Agents

                            ObjMemberNoseries.Reset;
                            ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                            ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", Rec."Global Dimension 2 Code");
                            if ObjMemberNoseries.FindSet then begin
                                ObjMemberNoseries."Account No" := IncStr(ObjMemberNoseries."Account No");
                                ObjMemberNoseries.Modify;
                            end;
                            VarBOSAACC := ObjCust."No.";
                            //  until ObjProductsApp.Next = 0;
                            //end;
                        end;
                        //==================================================================================================End Back Office Account

                        //==================================================================================================Front Office Accounts
                        ObjProductsApp.Reset;
                        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                        ObjProductsApp.SetRange(ObjProductsApp."Product Source", ObjProductsApp."Product Source"::FOSA);
                        if ObjProductsApp.FindSet then begin
                            repeat
                                //IF ObjProductsApp."Product Source" = ObjProductsApp."Product Source"::FOSA THEN BEGIN
                                ObjAccountType.Reset();
                                ObjAccountType.SETRANGE(ObjAccountType.Code, ObjProductsApp.Product);
                                if ObjAccountType.Find('-') then begin

                                    VarAcctNo := ObjAccountType."Account No Prefix" + VarNewMembNo;
                                end;

                                IF Rec."Certificate No" <> '' THEN BEGIN
                                    ObjAccounts.RESET;
                                    ObjAccounts.SETRANGE(ObjAccounts."Certificate No", Rec."Certificate No");
                                    ObjAccounts.SETRANGE(ObjAccounts."Account Type", ObjProductsApp.Product);
                                    IF ObjAccounts.FINDSET THEN BEGIN
                                        ERROR('The Group has an existing Account %1 account No %1', ObjAccounts."Account Type", ObjAccounts."No.");
                                    END;
                                END;

                                //===================================================================Create FOSA account
                                ObjAccounts.Init;
                                ObjAccounts."No." := VarAcctNo;
                                ObjAccounts."Date of Birth" := Rec."Date of Birth";
                                ObjAccounts.Name := Rec.Name;
                                ObjAccounts."Creditor Type" := ObjAccounts."creditor type"::"FOSA Account";
                                ObjAccounts."Personal No." := Rec."Payroll No";
                                ObjAccounts."ID No." := Rec."ID No.";
                                ObjAccounts."Mobile Phone No" := Rec."Mobile Phone No";
                                ObjAccounts."Phone No." := Rec."Mobile Phone No";
                                ObjAccounts."Registration Date" := Rec."Registration Date";
                                ObjAccounts."Post Code" := Rec."Postal Code";
                                ObjAccounts.County := Rec.City;
                                ObjAccounts."BOSA Account No" := ObjCust."No.";
                                //ObjAccounts.Picture:=Picture;
                                //ObjAccounts.Signature:=Signature;
                                ObjAccounts."Passport No." := Rec."Passport No.";
                                ObjAccounts."Employer Code" := Rec."Employer Code";
                                ObjAccounts.Status := ObjAccounts.Status::Deceased;
                                ObjAccounts."Account Type" := ObjProductsApp.Product;
                                ObjAccounts."Date of Birth" := Rec."Date of Birth";
                                ObjAccounts."Global Dimension 1 Code" := Format(ObjProductsApp."Product Source");
                                ObjAccounts."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                ObjAccounts.Address := Rec.Address;
                                if Rec."Account Category" = Rec."account category"::Joint then begin
                                    ObjAccounts."Account Category" := ObjAccounts."account category"::Corporate
                                end else
                                    ObjAccounts."Account Category" := Rec."Account Category";
                                ObjAccounts."Address 2" := Rec."Address 2";
                                ObjAccounts."Phone No." := Rec."Mobile Phone No";
                                ObjAccounts."Registration Date" := Today;
                                ObjAccounts.Status := ObjAccounts.Status::Active;
                                ObjAccounts.Section := Rec.Section;
                                ObjAccounts."Home Address" := Rec."Home Address";
                                ObjAccounts.District := Rec.District;
                                ObjAccounts.Location := Rec.Location;
                                ObjAccounts."Sub-Location" := Rec."Sub-Location";
                                ObjAccounts."Registration Date" := Today;
                                ObjAccounts."Monthly Contribution" := Rec."Monthly Contribution";
                                ObjAccounts."E-Mail" := Rec."E-Mail (Personal)";
                                ObjAccounts."Group/Corporate Trade" := Rec."Group/Corporate Trade";
                                ObjAccounts."Name of the Group/Corporate" := Rec."Name of the Group/Corporate";
                                ObjAccounts."Certificate No" := Rec."Certificate No";
                                ObjAccounts."Registration Date" := Rec."Registration Date";
                                ObjAccounts."Created By" := UserId;

                                if ObjCust."Account Category" = ObjCust."account category"::Corporate then
                                    ObjAccounts."Joint Account Name" := Rec."First Name" + ' &' + Rec."First Name2" + ' &' + Rec."First Name3" + 'JA';

                                // ObjAccounts.Insert;


                                ObjAccounts.Reset;
                                if ObjAccounts.Get(VarAcctNo) then begin
                                    ObjAccounts.Validate(ObjAccounts.Name);
                                    ObjAccounts.Validate(ObjAccounts."Account Type");
                                    ObjAccounts.Modify;


                                    ObjMemberNoseries.Reset;
                                    ObjMemberNoseries.SetRange(ObjMemberNoseries."Account Type", ObjProductsApp.Product);
                                    ObjMemberNoseries.SetRange(ObjMemberNoseries."Branch Code", Rec."Global Dimension 2 Code");
                                    if ObjMemberNoseries.FindSet then begin
                                        ObjMemberNoseries."Account No" := IncStr(ObjMemberNoseries."Account No");
                                        ObjMemberNoseries.Modify;
                                    end;


                                    //Update BOSA with FOSA Account
                                    if ObjCust.Get(VarBOSAACC) then begin
                                        ObjCust."FOSA Account No." := VarAcctNo;
                                        ObjCust.Modify;
                                    end;
                                end;


                                ObjNextOfKinApp.Reset;
                                ObjNextOfKinApp.SetRange(ObjNextOfKinApp."Account No", Rec."No.");
                                if ObjNextOfKinApp.Find('-') then begin
                                    repeat
                                        ObjNextofKinFOSA.Init;
                                        ObjNextofKinFOSA."Account No" := VarAcctNo;
                                        ObjNextofKinFOSA.Name := ObjNextOfKinApp.Name;
                                        ObjNextofKinFOSA.Relationship := ObjNextOfKinApp.Relationship;
                                        ObjNextofKinFOSA.Beneficiary := ObjNextOfKinApp.Beneficiary;
                                        ObjNextofKinFOSA."Date of Birth" := ObjNextOfKinApp."Date of Birth";
                                        ObjNextofKinFOSA.Address := ObjNextOfKinApp.Address;
                                        ObjNextofKinFOSA.Telephone := ObjNextOfKinApp.Telephone;
                                        ObjNextofKinFOSA.Email := ObjNextOfKinApp.Email;
                                        ObjNextofKinFOSA."ID No." := ObjNextOfKinApp."ID No.";
                                        ObjNextofKinFOSA."%Allocation" := ObjNextOfKinApp."%Allocation";
                                        ObjNextofKinFOSA."Next Of Kin Type" := ObjNextOfKinApp."Next Of Kin Type";
                                    ///  ObjNextofKinFOSA.Insert;
                                    until ObjNextOfKinApp.Next = 0;
                                end;

                                //==================================================================================================Insert Account Agents
                                ObjMemberAppAgent.Reset;
                                ObjMemberAppAgent.SetRange(ObjMemberAppAgent."Account No", Rec."No.");
                                if ObjMemberAppAgent.Find('-') then begin
                                    repeat
                                        ObjAccountAgents.Init;
                                        ObjAccountAgents."Account No" := VarAcctNo;
                                        ObjAccountAgents.Names := ObjMemberAppAgent.Names;
                                        ObjAccountAgents."Date Of Birth" := ObjMemberAppAgent."Date Of Birth";
                                        ObjAccountAgents."Staff/Payroll" := ObjMemberAppAgent."Staff/Payroll";
                                        ObjAccountAgents."ID No." := ObjMemberAppAgent."ID No.";
                                        ObjAccountAgents."BOSA No." := ObjMemberAppAgent."BOSA No.";
                                        ObjAccountAgents."Email Address" := ObjMemberAppAgent."Email Address";
                                        ObjAccountAgents."Allowed  Correspondence" := ObjMemberAppAgent."Allowed  Correspondence";
                                        ObjAccountAgents."Allowed Balance Enquiry" := ObjMemberAppAgent."Allowed Balance Enquiry";
                                        ObjAccountAgents."Allowed FOSA Withdrawals" := ObjMemberAppAgent."Allowed FOSA Withdrawals";
                                        ObjAccountAgents."Allowed Loan Processing" := ObjMemberAppAgent."Allowed Loan Processing";
                                        ObjAccountAgents."Must Sign" := ObjMemberAppAgent."Must Sign";
                                        ObjAccountAgents."Must be Present" := ObjMemberAppAgent."Must be Present";
                                        ObjAccountAgents."Expiry Date" := ObjMemberAppAgent."Expiry Date";
                                    //ObjAccountAgents.Insert;

                                    until ObjMemberAppAgent.Next = 0;
                                end;
                                //==================================================================================================End Insert Account Agents


                                ObjAccountSignApp.Reset;
                                ObjAccountSignApp.SetRange(ObjAccountSignApp."Account No", Rec."No.");
                                if ObjAccountSignApp.Find('-') then begin
                                    repeat
                                        if ObjNoSeries.Get then begin
                                            ObjNoSeries.TestField(ObjNoSeries."Signatories Document No");
                                            VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Signatories Document No", 0D, true);
                                            if VarDocumentNo <> '' then begin
                                                ObjAccountSign.Init;
                                                ObjAccountSign."Document No" := VarDocumentNo;
                                                ObjAccountSign."Account No" := VarAcctNo;
                                                ObjAccountSign.Names := ObjAccountSignApp.Names;
                                                ObjAccountSign."Date Of Birth" := ObjAccountSignApp."Date Of Birth";
                                                ObjAccountSign."Staff/Payroll" := ObjAccountSignApp."Staff/Payroll";
                                                ObjAccountSign."ID No." := ObjAccountSignApp."ID No.";
                                                ObjAccountSign."Mobile No" := ObjAccountSignApp."Mobile No.";
                                                ObjAccountSign."Member No." := ObjAccountSignApp."BOSA No.";
                                                ObjAccountSign."Email Address" := ObjAccountSignApp."Email Address";
                                                ObjAccountSign.Signatory := ObjAccountSignApp.Signatory;
                                                ObjAccountSign."Must Sign" := ObjAccountSignApp."Must Sign";
                                                ObjAccountSign."Must be Present" := ObjAccountSignApp."Must be Present";
                                                ObjAccountSign.Picture := ObjAccountSignApp.Picture;
                                                ObjAccountSign.Signature := ObjAccountSignApp.Signature;
                                                ObjAccountSign."Expiry Date" := ObjAccountSignApp."Expiry Date";
                                                //ObjAccountSign.Insert;
                                            end;
                                        end;
                                    until ObjAccountSignApp.Next = 0;
                                end;
                                //END;
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                GenJournalLine.DeleteAll;

                                ObjGenSetUp.Get();

                                //Charge Registration Fee
                                if ObjGenSetUp."Charge FOSA Registration Fee" = true then begin

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'GENERAL';
                                    GenJournalLine."Journal Batch Name" := 'REGFee';
                                    GenJournalLine."Document No." := Rec."No.";
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := VarAcctNo;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine."External Document No." := 'REGFEE/' + Format(Rec."Payroll No");
                                    GenJournalLine.Description := 'Registration Fee';
                                    GenJournalLine.Amount := ObjGenSetUp."BOSA Registration Fee Amount";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := ObjGenSetUp."FOSA Registration Fee Account";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        //GenJournalLine.INSERT;



                                        GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                    GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                    if GenJournalLine.Find('-') then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                    end;
                                end;
                                Message('You have successfully created a %1 Product, A/C No=%2', ObjProductsApp.Product, VarAcctNo);

                            //End Charge Registration Fee
                            until ObjProductsApp.Next = 0;
                        end;
                        Message('You have successfully Registered a New Sacco Member. Membership No=%1.The Member will be notifed via an SMS', ObjCust."No.");
                        //==========================================================================================================End Front Office Accounts



                        ObjGenSetUp.Get();

                        //=====================================================================================================Send SMS
                        if ObjGenSetUp."Send Membership Reg SMS" = true then begin
                            VarAccounts := '';
                            ObjAccounts.Reset;
                            ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarBOSAACC);
                            if ObjAccounts.FindSet then begin
                                repeat
                                    if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                                        VarAccounts := VarAccounts + Format(ObjAccounts."No.") + ' - ' + Format(ObjAccountType."Product Short Name") + '; ';
                                    end;
                                until ObjAccounts.Next = 0;
                            end;
                            SFactory.FnSendSMS('MEMBERAPP', 'You member Registration has been completed. Your Member No is ' + VarBOSAACC + ' and your Accounts are: ' + VarAccounts,
                            VarBOSAACC, Rec."Mobile Phone No");
                        end;

                        //======================================================================================================Send Email
                        if ObjGenSetUp."Send Membership Reg Email" = true then begin
                            FnSendRegistrationEmail(Rec."No.", Rec."E-Mail (Personal)", Rec."ID No.");
                        end;

                        Rec.Created := true;

                        Rec.CalcFields("Assigned No.");
                        FnRuninsertBOSAAccountNos(Rec."Assigned No.");//========================================================================Update Membership Account with BOSA Account Nos

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        ApprovalsMgmt: codeunit 1535;
    begin
        UpdateControls();
        EditableField := true;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;

        if (Rec.Status = Rec.Status::Approved) and (Rec."Assigned No." = '') then
            EnableCreateMember := true;
        if Rec.Status <> Rec.Status::Open then
            EditableField := false;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec."Self Recruited" := true;
        EmployedEditable := false;
        ContractingEditable := false;
        OthersEditable := false;

        if Rec."Account Category" <> Rec."account category"::Corporate then begin
            Joint2DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;




        if Rec."Account Category" <> Rec."account category"::Group then begin
            NumberofMembersEditable := false
        end else
            NumberofMembersEditable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Responsibility Centre" := UserMgt.GetSalesFilter;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GenSetUp.Get();
        Rec."Monthly Contribution" := GenSetUp."Corporate Minimum Monthly Cont";
        Rec."Account Category" := Rec."account category"::Group;
    end;

    trigger OnOpenPage()
    begin

        if UserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Centre", UserMgt.GetSalesFilter);
            Rec.FilterGroup(0);
        end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        Cust: Record Customer;
        Accounts: Record Vendor;
        AcctNo: Code[20];
        NextOfKinApp: Record "Member App Nominee";
        MAccountSign: Record "Member Account Signatories";
        PAccountSign: Record "FOSA Account Sign. Details";
        ObjAccountSignApp: Record "Member App Signatories";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "Member App Nominee";
        NOKBOSA: Record "Members Next of Kin";
        BOSAACC: Code[20];
        NextOfKin: Record "Members Next of Kin";
        PictureExists: Boolean;
        text001: label 'Status must be open';
        UserMgt: Codeunit "User Setup Management";
        NotificationE: Codeunit Mail;
        MailBody: Text[250];
        ccEmail: Text[1000];
        toEmail: Text[1000];
        GenSetUp: Record "Sacco General Set-Up";
        ClearingAcctNo: Code[20];
        AdvrAcctNo: Code[20];
        DocumentType: Enum "Document Type";
        // DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        AccountTypes: Record "Account Types-Saving Products";
        DivAcctNo: Code[20];
        NameEditable: Boolean;
        AddressEditable: Boolean;
        NoEditable: Boolean;
        DioceseEditable: Boolean;
        HomeAdressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        CustPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        MaritalstatusEditable: Boolean;
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        OfficeBranchEditable: Boolean;
        DeptEditable: Boolean;
        SectionEditable: Boolean;
        OccupationEditable: Boolean;
        DesignationEdiatble: Boolean;
        EmployerCodeEditable: Boolean;
        DOBEditable: Boolean;
        EmailEdiatble: Boolean;
        StaffNoEditable: Boolean;
        GenderEditable: Boolean;
        MonthlyContributionEdit: Boolean;
        PostCodeEditable: Boolean;
        CityEditable: Boolean;
        WitnessEditable: Boolean;
        StatusEditable: Boolean;
        BankCodeEditable: Boolean;
        BranchCodeEditable: Boolean;
        BankAccountNoEditable: Boolean;
        VillageResidence: Boolean;
        SignatureExists: Boolean;
        NewMembNo: Code[30];
        Saccosetup: Record "Sacco No. Series";
        NOkApp: Record "Member App Nominee";
        TitleEditable: Boolean;
        PostalCodeEditable: Boolean;
        HomeAddressPostalCodeEditable: Boolean;
        HomeTownEditable: Boolean;
        RecruitedEditable: Boolean;
        ContactPEditable: Boolean;
        ContactPRelationEditable: Boolean;
        ContactPOccupationEditable: Boolean;
        CopyOFIDEditable: Boolean;
        CopyofPassportEditable: Boolean;
        SpecimenEditable: Boolean;
        ContactPPhoneEditable: Boolean;
        PictureEditable: Boolean;
        SignatureEditable: Boolean;
        PayslipEditable: Boolean;
        RegistrationFeeEditable: Boolean;
        CopyofKRAPinEditable: Boolean;
        membertypeEditable: Boolean;
        FistnameEditable: Boolean;
        dateofbirth2: Boolean;
        registrationeditable: Boolean;
        EstablishdateEditable: Boolean;
        RegistrationofficeEditable: Boolean;
        Signature2Editable: Boolean;
        Picture2Editable: Boolean;
        MembApp: Record "Membership Applications";
        title2Editable: Boolean;
        mobile3editable: Boolean;
        emailaddresEditable: Boolean;
        gender2editable: Boolean;
        postal2Editable: Boolean;
        town2Editable: Boolean;
        passpoetEditable: Boolean;
        maritalstatus2Editable: Boolean;
        payrollno2editable: Boolean;
        Employercode2Editable: Boolean;
        address3Editable: Boolean;
        DateOfAppointmentEDitable: Boolean;
        TermsofServiceEditable: Boolean;
        HomePostalCode2Editable: Boolean;
        Employername2Editable: Boolean;
        ageEditable: Boolean;
        CopyofconstitutionEditable: Boolean;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening";
        RecruitedByEditable: Boolean;
        RecruiterNameEditable: Boolean;
        RecruiterRelationShipEditable: Boolean;
        AccoutTypes: Record "Account Types-Saving Products";
        NomineeEditable: Boolean;
        TownEditable: Boolean;
        CountryEditable: Boolean;
        MobileEditable: Boolean;
        PassportEditable: Boolean;
        RejoiningDateEditable: Boolean;
        PrevousRegDateEditable: Boolean;
        AppCategoryEditable: Boolean;
        RegistrationDateEditable: Boolean;
        DataSheet: Record "Data Sheet Main";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cuat: Integer;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        OthersEditable: Boolean;
        Joint2DetailsVisible: Boolean;
        ProductsApp: Record "Membership Reg. Products Appli";
        NextofKinFOSA: Record "FOSA Account NOK Details";
        NumberofMembersEditable: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        EnableCreateMember: Boolean;
        //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        SFactory: Codeunit "Au Factory";
        WelcomeMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        RegistrationMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to  Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership registration has been successfully processed</p><p style="font-family:Verdana,Arial;font-size:9pt">Your membership number is <b>%2</b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        EditableField: Boolean;
        RefereeEditable: Boolean;
        EmailIndemnifiedEditable: Boolean;
        SendEStatementsEditable: Boolean;
        ObjAccountAppAgent: Record "Account Agents App Details";
        ObjAccountAgent: Record "Account Agent Details";
        ObjMemberAppAgent: Record "Member Agents App Details";
        ObjMemberAgent: Record "Member Agent Details";
        IdentificationDocTypeEditable: Boolean;
        PhysicalAddressEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
        WkFlwIntegration: codeunit WorkflowIntegration;
        ObjAccountAgents: Record "Account Agent Details";
        ObjMembers: Record Customer;
        ObjBOSAAccount: Record "BOSA Accounts No Buffer";
        CompInfo: Record "Company Information";
        ObjProductsApp: Record "Membership Reg. Products Appli";
        ObjCust: Record Customer;
        ObjSaccosetup: Record "Sacco General Set-Up";
        ObjMemberNoseries: Record "Member Accounts No Series";
        VarNewMembNo: Code[30];
        ObjNextOfKinApp: Record "Member App Nominee";
        ObjNextOfKin: Record "Members Next of Kin";
        ObjAccountSign: Record "FOSA Account Sign. Details";
        VarAcctNo: Code[30];
        VarBOSAACC: Code[30];
        ObjAccounts: Record Vendor;
        ObjNextofKinFOSA: Record "FOSA Account NOK Details";
        ObjGenSetUp: Record "Sacco General Set-Up";
        VarAccountDescription: Text;
        VarAccountTypes: Code[250];
        ObjAccountType: Record "Account Types-Saving Products";
        VarMemberName: Text;
        SurestepFactory: Codeunit "Au Factory";
        VarTextExtension: Text;
        VarTextExtensionII: Text;
        VarEmailSubject: Text;
        VarEmailBody: Text;
        ObjNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        VarDocumentNo: Code[30];
        CoveragePercentStyle: Text;
        ObjEntitiesAMLEntries: Record "Entities Customer Risk Rate";


    procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::Approved then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            EmployerCodeEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;

        if Rec.Status = Rec.Status::"Pending Approval" then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            EmployerCodeEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;


        if Rec.Status = Rec.Status::Open then begin
            NameEditable := true;
            AddressEditable := true;
            GlobalDim1Editable := true;
            GlobalDim2Editable := true;
            CustPostingGroupEdit := true;
            PhoneEditable := true;
            MaritalstatusEditable := true;
            IDNoEditable := true;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            OfficeBranchEditable := true;
            DeptEditable := true;
            SectionEditable := true;
            OccupationEditable := true;
            DesignationEdiatble := true;
            EmployerCodeEditable := true;
            DOBEditable := true;
            EmailEdiatble := true;
            StaffNoEditable := true;
            GenderEditable := true;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := true;
            WitnessEditable := true;
            BankCodeEditable := true;
            BranchCodeEditable := true;
            BankAccountNoEditable := true;
            VillageResidence := true;
            TitleEditable := true;
            PostalCodeEditable := true;
            HomeAddressPostalCodeEditable := true;
            HomeTownEditable := true;
            RecruitedEditable := true;
            ContactPEditable := true;
            ContactPRelationEditable := true;
            ContactPOccupationEditable := true;
            CopyOFIDEditable := true;
            CopyofPassportEditable := true;
            SpecimenEditable := true;
            ContactPPhoneEditable := true;
            HomeAdressEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            PayslipEditable := true;
            RegistrationFeeEditable := true;
            title2Editable := true;
            emailaddresEditable := true;
            gender2editable := true;
            HomePostalCode2Editable := true;
            town2Editable := true;
            passpoetEditable := true;
            maritalstatus2Editable := true;
            payrollno2editable := true;
            Employercode2Editable := true;
            address3Editable := true;
            Employername2Editable := true;
            ageEditable := true;
            mobile3editable := true;
            CopyofconstitutionEditable := true;
            NomineeEditable := true;
            TownEditable := true;
            CountryEditable := true;
            MobileEditable := true;
            PassportEditable := true;
            RejoiningDateEditable := true;
            PrevousRegDateEditable := true;
            AppCategoryEditable := true;
            RegistrationDateEditable := true;
            TermsofServiceEditable := true;
            EmployerCodeEditable := true;
            RecruitedByEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            IdentificationDocTypeEditable := true;
            PhysicalAddressEditable := true;
            RefereeEditable := true;
            MonthlyIncomeEditable := true;
        end
    end;

    local procedure SelfRecruitedControl()
    begin
        /*
            IF "Self Recruited"=TRUE THEN BEGIN
             RecruitedByEditable:=FALSE;
             RecruiterNameEditable:=FALSE;
             RecruiterRelationShipEditable:=FALSE;
             END ELSE
            IF "Self Recruited"<>TRUE THEN BEGIN
             RecruitedByEditable:=TRUE;
             RecruiterNameEditable:=TRUE;
             RecruiterRelationShipEditable:=TRUE;
             END;
             */

    end;


    procedure FnSendReceivedApplicationSMS()
    begin

        GenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := Rec."No.";
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := BOSAACC;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBAPP';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member your application has been received and going through approval,'
        + ' ' + CompInfo.Name + ' ' + GenSetUp."Customer Care No";
        SMSMessage."Telephone No" := Rec."Mobile Phone No";
        if Rec."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;


    procedure FnSendRegistrationSMS()
    begin

        GenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := Rec."No.";
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := BOSAACC;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBREG';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member you have been registered successfully, your Membership No is '
        + BOSAACC + ' Name ' + Rec.Name + ' ' + CompInfo.Name + ' ' + GenSetUp."Customer Care No";
        SMSMessage."Telephone No" := Rec."Mobile Phone No";
        if Rec."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure UpdateViewLogEntries()
    begin
        /*ViewLog.INIT;
        ViewLog."Entry No.":=ViewLog."Entry No."+1;
        ViewLog."User ID":=USERID;
        ViewLog."Table No.":=51516364;
        ViewLog."Table Caption":='Members Register';
        ViewLog.Date:=TODAY;
        ViewLog.Time:=TIME;
        */

    end;

    local procedure FnCheckfieldrestriction()
    begin
        if (Rec."Account Category" = Rec."account category"::Individual) then begin
            //CALCFIELDS(Picture,Signature);
            Rec.TestField(Name);
            Rec.TestField("ID No.");
            Rec.TestField("Mobile Phone No");
            //TESTFIELD("Employer Code");
            //TESTFIELD("Personal No");
            Rec.TestField("Monthly Contribution");
            Rec.TestField("Member's Residence");
            Rec.TestField(Gender);
            Rec.TestField("Employment Info");
            Rec.TestField("Address 2");

            //TESTFIELD("Copy of Current Payslip");
            //TESTFIELD("Member Registration Fee Receiv");
            Rec.TestField("Customer Posting Group");
            Rec.TestField("Global Dimension 1 Code");
            //TESTFIELD("Global Dimension 2 Code");
            //TESTFIELD("Contact Person");
            //TESTFIELD("Contact Person Phone");
            //IF Picture=0 OR Signature=0 THEN
            //ERROR(Insert )
        end else

            if (Rec."Account Category" = Rec."account category"::Group) or (Rec."Account Category" = Rec."account category"::Joint) then begin
                Rec.TestField(Name);
                Rec.TestField("Registration No");
                Rec.TestField("Copy of KRA Pin");
                Rec.TestField("Member Registration Fee Receiv");
                ///TESTFIELD("Account Category");
                Rec.TestField("Customer Posting Group");
                Rec.TestField("Global Dimension 1 Code");
                Rec.TestField("Global Dimension 2 Code");
                //TESTFIELD("Copy of constitution");
                Rec.TestField("Contact Person");
                Rec.TestField("Contact Person Phone");

            end;
    end;

    local procedure FnSendReceivedApplicationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    var
        Memb: Record "Membership Applications";
        // SMTPMail: Codeunit "SMTP Mail";
        // SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        Recipient: list of [Text];
    begin
        //   SMTPSetup.Get();

        Memb.Reset;
        Memb.SetRange(Memb."No.", ApplicationNo);
        if Memb.Find('-') then begin
            if Email = '' then begin
                Error('Email Address Missing for Member Application number' + '-' + Memb."No.");
            end;
            // if Memb."E-Mail (Personal)" <> '' then
            //     Recipient.Add(Email);
            // SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Recipient, 'Membership Application', '', true);
            // SMTPMail.AppendBody(StrSubstNo(WelcomeMessage, Memb.Name, IDNo, UserId));
            // SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            // SMTPMail.AppendBody('<br><br>');
            // SMTPMail.AddAttachment(FileName, Attachment);
            // SMTPMail.Send;
        end;
    end;

    local procedure FnSendRegistrationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    var
        Memb: Record "Membership Applications";
        //SMTPMail: Codeunit "SMTP Mail";
        //SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        //  SMTPSetup.Get();

        VarAccountDescription := '';
        VarAccountTypes := '<p><ul style="list-style-type:square">';

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarBOSAACC);
        if ObjAccounts.FindSet then begin
            repeat

                if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                    VarAccountDescription := ObjAccountType.Description;
                end;

                VarAccountTypes := VarAccountTypes + '<li>' + Format(ObjAccounts."No.") + ' - ' + Format(VarAccountDescription) + '</li>';
            until ObjAccounts.Next = 0;
        end;
        VarAccountTypes := VarAccountTypes + '</ul></p>';


        VarMemberName := SurestepFactory.FnConvertTexttoBeginingWordstostartWithCapital(Rec.Name);
        VarTextExtension := '<p>At Kingdom Sacco, we provide you with a variety of efficient and convenient services that enable you to:</p>' +
               '<p>1. Make Automated Deposit to your account through any Equity Bank Branch to our Account No. 15172262333007 and any Family Bank Branch via Utility Payment. You will provide your Kingdom Sacco 12-digit Account Number.</p>' +
               '<p>2. Make Automated Deposits through MPESA or Equitel/Equity Bank Agents using our Paybill No. 521000 and through Family Bank Agents using Bill Payment Code 020, then provide your Account Number and Amount.</p>' +
               '<p>3. Transact through our Mobile Banking Channels to Apply for Loans, MPESA Withdrawal, Account Transfers, Account Enquiries, Statement Requests etc. You can download Kingdom Sacco Mobile App on Google Play Store</p>';

        VarTextExtensionII := '<p>5. Access funds via Cardless ATM Withdrawal Service with Family Bank accessible to all our registered Mobile Banking Users. For guidelines send the word CARDLESS to 0705270662 or use our Mobile App.</p>' +
               '<p>6. Apply for a Cheque Book and initiate cheque payments from your account at Kingdom Sacco.</p>' +
               '<p>7. Process your salary to your Kingdom Sacco Account and benefit from very affordable salary loans.</p>' +
               '<p>8. Operate an Ufalme Account and save in order to acquire Land/Housing in our upcoming projects.</p>' +
               '<p>Visit our website <a href="http://www.kingdomsacco.com">www.kingdomsacco.com</a> for more information on our service offering.</p>' +
               '<p>Thank you for choosing Kingdom Sacco. Our objective is to empower you economically and socially by promoting a Savings and Investments culture and providing affordable credit.</p>';


        VarEmailSubject := 'WELCOME TO KINGDOM SACCO';
        VarEmailBody := 'Welcome and Thank you for Joining Kingdom Sacco. Your Membership Number is ' + VarBOSAACC + '. Your Account Numbers are: ' + VarAccountTypes + VarTextExtension + VarTextExtensionII;

        //   SurestepFactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, "E-Mail (Personal)", '', '');
    end;

    local procedure FnUpdateMemberSubAccounts()
    begin
        Saccosetup.Get();

        //SHARE CAPITAL
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", Rec."No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '601');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", Rec."ID No.");
            if ObjMembers.FindSet then begin
                if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(HQ)");
                    Saccosetup."Share Capital Account No(HQ)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(NAIV)");
                    Saccosetup."Share Capital Account No(NAIV)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(NKR)");
                    Saccosetup."Share Capital Account No(NKR)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(ELD)");
                    Saccosetup."Share Capital Account No(ELD)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Share Capital No" := IncStr(Saccosetup."Share Capital Account No(MSA)");
                    Saccosetup."Share Capital Account No(MSA)" := ObjMembers."Share Capital No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Share Capital No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Share Capital";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '601';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;
        //END SHARE CAPITAL

        //DEPOSITS CONTRIBUTION
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", Rec."No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '602');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", Rec."ID No.");
            if ObjMembers.FindSet then begin
                if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
                    Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
                    Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
                    Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;
                if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
                    Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;
                if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
                    Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '602';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

        //CORPORATE DEPOSITS CONTRIBUTION
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", Rec."No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '603');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", Rec."ID No.");
            if ObjMembers.FindSet then begin
                if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
                    Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
                    Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
                    Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;
                if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
                    Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;
                if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
                    Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '603';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

        //FOSA SHARES CONTRIBUTION
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", Rec."No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '605');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", Rec."ID No.");
            if ObjMembers.FindSet then begin
                if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
                    Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
                    Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
                    Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;
                if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
                    Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;
                if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
                    Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '605';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

        //FOSA SHARES CONTRIBUTION
        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", Rec."No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '607');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", Rec."ID No.");
            if ObjMembers.FindSet then begin
                if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(HQ)");
                    Saccosetup."Deposits Account No(HQ)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NAIV)");
                    Saccosetup."Deposits Account No(NAIV)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(NKR)");
                    Saccosetup."Deposits Account No(NKR)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;
                if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(ELD)");
                    Saccosetup."Deposits Account No(ELD)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;
                if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Deposits Account No" := IncStr(Saccosetup."Deposits Account No(MSA)");
                    Saccosetup."Deposits Account No(MSA)" := ObjMembers."Deposits Account No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Deposits Account No";
                    ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Deposit Contribution";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '607';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

        //BENEVOLENT FUND

        ProductsApp.Reset;
        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", Rec."No.");
        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::BOSA);
        ProductsApp.SetRange(ProductsApp.Product, '606');
        if ProductsApp.FindSet then begin
            ObjMembers.Reset;
            ObjMembers.SetRange(ObjMembers."ID No.", Rec."ID No.");
            if ObjMembers.FindSet then begin
                if Rec."Global Dimension 2 Code" = 'NAIROBI' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(HQ)");
                    Saccosetup."BenFund Account No(HQ)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                    //ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;

                end;
                if Rec."Global Dimension 2 Code" = 'NAIVASHA' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(NAIV)");
                    Saccosetup."BenFund Account No(NAIV)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                    //ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'NAKURU' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(NKR)");
                    Saccosetup."BenFund Account No(NKR)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                 //   ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'ELDORET' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(ELD)");
                    Saccosetup."BenFund Account No(ELD)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;


                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                   // ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;
                end;

                if Rec."Global Dimension 2 Code" = 'MOMBASA' then begin
                    ObjMembers."Benevolent Fund No" := IncStr(Saccosetup."BenFund Account No(MSA)");
                    Saccosetup."BenFund Account No(MSA)" := ObjMembers."Benevolent Fund No";
                    ObjMembers.Modify;
                    Saccosetup.Modify;

                    ObjBOSAAccount.Init;
                    ObjBOSAAccount."Account No" := ObjMembers."Benevolent Fund No";
                   // ObjBOSAAccount."Transaction Type" := ObjBOSAAccount."transaction type"::"Benevolent Fund";
                    ObjBOSAAccount."Member No" := ObjMembers."No.";
                    ObjBOSAAccount."Account Name" := ObjMembers.Name;
                    ObjBOSAAccount."ID No" := ObjMembers."ID No.";
                    ObjBOSAAccount."Account Type" := '606';
                    ObjBOSAAccount.Insert;
                end;
            end;
        end;

    end;

    local procedure FnRuninsertBOSAAccountNos(VarMemberNo: Code[30])
    begin

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetRange(ObjAccounts."Account Type", '601');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."Share Capital No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetFilter(ObjAccounts."Account Type", '=%1|%2', '602', '603');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."Deposits Account No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetFilter(ObjAccounts."Account Type", '=%1', '606');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."Benevolent Fund No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;


        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        ObjAccounts.SetFilter(ObjAccounts."Account Type", '=%1', '605');
        ObjAccounts.SetRange(ObjAccounts.Status, ObjAccounts.Status::Active);
        if ObjAccounts.FindSet then begin
            if ObjCust.Get(VarMemberNo) then begin
                ObjCust."FOSA Shares Account No" := ObjAccounts."No.";
                ObjCust.Modify;
            end;
        end;
    end;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member Risk Level" <> Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member Risk Level" = Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Favorable';
    end;
}




