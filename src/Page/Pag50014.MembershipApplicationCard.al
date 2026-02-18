//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50014 "Membership Application Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
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
                field("Assigned No."; Rec."Assigned No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Category';
                    ShowMandatory = true;

                    Editable = AccountCategoryEditable;
                    OptionCaption = 'Individual,Joint';

                    trigger OnValidate()
                    begin
                        Joint2DetailsVisible := false;
                        Joint3DetailsVisible := false;

                        if Rec."Account Category" = Rec."account category"::Corporate then begin
                            Joint2DetailsVisible := true;
                            Joint3DetailsVisible := true;
                        end;
                        if Rec."Account Category" = Rec."account category"::Individual then begin
                            Joint2DetailsVisible := false;
                            Joint3DetailsVisible := false;
                        end;
                    end;
                }
                field(Picture; Picture)
                {
                    trigger OnAssistEdit()
                    begin
                        Page.Run(17370);
                    end;
                }
                // field("Member Category"; Rec."Member Category")
                // {
                //     ApplicationArea = all;
                //     Enabled = NameEditable;
                //    // Caption = 'Member Type';
                // }
                // field("Sub Category"; Rec."Sub Category") { ApplicationArea = all; Enabled = NameEditable; }
                // field("Group No"; Rec."Group No")
                // {
                //     ApplicationArea = all;
                //     Enabled = NameEditable;
                //  //   Caption = 'Cluster Type';
                // }
                // group("Joint Details")
                // {
                //     Visible = Joint2DetailsVisible;
                //     field("Joint Account Name"; Rec."Joint Account Name")
                //     {
                //         ApplicationArea = Basic;
                //         Enabled = FirstNameEditable;
                //         Visible = Joint2DetailsVisible;
                //     }
                //     field("Signing Instructions"; Rec."Signing Instructions")
                //     {
                //         ApplicationArea = Basic;
                //         Enabled = FirstNameEditable;
                //         Visible = Joint2DetailsVisible;
                //     }
                // }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = FirstNameEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name";
                    end;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = MiddleNameEditable;

                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name" + ' ' + Rec."Middle Name";
                    end;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Editable = LastNameEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec.Name := Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Identification Document"; Rec."Identification Document")
                {
                    ApplicationArea = Basic;
                    Editable = IdentificationDocTypeEditable;

                    trigger OnValidate()
                    begin
                        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
                            PassportEditable := false;
                            IDNoEditable := true
                        end else
                            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                                PassportEditable := true;
                                IDNoEditable := false
                            end else
                                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                                    PassportEditable := true;
                                    IDNoEditable := true;
                                end;
                    end;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = IDNoEditable;
                    ShowMandatory = Rec."Identification Document" = Rec."Identification Document"::"Nation ID Card";
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = IDNoEditable;
                    ShowMandatory = Rec."Identification Document" = Rec."Identification Document"::"Passport Card";
                }
                field("PassPort Exipiry Date"; Rec."PassPort Exipiry Date")
                {
                    ApplicationArea = Basic;
                    Editable = PassportEditable;
                }

                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                    Enabled = NameEditable;
                }



                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = Basic;
                    Editable = KRAPinEditable;
                    ShowMandatory = true;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = DOBEditable;
                    ShowMandatory = true;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Editable = GenderEditable;
                    ShowMandatory = true;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = MaritalstatusEditable;
                    ShowMandatory = true;
                }
                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = MobileEditable;
                    ShowMandatory = true;
                }
                field("Secondary Mobile No"; Rec."Secondary Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = SecondaryMobileEditable;
                    ShowMandatory = true;
                }
                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Editable = EmailEdiatble;

                }
                field("E-mail Indemnified"; Rec."E-mail Indemnified")
                {
                    ApplicationArea = Basic;
                    Editable = EmailIndemnifiedEditable;
                    Visible = false;
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Postal Address';
                    ApplicationArea = Basic;
                    Editable = AddressEditable;
                    //ShowMandatory = true;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = PostCodeEditable;
                    //ShowMandatory = true;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Country';
                    Editable = CountryEditable;
                    LookupPageId = CountriesLookup;

                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                    ShowMandatory = true;
                }
                field(CountyName; Rec."County Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                    Visible = false;
                    ShowMandatory = true;
                }
                field(District; Rec.District)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                    Caption = 'Sub County';
                    ShowMandatory = true;
                }
                field("Sub-County Name"; Rec."Sub-County Name")
                {
                    Enabled = false;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                    Caption = 'Ward';
                }
                field("How did you Know About Us"; Rec."How did you Know About Us")
                {
                    ApplicationArea = basic;
                    Enabled = NameEditable;
                }
                field("Member's Residence"; Rec."Member's Residence")
                {
                    ApplicationArea = Basic;
                    visible = false;
                    Editable = MemberResidenceEditable;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Physical Address/Home Address';
                    Editable = PhysicalAddressEditable;
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;

                    Visible = true;
                    Enabled = NameEditable;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;

                    ShowMandatory = true;
                    Editable = EditBranch;
                }
                field("Monthly Contribution"; Rec."Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyContributionEdit;
                    ShowMandatory = true;
                }
                field("Programmed Deposits"; Rec."Programmed Deposits")
                {
                    ApplicationArea = Basic;
                    Caption = 'Programmed Deposit Contribution';
                }


                field("Paid Registration Fee"; Rec."Paid Registration Fee")

                {
                    ShowMandatory = true;
                }
                field("Deduct Registration Fee"; Rec."Deduct Registration Fee") { }

                field("Data Protection"; Rec."Data Protection")
                {

                }
                field("Minimum Share Capital"; Rec."Minimum Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyContributionEdit;
                    ShowMandatory = true;
                    Caption = 'Share Capital Monthly Contribution';
                }
                field("Max Share Capital"; Rec."Max Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyContributionEdit;
                    ShowMandatory = true;
                }
                field("Application Category"; Rec."Application Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Final Approver"; Rec."Final Approver")
                {
                    ApplicationArea = Basic;
                    Caption = 'Approved By';
                }
            }

            group("Bank Details")
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;
                }
                field("Bank Branch Code"; Rec."Bank Branch Code")
                {
                    ApplicationArea = Basic;

                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;
                }
            }
            group("Occupation Details")
            {
                Caption = 'Occupation Details';
                field("Employment Info"; Rec."Employment Info")
                {
                    ApplicationArea = Basic;
                    Editable = EmploymentInfoEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        EmployedVisible := false;
                        SelfEmployedVisible := false;
                        OtherVisible := false;

                        if (Rec."Employment Info" = Rec."employment info"::Employed) or (Rec."Employment Info" = Rec."employment info"::"Employed & Self Employed") then begin
                            EmployedVisible := true;
                        end;

                        if (Rec."Employment Info" = Rec."employment info"::"Self-Employed") or (Rec."Employment Info" = Rec."employment info"::"Employed & Self Employed") then begin
                            SelfEmployedVisible := true;
                        end;

                        if (Rec."Employment Info" = Rec."employment info"::Others) or (Rec."Employment Info" = Rec."employment info"::Contracting) then begin
                            OtherVisible := true;
                        end;

                        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
                            PassportEditable := false;
                            IDNoEditable := true
                        end else
                            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                                PassportEditable := true;
                                IDNoEditable := false
                            end else
                                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                                    PassportEditable := true;
                                    IDNoEditable := true;
                                end;
                    end;
                }
                group(Employed)
                {
                    Caption = 'Employment Details';
                    Visible = EmployedVisible;
                    field("Employment Status"; Rec."Employment Status")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Employer Code"; Rec."Employer Code")
                    {
                        ApplicationArea = Basic;
                        Editable = EmployerCodeEditable;
                        ShowMandatory = true;
                    }
                    field("Employer Name"; Rec."Employer Name")
                    {
                        ApplicationArea = Basic;
                        Editable = EmployedEditable;
                    }
                    field("Employer Address"; Rec."Employer Address")
                    {
                        ApplicationArea = Basic;
                        Editable = EmployerAddressEditable;
                    }
                    field("Member Payment Type"; Rec."Member Payment Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Terms of Employment"; Rec."Terms of Employment")
                    {
                        ApplicationArea = Basic;
                        Editable = TermsofEmploymentEditable;
                        ShowMandatory = true;
                    }
                    field("Date of Employment"; Rec."Date of Employment")
                    {
                        ApplicationArea = Basic;
                        Editable = EmploymentDateEditable;
                    }
                    field("Position Held"; Rec."Position Held")
                    {
                        ApplicationArea = Basic;
                        Editable = PositionHeldEditable;
                    }
                }

                group(SelfEmployed)
                {
                    Caption = 'Self_Employment Details';
                    Visible = SelfEmployedVisible;
                    field("Nature Of Business"; Rec."Nature Of Business")
                    {
                        ApplicationArea = Basic;
                        Editable = NatureofBussEditable;
                    }
                    field(Industry; Rec.Industry)
                    {
                        ApplicationArea = Basic;
                        Editable = IndustryEditable;
                    }
                    field("Business Name"; Rec."Business Name")
                    {
                        ApplicationArea = Basic;
                        Editable = BusinessNameEditable;
                    }
                    field("Physical Business Location"; Rec."Physical Business Location")
                    {
                        ApplicationArea = Basic;
                        Editable = PhysicalBussLocationEditable;
                    }

                    field("Expected Monthly Income Amount"; Rec."Expected Monthly Income Amount")
                    {
                        ApplicationArea = basic;
                        Caption = 'Approximate Monthly Income';
                    }
                    field("Year of Commence"; Rec."Year of Commence")
                    {
                        ApplicationArea = Basic;
                        Editable = YearOfCommenceEditable;
                    }
                }
                group(Other)
                {
                    Caption = 'Details';
                    Visible = OtherVisible;
                    field("Others Details"; Rec."Others Details")
                    {
                        ApplicationArea = Basic;
                        //Caption = 'Occupation Details';
                        //Editable = OthersEditable;
                    }
                }
            }
            group("Referee Details")
            {
                Caption = 'Introducer Details';
                field("Referee Member No"; Rec."Referee Member No")
                {
                    ApplicationArea = Basic;
                    Editable = NameEditable;
                    Caption = 'Member No';
                    //Editable = RefereeEditable;
                }
                field("Referee Name"; Rec."Referee Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                }
                field("Referee ID No"; Rec."Referee ID No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member IDNo';
                }
                field("Referee Mobile Phone No"; Rec."Referee Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile Phone No.';
                }
                field("Introducer Relationship"; Rec."Introducer Relationship")
                {
                    ApplicationArea = Basic;
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
                    //Visible = false;
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
                        //   Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                    field("Due Diligence Measure"; Rec."Due Diligence Measure")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        //   Image = Person;
                        StyleExpr = CoveragePercentStyle;
                    }
                }
                part(Control27; "Member Due Diligence Measure")
                {
                    Visible = false;
                    Caption = 'Due Diligence Measure';
                    SubPageLink = "Member No" = field("No.");
                    SubPageView = sorting("Due Diligence No");
                }
            }
            group(Joint2Details)
            {
                Caption = 'Joint2Details';
                Visible = Joint2DetailsVisible;
                field("First Name2"; Rec."First Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 2" := Rec."First Name2";
                    end;
                }
                field("Middle Name2"; Rec."Middle Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';

                    trigger OnValidate()
                    begin
                        Rec."Name 2" := Rec."First Name2" + ' ' + Rec."Middle Name2";
                    end;
                }
                field("Last Name2"; Rec."Last Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 2" := Rec."First Name2" + ' ' + Rec."Middle Name2" + ' ' + Rec."Last Name2";
                    end;
                }
                field("Name 2"; Rec."Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address3; Rec.Address3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                }
                field("Postal Code 2"; Rec."Postal Code 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 2"; Rec."Town 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Mobile No. 3"; Rec."Mobile No. 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth2"; Rec."Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                }
                field("ID No.2"; Rec."ID No.2")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 2"; Rec."Passport 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                }
                field(Gender2; Rec.Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    ShowMandatory = true;
                }
                field("Marital Status2"; Rec."Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                }
                field("Home Postal Code2"; Rec."Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                }
                field("Home Town2"; Rec."Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                }
                field("Employer Code2"; Rec."Employer Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                }
                field("Employer Name2"; Rec."Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal2)"; Rec."E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail (Personal)';
                }
            }
            group(Joint3Details)
            {
                Visible = Joint3DetailsVisible;
                field("First Name3"; Rec."First Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 3" := Rec."First Name3";
                    end;
                }
                field("Middle Name 3"; Rec."Middle Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';

                    trigger OnValidate()
                    begin
                        Rec."Name 3" := Rec."First Name3" + ' ' + Rec."Middle Name 3";
                    end;
                }
                field("Last Name3"; Rec."Last Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Name 3" := Rec."First Name3" + ' ' + Rec."Middle Name 3" + ' ' + Rec."Last Name3";
                    end;
                }
                field("Name 3"; Rec."Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address4; Rec.Address4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                }
                field("Postal Code 3"; Rec."Postal Code 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 3"; Rec."Town 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Mobile No. 4"; Rec."Mobile No. 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth3"; Rec."Date of Birth3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    ShowMandatory = true;
                }
                field("ID No.3"; Rec."ID No.3")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 3"; Rec."Passport 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                }
                field(Gender3; Rec.Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    ShowMandatory = true;
                }
                field("Marital Status3"; Rec."Marital Status3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                }
                field("Home Postal Code3"; Rec."Home Postal Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                }
                field("Home Town3"; Rec."Home Town3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                }
                field("Employer Code3"; Rec."Employer Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                }
                field("Employer Name3"; Rec."Employer Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal3)"; Rec."E-Mail (Personal3)")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control35; "Member Picture-App")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                Editable = MobileEditable;
                SubPageLink = "No." = field("No.");
            }
            part(Control36; "Member Signature-App")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                Editable = MobileEditable;
                Enabled = MobileEditable;
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
                    RunPageLink = "Membership Applicaton No" = field("No.");//80052


                }

                action("Membership Report")
                {
                    ApplicationArea = Basic;
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        Membership: Record "Membership Applications";
                    begin
                        Membership.Reset();
                        Membership.SetRange("No.", Rec."No.");
                        if Membership.Find('-') then begin
                            Report.Run(80052, true, false, Membership);
                        end;
                    end;


                }
                action("Next of Kin Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Nominee Detail";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    Visible = false;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");

                    trigger OnAction()
                    begin
                        //===================================================================Signatory 1
                        if Rec."Account Category" = Rec."account category"::Joint then begin
                            ObjMemberAppSignatories.Init;
                            ObjMemberAppSignatories."Account No" := Rec."No.";
                            ObjMemberAppSignatories.Names := Rec.Name;
                            ObjMemberAppSignatories."ID No." := Rec."ID No.";
                            ObjMemberAppSignatories."Date Of Birth" := Rec."Date of Birth";
                            ObjMemberAppSignatories."Email Address" := Rec."E-Mail (Personal)";
                            ObjMemberAppSignatories."Mobile No." := Rec."Mobile Phone No";
                            ObjMemberAppSignatories.Insert;
                        end;

                        //===================================================================Signatory 2
                        if Rec."Account Category" = Rec."account category"::Joint then begin
                            ObjMemberAppSignatories.Init;
                            ObjMemberAppSignatories."Account No" := Rec."No.";
                            ObjMemberAppSignatories.Names := Rec."Name 2";
                            ObjMemberAppSignatories."ID No." := Rec."ID No.2";
                            ObjMemberAppSignatories."Date Of Birth" := Rec."Date of Birth2";
                            ObjMemberAppSignatories."Email Address" := Rec."E-Mail (Personal2)";
                            ObjMemberAppSignatories."Mobile No." := Rec."Mobile No. 2";
                            ObjMemberAppSignatories.Insert;
                        end;

                        //===================================================================Signatory 3
                        if Rec."Account Category" = Rec."account category"::Joint then begin
                            ObjMemberAppSignatories.Init;
                            ObjMemberAppSignatories."Account No" := Rec."No.";
                            ObjMemberAppSignatories.Names := Rec."Name 3";
                            ObjMemberAppSignatories."ID No." := Rec."ID No.3";
                            ObjMemberAppSignatories."Date Of Birth" := Rec."Date of Birth3";
                            ObjMemberAppSignatories."Email Address" := Rec."E-Mail (Personal3)";
                            ObjMemberAppSignatories."Mobile No." := Rec."Mobile No. 3";
                            ObjMemberAppSignatories.Insert;
                        end;
                    end;
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
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Individual Member Risk Rating";
                    RunPageLink = "Membership Application No" = field("No.");

                    trigger OnAction()
                    begin
                        SFactory.FnGetMemberApplicationAMLRiskRating(Rec."No.");
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
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if Rec.Status = Rec.Status::Open then
                            Rec.TestField(Picture);
                        Rec.TestField(Signature);

                        FnCheckfieldrestriction();
                        if WorkflowManagement.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) then
                            WorkflowManagement.OnSendMembershipApplicationForApproval(Rec);


                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    // Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Confirm('Are you sure you want to cancel this approval request', false) = true then
                            WorkflowManagement.OnCancelMembershipApplicationApprovalRequest(Rec);

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
                action("Create Account")
                {
                    ApplicationArea = all;
                    Caption = 'Create Account';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = EnableCreateMember;
                    trigger OnAction()
                    var
                        VarAccounts: Text;
                        Cust: record Customer;
                        ObjAccountType: Record "Account Types-Saving Products";
                        SaccoNoSeries: Record "Sacco No. Series";
                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Error('The Membership Application must be approved before accounts are created');
                        Rec.TestField(Rec."Monthly Contribution");

                        ObjProductsApp.Reset;
                        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                        if ObjProductsApp.FindSet = false then begin
                            Error('You must select products (account types) to be created for the member');
                        end;
                        // if Rec."ID No." <> '' then begin
                        //     Cust.Reset;
                        //     Cust.SetRange(Cust."ID No.", Rec."ID No.");
                        //     Cust.SetRange(cust."Passport No.", Rec."Passport No.");
                        //     Cust.SetRange(Cust."Passport No", Rec."Passport No.");

                        //     if Cust.FindSet then begin
                        //         Error('The ID No./Passport No. already exists in the Members Register for Member No. %1', Cust."No.");
                        //     end;
                        // end;
                        Cust.Reset;
                        if (Rec."ID No." = '') and (Rec."Passport No." = '') then
                            Error('You must provide either an ID No. or a Passport No.');

                        // Check ID No.
                        if Rec."ID No." <> '' then begin
                            Cust.SetRange("ID No.", Rec."ID No.");
                            if Cust.FindFirst() then
                                Error(
                                    'The ID No. %1 already exists in the Members Register for Member No. %2',
                                    Rec."ID No.", Cust."No."
                                );
                        end;

                        // Check Passport No.
                        Cust.Reset;
                        if Rec."Passport No." <> '' then begin
                            Cust.SetRange("Passport No.", Rec."Passport No.");
                            if Cust.FindFirst() then
                                Error(
                                    'The Passport No. %1 already exists in the Members Register for Member No. %2',
                                    Rec."Passport No.", Cust."No."
                                );
                        end;


                        ObjProductsApp.Reset;
                        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                        ObjProductsApp.SetRange(ObjProductsApp."Product Source", ObjProductsApp."Product Source"::BOSA);
                        if ObjProductsApp.FindSet = false then begin
                            Error('You must select Membership product for a new Member for Member No to be assigned');
                        end;

                        if Confirm('Are you sure you want to create the selected accounts for the New Member?') = false then
                            exit;
                        begin
                            ObjProductsApp.Reset;
                            ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                            ObjProductsApp.SetRange(ObjProductsApp."Product Source", ObjProductsApp."product source"::BOSA);
                            //ObjProductsApp.SetRange(ObjProductsApp.Product, 'MEMBERSHIP');
                            if ObjProductsApp.FindSet then begin
                                SaccoNoSeries.Get();
                                VarNewMembNo := NoSeriesMgt.GetNextNo(SaccoNoSeries."Members Nos", Today, true);
                            end;
                            //Create Member
                            //Message('the number is %1', VarNewMembNo);
                            CustomerTable."No." := Format(VarNewMembNo);
                            CustomerTable.Name := Rec.Name;
                            CustomerTable.Address := Rec.Address;
                            CustomerTable."Address 2" := Rec."Address 2";
                            CustomerTable."Post Code" := Rec."Postal Code";
                            CustomerTable.Town := Rec.Town;
                            CustomerTable.County := Rec.County;
                            CustomerTable.ISNormalMember := true;
                            CustomerTable.City := Rec.City;
                            CustomerTable."Country/Region Code" := Rec."Country/Region Code";
                            CustomerTable."Phone No." := Rec."Phone No.";
                            CustomerTable."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                            CustomerTable."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                            CustomerTable."Customer Posting Group" := Rec."Customer Posting Group";
                            CustomerTable."Registration Date" := Today;
                            CustomerTable."Mobile Phone No" := Rec."Mobile Phone No";
                            CustomerTable."Mobile Phone No." := Rec."Mobile Phone No";
                            CustomerTable.Status := CustomerTable.Status::Active;
                            CustomerTable."Date of Birth" := Rec."Date of Birth";
                            CustomerTable.Piccture := Rec.Picture;
                            CustomerTable.Signature := Rec.Signature;
                            CustomerTable."Station/Department" := Rec."Station/Department";
                            CustomerTable."E-Mail" := Rec."E-Mail (Personal)";
                            CustomerTable."E-Mail (Personal)" := Rec."E-Mail (Personal)";
                            CustomerTable.Location := Rec.Location;
                            CustomerTable.Title := Rec.Title;
                            CustomerTable."Home Address" := Rec."Home Address";
                            CustomerTable."Home Postal Code" := Rec."Home Postal Code";
                            CustomerTable."Home Town" := Rec."Home Town";
                            CustomerTable."Recruited By" := Rec."Recruited By";
                            CustomerTable."Contact Person" := Rec."Contact Person";
                            CustomerTable."ContactPerson Relation" := Rec."ContactPerson Relation";
                            CustomerTable."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                            CustomerTable."Member Share Class" := Rec."Member Share Class";
                            CustomerTable."Member's Residence" := Rec."Member's Residence";
                            CustomerTable."Member House Group" := Rec."Member House Group";
                            CustomerTable."Member House Group Name" := Rec."Member House Group Name";
                            CustomerTable."Occupation Details" := Rec."Employment Info";
                            CustomerTable."Employer Code" := Rec."Employer Code";
                            CustomerTable."Employer Name" := Rec."Employer Name";
                            CustomerTable."Employer Address" := Rec."Employer Address";
                            CustomerTable."Terms Of Employment" := Rec."Terms of Employment";
                            CustomerTable."Date of Employment" := Rec."Date of Employment";
                            CustomerTable."Position Held" := Rec."Position Held";
                            CustomerTable."Expected Monthly Income" := Rec."Expected Monthly Income";
                            CustomerTable."Expected Monthly Income Amount" := Rec."Expected Monthly Income Amount";
                            CustomerTable."Nature Of Business" := Rec."Nature Of Business";
                            CustomerTable.Industry := Rec.Industry;
                            CustomerTable."Business Name" := Rec."Business Name";
                            CustomerTable."Physical Business Location" := Rec."Physical Business Location";
                            CustomerTable."Year of Commence" := Rec."Year of Commence";
                            CustomerTable."Identification Document" := Rec."Identification Document";
                            CustomerTable."Referee Member No" := Rec."Referee Member No";
                            CustomerTable."Referee Name" := Rec."Referee Name";
                            CustomerTable."Referee ID No" := Rec."Referee ID No";
                            CustomerTable."Referee Mobile Phone No" := Rec."Referee Mobile Phone No";
                            CustomerTable."Introducer Relationship" := Rec."Introducer Relationship";
                            CustomerTable."Email Indemnified" := Rec."E-mail Indemnified";
                            CustomerTable."Created By" := UserId;
                            CustomerTable."Member Needs House Group" := Rec."Member Needs House Group";
                            CustomerTable."First Name" := Rec."First Name";
                            CustomerTable."Middle Name" := Rec."Middle Name";
                            CustomerTable."Last Name" := Rec."Last Name";
                            CustomerTable.Gender := Rec.Gender;
                            CustomerTable."How did you Know about Us" := Rec."How did you Know About Us";
                            CustomerTable.MemberCategory := Rec."Member Category";
                            CustomerTable."PassPort Exipiry Date" := Rec."PassPort Exipiry Date";
                            CustomerTable."Sub Category" := Rec."Sub Category";
                            CustomerTable."Source Of Income" := Rec."Source Of Income";
                            CustomerTable.Others := Rec.Others;
                            CustomerTable."Type of house" := Rec."Type of house";
                            CustomerTable."Access to Clean water" := Rec."Access to Clean water";
                            CustomerTable."HouseHold Size" := Rec."HouseHold Size";
                            CustomerTable."Monthly Income" := Rec."Monthly Income";
                            CustomerTable."Access To Medical Cover" := Rec."Access To Medical Cover";
                            CustomerTable."Group No" := Rec."Group No";
                            CustomerTable."Minimum Share Capital" := Rec."Minimum Share Capital";
                            CustomerTable."Max Share Capital" := Rec."Max Share Capital";
                            CustomerTable."Paid Registration Fee" := Rec."Paid Registration Fee";
                            CustomerTable." Deduct Registration Fee" := Rec."Deduct Registration Fee";
                            CustomerTable."County Name" := Rec."County Name";
                            CustomerTable."Sub-County Name" := Rec."Sub-County Name";
                            CustomerTable."Data Protection" := Rec."Data Protection";
                            CustomerTable."Programmed Deposit Contr." := Rec."Programmed Deposits";

                            //*****************************to Sort Joint
                            CustomerTable."Name 2" := Rec."Name 2";
                            CustomerTable.Address3 := Rec.Address3;
                            CustomerTable."Postal Code 2" := Rec."Postal Code 2";
                            CustomerTable."Home Postal Code2" := Rec."Home Postal Code2";
                            CustomerTable."Home Town2" := Rec."Home Town2";
                            CustomerTable."ID No.2" := Rec."ID No.2";
                            CustomerTable."Passport 2" := Rec."Passport 2";
                            CustomerTable."Passport No." := Rec."Passport No.";
                            CustomerTable."Passport No" := Rec."Passport No.";
                            CustomerTable.Gender2 := Rec.Gender2;
                            CustomerTable."Marital Status2" := Rec."Marital Status2";
                            CustomerTable."E-Mail (Personal2)" := Rec."E-Mail (Personal2)";
                            CustomerTable."Employer Code2" := Rec."Employer Code2";
                            CustomerTable."Employer Name2" := Rec."Employer Name2";
                            CustomerTable."Picture 2" := Rec."Picture 2";
                            CustomerTable."Signature  2" := Rec."Signature  2";


                            CustomerTable."Name 3" := Rec."Name 3";
                            CustomerTable."Address3-Joint" := Rec.Address4;
                            CustomerTable."Postal Code 3" := Rec."Postal Code 3";
                            CustomerTable."Home Postal Code3" := Rec."Home Postal Code3";
                            CustomerTable."Mobile No. 4" := Rec."Mobile No. 4";
                            CustomerTable."Home Town3" := Rec."Home Town3";
                            CustomerTable."ID No.3" := Rec."ID No.3";
                            CustomerTable."Passport 3" := Rec."Passport 3";
                            CustomerTable.Gender3 := Rec.Gender3;
                            CustomerTable."Marital Status3" := Rec."Marital Status3";
                            CustomerTable."E-Mail (Personal3)" := Rec."E-Mail (Personal3)";
                            CustomerTable."Employer Code3" := Rec."Employer Code3";
                            CustomerTable."Employer Name3" := Rec."Employer Name3";
                            CustomerTable."Picture 3" := Rec."Picture 3";
                            CustomerTable."Signature  3" := Rec."Signature  3";
                            CustomerTable."Account Category" := Rec."Account Category";
                            CustomerTable."Joint Account Name" := Rec."Joint Account Name";
                            if Rec."Account Category" = Rec."account category"::Joint then
                                CustomerTable.Name := Rec."Joint Account Name";
                            CustomerTable."Data Protection" := Rec."Data Protection";
                            //===================================================================================End Joint Account Details

                            //**
                            CustomerTable."Office Branch" := Rec."Office Branch";
                            CustomerTable.Department := Rec.Department;
                            CustomerTable.Occupation := Rec.Occupation;
                            CustomerTable.Designation := Rec.Designation;
                            CustomerTable."Bank Code" := Rec."Bank Code";
                            CustomerTable."Bank Branch Code" := Rec."Bank Code";
                            CustomerTable."Bank Branch Name" := UpperCase(Rec."Bank Branch Name");
                            CustomerTable."Bank Name" := Rec."Bank Name";
                            CustomerTable."Bank Account No." := Rec."Bank Account No";
                            //**
                            CustomerTable."Sub-Location" := Rec."Sub-Location";
                            CustomerTable.District := Rec.District;
                            CustomerTable."Payroll No" := Rec."Payroll No";
                            CustomerTable."ID No." := Rec."ID No.";
                            CustomerTable."Mobile Phone No" := Rec."Mobile Phone No";
                            CustomerTable."Marital Status" := Rec."Marital Status";
                            CustomerTable."Customer Type" := CustomerTable."customer type"::Member;
                            CustomerTable.Gender := Rec.Gender;

                            CustomerTable.Piccture := Rec.Picture;
                            CustomerTable.Signature := Rec.Signature;

                            CustomerTable."Monthly Contribution" := Rec."Monthly Contribution";
                            CustomerTable."Programmed Deposit Contr." := Rec."Programmed Deposits";
                            CustomerTable."Contact Person" := Rec."Contact Person";
                            CustomerTable."Contact Person Phone" := Rec."Contact Person Phone";
                            CustomerTable."ContactPerson Relation" := Rec."ContactPerson Relation";
                            CustomerTable."Recruited By" := Rec."Recruited By";
                            CustomerTable."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                            CustomerTable."Village/Residence" := Rec."Village/Residence";
                            CustomerTable.Pin := Rec."KRA PIN";
                            CustomerTable."KYC Completed" := true;

                            //========================================================================Member Risk Rating
                            CustomerTable."Individual Category" := Rec."Individual Category";
                            CustomerTable.Entities := Rec.Entities;
                            CustomerTable."Member Residency Status" := Rec."Member Residency Status";
                            CustomerTable."Industry Type" := Rec."Industry Type";
                            CustomerTable."Length Of Relationship" := Rec."Length Of Relationship";
                            CustomerTable."International Trade" := Rec."International Trade";
                            CustomerTable."Electronic Payment" := Rec."Electronic Payment";
                            CustomerTable."Accounts Type Taken" := Rec."Accounts Type Taken";
                            CustomerTable."Cards Type Taken" := Rec."Cards Type Taken";
                            CustomerTable."Fosa PostFix" := '00';


                            CustomerTable.Insert(true);
                            //========================================================================End Member Risk Rating

                            ObjNextOfKinApp.Reset;
                            ObjNextOfKinApp.SetRange(ObjNextOfKinApp."Account No", Rec."No.");
                            if ObjNextOfKinApp.Find('-') then begin
                                repeat
                                    ObjNextOfKin.Init;
                                    ObjNextOfKin."Account No" := CustomerTable."No.";
                                    ObjNextOfKin.Name := ObjNextOfKinApp.Name;
                                    ObjNextOfKin.Relationship := ObjNextOfKinApp.Relationship;
                                    ObjNextOfKin.Beneficiary := ObjNextOfKinApp.Beneficiary;
                                    ObjNextOfKin."Date of Birth" := ObjNextOfKinApp."Date of Birth";
                                    ObjNextOfKin.Address := ObjNextOfKinApp.Address;
                                    ObjNextOfKin.Telephone := ObjNextOfKinApp.Telephone;
                                    ObjNextOfKin.Email := ObjNextOfKinApp.Email;
                                    ObjNextOfKin."ID No." := ObjNextOfKinApp."ID No.";
                                    ObjNextOfKin."Member No" := ObjNextOfKinApp."Member No";
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

                                    if ObjNoSeries.Get then begin
                                        ObjNoSeries.TestField(ObjNoSeries."Agent Serial Nos");
                                        VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Agent Serial Nos", 0D, true);
                                        if VarDocumentNo <> '' then begin
                                            ObjMemberAgent.Init;
                                            ObjMemberAgent."Document No" := VarDocumentNo;
                                            ObjMemberAgent."Account No" := CustomerTable."No.";
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
                                        end;
                                    end;
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
                            VarBOSAACC := CustomerTable."No.";
                            //MemberAuotoIncre := CustomerTable."Fosa PostFix";

                        end;

                        //==================================================================================================End Membership Registration

                        //==========================================s========================================================Member Accounts Accounts
                        ObjProductsApp.Reset;
                        ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
                        ObjProductsApp.SetRange(ObjProductsApp."Product Source", ObjProductsApp."Product Source"::FOSA);
                        if ObjProductsApp.FindSet then begin
                            repeat
                                if CustomerTable.Get(VarBOSAACC) then begin
                                    MemberAuotoIncre := CustomerTable."Fosa PostFix";
                                end;
                                IF ObjProductsApp."Product Source" = ObjProductsApp."Product Source"::FOSA THEN BEGIN
                                    ObjAccountType.Reset();
                                    ObjAccountType.SETRANGE(ObjAccountType.Code, ObjProductsApp.Product);
                                    if ObjAccountType.Find('-') then begin

                                        VarAcctNo := ObjAccountType."Account No Prefix" + ObjAccountType."Product Code" + VarNewMembNo + MemberAuotoIncre;
                                    end;

                                    if Rec."Account Category" = Rec."account category"::Individual then begin
                                        ObjAccounts.Reset;
                                        ObjAccounts.SetRange(ObjAccounts."ID No.", Rec."ID No.");
                                        ObjAccounts.SetRange(ObjAccounts."Account Type", ObjProductsApp.Product);
                                        ObjAccounts.SetFilter(ObjAccounts.Status, '<>%1&<>%2', ObjAccounts.Status::Closed, ObjAccounts.Status::Deceased);
                                        if ObjAccounts.FindSet then begin
                                            Error('The Member has an existing %1', ObjAccounts."Account Type");
                                        end;
                                    end;

                                    //===================================================================Create Account
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
                                    ObjAccounts."BOSA Account No" := CustomerTable."No.";
                                    ObjAccounts."Passport No." := Rec."Passport No.";
                                    ObjAccounts."Employer Code" := Rec."Employer Code";
                                    ObjAccounts.Status := ObjAccounts.Status::Deceased;
                                    ObjAccounts."Account Type" := ObjProductsApp.Product;
                                    ObjAccounts."Date of Birth" := Rec."Date of Birth";
                                    ObjAccounts.piccture := Rec.Picture;
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
                                    ObjAccounts.Section := rec.Section;
                                    ObjAccounts."Home Address" := Rec."Home Address";
                                    ObjAccounts.District := rec.District;
                                    ObjAccounts.Location := rec.Location;
                                    ObjAccounts."Sub-Location" := Rec."Sub-Location";
                                    ObjAccounts."Registration Date" := Today;
                                    ObjAccounts."Monthly Contribution" := Rec."Monthly Contribution";
                                    ObjAccounts."E-Mail" := Rec."E-Mail (Personal)";
                                    ObjAccounts."Group/Corporate Trade" := Rec."Group/Corporate Trade";
                                    ObjAccounts."Name of the Group/Corporate" := Rec."Name of the Group/Corporate";
                                    ObjAccounts."Signing Instructions" := Rec."Signing Instructions";
                                    ObjAccounts."Certificate No" := Rec."Certificate No";
                                    ObjAccounts."Registration Date" := Rec."Registration Date";
                                    ObjAccounts."Created By" := UserId;

                                    //=============================================================Joint Account Details
                                    ObjAccounts."Name 2" := Rec."Name 2";
                                    ObjAccounts."Address3-Joint" := Rec.Address3;
                                    ObjAccounts."Postal Code 2" := Rec."Postal Code 2";
                                    ObjAccounts."Home Postal Code2" := Rec."Home Postal Code2";
                                    ObjAccounts."Home Town2" := Rec."Home Town2";
                                    ObjAccounts."ID No.2" := Rec."ID No.2";
                                    ObjAccounts."Passport 2" := Rec."Passport 2";
                                    ObjAccounts.Gender2 := Rec.Gender2;
                                    ObjAccounts."Marital Status2" := Rec."Marital Status2";
                                    ObjAccounts."E-Mail (Personal2)" := Rec."E-Mail (Personal2)";
                                    ObjAccounts."Employer Code2" := Rec."Employer Code2";
                                    ObjAccounts."Employer Name2" := Rec."Employer Name2";
                                    ObjAccounts."Picture 2" := Rec."Picture 2";
                                    ObjAccounts."Signature  2" := Rec."Signature  2";
                                    ObjAccounts."Member's Residence" := Rec."Member's Residence";
                                    ObjAccounts."Joint Account Name" := Rec."Joint Account Name";

                                    ObjAccounts."Name 3" := Rec."Name 3";
                                    ObjAccounts."Address3-Joint" := Rec.Address4;
                                    ObjAccounts."Postal Code 3" := Rec."Postal Code 3";
                                    ObjAccounts."Home Postal Code3" := Rec."Home Postal Code3";
                                    ObjAccounts."Home Town3" := Rec."Home Town3";
                                    ObjAccounts."ID No.3" := Rec."ID No.3";
                                    ObjAccounts."Passport 3" := Rec."Passport 3";
                                    ObjAccounts.Gender3 := Rec.Gender3;
                                    ObjAccounts."Marital Status3" := Rec."Marital Status3";
                                    ObjAccounts."E-Mail (Personal3)" := Rec."E-Mail (Personal3)";
                                    ObjAccounts."Employer Code3" := Rec."Employer Code3";
                                    ObjAccounts."Employer Name3" := Rec."Employer Name3";
                                    ObjAccounts."Picture 3" := Rec."Picture 3";
                                    ObjAccounts."Signature  3" := Rec."Signature  3";
                                    ObjAccounts."Joint Account Name" := Rec."Joint Account Name";


                                    //=============================================================End Joint Account Details
                                    ObjAccounts.Insert;


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

                                        // CustomerTable."Fosa PostFix" := IncStr(CustomerTable."Fosa PostFix");
                                        // CustomerTable.Modify;
                                        if CustomerTable.Get(VarBOSAACC) then begin
                                            CustomerTable."FOSA Account No." := VarAcctNo;
                                            CustomerTable."Fosa PostFix" := IncStr(CustomerTable."Fosa PostFix");

                                            CustomerTable.Modify;
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
                                            ObjNextofKinFOSA."Member No" := ObjNextOfKinApp."Member No";
                                            ObjNextofKinFOSA."%Allocation" := ObjNextOfKinApp."%Allocation";
                                            ObjNextofKinFOSA."Next Of Kin Type" := ObjNextOfKinApp."Next Of Kin Type";
                                            ObjNextofKinFOSA.Insert;
                                        until ObjNextOfKinApp.Next = 0;
                                    end;

                                    //==================================================================================================Insert Account Agents
                                    ObjMemberAppAgent.Reset;
                                    ObjMemberAppAgent.SetRange(ObjMemberAppAgent."Account No", Rec."No.");
                                    if ObjMemberAppAgent.Find('-') then begin
                                        repeat
                                            if ObjNoSeries.Get then begin
                                                ObjNoSeries.TestField(ObjNoSeries."Agent Serial Nos");
                                                VarDocumentNo := NoSeriesMgt.GetNextNo(ObjNoSeries."Agent Serial Nos", 0D, true);
                                                if VarDocumentNo <> '' then begin
                                                    ObjAccountAgents.Init;
                                                    ObjAccountAgents."Document No" := VarDocumentNo;
                                                    ObjAccountAgents."Account No" := VarAcctNo;
                                                    ObjAccountAgents.Names := ObjMemberAppAgent.Names;
                                                    ObjAccountAgents."Date Of Birth" := ObjMemberAppAgent."Date Of Birth";
                                                    ObjAccountAgents."Staff/Payroll" := ObjMemberAppAgent."Staff/Payroll";
                                                    ObjAccountAgents."ID No." := ObjMemberAppAgent."ID No.";
                                                    ObjAccountAgents."Allowed  Correspondence" := ObjMemberAppAgent."Allowed  Correspondence";
                                                    ObjAccountAgents."Allowed Balance Enquiry" := ObjMemberAppAgent."Allowed Balance Enquiry";
                                                    ObjAccountAgents."Allowed FOSA Withdrawals" := ObjMemberAppAgent."Allowed FOSA Withdrawals";
                                                    ObjAccountAgents."Allowed Loan Processing" := ObjMemberAppAgent."Allowed Loan Processing";
                                                    ObjAccountAgents."Must Sign" := ObjMemberAppAgent."Must Sign";
                                                    ObjAccountAgents."Must be Present" := ObjMemberAppAgent."Must be Present";
                                                    ObjAccountAgents."Expiry Date" := ObjMemberAppAgent."Expiry Date";
                                                    ObjAccountAgents.Insert;
                                                end;
                                            end;
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





                                    //END;
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                    GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                    GenJournalLine.DeleteAll;

                                    ObjGenSetUp.Get();

                                    //Charge Registration Fee
                                    if Cust."Paid Registration Fee" = true then begin

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'GENERAL';
                                        GenJournalLine."Journal Batch Name" := 'REGFee';
                                        GenJournalLine."Document No." := Rec."No.";
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                        GenJournalLine."Account No." := VarNewMembNo;
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine."External Document No." := 'REGFEE/' + Format(Rec."Payroll No");
                                        GenJournalLine.Description := 'Registration Fee';
                                        GenJournalLine.Amount := ObjGenSetUp."BOSA Registration Fee Amount";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := '';
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;



                                        GenJournalLine.Reset;
                                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                        GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                        if GenJournalLine.Find('-') then begin
                                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                        end;

                                        CustLedgEntry.Reset;
                                        CustLedgEntry.SetRange("Customer No.", VarNewMembNo);
                                        CustLedgEntry.SetRange("Document No.", Rec."No.");
                                        CustLedgEntry.SetRange(Description, 'Registration Fee');
                                        if CustLedgEntry.FindLast then begin
                                            CustLedgEntry."Transaction Type" := CustLedgEntry."Transaction Type"::"Registration Fee";
                                            CustLedgEntry.Modify();
                                        end;
                                    end;
                                    Message('You have successfully created a %1 Product, A/C No=%2', ObjProductsApp.Product, VarAcctNo);


                                    //End Charge Registration Fee
                                end;
                            until ObjProductsApp.Next = 0;
                        end;
                        Message('You have successfully Registered a New Sacco Member. Membership No=%1.The Member will be notifed via SMS and/or Email.', CustomerTable."No.");

                        //=================================================================================================================End Member Accounts


                        if Rec."Member Payment Type" = Rec."member payment type"::"Standing Order" then
                            Message('Member Standing order No is %1', VarStandingNo);

                        ObjGenSetUp.Get();

                        //=====================================================================================================Send SMS
                        //if ObjGenSetUp."Send Membership Reg SMS" = true then begin
                        VarAccounts := '';
                        ObjAccounts.Reset;
                        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarBOSAACC);
                        if ObjAccounts.FindSet then begin
                            repeat
                                if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                                    VarAccounts := VarAccounts + Format(ObjAccounts."No.") + ' - ' + Format(ObjAccountType.Description) + '; ';
                                end;
                            until ObjAccounts.Next = 0;
                        end;

                        SmsManagement.SendSmsResponse(Rec."Mobile Phone No", 'Dear Member, Welcome to Utabibu Sacco. Your Membership Number No is ' + Format(VarBOSAACC) + '. You can make direct deposits to your account by dialling *720# or using Utapesa App. For more info visit www.utabibusacco.co.ke');

                        // SFactory.FnSendSMS('MEMBERAPP', 'You Membership Registration has been completed. Your Member No is ' + VarBOSAACC + ' and your Accounts are: ' + VarAccounts,
                        // VarBOSAACC, Rec."Mobile Phone No");
                        //end;

                        //======================================================================================================Send Email
                        if ObjGenSetUp."Send Membership App Email" then begin
                            if Rec."E-Mail (Personal)" <> '' then begin

                                //FnSendRegistrationEmail(Rec."No.", Rec."E-Mail (Personal)", Rec."ID No.", VarBOSAACC);
                                //   SmsManagement.SendSmsResponse(Rec."E-Mail (Personal)", 'Welcome to Utabibu Sacco. Your Membership number No is ' + Format(VarBOSAACC));


                            end;

                        end;
                        Rec.Created := true;
                        Rec.CalcFields(Rec."Assigned No.");
                        //FnRuninsertBOSAAccountNos(Rec."Assigned No.");//========================================================================Update Membership Account with BOSA Account Nos
                    end;
                }
                action("Update KYC Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Update KYC Details';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = EnableUpdateKYC;

                    trigger OnAction()
                    var
                        VarAccounts: Text;
                        ObjAccountType: Record "Account Types-Saving Products";
                    begin
                        if Rec.Status <> Rec.Status::Approved then
                            Error('The Membership Application must be approved before KYC Details are updated');

                        //FnRunEnsureDueDiligenceMeasureChecked;
                        CustomerTable.Reset;
                        CustomerTable.SetRange(CustomerTable."ID No.", Rec."ID No.");
                        if CustomerTable.FindSet then begin
                            CustomerTable.Address := Rec.Address;
                            CustomerTable."Address 2" := Rec."Address 2";
                            CustomerTable."Post Code" := Rec."Postal Code";
                            CustomerTable.Town := Rec.Town;
                            CustomerTable.County := Rec.County;
                            CustomerTable.City := Rec.City;
                            CustomerTable."Country/Region Code" := Rec."Country/Region Code";
                            CustomerTable."Phone No." := Rec."Phone No.";
                            CustomerTable."Date of Birth" := Rec."Date of Birth";
                            CustomerTable.Piccture := Rec.Picture;
                            CustomerTable.Signature := Rec.Signature;
                            CustomerTable."E-Mail" := Rec."E-Mail (Personal)";
                            CustomerTable.Location := Rec.Location;
                            CustomerTable.Title := Rec.Title;
                            CustomerTable."Home Address" := Rec."Home Address";
                            CustomerTable."Home Postal Code" := Rec."Home Postal Code";
                            CustomerTable."Home Town" := Rec."Home Town";
                            CustomerTable."Recruited By" := Rec."Recruited By";
                            CustomerTable."Contact Person" := Rec."Contact Person";
                            CustomerTable."ContactPerson Relation" := Rec."ContactPerson Relation";
                            CustomerTable."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                            CustomerTable."Member Share Class" := Rec."Member Share Class";
                            CustomerTable."Member's Residence" := Rec."Member's Residence";
                            CustomerTable."Member House Group" := Rec."Member House Group";
                            CustomerTable."Member House Group Name" := Rec."Member House Group Name";
                            CustomerTable."Occupation Details" := Rec."Employment Info";
                            CustomerTable."Employer Code" := Rec."Employer Code";
                            CustomerTable."Employer Name" := Rec."Employer Name";
                            CustomerTable."Employer Address" := Rec."Employer Address";
                            CustomerTable."Terms Of Employment" := Rec."Terms of Employment";
                            CustomerTable."Date of Employment" := Rec."Date of Employment";
                            CustomerTable."Position Held" := Rec."Position Held";
                            CustomerTable."Expected Monthly Income" := Rec."Expected Monthly Income";
                            CustomerTable."Expected Monthly Income Amount" := Rec."Expected Monthly Income Amount";
                            CustomerTable."Nature Of Business" := Rec."Nature Of Business";
                            CustomerTable.Industry := Rec.Industry;
                            CustomerTable."Business Name" := Rec."Business Name";
                            CustomerTable."Physical Business Location" := Rec."Physical Business Location";
                            CustomerTable."Year of Commence" := Rec."Year of Commence";
                            CustomerTable."Identification Document" := Rec."Identification Document";
                            CustomerTable."Referee Member No" := Rec."Referee Member No";
                            CustomerTable."Referee Name" := Rec."Referee Name";
                            CustomerTable."Referee ID No" := Rec."Referee ID No";
                            CustomerTable."Referee Mobile Phone No" := Rec."Referee Mobile Phone No";
                            CustomerTable."Introducer Relationship" := Rec."Introducer Relationship";
                            CustomerTable."Email Indemnified" := Rec."E-mail Indemnified";
                            CustomerTable."Member Needs House Group" := Rec."Member Needs House Group";
                            CustomerTable."Data Protection" := Rec."Data Protection";


                            //*****************************to Sort Joint
                            CustomerTable."Name 2" := Rec."Name 2";
                            CustomerTable.Address3 := Rec.Address3;
                            CustomerTable."Postal Code 2" := Rec."Postal Code 2";
                            CustomerTable."Home Postal Code2" := Rec."Home Postal Code2";
                            CustomerTable."Home Town2" := Rec."Home Town2";
                            CustomerTable."ID No.2" := Rec."ID No.2";
                            CustomerTable."Passport 2" := Rec."Passport 2";
                            CustomerTable.Gender2 := Rec.Gender2;
                            CustomerTable."Marital Status2" := Rec."Marital Status2";
                            CustomerTable."E-Mail (Personal2)" := Rec."E-Mail (Personal2)";
                            CustomerTable."Employer Code2" := Rec."Employer Code2";
                            CustomerTable."Employer Name2" := Rec."Employer Name2";
                            CustomerTable."Picture 2" := Rec."Picture 2";
                            CustomerTable."Signature  2" := Rec."Signature  2";
                            CustomerTable."Name 3" := Rec."Name 3";
                            CustomerTable."Address3-Joint" := Rec.Address4;
                            CustomerTable."Postal Code 3" := Rec."Postal Code 3";
                            CustomerTable."Home Postal Code3" := Rec."Home Postal Code3";
                            CustomerTable."Mobile No. 4" := Rec."Mobile No. 4";
                            CustomerTable."Home Town3" := Rec."Home Town3";
                            CustomerTable."ID No.3" := Rec."ID No.3";
                            CustomerTable."Passport 3" := Rec."Passport 3";
                            CustomerTable.Gender3 := Rec.Gender3;
                            CustomerTable."Marital Status3" := Rec."Marital Status3";
                            CustomerTable."E-Mail (Personal3)" := Rec."E-Mail (Personal3)";
                            CustomerTable."Employer Code3" := Rec."Employer Code3";
                            CustomerTable."Employer Name3" := Rec."Employer Name3";
                            CustomerTable."Picture 3" := Rec."Picture 3";
                            CustomerTable."Signature  3" := Rec."Signature  3";
                            CustomerTable."Account Category" := Rec."Account Category";
                            CustomerTable."Joint Account Name" := Rec."Joint Account Name";
                            if Rec."Account Category" = Rec."account category"::Joint then
                                CustomerTable.Name := Rec."Joint Account Name";
                            CustomerTable."Data Protection" := Rec."Data Protection";
                            //===================================================================================End Joint Account Details

                            //**
                            CustomerTable."Office Branch" := Rec."Office Branch";
                            CustomerTable.Department := Rec.Department;
                            CustomerTable.Occupation := Rec.Occupation;
                            CustomerTable.Designation := Rec.Designation;
                            CustomerTable."Bank Code" := Rec."Bank Code";
                            CustomerTable."Bank Branch Code" := Rec."Bank Name";
                            CustomerTable."Bank Account No." := Rec."Bank Account No";
                            //**
                            CustomerTable."Sub-Location" := Rec."Sub-Location";
                            CustomerTable.District := Rec.District;
                            CustomerTable."Payroll No" := Rec."Payroll No";
                            CustomerTable."ID No." := Rec."ID No.";
                            CustomerTable."Mobile Phone No" := Rec."Mobile Phone No";
                            CustomerTable."Marital Status" := Rec."Marital Status";
                            CustomerTable."Customer Type" := CustomerTable."customer type"::Member;
                            CustomerTable.Gender := Rec.Gender;

                            CustomerTable.Piccture := Rec.Picture;
                            CustomerTable.Signature := Rec.Signature;

                            CustomerTable."Monthly Contribution" := Rec."Monthly Contribution";
                            CustomerTable."Contact Person" := Rec."Contact Person";
                            CustomerTable."Contact Person Phone" := Rec."Contact Person Phone";
                            CustomerTable."ContactPerson Relation" := Rec."ContactPerson Relation";
                            CustomerTable."Recruited By" := Rec."Recruited By";
                            CustomerTable."ContactPerson Occupation" := Rec."ContactPerson Occupation";
                            CustomerTable."Village/Residence" := Rec."Village/Residence";
                            CustomerTable.Pin := Rec."KRA PIN";
                            CustomerTable."KYC Completed" := true;
                            CustomerTable."Data Protection" := Rec."Data Protection";

                            //========================================================================Member Risk Rating
                            CustomerTable."Individual Category" := Rec."Individual Category";
                            CustomerTable.Entities := Rec.Entities;
                            CustomerTable."Member Residency Status" := Rec."Member Residency Status";
                            CustomerTable."Industry Type" := Rec."Industry Type";
                            CustomerTable."Length Of Relationship" := Rec."Length Of Relationship";
                            CustomerTable."International Trade" := Rec."International Trade";
                            CustomerTable."Electronic Payment" := Rec."Electronic Payment";
                            CustomerTable."Accounts Type Taken" := Rec."Accounts Type Taken";
                            CustomerTable."Cards Type Taken" := Rec."Cards Type Taken";
                            CustomerTable.Modify;
                            //========================================================================End Member Risk Rating


                        end;
                        Message('You have successfully Updated the KYC Details for Member No=%1.The Member will be notifed via SMS and/or Email.', CustomerTable."No.");

                        ObjGenSetUp.Get();

                        //=====================================================================================================Send SMS
                        if ObjGenSetUp."Send Membership Reg SMS" = true then begin
                            SFactory.FnSendSMS('MEMBERAPP', 'Dear ' + Rec."First Name" + ', you Membership KYC Details have been completed. You can now transact on your Accounts without any limits.',
                            CustomerTable."No.", Rec."Mobile Phone No");
                        end;

                        //======================================================================================================Send Email
                        if ObjGenSetUp."Send Membership Reg Email" = true then begin
                            FnSendKYCUpdateEmail(Rec."No.", Rec."E-Mail (Personal)", Rec."ID No.", CustomerTable."No.");
                        end;
                        Rec."KYC Completed" := true;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
    // WorkflowManagement: Codeunit "Workflow Management";
    // WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        UpdateControls();
        EnableCreateMember := false;
        EnableUpdateKYC := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        EnabledApprovalWorkflowsExist := true;

        if Rec.Status = Rec.Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if (Rec.Status = Rec.Status::Approved) then
            EnableCreateMember := true;

        if Rec.Created = true then
            EnableCreateMember := false;

        if (Rec.Created = true) and (Rec."KYC Completed" = false) and (Rec."Online Application" = true) then
            EnableUpdateKYC := true;


    end;

    trigger OnAfterGetRecord()
    begin

        StyleText := 'UnFavorable';


        EditBranch := false;
        UserSetup.reset;
        UserSetup.setrange("User ID", UserId);
        UserSetup.setrange("Edit Branch", true);
        if UserSetup.FindFirst then begin

            EditBranch := true;
        end else begin

            EditBranch := False;
        end;
        EmployedVisible := false;
        SelfEmployedVisible := false;
        OtherVisible := false;

        if (Rec."Employment Info" = Rec."employment info"::Employed) or (Rec."Employment Info" = Rec."employment info"::"Employed & Self Employed") then begin
            EmployedVisible := true;
        end;

        if (Rec."Employment Info" = Rec."employment info"::"Self-Employed") or (Rec."Employment Info" = Rec."employment info"::"Employed & Self Employed") then begin
            SelfEmployedVisible := true;
        end;

        if (Rec."Employment Info" = Rec."employment info"::Others) or (Rec."Employment Info" = Rec."employment info"::Contracting) then begin
            OtherVisible := true;
        end;

        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
            PassportEditable := false;
            IDNoEditable := true
        end else
            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                PassportEditable := true;
                IDNoEditable := false
            end else
                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                    PassportEditable := true;
                    IDNoEditable := true;
                end;

        SetStyles();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Responsibility Centre" := ObjUserMgt.GetSalesFilter;
        MembApp2.reset;
        MembApp2.SetRange(MembApp2."No.", Rec."No.");
        MembApp2.Setrange(Created, False);
        if MembApp2.FindFirst() Then begin
            if MembApp2.Count > 2 then begin
                if MembApp2."ID No." = '' then
                    Error('There are still some Unused member Nos. Please utilise them first');
            end;
        end;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserMgt: Codeunit "User Management";
    begin
        ObjGenSetUp.Get();
        Rec."Monthly Contribution" := ObjGenSetUp."Min. Contribution";
        Rec."Customer Posting Group" := ObjGenSetUp."Default Customer Posting Group";

        EditBranch := false;
        UserSetup.reset;
        UserSetup.setrange("User ID", UserId);
        UserSetup.setrange("Edit Branch", true);
        if UserSetup.FindFirst then begin

            EditBranch := true;
        end else begin

            EditBranch := False;
        end;
    end;

    trigger OnOpenPage()
    begin

        if ObjUserMgt.GetSalesFilter <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Centre", ObjUserMgt.GetSalesFilter);
            Rec.FilterGroup(0);
        end;

        EditBranch := false;
        UserSetup.reset;
        UserSetup.setrange("User ID", UserId);
        UserSetup.setrange("Edit Branch", true);
        if UserSetup.FindFirst then begin

            EditBranch := true;
        end else begin

            EditBranch := False;
        end;

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;

        if Rec."Account Category" = Rec."account category"::Corporate then begin
            Joint2DetailsVisible := true;
            Joint3DetailsVisible := true;
        end;
        if Rec."Account Category" = Rec."account category"::Individual then begin
            Joint2DetailsVisible := false;
            Joint3DetailsVisible := false;
        end;

        EmployedVisible := false;
        SelfEmployedVisible := false;
        OtherVisible := false;

        if (Rec."Employment Info" = Rec."employment info"::Employed) or (Rec."Employment Info" = Rec."employment info"::"Employed & Self Employed") then begin
            EmployedVisible := true;
        end;

        if (Rec."Employment Info" = Rec."employment info"::"Self-Employed") or (Rec."Employment Info" = Rec."employment info"::"Employed & Self Employed") then begin
            SelfEmployedVisible := true;
        end;

        if (Rec."Employment Info" = Rec."employment info"::Others) or (Rec."Employment Info" = Rec."employment info"::Contracting) then begin
            OtherVisible := true;
        end;




        if Rec."Identification Document" = Rec."identification document"::"Nation ID Card" then begin
            PassportEditable := false;
            IDNoEditable := true
        end else
            if Rec."Identification Document" = Rec."identification document"::"Passport Card" then begin
                PassportEditable := true;
                IDNoEditable := false
            end else
                if Rec."Identification Document" = Rec."identification document"::"Aliens Card" then begin
                    PassportEditable := true;
                    IDNoEditable := true;
                end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        ObjCust: Record Customer;
        EditBranch: boolean;
        MembApp2: Record "Membership Applications";
        CustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        ObjAccounts: Record Vendor;
        VarAcctNo: Code[20];
        MemberAuotoIncre: code[30];
        ObjNextOfKinApp: Record "Member App Nominee";
        ObjAccountSign: Record "FOSA Account Sign. Details";
        ObjAccountSignApp: Record "Member App Signatories";
        ObjAcc: Record Vendor;
        UsersID: Record User;
        UserSetup: Record "User Setup";
        ObjNok: Record "Member App Nominee";
        ObjNOKBOSA: Record "Members Next of Kin";
        VarBOSAACC: Code[20];
        ObjNextOfKin: Record "Members Next of Kin";
        VarPictureExists: Boolean;
        text001: label 'Status must be open';
        ObjUserMgt: Codeunit "User Setup Management";
        ObjNotificationE: Codeunit Mail;
        VarMailBody: Text[250];
        VarccEmail: Text[1000];
        VartoEmail: Text[1000];
        ObjGenSetUp: Record "Sacco General Set-Up";
        VarClearingAcctNo: Code[20];
        VarAdvrAcctNo: Code[20];
        ObjAccountTypes: Record "Account Types-Saving Products";
        VarDivAcctNo: Code[20];
        NameEditable: Boolean;
        AddressEditable: Boolean;
        NoEditable: Boolean;
        DioceseEditable: Boolean;
        Picture: Text;
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
        EmployerNameEditable: Boolean;
        DepartmentEditable: Boolean;
        TermsofEmploymentEditable: Boolean;
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
        ProductEditable: Boolean;
        SecondaryMobileEditable: Boolean;
        AccountCategoryEditable: Boolean;
        OfficeTelephoneEditable: Boolean;
        OfficeExtensionEditable: Boolean;
        MemberParishEditable: Boolean;
        KnowDimkesEditable: Boolean;
        CountyEditable: Boolean;
        DistrictEditable: Boolean;
        LocationEditable: Boolean;
        SubLocationEditable: Boolean;
        EmploymentInfoEditable: Boolean;
        VillageResidence: Boolean;
        SignatureExists: Boolean;
        VarNewMembNo: Code[30];
        ObjSaccosetup: Record "Sacco No. Series";
        ObjNOkApp: Record "Member App Nominee";
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
        ObjDataSheet: Record "Data Sheet Main";
        ObjSMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cuat: Integer;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        OthersEditable: Boolean;
        Joint2DetailsVisible: Boolean;
        ObjProductsApp: Record "Membership Reg. Products Appli";
        ObjNextofKinFOSA: Record "FOSA Account NOK Details";
        ObjUsersRec: Record User;
        Joint3DetailsVisible: Boolean;
        CompInfo: Record "Company Information";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FirstNameEditable: Boolean;
        MiddleNameEditable: Boolean;
        LastNameEditable: Boolean;
        PayrollNoEditable: Boolean;
        MemberResidenceEditable: Boolean;
        ShareClassEditable: Boolean;
        KRAPinEditable: Boolean;
        ObjViewLog: Record "View Log Entry";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        WelcomeMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        RegistrationMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Kingdom Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership registration has been successfully processed</p><p style="font-family:Verdana,Arial;font-size:9pt">Your membership number is <b>%2</b></p><br>Regards<p>%3</p><p><b>KINGDOM SACCO LTD</b></p>';
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        SFactory: Codeunit "Au Factory";
        SmsManagement: Codeunit "Sms Management";
        NatureofBussEditable: Boolean;
        IndustryEditable: Boolean;
        BusinessNameEditable: Boolean;
        PhysicalBussLocationEditable: Boolean;
        YearOfCommenceEditable: Boolean;
        PositionHeldEditable: Boolean;
        EmploymentDateEditable: Boolean;
        EmployerAddressEditable: Boolean;
        EmailIndemnifiedEditable: Boolean;
        SendEStatementsEditable: Boolean;
        ObjAccountAppAgent: Record "Account Agents App Details";
        ObjAccountAgent: Record "Account Agent Details";
        ObjMemberAppAgent: Record "Member Agents App Details";
        ObjMemberAgent: Record "Member Agent Details";
        IdentificationDocTypeEditable: Boolean;
        PhysicalAddressEditable: Boolean;
        RefereeEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
        ObjAccountAgents: Record "Account Agent Details";
        ObjMembers: Record customer;
        ObjBOSAAccount: Record "BOSA Accounts No Buffer";
        StyleText: Text[20];
        CoveragePercentStyle: Text;
        ObjMemberNoseries: Record "Member Accounts No Series";
        VarAccountTypes: Text[1000];
        VarAccountDescription: Text[1000];
        ObjAccountType: Record "Account Types-Saving Products";
        VarMemberName: Text[100];
        AUFactory: Codeunit "Au Factory";
        VarEmailSubject: Text;
        VarEmailBody: Text;
        VarTextExtension: Text;
        VarTextExtensionII: Text;
        VarEnableNeedHouse: Boolean;
        EmployedVisible: Boolean;
        SelfEmployedVisible: Boolean;
        OtherVisible: Boolean;
        ObjNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        VarProductCount: Integer;
        ObjMemberAppSignatories: Record "Member App Signatories";
        EnableUpdateKYC: Boolean;
        VarStandingNo: Code[20];
        WorkflowManagement: Codeunit WorkflowIntegration;
        CustomerTable: Record Customer;


    procedure UpdateControls()
    begin

        if (Rec.Status = Rec.Status::Approved) or ((Rec."Online Application" = true) and (Rec."KYC Completed" = true)) then begin
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
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;
            PositionHeldEditable := false;
            EmploymentDateEditable := false;
            EmployerAddressEditable := false;
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
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;
            PositionHeldEditable := false;
            EmploymentDateEditable := false;
            EmployerAddressEditable := false;
            EmailIndemnifiedEditable := false;
            SendEStatementsEditable := false;
            IdentificationDocTypeEditable := false;
            PhysicalAddressEditable := false;
            RefereeEditable := false;
            MonthlyIncomeEditable := false;
        end;


        if (Rec.Status = Rec.Status::Open) or ((Rec."Online Application" = true) and (Rec."KYC Completed" = false)) then begin
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
            ProductEditable := true;
            SecondaryMobileEditable := true;
            AccountCategoryEditable := true;
            OfficeTelephoneEditable := true;
            OfficeExtensionEditable := true;
            CountyEditable := true;
            DistrictEditable := true;
            LocationEditable := true;
            SubLocationEditable := true;
            EmploymentInfoEditable := true;
            MemberParishEditable := true;
            KnowDimkesEditable := true;
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            FirstNameEditable := true;
            MiddleNameEditable := true;
            LastNameEditable := true;
            PayrollNoEditable := true;
            MemberResidenceEditable := true;
            ShareClassEditable := true;
            KRAPinEditable := true;
            RecruitedByEditable := true;
            EmailIndemnifiedEditable := true;
            SendEStatementsEditable := true;
            NatureofBussEditable := true;
            IndustryEditable := true;
            BusinessNameEditable := true;
            PhysicalBussLocationEditable := true;
            YearOfCommenceEditable := true;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
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

    end;


    procedure FnSendReceivedApplicationSMS()
    begin

        ObjGenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        ObjSMSMessage.Reset;
        if ObjSMSMessage.Find('+') then begin
            iEntryNo := ObjSMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        ObjSMSMessage.Init;
        ObjSMSMessage."Entry No" := iEntryNo;
        ObjSMSMessage."Batch No" := Rec."No.";
        ObjSMSMessage."Document No" := '';
        ObjSMSMessage."Account No" := VarBOSAACC;
        ObjSMSMessage."Date Entered" := Today;
        ObjSMSMessage."Time Entered" := Time;
        ObjSMSMessage.Source := 'MEMBAPP';
        ObjSMSMessage."Entered By" := UserId;
        ObjSMSMessage."Sent To Server" := ObjSMSMessage."sent to server"::No;
        ObjSMSMessage."SMS Message" := 'Dear Member your application has been received and going through approval,'
        + ' ' + CompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        ObjSMSMessage."Telephone No" := Rec."Mobile Phone No";
        if Rec."Mobile Phone No" <> '' then
            ObjSMSMessage.Insert;
    end;


    procedure FnSendRegistrationSMS()
    begin

        ObjGenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        ObjSMSMessage.Reset;
        if ObjSMSMessage.Find('+') then begin
            iEntryNo := ObjSMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        ObjSMSMessage.Init;
        ObjSMSMessage."Entry No" := iEntryNo;
        ObjSMSMessage."Batch No" := Rec."No.";
        ObjSMSMessage."Document No" := '';
        ObjSMSMessage."Account No" := VarBOSAACC;
        ObjSMSMessage."Date Entered" := Today;
        ObjSMSMessage."Time Entered" := Time;
        ObjSMSMessage.Source := 'MEMBREG';
        ObjSMSMessage."Entered By" := UserId;
        ObjSMSMessage."Sent To Server" := ObjSMSMessage."sent to server"::No;
        ObjSMSMessage."SMS Message" := 'Dear Member you have been registered successfully, your Membership No is '
        + VarBOSAACC + ' Name ' + Rec.Name + ' ' + CompInfo.Name + ' ' + ObjGenSetUp."Customer Care No";
        ObjSMSMessage."Telephone No" := Rec."Mobile Phone No";
        if Rec."Mobile Phone No" <> '' then
            ObjSMSMessage.Insert;
    end;

    local procedure UpdateViewLogEntries()
    begin
        ObjViewLog.Init;
        ObjViewLog."Entry No." := ObjViewLog."Entry No." + 1;
        ObjViewLog."User ID" := UserId;
        ObjViewLog."Table No." := 51516364;
        ObjViewLog."Table Caption" := 'Members Register';
        ObjViewLog.Date := Today;
        ObjViewLog.Time := Time;
    end;

    procedure FnCheckfieldrestriction()
    begin
        if (Rec."Account Category" = Rec."account category"::Individual) then begin
            //  CALCFIELDS(Picture, Signature);
            Rec.TestField(Name);
            // Rec.TestField("ID No.");
            Rec.TestField("Mobile Phone No");
            Rec.TestField("Global Dimension 2 Code");
            Rec.TestField("Monthly Contribution");
            Rec.TestField(Gender);
            Rec.TestField("Employment Info");
            Rec.TestField("KRA PIN");
            Rec.TestField("Date of Birth");
            Rec.TestField(County);
            Rec.TestField(District);
            Rec.TestField(Signature);
            Rec.TestField(Picture);
            Rec.TestField("Address 2");
            Rec.TestField("Paid Registration Fee", true);
            ObjProductsApp.Reset;
            ObjProductsApp.SetRange(ObjProductsApp."Membership Applicaton No", Rec."No.");
            if ObjProductsApp.FindSet = false then begin
                Error('You must select products (account types) to be created for the member');
            end;
            ObjNextOfKinApp.Reset();
            ObjNextOfKinApp.setrange(ObjNextOfKinApp."Account No", Rec."No.");
            if ObjNextOfKinApp.FindSet = false then begin
                error('You must add next of kin and nominee details');
            end

        end else

            if (Rec."Account Category" = Rec."account category"::Group) or (Rec."Account Category" = Rec."account category"::Joint) then begin
                Rec.TestField(Name);
                Rec.TestField("Registration No");
                Rec.TestField("Copy of KRA Pin");
                Rec.TestField("Member Registration Fee Receiv");
                Rec.TestField("Customer Posting Group");
                Rec.TestField("Global Dimension 1 Code");
                Rec.TestField("Global Dimension 2 Code");

            end;

    end;

    local procedure FnSendReceivedApplicationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    var
        Memb: Record "Membership Applications";
        //  SMTPMail: Codeunit "SMTP Mail";
        //  SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        recipient: List of [Text];
    begin
        // SMTPSetup.Get();

        Memb.Reset;
        Memb.SetRange(Memb."No.", ApplicationNo);
        Memb.SetFilter(Memb."E-Mail (Personal)", '<>%1', '');
        if Memb.Find('-') then begin
            if Email = '' then begin
                Error('Email Address Missing for Member Application number' + '-' + Memb."No.");
            end;

        end;




    end;

    local procedure FnSendRegistrationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20]; VarMemberNo: Code[30])
    var
        Memb: Record "Membership Applications";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        SendEmail: Codeunit Email;
        Emailmessage: Codeunit "Email Message";
        cryp: Codeunit "Cryptography Management";
        EmailTextBuilder: TextBuilder;
        FormattedBody: Text;
        DearCandidateLbl: Label 'Dear %1,';
        KindRegardsLbl: Label '<p>Kind Regards</p><br> %2 <br>';
        NewBody: Text;
        Fosaaccounts: text;
    begin
        VarAccountDescription := '';
        VarAccountTypes := '<p><ul style="list-style-type:square">';

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        if ObjAccounts.FindSet then begin
            repeat

                if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                    VarAccountDescription := ObjAccountType.Description;
                end;

                VarAccountTypes := VarAccountTypes + '<li>' + Format(ObjAccounts."No.") + ' - ' + Format(VarAccountDescription) + '</li>';
            until ObjAccounts.Next = 0;
        end;
        VarAccountTypes := VarAccountTypes + '</ul></p>';
        CompanyInfo.Get;
        VarMemberName := aufactory.FnConvertTexttoBeginingWordstostartWithCapital(Rec.Name);
        VarEmailSubject := CompanyInfo.Name;
        IF VarAccountTypes <> '' THEN begin
            Fosaaccounts := 'Fosa Accounts ' + VarAccountTypes
        end

        ELSE begin
            Fosaaccounts := '';
        end;



        VarEmailBody := 'Welcome and Thank you for Joining ' + CompanyInfo.Name + '.' + ' Your Membership Number is ' + VarMemberNo + '<br>' + Fosaaccounts;
        EmailTextBuilder.Clear();
        EmailTextBuilder.Append(DearCandidateLbl);
        EmailTextBuilder.Append(VarEmailBody);
        EmailTextBuilder.Append(KindRegardsLbl);
        NewBody := EmailTextBuilder.ToText();
        FormattedBody := StrSubstNo(NewBody, VarMemberName, CompanyInfo.Name);
        Emailmessage.create(Email, VarEmailSubject, FormattedBody, true);
        SendEmail.send(Emailmessage);
    end;

    local procedure FnUpdateMemberSubAccounts()
    begin

    end;

    local procedure SetStyles()
    begin
        CoveragePercentStyle := 'Strong';
        if Rec."Member Risk Level" <> Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Unfavorable';
        if Rec."Member Risk Level" = Rec."member risk level"::"Low Risk" then
            CoveragePercentStyle := 'Favorable';
    end;

    local procedure FnRuninsertBOSAAccountNos(VarMemberNo: Code[30])
    begin

    end;

    local procedure FnGetMinimumRequirement()
    begin
        Rec.TestField(Picture);
        Rec.TestField(Signature);
        Rec.TestField("Monthly Contribution");
        // Rec.TestField("ID No.");
        Rec.TestField("Mobile Phone No");

    end;

    local procedure FnRunCheckDueDiligenceMeasureGeneration()
    var
        ObjDueDiligenceMeasures: Record "Member Due Diligence Measures";
    begin
        ObjDueDiligenceMeasures.Reset;
        ObjDueDiligenceMeasures.SetRange(ObjDueDiligenceMeasures."Member No", Rec."No.");
        if not ObjDueDiligenceMeasures.Find('-') then begin
            Error('Kindly Generate Due Diligence Measures for this Application before Proceeding');
        end;
    end;

    local procedure FnRunEnsureDueDiligenceMeasureChecked()
    var
        ObjDueDiligenceMeasures: Record "Member Due Diligence Measures";
    begin
        ObjDueDiligenceMeasures.Reset;
        ObjDueDiligenceMeasures.SetRange(ObjDueDiligenceMeasures."Member No", Rec."No.");
        ObjDueDiligenceMeasures.SetRange(ObjDueDiligenceMeasures."Due Diligence Done", false);
        if ObjDueDiligenceMeasures.FindSet then begin
            Error('Kindly Ensure All Due Diligence Measures for this Application has been Checked before Creating the Account');
        end;
    end;

    local procedure FnSendKYCUpdateEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20]; VarMemberNo: Code[30])
    var
        Memb: Record "Membership Applications";
        // SMTPMail: Codeunit "SMTP Mail";
        // SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        //SMTPSetup.Get();

        VarAccountDescription := '';
        VarAccountTypes := '<p><ul style="list-style-type:square">';

        ObjAccounts.Reset;
        ObjAccounts.SetRange(ObjAccounts."BOSA Account No", VarMemberNo);
        if ObjAccounts.FindSet then begin
            repeat

                if ObjAccountType.Get(ObjAccounts."Account Type") then begin
                    VarAccountDescription := ObjAccountType."Product Short Name";
                end;

                VarAccountTypes := VarAccountTypes + '<li>' + Format(ObjAccounts."No.") + ' - ' + Format(VarAccountDescription) + '</li>';
            until ObjAccounts.Next = 0;
        end;
        VarAccountTypes := VarAccountTypes + '</ul></p>';

        VarMemberName := aufactory.FnConvertTexttoBeginingWordstostartWithCapital(Rec.Name);
        VarTextExtension := '<p>At Demo Sacco, we provide you with a variety of efficient and convenient services that enable you to:</p>' +
               '<p>1. Make Automated Deposit to your account through any Equity Bank Branch to our Account No. 15172262333007 and any Family Bank Branch via Utility Payment. You will provide your Demo Sacco 12-digit Account Number.</p>' +
               '<p>2. Make Automated Deposits through MPESA or Equitel/Equity Bank Agents using our Paybill No. 521000 and through Family Bank Agents using Bill Payment Code 020, then provide your Account Number and Amount.</p>' +
               '<p>3. Transact through our Mobile Banking Channels to Apply for Loans, MPESA Withdrawal, Account Transfers, Account Enquiries, Statement Requests etc. You can download Demo Sacco Mobile App on Google Play Store</p>';

        VarTextExtensionII := '<p>5. Access funds via Cardless ATM Withdrawal Service with Family Bank accessible to all our registered Mobile Banking Users. For guidelines send the word CARDLESS to 0705270662 or use our Mobile App.</p>' +
               '<p>6. Apply for a Cheque Book and initiate cheque payments from your account at Demo Sacco.</p>' +
               '<p>7. Process your salary to your Demo Sacco Account and benefit from very affordable salary loans.</p>' +
               '<p>8. Operate an Ufalme Account and save in order to acquire Land/Housing in our upcoming projects.</p>' +
               '<p>Visit our website <a href="http://www.Demosacco.com">www.Demosacco.com</a> for more information on our service offering.</p>' +
               '<p>Thank you for choosing Demo Sacco. Our objective is to empower you economically and socially by promoting a Savings and Investments culture and providing affordable credit.</p>';


        VarEmailSubject := 'MEMBERSHIP KYC DETAILS UPDATED - ' + VarMemberNo;
        VarEmailBody := '<p>Your Membership KYC Details have successfully been updated. You can now transact on your Accounts without any limits.</p>' +
              '<p>Your Membership Number is ' + VarMemberNo + '. Your Account Numbers are: ' + VarAccountTypes + '</p>' + VarTextExtension + VarTextExtensionII;

        //aufactory.FnSendStatementViaMail(VarMemberName, VarEmailSubject, VarEmailBody, "E-Mail (Personal)", '', '');
    end;
}




