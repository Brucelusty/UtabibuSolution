//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50040 "Updated Change Request Card"
{
    Editable = false;
    PageType = Card;
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "Change Request";
    PromotedActionCategories = 'New,Process,Report,Send & Cancel Approval,Update Changes';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; rec.No)
                {
                    ApplicationArea = Basic;
                }
                field(Type; rec.Type)
                {
                    ApplicationArea = Basic;
                    Editable = TypeEditable;

                    trigger OnValidate()
                    begin
                        AccountVisible := false;
                        MobileVisible := false;
                        nxkinvisible := false;

                        if rec.Type = rec.Type::"Mobile Change" then begin
                            MobileVisible := true;
                        end;

                        if rec.Type = rec.Type::"ATM Change" then begin
                            AccountVisible := true;
                            nxkinvisible := true;
                        end;

                        if rec.Type = rec.Type::"Backoffice Change" then begin
                            AccountVisible := true;
                            nxkinvisible := true;
                        end;
                        if rec.Type = rec.Type::"Agile Change" then begin
                            AccountVisible := true;
                            nxkinvisible := true;
                        end;
                    end;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Editable = AccountNoEditable;
                }
                field("Captured by"; Rec."Captured by")
                {
                    ApplicationArea = Basic;
                }
                field("Capture Date"; Rec."Capture Date")
                {
                    ApplicationArea = Basic;
                }
                field("Approved by"; Rec."Approved by")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reason for change"; Rec."Reason for change")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
            }
            group(Mobile)
            {
                Caption = 'Phone No Details';
                Visible = Mobilevisible;
                field("S-Mobile No"; Rec."S-Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("S-Mobile No(New Value)"; Rec."S-Mobile No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'S-Mobile No(New Value)';
                    Editable = SMobileNoEditable;
                }
            }
            group("Atm Details")
            {
                Caption = 'ATM Card Details';
                Visible = Atmvisible;
                field("ATM Approve"; Rec."ATM Approve")
                {
                    ApplicationArea = Basic;
                    Editable = ATMApproveEditable;
                }
                field("Card Expiry Date"; Rec."Card Expiry Date")
                {
                    ApplicationArea = Basic;
                    Editable = CardExpiryDateEditable;
                }
                field("Card Valid From"; Rec."Card Valid From")
                {
                    ApplicationArea = Basic;
                    Editable = CardValidFromEditable;
                }
                field("Card Valid To"; Rec."Card Valid To")
                {
                    ApplicationArea = Basic;
                    Editable = CardValidToEditable;
                }
                field("Date ATM Linked"; Rec."Date ATM Linked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM No."; Rec."ATM No.")
                {
                    ApplicationArea = Basic;
                    Editable = ATMNOEditable;
                }
                field("ATM Issued"; Rec."ATM Issued")
                {
                    ApplicationArea = Basic;
                    Editable = ATMIssuedEditable;
                }
                field("ATM Self Picked"; Rec."ATM Self Picked")
                {
                    ApplicationArea = Basic;
                    Editable = ATMSelfPickedEditable;
                }
                field("ATM Collector Name"; Rec."ATM Collector Name")
                {
                    ApplicationArea = Basic;
                    Editable = ATMCollectorNameEditable;
                }
                field("ATM Collectors ID"; Rec."ATM Collectors ID")
                {
                    ApplicationArea = Basic;
                    Editable = ATMCollectorIDEditable;
                }
                field("Atm Collectors Moile"; Rec."Atm Collectors Moile")
                {
                    ApplicationArea = Basic;
                    Editable = ATMCollectorMobileEditable;
                }
                field("Responsibility Centers"; Rec."Responsibility Centers")
                {
                    ApplicationArea = Basic;
                    Editable = ResponsibilityCentreEditable;
                }
            }
            group("Bank Details")
            {
                Caption = 'Bank Details';
                field("Bank Code(Old)"; Rec."Bank Code(Old)")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field("Bank Code(New)"; Rec."Bank Code(New)")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field("Bank Account No(Old)"; Rec."Bank Account No(Old)")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Bank Account No(New)"; Rec."Bank Account No(New)")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Name (New)"; Rec."Bank Name (New)")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Branch Name(New)"; Rec."Bank Branch Name(New)")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Account Info")
            {
                Caption = 'Account Details';
                Visible = Accountvisible;
                field(Name; rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Name(New Value)"; Rec."Name(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name(New Value)';
                    Editable = NameEditable;
                }
                field(Picture; rec.Picture)
                {
                    ApplicationArea = Basic;
                    Editable = PictureEditable;
                }
                field(signinature; rec.signinature)
                {
                    ApplicationArea = Basic;
                    Editable = SignatureEditable;
                }
                field(Address; rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Address(New Value)"; Rec."Address(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Address(New Value)';
                    Editable = AddressEditable;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Post Code (New)"; Rec."Post Code (New)")
                {
                    ApplicationArea = Basic;
                }
                field(City; rec.City)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("City(New Value)"; Rec."City(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'City(New Value)';
                    Editable = CityEditable;
                }
                field("Phone No.(New)"; Rec."Phone No.(New)")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email(New Value)"; Rec."Email(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Email(New Value)';
                    Editable = true;
                }
                field("Personal No"; Rec."Personal No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Personal No(New Value)"; Rec."Personal No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Personal No(New Value)';
                    Editable = PersonalNoEditable;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No(New Value)"; Rec."ID No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No(New Value)';
                    Editable = IDNoEditable;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field(Age; rec.Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Gender; rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field("Marital Status(New Value)"; Rec."Marital Status(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status(New Value)';
                    Editable = MaritalStatusEditable;
                    ToolTip = 'Please enter your marital status';
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Passport No.(New Value)"; Rec."Passport No.(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.(New Value)';
                    Editable = PassPortNoEditbale;
                }

                field("Data Protection"; Rec."Data Protection")
                {
                    ApplicationArea = Basic;
                    Editable = DataProtectionEditable;
                }
                FIELD("Data Protection(New)"; Rec."Data Protection(New)")
                {
                    ApplicationArea = Basic;
                    Editable = DataProtectionEditable;

                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type(New Value)"; Rec."Account Type(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Type(New Value)';
                    Editable = AccountTypeEditible;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Category(New Value)"; Rec."Account Category(New Value)")
                {
                    ApplicationArea = Basic;
                }
                field("Card No"; Rec."Card No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Card No(New Value)"; Rec."Card No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Card No(New Value)';
                    Editable = CardNoEditable;
                }
                field("Home Address"; Rec."Home Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Address(New Value)"; Rec."Home Address(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Address(New Value)';
                    Editable = HomeAddressEditable;
                }
                field(Loaction; rec.Loaction)
                {
                    ApplicationArea = Basic;
                    Caption = '<Locaction>';
                    Editable = false;
                }
                field("Loaction(New Value)"; Rec."Loaction(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Location(New Value)';
                    Editable = LocationEditable;
                }
                field("Sub-Location"; Rec."Sub-Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub-Location(New Value)"; Rec."Sub-Location(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sub-Location(New Value)';
                    Editable = SubLocationEditable;
                }
                field(District; rec.District)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("District(New Value)"; Rec."District(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'District(New Value)';
                    Editable = DistrictEditable;
                }
                field("Status."; Rec."Status.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Status.(New)"; Rec."Status.(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Occupation; rec.Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Occupation(New)"; Rec."Occupation(New)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Occupation(New Value)';
                }
                field("KRA Pin(Old)"; Rec."KRA Pin(Old)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("KRA Pin(New)"; Rec."KRA Pin(New)")
                {
                    ApplicationArea = Basic;
                }
                field(Disabled; rec.Disabled)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Blocked; rec.Blocked)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Blocked (New)"; Rec."Blocked (New)")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code(New)"; Rec."Employer Code(New)")
                {
                    ApplicationArea = Basic;
                }
                field("Deduct From Deposit"; Rec."Deduct From Deposit")
                {

                }
                field("Charge Reactivation Fee"; Rec."Charge Reactivation Fee")
                {
                    ApplicationArea = Basic;
                    Editable = ReactivationFeeEditable;
                }
                field("Signing Instructions"; Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    ApplicationArea = Basic;
                    Editable = RetirementDateEditable;
                }
                field("Retirement Date(New)"; Rec."Retirement Date(New)")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Contributions"; Rec."Monthly Contributions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Contributions(NewValu)"; Rec."Monthly Contributions(NewValu)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Monthly Contributions(New Value)';
                    Editable = MonthlyContributionEditable;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mobile No(New Value)"; Rec."Mobile No(New Value)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No(New Value)';
                    Editable = MobileNoEditable;
                }

                field("Group Account No"; Rec."Group Account No")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Change Group Details"; Rec."Change Group Details") { Caption = 'Change/Delink Group'; }
                field("Group Account No -New"; Rec."Group Account No -New")
                {
                    ApplicationArea = Basic;
                    Caption = 'Group No New';

                }
                field("Group Account Name"; Rec."Group Account Name")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Phone No.(Old)"; Rec."Phone No.(Old)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000082; "Member Picture-Change Req")
            {
                Caption = 'Picture';
                Visible = false;
            }
            part(Control1000000083; "Member Signature-Change Req")
            {
                Caption = 'Signature';
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Changes")
            {
                ApplicationArea = Basic;
                Caption = 'Update Changes';
                Image = UserInterface;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if (rec."Approval Status" <> rec."Approval Status"::Approved) then begin
                        Error('Change Request Must be Approved First');
                    end;
                    if ((rec.Type = rec.Type::"Mobile Change") or (rec.Type = rec.Type::"ATM Change") or (rec.Type = rec.Type::"Agile Change")) then begin

                        vend.Reset;
                        vend.SetRange(vend."No.", rec."Account No");
                        if vend.Find('-') then begin
                            if rec."Name(New Value)" <> '' then
                                vend.Name := rec."Name(New Value)";
                            vend."Global Dimension 2 Code" := rec.Branch;
                            if rec."Address(New Value)" <> '' then
                                vend.Address := rec."Address(New Value)";

                            if rec."Email(New Value)" <> '' then
                                vend."E-Mail" := rec."Email(New Value)";
                            vend."E-Mail (Personal)" := rec."Email(New Value)";
                            vend.Status := rec."Status (New Value)";
                            if rec."Mobile No(New Value)" <> '' then
                                vend."Mobile Phone No" := rec."Mobile No(New Value)";
                            vend."Mobile Phone No" := Memb."Mobile Phone No";
                            vend."Phone No." := rec."Mobile No(New Value)";
                            if rec."S-Mobile No(New Value)" <> '' then
                                vend."S-Mobile No" := rec."S-Mobile No(New Value)";
                            if rec."ATM Collector Name" <> '' then
                                vend."ATM Collector Name" := rec."ATM Collector Name";
                            if rec."ID No(New Value)" <> '' then
                                vend."ID No." := rec."ID No(New Value)";
                            if rec."Personal No(New Value)" <> '' then
                                vend."Personal No." := rec."Personal No(New Value)";
                            if rec."City(New Value)" <> '' then
                                vend.City := rec."City(New Value)";
                            if rec."Section(New Value)" <> '' then
                                vend.Section := rec."Section(New Value)";
                            if rec."Card Expiry Date" <> 0D then
                                vend."Card Expiry Date" := rec."Card Expiry Date";
                            if rec."Card No(New Value)" <> '' then
                                vend."Card No." := rec."Card No(New Value)";
                            if rec."Card No(New Value)" <> '' then
                                vend."ATM No." := rec."Card No(New Value)";
                            if rec."Card Valid From" <> 0D then
                                vend."Card Valid From" := rec."Card Valid From";
                            if rec."Card Valid To" <> 0D then
                                vend."Card Valid To" := rec."Card Valid To";
                            if rec."Marital Status(New Value)" <> rec."marital status(new value)"::" " then
                                vend."Marital Status" := rec."Marital Status(New Value)";
                            if rec."Responsibility Centers" <> '' then
                                vend."Responsibility Center" := rec."Responsibility Centers";
                            if rec."Phone No.(New)" <> '' then
                                vend."Phone No." := rec."Phone No.(New)";
                            vend."Phone No." := rec."Mobile No(New Value)";
                            vend.Blocked := rec."Blocked (New)";
                            vend.Status := rec."Status.(New)";
                            vend.Modify;

                        end;
                    end;


                    if rec.Type = rec.Type::"Backoffice Change" then begin
                        Memb.Reset;
                        Memb.SetRange(Memb."No.", rec."Account No");
                        if Memb.Find('-') then begin
                            if rec."Name(New Value)" <> '' then
                                Memb.Name := rec."Name(New Value)";
                            Memb."Global Dimension 2 Code" := rec.Branch;
                            if rec."Address(New Value)" <> '' then
                                Memb.Address := rec."Address(New Value)";
                            if rec."Post Code (New)" <> '' then
                                Memb."Post Code" := rec."Post Code (New)";
                            if rec."Email(New Value)" <> '' then begin
                                Memb."E-Mail" := rec."Email(New Value)";
                                Memb."E-Mail (Personal)" := rec."Email(New Value)";
                            end;

                            if rec."Mobile No(New Value)" <> '' then begin
                                Memb."Mobile Phone No" := rec."Mobile No(New Value)";
                                memb."Mobile Phone No." := rec."Mobile No(New Value)";
                            end;


                            if rec."Phone No.(New)" <> '' then begin
                                Memb."Mobile Phone No" := rec."Phone No.(New)";
                                memb."Mobile Phone No." := Rec."Phone No.(New)";
                                Memb."Phone No." := rec."Phone No.(New)";
                            end;

                            if rec."ID No(New Value)" <> '' then
                                Memb."ID No." := rec."ID No(New Value)";
                            if rec."Personal No(New Value)" <> '' then begin
                                Memb."Payroll No" := rec."Personal No(New Value)";
                                Memb.Validate("Payroll No");
                                loans.Reset;
                                loans.SetRange(loans."Client Code", rec."Account No");
                                if loans.Find('-') then begin
                                    repeat
                                        loans."Staff No" := rec."Personal No(New Value)";
                                        loans.Modify;
                                    until loans.Next = 0;
                                end;
                            end;
                            if rec."City(New Value)" <> '' then begin
                                Memb.City := rec."City(New Value)";
                                Memb.Status := rec."Status(New Value)";
                            end;
                            if rec."Section(New Value)" <> '' then begin
                                Memb.Section := rec."Section(New Value)";
                                Memb.Blocked := rec."Blocked (New)";
                            end;
                            if rec."Marital Status(New Value)" <> rec."marital status(new value)"::" " then
                                Memb."Marital Status" := rec."Marital Status(New Value)";
                            if rec."Responsibility Centers" <> '' then begin
                                Memb."Responsibility Center" := rec."Responsibility Centers";
                            end;

                            //if rec."Change Group Details" then begin

                            //end;

                            if rec."Occupation(New)" <> '' then begin
                                Memb.Occupation := rec."Occupation(New)";
                            end;


                            //Update Bank
                            if rec."Bank Code(New)" <> '' then begin
                                Memb."Bank Code" := rec."Bank Code(New)";
                            end;

                            if rec."Bank Name (New)" <> '' then begin

                            end;
                            // Memb."Benevolent Fund Historical":="Bank Name (New)";
                            if rec."Bank Account No(New)" <> '' then begin
                                Memb."Bank Account No." := rec."Bank Account No(New)";
                            end;

                            //Bank Branch
                            if rec."Bank Branch Code(New)" <> '' then begin
                                Memb."Bank Branch Code" := rec."Bank Branch Code(New)";
                            end;

                            if rec."Bank Branch Name(New)" <> '' then begin

                            end;
                            //Memb."Block Mobile Loan":="Bank Branch Name(New)";

                            if rec."KRA Pin(New)" <> '' then begin
                                Memb.Pin := rec."KRA Pin(New)";
                                Memb.Modify(true);
                                Message('%1', Memb.Pin);
                            end;

                            IF Rec."Data Protection(New)" <> Rec."Data Protection(New)" = false then begin
                                memb."Data Protection" := rec."Data Protection(New)";
                            end;


                            Memb."Last Date Modified" := rec."Capture Date";

                            if rec."Group Account Name" <> '' then begin
                                Memb."Group Account Name" := rec."Group Account Name";
                            end;

                            if rec."Employer Code(New)" <> '' then begin
                                Memb."Employer Code" := rec."Employer Code(New)";
                            end;

                            //Memb.Piccture := Picture;
                            Memb."Date of Birth" := rec."Date Of Birth";
                            //Memb."Total BOSA Loan Balance":=Age;
                            Memb.Gender := rec.Gender;

                            Memb.Status := rec."Status.(New)";
                            if Rec."Change Group Details" then begin
                                Memb."Group No" := Rec."Group Account No -New";
                            end;

                            Memb."Account Category" := rec."Account Category(New Value)";
                            if Rec."Charge Reactivation Fee" = true then begin
                                Memb."Rejoining Date" := Today;
                                Memb.rejoined := true;
                                Memb.Blocked := Memb.Blocked::" ";
                                Memb.Status := Memb.Status::Active;
                            end;
                            Memb.Modify;

                            if rec."Charge Reactivation Fee" = true then begin
                                if Confirm('The System Is going to Charge Reactivation Fee', false) = true then begin
                                    GenSetUp.Get();
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                    if GenJournalLine.FindSet then begin
                                        GenJournalLine.DeleteAll;
                                    end;

                                    if Rec."Deduct From Deposit" = true then begin

                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Reset;
                                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                        GenJournalLine.DeleteAll;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Account No." := rec."Account No";
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Rejoining Fee";
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine."Document No." := rec.No;
                                        GenJournalLine.Amount := GenSetUp."Rejoining Fee";
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := GenSetUp."Rejoining Fees Account";
                                        GenJournalLine.Description := 'Account Reactivation Fee' + ' ' + rec.No;

                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Account No." := rec."Account No";
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine."Document No." := rec.No;
                                        GenJournalLine.Description := 'Account Reactivation Fee' + ' ' + rec.No;
                                        GenJournalLine.Amount := GenSetUp."Rejoining Fee";
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Account No." := rec."Account No";
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Rejoining Fee";
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine."Document No." := rec.No;
                                        GenJournalLine.Description := 'Account Reactivation Fee' + ' ' + rec.No;
                                        GenJournalLine.Amount := GenSetUp."Rejoining Fee" * -1;
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                    end else begin
                                        LineNo := LineNo + 10000;
                                        GenJournalLine.Reset;
                                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                        GenJournalLine.DeleteAll;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Account No." := rec."Account No";
                                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Rejoining Fee";
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine."Document No." := rec.No;
                                        GenJournalLine.Description := 'Account Reactivation Fee' + ' ' + rec.No;
                                        GenJournalLine.Amount := GenSetUp."Rejoining Fee";
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := GenSetUp."Rejoining Fees Account";
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    end;
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                    if GenJournalLine.FindSet then begin
                                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                    end;
                                    Message('Reactivation Fee Charged Successfuly');
                                end;
                            end;



                        end;

                    end;

                    rec.Changed := true;
                    rec.Modify;
                    Message('Changes have been updated Successfully');

                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                    //ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    Workflowintegration: Codeunit WorkflowIntegration;
                begin

                    if rec."Approval Status" <> rec."Approval Status"::Open then
                        Error(text001);
                    rec.TestField("Reason for change");
                    if Workflowintegration.CheckChangeRequestApprovalsWorkflowEnabled(Rec) then
                        Workflowintegration.OnSendChangeRequestForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel A&pproval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()
                var
                    text001: label 'This batch is already pending approval';
                // ApprovalMgt: Codeunit "Approvals Mgmt.";
                begin
                    rec."Approval Status" := rec."Approval Status"::Open;// THEN
                                                                         //ERROR(text001);
                end;
            }
            action(Approvals)
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
                    DocumentType := Documenttype::ChangeRequest;
                    ApprovalEntries.SetRecordFilters(Database::"Change Request", DocumentType, Rec.No);
                    ApprovalEntries.Run;
                end;
            }
            separator(Action1000000047)
            {
            }
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
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
            action(Populate)
            {
                ApplicationArea = Basic;
                Caption = 'Populate';
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                begin

                end;
            }
            separator(Action1000000055)
            {
            }
            action("Next of Kin")
            {
                ApplicationArea = Basic;
                Caption = 'Next of Kin';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Next of Kin-Change";
                RunPageLink = "Account No" = field("Account No");
                Visible = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        AccountVisible := false;
        MobileVisible := false;
        nxkinvisible := false;

        if rec.Type = rec.Type::"Mobile Change" then begin
            MobileVisible := true;
        end;

        if rec.Type = rec.Type::"ATM Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;

        if rec.Type = rec.Type::"Backoffice Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;
        if rec.Type = rec.Type::"Agile Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;


        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        AccountVisible := false;
        MobileVisible := false;
        nxkinvisible := false;

        if rec.Type = rec.Type::"Mobile Change" then begin
            MobileVisible := true;
        end;

        if rec.Type = rec.Type::"ATM Change" then begin
            AccountVisible := true;
            nxkinvisible := false;
        end;

        if rec.Type = rec.Type::"Backoffice Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;
        if rec.Type = rec.Type::"Agile Change" then begin
            AccountVisible := true;
            nxkinvisible := true;
        end;


        UpdateControl();
    end;

    var
        vend: Record Vendor;
        Memb: Record Customer;
        MobileVisible: Boolean;
        AtmVisible: Boolean;
        AccountVisible: Boolean;
        ProductNxK: Record "FOSA Account NOK Details";
        MembNxK: Record "Members Next of Kin";
        cloudRequest: Record "Change Request";
        nxkinvisible: Boolean;
        Kinchangedetails: Record "Members Next of Kin";
        DocumentType: Enum "Approval Document Type";
        //DocumentType: Option " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Withdrawal","Membership Reg","Loan Batches","Payment Voucher","Petty Cash",Loan,Interbank,Checkoff,"Savings Product Opening","Standing Order",ChangeRequest;
        MemberNxK: Record "Members Next of Kin";
        GenSetUp: Record "Sacco General Set-Up";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        NameEditable: Boolean;
        PictureEditable: Boolean;
        SignatureEditable: Boolean;
        AddressEditable: Boolean;
        CityEditable: Boolean;
        EmailEditable: Boolean;
        PersonalNoEditable: Boolean;
        IDNoEditable: Boolean;
        MaritalStatusEditable: Boolean;
        PassPortNoEditbale: Boolean;
        DataProtectionEditable: Boolean;
        AccountTypeEditible: Boolean;
        SectionEditable: Boolean;
        CardNoEditable: Boolean;
        HomeAddressEditable: Boolean;
        LocationEditable: Boolean;
        SubLocationEditable: Boolean;
        DistrictEditable: Boolean;
        MemberStatusEditable: Boolean;
        ReasonForChangeEditable: Boolean;
        SigningInstructionEditable: Boolean;
        MonthlyContributionEditable: Boolean;
        MemberCellEditable: Boolean;
        ATMApproveEditable: Boolean;
        CardExpiryDateEditable: Boolean;
        CardValidFromEditable: Boolean;
        CardValidToEditable: Boolean;
        ATMNOEditable: Boolean;
        ATMIssuedEditable: Boolean;
        ATMSelfPickedEditable: Boolean;
        ATMCollectorNameEditable: Boolean;
        ATMCollectorIDEditable: Boolean;
        ATMCollectorMobileEditable: Boolean;
        ResponsibilityCentreEditable: Boolean;
        MobileNoEditable: Boolean;
        SMobileNoEditable: Boolean;
        TypeEditable: Boolean;
        AccountNoEditable: Boolean;
        AccountCategoryEditable: Boolean;
        ReactivationFeeEditable: Boolean;
        loans: Record "Loans Register";
        RetirementDateEditable: Boolean;

    local procedure UpdateControl()
    begin
        if rec."Approval Status" = rec."Approval Status"::Open then begin
            NameEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            AddressEditable := true;
            CityEditable := true;
            EmailEditable := true;
            PersonalNoEditable := true;
            IDNoEditable := true;
            MaritalStatusEditable := true;
            PassPortNoEditbale := true;
            AccountTypeEditible := true;
            EmailEditable := true;
            SectionEditable := true;
            CardNoEditable := true;
            HomeAddressEditable := true;
            LocationEditable := true;
            SubLocationEditable := true;
            DistrictEditable := true;
            MemberStatusEditable := true;
            ReasonForChangeEditable := true;
            SigningInstructionEditable := true;
            MonthlyContributionEditable := true;
            MemberCellEditable := true;
            ATMApproveEditable := true;
            CardExpiryDateEditable := true;
            CardValidFromEditable := true;
            CardValidToEditable := true;
            ATMNOEditable := true;
            ATMIssuedEditable := true;
            ATMSelfPickedEditable := true;
            ATMCollectorNameEditable := true;
            ATMCollectorIDEditable := true;
            ATMCollectorMobileEditable := true;
            ResponsibilityCentreEditable := true;
            MobileNoEditable := true;
            SMobileNoEditable := true;
            AccountNoEditable := true;
            ReactivationFeeEditable := true;
            TypeEditable := true;
            AccountCategoryEditable := true;
            DataProtectionEditable := true;
        end else
            if rec."Approval Status" = rec."Approval Status"::Pending then begin
                NameEditable := false;
                PictureEditable := false;
                SignatureEditable := false;
                AddressEditable := false;
                CityEditable := false;
                EmailEditable := false;
                PersonalNoEditable := false;
                IDNoEditable := false;
                MaritalStatusEditable := false;
                PassPortNoEditbale := false;
                AccountTypeEditible := false;
                EmailEditable := false;
                SectionEditable := false;
                CardNoEditable := false;
                HomeAddressEditable := false;
                LocationEditable := false;
                SubLocationEditable := false;
                DistrictEditable := false;
                MemberStatusEditable := false;
                ReasonForChangeEditable := false;
                SigningInstructionEditable := false;
                MonthlyContributionEditable := false;
                MemberCellEditable := false;
                ATMApproveEditable := false;
                CardExpiryDateEditable := false;
                CardValidFromEditable := false;
                CardValidToEditable := false;
                ATMNOEditable := false;
                ATMIssuedEditable := false;
                ATMSelfPickedEditable := false;
                ATMCollectorNameEditable := false;
                ATMCollectorIDEditable := false;
                ATMCollectorMobileEditable := false;
                ResponsibilityCentreEditable := false;
                MobileNoEditable := false;
                SMobileNoEditable := false;
                AccountNoEditable := false;
                TypeEditable := false;
                ReactivationFeeEditable := false;
                AccountCategoryEditable := false;
                DataProtectionEditable := false;
            end else
                if rec."Approval Status" = rec."Approval Status"::Approved then begin
                    NameEditable := false;
                    PictureEditable := false;
                    SignatureEditable := false;
                    AddressEditable := false;
                    CityEditable := false;
                    EmailEditable := false;
                    PersonalNoEditable := false;
                    IDNoEditable := false;
                    MaritalStatusEditable := false;
                    PassPortNoEditbale := false;
                    AccountTypeEditible := false;
                    EmailEditable := false;
                    SectionEditable := false;
                    CardNoEditable := false;
                    HomeAddressEditable := false;
                    LocationEditable := false;
                    SubLocationEditable := false;
                    DistrictEditable := false;
                    MemberStatusEditable := false;
                    ReasonForChangeEditable := false;
                    SigningInstructionEditable := false;
                    MonthlyContributionEditable := false;
                    MemberCellEditable := false;
                    ATMApproveEditable := false;
                    CardExpiryDateEditable := false;
                    CardValidFromEditable := false;
                    CardValidToEditable := false;
                    ATMNOEditable := false;
                    ATMIssuedEditable := false;
                    ATMSelfPickedEditable := false;
                    ATMCollectorNameEditable := false;
                    ATMCollectorIDEditable := false;
                    ATMCollectorMobileEditable := false;
                    ResponsibilityCentreEditable := false;
                    MobileNoEditable := false;
                    SMobileNoEditable := false;
                    AccountNoEditable := false;
                    ReactivationFeeEditable := false;
                    TypeEditable := false;
                    AccountCategoryEditable := false;
                    DataProtectionEditable := false;
                end;
    end;
}




