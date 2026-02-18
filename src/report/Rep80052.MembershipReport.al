report 80052 "Membership Report"
{
    ApplicationArea = All;
    Caption = 'Membership Report';
    UsageCategory = Documents;
    //DefaultRenderingLayout = LayoutName;
    DefaultLayout = Word;
    WordLayout = 'Layouts/MembershipApp.docx';
    //RDLCLayout = 'Layouts/MembershipApp.rdlc';
    dataset
    {
        dataitem(MembershipApplications; "Membership Applications")
        {
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(No; "No.")
            {
            }
            column(AccountCategory; "Account Category")
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(MiddleName; "Middle Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(FullName; Name) { }
            column(IDNo; "ID No.")
            {
            }
            column(Mobile_Phone_No; "Mobile Phone No") { }
            column(PayrollNo; "Payroll No")
            {
            }
            column(KRAPIN; "KRA PIN")
            {
            }
            column(DateofBirth; "Date of Birth")
            {
            }
            column(Gender; Gender)
            {
            }
            column(MaritalStatus; "Marital Status")
            {
            }
            column(PostalCode; "Postal Code")
            {
            }
            column(MonthlyContribution; "Monthly Contribution")
            {
            }
            column(BankAccountNo; "Bank Account No")
            {
            }
            column(BankBranchCode; "Bank Branch Code")
            {
            }
            column(BankBranchName; "Bank Branch Name")
            {
            }
            column(BankCode; "Bank Code")
            {
            }
            column(BankName; "Bank Name")
            {
            }
            column(EMailPersonal; "E-Mail (Personal)")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(EmployerName; "Employer Name")
            {
            }
            column(EmployerNo; "Employer No")
            {
            }
            column(Terms_Of_Service; "Terms Of Service")
            {

            }
            column(EmploymentLocation; EmploymentLocation) { }
            column(Date_of_Employment; "Date of Employment") { }
            column(Position_Held; "Position Held") { }
            column(Terms_of_Employment; "Terms of Employment") { }
            column(Physical_Business_Location; "Physical Business Location") { }
            column(Nature_Of_Business; "Nature Of Business") { }
            column(Others_Details; "Others Details") { }

            column(RecruiterName; "Recruiter Name")
            {
            }
            column(RefereeIDNo; "Referee ID No")
            {
            }
            column(RefereeMemberNo; "Referee Member No")
            {
            }
            column(RefereeMobilePhoneNo; "Referee Mobile Phone No")
            {
            }
            column(RefereeName; "Referee Name")
            {
            }
            column(Town; Town) { }
            column(City; City) { }
            column(County; County) { }
            column(County_Name; "County Name") { }
            column(District; District) { }
            column(Location; Location) { }
            column(Sub_County_Name; "Sub-County Name") { }

            column(Address_2; "Address 2") { }
            column(Picture;Picture)
            {

            }
            column(Signature;Signature)
            {

            }

            dataitem("Member App Nominee"; "Member App Nominee")
            {
                DataItemLink = "Account No" = field("No.");
                column(Account_No; "Account No") { }
                column(Name; Name) { }
                column(ID_No_; "ID No.") { }
                column(Address; Address) { }
                column(Telephone; Telephone) { }
                column(Date_of_Birth; "Date of Birth") { }
                column(Age; Age) { }
                column(Allocation; "%Allocation") { }
                column(Next_Of_Kin_Type; "Next Of Kin Type") { }
                

                column(Relationship; Relationship) { }
            }
            trigger OnAfterGetRecord()
            begin
                EmploymentLocation := '';
                Employemnt.Reset();
                Employemnt.SetRange("Employer Code", "Employer Code");
                if Employemnt.Find('-')
                then begin
                    EmploymentLocation := Employemnt."Employer Physical Location";
                end
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }


    trigger OnPreReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
        ;
    end;

    var
        Company: Record "Company Information";
        Employemnt: Record "Employers Register";
        EmploymentLocation: Text;
}

