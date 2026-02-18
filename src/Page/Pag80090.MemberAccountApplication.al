//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 80090 "Member Account Application"
{
    CardPageID = "Member Account Appl. Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    Caption = 'Fosa Account opennig List';
    ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "FOSA Account Applicat. Details";
    SourceTableView = where("Application Status" = filter(<> Converted),
                            "Online Application" = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account No"; Rec."BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type Name"; Rec."Account Type Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Application Status"; Rec."Application Status")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                }
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
                action("Next of Kin")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Product App Nominee Details";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HR Employees Attachements";
                    RunPageLink = "First Name" = field("No.");
                }
            }
        }
        area(processing)
        {
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    //TESTFIELD("Employer Code");
                    Rec.TestField("Account Type");
                    Rec.TestField("ID No.");
                    Rec.TestField("Staff No");
                    //TESTFIELD("BOSA Account No");
                    Rec.TestField("Date of Birth");
                    Rec.TestField("Global Dimension 2 Code");
                    /*
                    IF ("Micro Group"=FALSE) OR ("Micro Single"=FALSE) THEN
                    IF "BOSA Account No"='' THEN
                    ERROR('Please specify the Bosa Account.');
                    //TESTFIELD("BOSA Account No");
                    //TESTFIELD("Employer Code");
                    */

                    /*IF "Global Dimension 2 Code" = '' THEN
                    ERROR('Please specify the branch.');
                     */
                    if Rec."Application Status" = Rec."application status"::Converted then
                        Error('Application has already been converted.');

                    if AccoutTypes.Get(Accountype) then begin
                        if AccoutTypes."Account Type" = AccoutTypes."Account Type"::"Membership-Fosa" then begin
                            Nok.Reset;
                            Nok.SetRange(Nok."Account No", Rec."No.");
                            /*IF Nok.FIND('-') = FALSE THEN BEGIN
                            ERROR('Next of Kin have not been specified.');
                            END;*/

                        end;
                    end;


                    if Confirm('Are you sure you want to approve & create this account', true) = false then
                        exit;


                    Rec."Application Status" := Rec."application status"::Converted;
                    Rec.Modify;



                    BranchC := '';
                    IncrementNo := '';
                    /*
                    DimensionValue.RESET;
                    DimensionValue.SETRANGE(DimensionValue.Code,"Global Dimension 2 Code");
                    IF DimensionValue.FIND('-') THEN
                    BranchC:=DimensionValue."Account Code";
                    IncrementNo:=INCSTR(DimensionValue."No. Series");
                    
                    DimensionValue."No. Series":=IncrementNo;
                    DimensionValue.MODIFY;
                    */

                    if AccoutTypes.Get(Rec."Account Type") then begin
                        if AccoutTypes."Fixed Deposit" = true then begin
                            Rec.TestField(Rec."Savings Account No.");
                            //TESTFIELD("Maturity Type");
                            //TESTFIELD("Fixed Deposit Type");
                        end;

                        //get account 
                        AccoutTypes.Reset();
                        ;
                        AccoutTypes.SetRange(AccoutTypes.code, Rec."Account Type");
                        if AccoutTypes.Find('-') then begin
                            AcctNo := AccoutTypes."Account No Prefix" + '-' + Rec."BOSA Account No" + IncStr(AccoutTypes."Last No Used");
                        end;
                        Message('Generated account no is %1', AcctNo);
                        Accounts.Init;
                        Accounts."No." := AcctNo;
                        Accounts."Date of Birth" := Rec."Date of Birth";
                        Accounts.Name := Rec.Name;
                        Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                        Accounts."Debtor Type" := Rec."Debtor Type";
                        if Rec."Micro Single" = true then
                            Accounts."Group Account" := false
                        else
                            if Rec."Micro Group" = true then
                                Accounts."Group Account" := false;
                        Accounts."Personal No." := Rec."Staff No";
                        Accounts."ID No." := Rec."ID No.";
                        Accounts."Mobile Phone No" := Rec."Mobile Phone No";
                        Accounts."Registration Date" := Rec."Registration Date";
                        //Accounts."Marital Status":="Marital Status";
                        Accounts."BOSA Account No" := Rec."BOSA Account No";
                        //toDO Accounts.Image:=Picture;
                        Accounts.Signature := Rec.Signature;
                        Accounts."Passport No." := Rec."Passport No.";
                        Accounts."Employer Code" := Rec."Employer Code";
                        Accounts.Status := Accounts.Status::Deceased;
                        Accounts."Account Type" := Rec."Account Type";
                        Accounts."Account Category" := Rec."Account Category";
                        Accounts."Date of Birth" := Rec."Date of Birth";
                        Accounts."Global Dimension 1 Code" := 'FOSA';
                        Accounts."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        Accounts.Address := Rec.Address;
                        Accounts."Address 2" := Rec."Address 2";
                        Accounts.City := Rec.City;
                        Accounts."Phone No." := Rec."Phone No.";
                        Accounts."Telex No." := Rec."Telex No.";
                        Accounts."Post Code" := Rec."Post Code";
                        Accounts.County := Rec.County;
                        Accounts."E-Mail" := Rec."E-Mail";
                        Accounts."Home Page" := Rec."Home Page";
                        Accounts."Registration Date" := Today;
                        //Accounts.Status:=Status::New;
                        Accounts.Status := Rec.Status::Open;
                        Accounts.Section := Rec.Section;
                        Accounts."Home Address" := Rec."Home Address";
                        Accounts.District := Rec.District;
                        Accounts.Location := Rec.Location;
                        Accounts."Sub-Location" := Rec."Sub-Location";
                        Accounts."Savings Account No." := Rec."Savings Account No.";
                        Accounts."Signing Instructions" := Rec."Signing Instructions";
                        Accounts."Fixed Deposit Type" := Rec."Fixed Deposit Type";
                        Accounts."FD Maturity Date" := Rec."FD Maturity Date";
                        Accounts."Registration Date" := Today;
                        Accounts."Monthly Contribution" := Rec."Monthly Contribution";
                        Accounts."Formation/Province" := Rec."Formation/Province";
                        Accounts."Division/Department" := Rec."Division/Department";
                        Accounts."Station/Sections" := Rec."Station/Sections";
                        Accounts."Force No." := Rec."Force No.";
                        Accounts."Vendor Posting Group" := Rec."Account Type";
                        Accounts.Insert;

                    end;


                    Accounts.Reset;
                    if Accounts.Get(AcctNo) then begin
                        Accounts.Validate(Accounts.Name);
                        Accounts.Validate(Accounts."Account Type");
                        Accounts.Validate(Accounts."Global Dimension 1 Code");
                        Accounts.Validate(Accounts."Global Dimension 2 Code");
                        Accounts.Modify;

                        //Update BOSA with FOSA Account
                        if (Rec."Account Type" = 'SAV') then begin
                            if Cust.Get(Rec."BOSA Account No") then begin
                                Cust."FOSA Account No." := AcctNo;
                                //Cust."FOSA Account":="No.";
                                Cust.Modify;
                            end;
                        end;

                    end;

                    NextOfKinApp.Reset;
                    NextOfKinApp.SetRange(NextOfKinApp."Account No", Rec."No.");
                    if NextOfKinApp.Find('-') then begin
                        repeat
                            NextOfKin.Init;
                            //NextOfKin."Account No":=AcctNo;
                            NextOfKin."Account No" := Rec."No.";

                            NextOfKin.Name := NextOfKinApp.Name;
                            NextOfKin.Relationship := NextOfKinApp.Relationship;
                            NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                            NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                            NextOfKin.Address := NextOfKinApp.Address;
                            NextOfKin.Telephone := NextOfKinApp.Telephone;
                        /*NextOfKin.Fax:=NextOfKinApp.Fax;
                        NextOfKin.Email:=NextOfKinApp.Email;
                        NextOfKin."ID No.":=NextOfKinApp."ID No.";
                        NextOfKin."%Allocation":=NextOfKinApp."%Allocation";
                        NextOfKin.INSERT;*/

                        until NextOfKinApp.Next = 0;
                    end;

                    AccountSignApp.Reset;
                    AccountSignApp.SetRange(AccountSignApp."Document No", Rec."No.");
                    if AccountSignApp.Find('-') then begin
                        repeat
                            AccountSign.Init;
                            AccountSign."Account No" := AcctNo;
                            AccountSign.Names := AccountSignApp.Names;
                            AccountSign."Date Of Birth" := AccountSignApp."Date Of Birth";
                            AccountSign."ID No." := AccountSignApp."ID No.";
                            AccountSign.Signatory := AccountSignApp.Signatory;
                            AccountSign."Must Sign" := AccountSignApp."Must Sign";
                            AccountSign."Must be Present" := AccountSignApp."Must be Present";
                            AccountSign.Picture := AccountSignApp.Picture;
                            AccountSign.Signature := AccountSignApp.Signature;
                            AccountSign."Expiry Date" := AccountSignApp."Expiry Date";
                            AccountSign.Insert;

                        until AccountSignApp.Next = 0;
                    end;


                    Message('Account approved & created successfully.');

                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec."Application Status" = Rec."application status"::Converted then
                        Error('Application has already been converted.');

                    if Confirm('Are you sure you want to reject this application', true) = true then begin
                        Rec."Application Status" := Rec."application status"::Rejected;
                        Rec.Modify;
                    end;
                end;
            }
            group(Approvals)
            {
                action(Create)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Account';
                    Enabled = EnableCreateMember;
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        //-----Check Mandatory Fields---------
                        Rec.TestField("Employer Code");
                        Rec.TestField("Account Type");
                        Rec.TestField("ID No.");
                        Rec.TestField("Staff No");
                        Rec.TestField("BOSA Account No");
                        Rec.TestField("Date of Birth");
                        Rec.TestField("Global Dimension 2 Code");
                        if Rec."Global Dimension 2 Code" = '' then
                            Error('Please specify the branch.');

                        //-----End Check Mandatory Fields---------

                        //----Check If account Already Exists------
                        Acc.Reset;
                        Acc.SetRange(Acc."BOSA Account No", Rec."BOSA Account No");
                        Acc.SetRange(Acc."Account Type", Rec."Account Type");
                        Acc.SetFilter(Acc.Status, '<>%1', Acc.Status::Closed);
                        Acc.SetFilter(Acc.Status, '<>%1', Acc.Status::Deceased);
                        Acc.SetRange(Acc.Status, Acc.Status::Active);
                        if Acc.Find('-') then
                            Error('Account already exists. %1', Acc."No.");
                        //----End Check If account Already Exists------


                        //---Checkfields If Fixed Deposit------------
                        if AccoutTypes.Get(Rec."Account Type") then begin
                            if AccoutTypes."Fixed Deposit" = true then begin
                                Rec.TestField("Savings Account No.");
                              end;
                            //---End Checkfields If Fixed Deposit------------

                            if Rec."Application Status" = Rec."application status"::Converted then
                                Error('Application has already been converted.');


                           if Confirm('Are you sure you want to create this account?', true) = false then
                                exit;
                            Rec."Application Status" := Rec."application status"::Converted;
                            Rec."Registration Date" := Today;
                            Rec.Modify;

                            //--Assign Account Nos Based On The Product Type-----
                            //FOSA A/C FORMAT =PREFIX-MEMBERNO-PRODUCTCODE
                            if AccoutTypes.Get(Rec."Account Type") then
                                AcctNo := AccoutTypes."Account No Prefix" + '-' + Rec."BOSA Account No" + '-' + IncStr(AccoutTypes."Last No Used");

                            //---Create Account on Vendor Table----
                            Accounts.Init;
                            Accounts."No." := AcctNo;
                            Accounts."Date of Birth" := Rec."Date of Birth";
                            Accounts.Name := Rec.Name;
                            Accounts."Creditor Type" := Accounts."creditor type"::"FOSA Account";
                            Accounts."Personal No." := Rec."Staff No";
                            Accounts."ID No." := Rec."ID No.";
                            Accounts."Mobile Phone No" := Rec."Mobile Phone No";
                            Accounts."Registration Date" := Rec."Registration Date";
                            Accounts."Employer Code" := Rec."Employer Code";
                            Accounts."BOSA Account No" := Rec."BOSA Account No";
                            Accounts.Piccture := Rec.Picture;
                            Accounts.Signature := Rec.Signature;
                            Accounts."Passport No." := Rec."Passport No.";
                            Accounts.Status := Accounts.Status::Active;
                            Accounts."Account Type" := Rec."Account Type";
                            Accounts."Account Category" := Rec."Account Category";
                            Accounts."Date of Birth" := Rec."Date of Birth";
                            Accounts."Global Dimension 1 Code" := 'FOSA';
                            Accounts."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                            Accounts.Address := Rec.Address;
                            Accounts."Address 2" := Rec."Address 2";
                            Accounts.City := Rec.City;
                            Accounts."Phone No." := Rec."Phone No.";
                            Accounts."Telex No." := Rec."Telex No.";
                            Accounts."Post Code" := Rec."Post Code";
                            Accounts.County := Rec.County;
                            Accounts."E-Mail" := Rec."E-Mail";
                            Accounts."Home Page" := Rec."Home Page";
                            Accounts."Registration Date" := Today;
                            Accounts.Status := Rec.Status::Approved;
                            Accounts.Section := Rec.Section;
                            Accounts."Home Address" := Rec."Home Address";
                            Accounts.District := Rec.District;
                            Accounts.Location := Rec.Location;
                            Accounts."Sub-Location" := Rec."Sub-Location";
                            Accounts."Savings Account No." := Rec."Savings Account No.";
                            Accounts."Registration Date" := Today;
                            Accounts."Vendor Posting Group" := Rec."Vendor Posting Group";
                            Accounts.Insert;
                            Rec."Application Status" := Rec."application status"::Converted;
                        end;
                        AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                        AccoutTypes.Modify;

                        Accounts.Reset;
                        if Accounts.Get(AcctNo) then begin
                            Accounts.Validate(Accounts.Name);
                            Accounts.Validate(Accounts."Account Type");
                            Accounts.Validate(Accounts."Global Dimension 1 Code");
                            Accounts.Validate(Accounts."Global Dimension 2 Code");
                            Accounts.Modify;

                            //---Update BOSA with FOSA Account----
                            if (Rec."Account Type" = 'SAVINGS') then begin
                                if Cust.Get(Rec."BOSA Account No") then begin
                                    Cust."FOSA Account No." := AcctNo;
                                    Cust.Modify;
                                end;
                            end;
                            //---End Update BOSA with FOSA Account----
                        end;

                        //----Insert Nominee Information------
                        NextOfKinApp.Reset;
                        NextOfKinApp.SetRange(NextOfKinApp."Account No", Rec."No.");
                        if NextOfKinApp.Find('-') then begin
                            repeat
                                NextOfKin.Init;
                                NextOfKin."Account No" := Rec."No.";
                                NextOfKin.Name := NextOfKinApp.Name;
                                NextOfKin.Relationship := NextOfKinApp.Relationship;
                                NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                                NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                                NextOfKin.Address := NextOfKinApp.Address;
                                NextOfKin.Telephone := NextOfKinApp.Telephone;
                                //NextOfKin.Fax:=NextOfKinApp.Fax;
                                NextOfKin.Email := NextOfKinApp.Email;
                                NextOfKin."ID No." := NextOfKinApp."ID No.";
                                NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
                                NextOfKin.Insert;
                            until NextOfKinApp.Next = 0;
                        end;
                        //----End Insert Nominee Information------

                        //Insert Account Signatories------
                        AccountSignApp.Reset;
                        AccountSignApp.SetRange(AccountSignApp."Document No", Rec."No.");
                        if AccountSignApp.Find('-') then begin
                            repeat
                                AccountSign.Init;
                                AccountSign."Account No" := AcctNo;
                                AccountSign.Names := AccountSignApp."Account No";
                                AccountSign."Date Of Birth" := AccountSignApp."Date Of Birth";
                                AccountSign."ID No." := AccountSignApp."ID No.";
                                AccountSign.Signatory := AccountSignApp.Signatory;
                                AccountSign."Must Sign" := AccountSignApp."Must Sign";
                                AccountSign."Must be Present" := AccountSignApp."Must be Present";
                                AccountSign.Picture := AccountSignApp.Picture;
                                AccountSign.Signature := AccountSignApp.Signature;
                                AccountSign."Expiry Date" := AccountSignApp."Expiry Date";
                                AccountSign.Insert;
                                Rec."Application Status" := Rec."application status"::Converted;
                            until AccountSignApp.Next = 0;
                        end;
                        //Insert Account Signatories------

                        //--Send Confirmation Sms to The Member------
                        SFactory.FnSendSMS('FOSA ACC', 'Your Account successfully created.Account No=' + AcctNo, AcctNo, Rec."Mobile Phone No");
                        Message('You have successfully created a %1 Product, A/C No=%2. Member will be notified via SMS', Rec."Account Type", AcctNo);

                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Suite;
                    Caption = 'Send Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Confirm('Are you sure you want to send Approval request for this record?', true) = false then
                            exit;
                        if Rec."Micro Group" <> true then begin
                            Rec.TestField("Account Type");
                            Rec.TestField("ID No.");
                            //TESTFIELD("Staff No");
                            //TESTFIELD("BOSA Account No");
                            Rec.TestField("Date of Birth");
                            Rec.TestField("Global Dimension 2 Code");
                        end;

                        if (Rec."Micro Single" = true) then begin
                            Rec.TestField("Group Code");
                            Rec.TestField("Global Dimension 2 Code");
                            Rec.TestField("Account Type");
                        end;

                        // if (Rec."Micro Single" <> true) and (Rec."Micro Group" <> true) then
                        //     if Rec."Account Type" = 'SAVINGS' then begin
                        //         Rec.TestField("BOSA Account No");
                        //     end;

                        if Rec.Status <> Rec.Status::Open then
                            Error(Text001);
                        IF ApprovalsMgmt.CheckFAccountApplicationApprovalsWorkflowEnabled(Rec) THEN
                            ApprovalsMgmt.OnSendFAccountApplicationForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Suite;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Confirm('Are you sure you want cancel Approval request for this record?', true) = false then
                            exit;
                           // Approvalmgt.OnCancelFAccountApplicationApprovalRequest(Rec);
                    end;
                }
                action(Approval)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::ProductApplication;
                        ApprovalEntries.SetRecordFilters(Database::"FOSA Account Applicat. Details", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        EnableCreateMember := false;
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec.Status = Rec.Status::Approved) then
            EnableCreateMember := true;
    end;

    trigger OnOpenPage()
    begin
        ObjUserSetup.Reset;
        ObjUserSetup.SetRange("User ID", UserId);
        if ObjUserSetup.Find('-') then begin
            if ObjUserSetup."Approval Administrator" <> true then
                Rec.SetRange("Created By", UserId);
        end;
    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        PictureExists: Boolean;
        AccoutTypes: Record "Account Types-Saving Products";
        Accounts: Record Vendor;
        AcctNo: Code[50];

        DimensionValue: Record "Dimension Value";
        NextOfKin: Record "FOSA Account NOK Details";
        NextOfKinApp: Record "FOSA Account App Kin Details";
        AccountSign: Record "FOSA Account Sign. Details";
        AccountSignApp: Record "Product App Signatories";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "FOSA Account App Kin Details";
        Cust: Record Customer;
        NOKBOSA: Record "FOSA Account NOK Details";
        BranchC: Code[20];
        DimensionV: Record "Dimension Value";
        IncrementNo: Code[20];
        MicSingle: Boolean;
        MicGroup: Boolean;
        BosaAcnt: Boolean;
        EmailEdiatble: Boolean;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions;
        SaccoSetup: Record "Sacco No. Series";
        MicroGroupCode: Boolean;
        Vendor: Record Vendor;
        NameEditable: Boolean;
        NoEditable: Boolean;
        AddressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        VendorPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        MaritalstatusEditable: Boolean;
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        EmployerCodeEditable: Boolean;
        DOBEditable: Boolean;
        StaffNoEditable: Boolean;
        GenderEditable: Boolean;
        MonthlyContributionEdit: Boolean;
        PostCodeEditable: Boolean;
        CityEditable: Boolean;
        RecruitedEditable: Boolean;
        ContactPEditable: Boolean;
        ContactPRelationEditable: Boolean;
        ContactPOccupationEditable: Boolean;
        ContactPPhoneEditable: Boolean;
        Accountype: Boolean;
        Approvalusers: Record "Status Change Permision";
        Member: Record Customer;
        IncrementNoF: Code[20];
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        ParentEditable: Boolean;
        SavingsEditable: Boolean;
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit WorkflowIntegration;
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        SFactory: Codeunit "Au Factory";
        ObjUserSetup: Record "User Setup";
}




