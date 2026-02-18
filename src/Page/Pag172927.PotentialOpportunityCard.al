//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172927 "Potential Opportunity Card"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable ="Lead Management";
    SourceTableView = where(status = filter(Opportunity));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("First Name";Rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Middle Name";Rec."Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.";Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Lead Status";Rec."Lead Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Employment Info")
            {
                Caption = 'Employment Info';
                field(Control21; Rec."Employment Info")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if Rec."Employment Info" = Rec."employment info"::Employed then begin
                            EmployerCodeEditable := true;
                            DepartmentEditable := true;
                            TermsofEmploymentEditable := true;
                            ContractingEditable := false;
                            EmployedEditable := false;
                            OccupationEditable := false;
                            PositionHeldEditable := true;
                            EmploymentDateEditable := true;
                            EmployerAddressEditable := true;
                            NatureofBussEditable := false;
                            IndustryEditable := false;
                            BusinessNameEditable := false;
                            PhysicalBussLocationEditable := false;
                            YearOfCommenceEditable := false;



                        end else
                            if Rec."Employment Info" = Rec."employment info"::Contracting then begin
                                ContractingEditable := true;
                                EmployerCodeEditable := false;
                                DepartmentEditable := false;
                                TermsofEmploymentEditable := false;
                                OccupationEditable := false;
                                PositionHeldEditable := false;
                                EmploymentDateEditable := false;
                                EmployerAddressEditable := false;
                                NatureofBussEditable := false;
                                IndustryEditable := false;
                                BusinessNameEditable := false;
                                PhysicalBussLocationEditable := false;
                                YearOfCommenceEditable := false;
                            end else
                                if Rec."Employment Info" = Rec."employment info"::Others then begin
                                    OthersEditable := true;
                                    ContractingEditable := false;
                                    EmployerCodeEditable := false;
                                    DepartmentEditable := false;
                                    TermsofEmploymentEditable := false;
                                    OccupationEditable := false;
                                    PositionHeldEditable := false;
                                    EmploymentDateEditable := false;
                                    EmployerAddressEditable := false
                                end else
                                    if Rec."Employment Info" = Rec."employment info"::"Self-Employed" then begin
                                        OccupationEditable := true;
                                        EmployerCodeEditable := false;
                                        DepartmentEditable := false;
                                        TermsofEmploymentEditable := false;
                                        ContractingEditable := false;
                                        EmployedEditable := false;
                                        NatureofBussEditable := true;
                                        IndustryEditable := true;
                                        BusinessNameEditable := true;
                                        PhysicalBussLocationEditable := true;
                                        YearOfCommenceEditable := true;
                                        PositionHeldEditable := false;
                                        EmploymentDateEditable := false;
                                        EmployerAddressEditable := false

                                    end;




                        /*IF "Identification Document"="Identification Document"::"Nation ID Card" THEN BEGIN
                          PassportEditable:=FALSE;
                          IDNoEditable:=TRUE
                          END ELSE
                          IF "Identification Document"="Identification Document"::"Passport Card" THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=FALSE
                          END ELSE
                          IF "Identification Document"="Identification Document"::"Aliens Card" THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=TRUE;
                        END;*/

                    end;
                }
                field("Employer Code";Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerCodeEditable;
                    ShowMandatory = true;
                }
                field("Employer Name";Rec."Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = EmployedEditable;
                }
                field("Employer Address";Rec."Employer Address")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerAddressEditable;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic;
                    Caption = 'WorkStation / Depot';
                    Editable = DepartmentEditable;
                }
                field("Terms of Employment";Rec."Terms of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = TermsofEmploymentEditable;
                    ShowMandatory = true;
                }
                field("Date of Employment";Rec."Date of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = EmploymentDateEditable;
                }
                field("Position Held";Rec."Position Held")
                {
                    ApplicationArea = Basic;
                    Editable = PositionHeldEditable;
                }
                field("Expected Monthly Income";Rec."Expected Monthly Income")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyIncomeEditable;
                }
                field("Nature Of Business";Rec."Nature Of Business")
                {
                    ApplicationArea = Basic;
                    Editable = NatureofBussEditable;
                }
                field(Industry; Rec.Industry)
                {
                    ApplicationArea = Basic;
                    Editable = IndustryEditable;
                }
                field("Business Name";Rec."Business Name")
                {
                    ApplicationArea = Basic;
                    Editable = BusinessNameEditable;
                }
                field("Physical Business Location";Rec."Physical Business Location")
                {
                    ApplicationArea = Basic;
                    Editable = PhysicalBussLocationEditable;
                }
                field("Year of Commence";Rec."Year of Commence")
                {
                    ApplicationArea = Basic;
                    Editable = YearOfCommenceEditable;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = OccupationEditable;
                }
                field("Others Details";Rec."Others Details")
                {
                    ApplicationArea = Basic;
                    Editable = OthersEditable;
                }
            }
            group("Referee Details")
            {
                Caption = 'Referee Details';
                field("Referee Member No";Rec."Referee Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Referee Name";Rec."Referee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee ID No";Rec."Referee ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee Mobile Phone No";Rec."Referee Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(Dates)
            {
                field("Date Filter";Rec."Date Filter")
                {
                    ApplicationArea = Basic;
                }
                field("Next Action Date";Rec."Next Action Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next Action Date';
                }
                field("Last Date Attempted";Rec."Last Date Attempted")
                {
                    ApplicationArea = Basic;
                }
                field("Date of Last Interaction";Rec."Date of Last Interaction")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Opportunity details")
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Lost Reasons";Rec."Lost Reasons")
                {
                    ApplicationArea = Basic;
                }
                field("Company No.";Rec."Company No.")
                {
                    ApplicationArea = Basic;
                }
                field("Company Name";Rec."Company Name")
                {
                    ApplicationArea = Basic;
                }
                field("Job Title";Rec."Job Title")
                {
                    ApplicationArea = Basic;
                }
                field("ID No";Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Duration (Min.)";Rec."Duration (Min.)")
                {
                    ApplicationArea = Basic;
                }
                field("No. of Opportunities";Rec."No. of Opportunities")
                {
                    ApplicationArea = Basic;
                }
                field(status; Rec.status)
                {
                    ApplicationArea = Basic;
                }
                field("Lead Type";Rec."Lead Type")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Create Opportunity")
            {
                ApplicationArea = Basic;
                Caption = 'Create Customer Account';
                Image = ChangeTo;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Type = Rec.Type::Person then begin
                        MembApp.Init;
                        MembApp."No." :=Rec."No.";
                        MembApp."First Name" :=Rec."First Name";
                        MembApp."Middle Name" :=Rec."Middle Name";
                        MembApp."Last Name" := Rec.Surname;
                        MembApp.Name :=Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec.Surname;
                        MembApp.Address := Rec.Address;
                        MembApp."ID No." :=Rec."ID No";
                        MembApp."Customer Posting Group" := 'MEMBER';
                        MembApp."Customer Type" := MembApp."customer type"::Member;
                        MembApp.City := Rec.City;
                        MembApp."Recruited By" := UserId;
                        MembApp."Registration Date" := Today;
                        MembApp."Employment Info" :=Rec."Employment Info";
                        MembApp."Employer Code" :=Rec."Employer Code";
                        MembApp."Employer Name" :=Rec."Employer Name";
                        //    MembApp."Nature Of Business":="Nature Of Business";
                        MembApp."Business Name" :=Rec."Business Name";
                        MembApp."Physical Business Location" :=Rec."Physical Business Location";
                        MembApp."Terms of Employment" :=Rec."Terms of Employment";
                        MembApp."Referee Member No" :=Rec."Referee Member No";
                        MembApp."Referee Name" :=Rec."Referee Name";
                        MembApp."Referee Mobile Phone No" :=Rec."Referee Mobile Phone No";
                        MembApp."Referee ID No" :=Rec."Referee ID No";
                        MembApp.Insert(true);
                        Rec.Converted := true;

                        Rec.Modify;
                        Message('Opportunity Members Successfully Generated');

                    end;
                    if Rec.Type = Rec.Type::Company then begin
                        Employer.Init;
                        Employer.Code :=Rec."Company No.";
                        Employer.Description :=Rec."Company Name";
                        Employer."Join Date" := Today;
                        Employer.Insert(true);
                        Rec.Converted := true;
                        Rec.Modify;
                        Message('Opportunity Organizations Successfully Generated');
                    end;
                    // LOAN FORM
                end;
            }
            action("Meetings Schedule")
            {
                ApplicationArea = Basic;
                Image = FORM;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Meetings Schedule";
                RunPageLink ="Lead No" = field("No.");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Employment Info" =Rec."employment info"::Employed then begin
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;



        end else
            if Rec."Employment Info" =Rec."employment info"::Contracting then begin
                ContractingEditable := true;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
                PositionHeldEditable := false;
                EmploymentDateEditable := false;
                EmployerAddressEditable := false;
                NatureofBussEditable := false;
                IndustryEditable := false;
                BusinessNameEditable := false;
                PhysicalBussLocationEditable := false;
                YearOfCommenceEditable := false;
            end else
                if Rec."Employment Info" =Rec."employment info"::Others then begin
                    OthersEditable := true;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false;
                    PositionHeldEditable := false;
                    EmploymentDateEditable := false;
                    EmployerAddressEditable := false
                end else
                    if Rec."Employment Info" =Rec."employment info"::"Self-Employed" then begin
                        OccupationEditable := true;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false;
                        NatureofBussEditable := true;
                        IndustryEditable := true;
                        BusinessNameEditable := true;
                        PhysicalBussLocationEditable := true;
                        YearOfCommenceEditable := true;
                        PositionHeldEditable := false;
                        EmploymentDateEditable := false;
                        EmployerAddressEditable := false

                    end;
    end;

    trigger OnOpenPage()
    begin
        if Rec."Employment Info" =Rec."employment info"::Employed then begin
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false;
            PositionHeldEditable := true;
            EmploymentDateEditable := true;
            EmployerAddressEditable := true;
            NatureofBussEditable := false;
            IndustryEditable := false;
            BusinessNameEditable := false;
            PhysicalBussLocationEditable := false;
            YearOfCommenceEditable := false;



        end else
            if Rec."Employment Info" =Rec."employment info"::Contracting then begin
                ContractingEditable := true;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
                PositionHeldEditable := false;
                EmploymentDateEditable := false;
                EmployerAddressEditable := false;
                NatureofBussEditable := false;
                IndustryEditable := false;
                BusinessNameEditable := false;
                PhysicalBussLocationEditable := false;
                YearOfCommenceEditable := false;
            end else
                if Rec."Employment Info" =Rec."employment info"::Others then begin
                    OthersEditable := true;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false;
                    PositionHeldEditable := false;
                    EmploymentDateEditable := false;
                    EmployerAddressEditable := false
                end else
                    if Rec."Employment Info" =Rec."employment info"::"Self-Employed" then begin
                        OccupationEditable := true;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false;
                        NatureofBussEditable := true;
                        IndustryEditable := true;
                        BusinessNameEditable := true;
                        PhysicalBussLocationEditable := true;
                        YearOfCommenceEditable := true;
                        PositionHeldEditable := false;
                        EmploymentDateEditable := false;
                        EmployerAddressEditable := false

                    end;
    end;

    var
        CustCare: Record "General Equiries.";
        CQuery: Record "General Equiries.";
        Employer: Record "Sacco Employers";
        MembApp: Record "Membership Applications";
        LeadM: Record "Lead Management";
        Entry: Integer;
        Vend: Record Vendor;
        CASEM: Record "Cases Management";
        EmploymentInfoEditable: Boolean;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        NatureofBussEditable: Boolean;
        IndustryEditable: Boolean;
        BusinessNameEditable: Boolean;
        PhysicalBussLocationEditable: Boolean;
        YearOfCommenceEditable: Boolean;
        PositionHeldEditable: Boolean;
        EmploymentDateEditable: Boolean;
        EmployerAddressEditable: Boolean;
        EmployerCodeEditable: Boolean;
        DepartmentEditable: Boolean;
        TermsofEmploymentEditable: Boolean;
        OccupationEditable: Boolean;
        OthersEditable: Boolean;
        MonthlyIncomeEditable: Boolean;
}




