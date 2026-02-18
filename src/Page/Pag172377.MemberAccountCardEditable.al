//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172377 "Member Account Card - Editable"
{
    Caption = 'Member Card';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Members Register";
    SourceTableView = sorting("Employer Code")
                      where("Customer Type" = const(Member));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Payroll No";Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("FOSA Account No.";Rec."FOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        FosaName := '';

                        if Rec."FOSA Account No." <> '' then begin
                            if Vend.Get(Rec."FOSA Account No.") then begin
                                FosaName := Vend.Name;
                            end;
                        end;
                    end;
                }
                field(FosaName; FosaName)
                {
                    ApplicationArea = Basic;
                    Caption = 'FOSA Account Name';
                    Editable = true;
                }
                field("Account Category";Rec."Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        lblIDVisible := true;
                        lblDOBVisible := true;
                        lblRegNoVisible := false;
                        lblRegDateVisible := false;
                        lblGenderVisible := true;
                        txtGenderVisible := true;
                        lblMaritalVisible := true;
                        txtMaritalVisible := true;
                        if Rec."Account Category" <> Rec."account category"::Individual then begin
                            lblIDVisible := false;
                            lblDOBVisible := false;
                            lblRegNoVisible := true;
                            lblRegDateVisible := true;
                            lblGenderVisible := false;
                            txtGenderVisible := false;
                            lblMaritalVisible := false;
                            txtMaritalVisible := false;

                        end;
                    end;
                }
                field("ID No.";Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID Number';
                    Editable = true;
                }
                field("Passport No.";Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Post Code";Rec."Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code/City';
                    Editable = true;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field("StatusPermissions.""User ID"""; StatusPermissions."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Mobile Phone No";Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.";Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = true;
                }
                field("Employer Code";Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer';
                    Editable = true;
                }
                field("E-Mail (Personal)";Rec."E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                }
                field("Pension No";Rec."Pension No")
                {
                    ApplicationArea = Basic;
                }
                field("Job Title";Rec."Job title")
                {
                    ApplicationArea = Basic;
                    Caption = 'Job Title';
                    Editable = true;
                }
                field(PIN; Rec.Pin)
                {
                    ApplicationArea = Basic;
                    Caption = 'PIN';
                    Editable = true;
                }
                field("Registration Date";Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(txtMarital; Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Visible = txtMaritalVisible;
                }
                field("Date of Birth";Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Company Registration Date';
                    Editable = true;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Posting Group";Rec."Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::Edit);
                        if StatusPermissions.Find('-') = false then
                            Error('You do not have permissions to change the account status.');
                    end;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified";Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assigned System ID";Rec."Assigned System ID")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Joint2Details)
            {
                Caption = 'Joint2Details';
                field("Name 2";Rec."Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                }
                field(Address3; Rec.Address3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                }
                field("Postal Code 2";Rec."Postal Code 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 2";Rec."Town 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Mobile No. Three";Rec."Mobile No. Three")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth2";Rec."Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                }
                field("ID No.2";Rec."ID No.2")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 2";Rec."Passport 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 2";Rec."Member Parish 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    ShowMandatory = true;
                }
                field("Member Parish Name 2";Rec."Member Parish Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                }
                field(Gender2; Rec.Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status2";Rec."Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code2";Rec."Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town2";Rec."Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code2";Rec."Employer Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name2";Rec."Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal2)";Rec."E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail (Personal)';
                }
                field("Picture 2";Rec."Picture 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                }
                field("Signature  2";Rec."Signature  2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                }
            }
            group(Joint3Details)
            {
                field("Name 3";Rec."Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                }
                field(Address4; Rec.Address4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                }
                field("Postal Code 3";Rec."Postal Code 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 3";Rec."Town 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. 4";Rec."Mobile No. 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth3";Rec."Date of Birth3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    ShowMandatory = true;
                }
                field("ID No.3";Rec."ID No.3")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 3";Rec."Passport 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 3";Rec."Member Parish 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Member Parish Name 3";Rec."Member Parish Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                    Editable = false;
                }
                field(Gender3; Rec.Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status3";Rec."Marital Status3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code3";Rec."Home Postal Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town3";Rec."Home Town3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code3";Rec."Employer Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name3";Rec."Employer Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal3)";Rec."E-Mail (Personal3)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Picture 3";Rec."Picture 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                }
                field("Signature  3";Rec."Signature  3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                }
            }
            group("Other Details")
            {
                Caption = 'Other Details';
                Editable = true;
                field("Contact Person";Rec."Contact Person")
                {
                    ApplicationArea = Basic;
                }
                field("Contact Person Phone";Rec."Contact Person Phone")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail";Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Village/Residence";Rec."Village/Residence")
                {
                    ApplicationArea = Basic;
                }
                field("Home Page";Rec."Home Page")
                {
                    ApplicationArea = Basic;
                }
                field("Address 2";Rec."Address 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Physical Address';
                }
                field("Withdrawal Application Date";Rec."Withdrawal Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Date";Rec."Withdrawal Date")
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Fee";Rec."Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                }
                field("Status - Withdrawal App.";Rec."Status - Withdrawal App.")
                {
                    ApplicationArea = Basic;
                }
                field("Mode of Dividend Payment";Rec."Mode of Dividend Payment")
                {
                    ApplicationArea = Basic;
                }
                field("Recruited By";Rec."Recruited By")
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
            group("&Member")
            {
                Caption = '&Member';
                action("Member Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Ledger Entries';
                    Image = CustomerLedger;
                    RunObject = Page "Member Ledger Entries";
                    RunPageLink = "Customer No." = field("No.");
                    RunPageView = sorting("Customer No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                }
                action("Bank Account")
                {
                    ApplicationArea = Basic;
                    Image = Card;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = field("No.");
                }
                action(Contacts)
                {
                    ApplicationArea = Basic;
                    Image = ContactPerson;

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
            }
            group(ActionGroup22)
            {
                action("Members Kin Details List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Members Kin Details List';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Members Nominee Details List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories Details';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Account Signatory list";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("No.");
                }
                group(ActionGroup18)
                {
                }
                action("Detailed Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(172363, true, false, Cust);
                    end;
                }
                action("Detailed Interest Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Interest Statement';
                    Image = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(172151, true, false, Cust);
                    end;
                }
                action("Account Closure Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(172390, true, false, Cust);
                    end;
                }
                action("Recover Loans from Gurantors")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recover Loans from Gurantors';
                    Image = "Report";

                    trigger OnAction()
                    begin
                        
                    end;
                }
                action("Recover Loans from Deposit")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recover Loans from Deposit';

                    trigger OnAction()
                    begin
                        
                    end;
                }
                action("FOSA Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        /*Vend.RESET;
                        Vend.SETRANGE(Vend."BOSA Account No","No.");
                        IF Vend.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Vend);
                        */

                    end;
                }
                action("Member is  a Guarantor")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member is  a Guarantor';
                    Image = "Report";

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(172032, true, false, Cust);
                    end;
                }
                action("Member is  Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member is  Guaranteed';
                    Image = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(172035, true, false, Cust);
                    end;
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    Visible = false;
                }
                action("Dispatch Physical File")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*

                       IF Status <> Status::Active THEN
                       ERROR('you cannot dispatch an inactive file, kindly contact the administrator');

                       IF "File Movement Remarks"='' THEN

                       "File Movement Remarks":=FORMAT("File Movement Remarks1");
                       //TESTFIELD("File Movement Remarks");
                       User:=USERID;
                       TESTFIELD(User);
                       //TESTFIELD("Folio Number");
                       Cust.RESET;
                       Cust.SETRANGE(Cust."No.","No.");
                       IF Cust.FIND('-') THEN BEGIN
                       IF "Bank Code"='' THEN BEGIN
                       //Cust."Current file location":='REGISTRY';
                       //"Bank Code":='REGISTRY';
                       MODIFY;


                       END;
                       IF (Cust."File MVT Time"<>0T) AND (Cust."file Received"<>TRUE) THEN
                       ERROR('Please inform this user to receive this file before use %1',Cust.User);

                       IF Cust."Current file location"='' THEN
                       Cust."Current file location":='REGISTRY';
                       //IF "File Received by"<>USERID THEN ERROR('You do not have permissions to MOVE the file.');

                         ApprovalUsers.RESET;
                         ApprovalUsers.SETRANGE(ApprovalUsers."User ID",USERID);
                         IF ApprovalUsers.FIND('-') THEN BEGIN
                         REPEAT
                          //IF ApprovalUsers."User ID"<>"File Received by" THEN
                          //ERROR('You do not have permissions to MOVE the file.');
                         IF CONFIRM('Are You sure you want to move the phisical file to the selected location?')=FALSE THEN
                          EXIT;


                       {MOVESTATUS.RESET;
                       MOVESTATUS.SETRANGE(MOVESTATUS."User ID",USERID);
                       IF MOVESTATUS.FIND('-') THEN BEGIN
                       REPEAT
                       IF MOVESTATUS."User ID"<>"File Received by" THEN
                       ERROR('You do not have permissions to MOVE the file.');
                       IF CONFIRM('Are You sure you want to move the phisical file to the selected location?')=FALSE THEN
                       EXIT;}
                         {
                       FileMovementTracker.RESET;
                       FileMovementTracker.SETRANGE(FileMovementTracker."Member No.","No.");
                       IF FileMovementTracker.FIND('+') THEN BEGIN
                       IF FileMovementTracker.Stage = "Move to" THEN
                       ERROR('File already in %1',FileMovementTracker.Station);
                        }
                       "File MVT User ID":=USERID;
                       User:=USERID;
                       "File MVT Time":=TIME;
                       "File MVT Date":=TODAY;
                       "File Previous Location":=FORMAT(Filelocc);
                       "Current file location":=Cust."Move to description";
                       "file Received":=FALSE;
                       "File Received by":='';
                       "file received date":=0D;
                       "File received Time":=0T;
                       MODIFY;
                       //"Current file location":="Move to";
                       //MODIFY;


                       ApprovalsSetup.RESET;
                       ApprovalsSetup.SETRANGE(ApprovalsSetup."Approval Type",ApprovalsSetup."Approval Type"::"File Movement");
                       ApprovalsSetup.SETRANGE(ApprovalsSetup.Stage,Cust."Move to");
                       IF ApprovalsSetup.FIND('-') THEN BEGIN





                       FileMovementTracker.RESET;
                       IF FileMovementTracker.FIND('+') THEN BEGIN
                       FileMovementTracker."Current Location":=FALSE;
                       EntryNo:=FileMovementTracker."Entry No.";
                       END;
                       FileMovementTracker.INIT;
                       FileMovementTracker."Entry No.":=EntryNo+1;
                       FileMovementTracker."Member No.":="No.";
                       FileMovementTracker."Approval Type":=ApprovalsSetup."Approval Type";
                       FileMovementTracker.Stage:=ApprovalsSetup.Stage;
                       FileMovementTracker."Current Location":=TRUE;
                       FileMovementTracker.Description:=ApprovalsSetup.Description;
                       FileMovementTracker.Station:=ApprovalsSetup.Station;
                       FileMovementTracker."Date/Time In":=CREATEDATETIME(TODAY,TIME);
                       //FileMovementTracker."Date/Time Out":= CREATEDATETIME(TODAY,TIME);
                       FileMovementTracker."USER ID":=USERID;
                       FileMovementTracker.Remarks:=Cust."File Movement Remarks";
                       FileMovementTracker.INSERT(TRUE);

                       //END;
                       END;

                       UNTIL ApprovalUsers.NEXT=0;
                       END;
                       END;

                       {

                                      Cust."File MVT User ID":=USERID;
                                      Cust."File MVT Time":=TIME;
                                      Cust."File MVT Date":=TODAY;
                                      Cust."File Previous Location":=Cust."Current file location";
                                      Cust."Current file location":=Cust."Move to description";
                                      Cust.MODIFY;
                       MESSAGE('done');



                        MOVESTATUS.RESET;
                         MOVESTATUS.SETRANGE(MOVESTATUS."User ID",USERID);
                          //MOVESTATUS.SETRANGE(MOVESTATUS.Description,"Current file location");
                         IF MOVESTATUS.FIND('-') THEN  BEGIN
                         REPEAT
                        //IF MOVESTATUS.Description<>"Current file location" THEN
                         //ERROR('You do not have permissions to MOVE the file.');



                       IF CONFIRM('Are you sure you want to move the physical file to the selected location?') = FALSE THEN
                       EXIT;



                       FileMovementTracker.RESET;
                       FileMovementTracker.SETRANGE(FileMovementTracker."Member No.","No.");
                       IF FileMovementTracker.FIND('+') THEN BEGIN
                       IF FileMovementTracker.Stage = "Move to" THEN
                       ERROR('File already in %1',FileMovementTracker.Station);
                       END;


                       "File MVT User ID":=USERID;
                       "File MVT Date":=TODAY;
                       "File MVT Time":=TIME;
                       "File Previous Location":="Current file location";
                       "file Received":=FALSE;
                       "file received date":=0D;
                       "File received Time":=0T;
                       "File Received by":='';
                       MODIFY;


                       ApprovalsSetup.RESET;
                       ApprovalsSetup.SETRANGE(ApprovalsSetup."Approval Type",ApprovalsSetup."Approval Type"::"File Movement");
                       ApprovalsSetup.SETRANGE(ApprovalsSetup.Stage,"Move to");
                       IF ApprovalsSetup.FIND('-') THEN BEGIN
                       FileMovementTracker.RESET;
                       IF FileMovementTracker.FIND('+') THEN
                       EntryNo:=FileMovementTracker."Entry No.";


                       FileMovementTracker.INIT;
                       FileMovementTracker."Entry No.":=EntryNo+1;
                       FileMovementTracker."Member No.":="No.";
                       FileMovementTracker."Approval Type":=ApprovalsSetup."Approval Type";
                       FileMovementTracker.Stage:=ApprovalsSetup.Stage;
                       FileMovementTracker."Current Location":=TRUE;
                       FileMovementTracker.Description:=ApprovalsSetup.Description;
                       FileMovementTracker.Station:=ApprovalsSetup.Station;
                       FileMovementTracker."Date/Time In":=CREATEDATETIME(TODAY,TIME);
                       FileMovementTracker."Date/Time Out":=CREATEDATETIME(TODAY,TIME);
                       FileMovementTracker."USER ID":=USERID;
                       FileMovementTracker.Remarks2:="File Movement Remarks";
                       FileMovementTracker.INSERT(TRUE);

                       //END;
                       END ELSE
                         ERROR('SORRY YOU ARE NOT AUTHORISED TO MOVE THIS FILE');

                       UNTIL MOVESTATUS.NEXT=0;
                                END;

                       }
                        */

                    end;
                }
                action("Receive Physical File")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        IF Status <> Status::Active THEN
                        ERROR('You cannot receive an inactive file, kindly contact the administrator');
                        
                        
                          Approvals.RESET;
                          Approvals.SETRANGE(Approvals.Stage,"Move to");
                          IF Approvals.FIND('-') THEN BEGIN
                         Description:=Approvals.Description;
                         station:=Approvals.Station;
                        
                          END;
                        
                          ApprovalUsers.RESET;
                          ApprovalUsers.SETRANGE(ApprovalUsers."User ID",USERID);
                        
                          IF NOT ApprovalUsers.FIND('-') THEN BEGIN
                          REPEAT
                         IF ApprovalUsers."User ID" <> USERID THEN
                         ERROR ('You do not have permission to receive a file');
                        
                         UNTIL ApprovalUsers.NEXT=0;
                          END;
                        
                        
                          ApprovalUsers.RESET;
                          ApprovalUsers.SETRANGE(ApprovalUsers."User ID",USERID);
                          ApprovalUsers.SETRANGE(ApprovalUsers."Approval Type",ApprovalUsers."Approval Type"::"File Movement");
                          IF ApprovalUsers.FIND('-') THEN BEGIN
                        
                          REPEAT
                        
                          IF ApprovalUsers.Stage<>"Move to" THEN
                         ERROR('You do not have permissions to Receive this file.');
                        FileMovementTracker.RESET;
                        
                        IF FileMovementTracker.FIND('+') THEN BEGIN
                        FileMovementTracker."Current Location":=FALSE;
                        EntryNo:=FileMovementTracker."Entry No.";
                        END;
                        FileMovementTracker.INIT;
                        FileMovementTracker."Entry No.":=EntryNo+1;
                        FileMovementTracker."Member No.":="No.";
                        //FileMovementTracker."Approval Type":=ApprovalsSetup."Approval Type";
                        FileMovementTracker."Approval Type":=ApprovalUsers."Approval Type";
                        FileMovementTracker.Stage:=ApprovalUsers.Stage;
                        FileMovementTracker."Current Location":=TRUE;
                        FileMovementTracker.Description:=Description;
                        FileMovementTracker.Station:=station;
                        FileMovementTracker."Date/Time In":=CREATEDATETIME(TODAY,TIME);
                        FileMovementTracker."USER ID":=USERID;
                        FileMovementTracker.Remarks:=Cust."File Movement Remarks";
                        FileMovementTracker.INSERT(TRUE);
                        
                        
                        
                         {MOVESTATUS.RESET;
                          MOVESTATUS.SETRANGE(MOVESTATUS."User ID",USERID);
                           //MOVESTATUS.SETRANGE(MOVESTATUS.Description,"Current file location");
                          IF MOVESTATUS.FIND('-') THEN  BEGIN
                          REPEAT
                          IF MOVESTATUS.Description<>"Current file location" THEN
                          //ERROR('You do not have permissions to Receive this file.');
                        
                        
                        MESSAGE('THE FILE HAS BEEN SUCCESSFULLY RECEIVED');
                        UNTIL MOVESTATUS.NEXT=0;
                        END;
                        }
                        
                        
                        IF ("file Received"=TRUE) THEN
                        ERROR('THE FILE HAS  BEEN RECIEVED')
                        ELSE
                        IF CONFIRM('HAVE YOU RECEIVED THE PHISICAL FILE',FALSE)=FALSE THEN
                        EXIT;
                        IF "file Received"=TRUE THEN
                        ERROR('THE FILE HAS  BEEN RECIEVED')
                        ELSE
                        "file Received":=TRUE;
                        "File Received by":=USERID;
                        "file received date":=TODAY;
                        "File received Time":=TIME;
                        "file Received":=TRUE;
                        MODIFY;
                        MODIFY;
                         UNTIL ApprovalUsers.NEXT=0;
                          END;
                         */

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        FosaName := '';

        if Rec."FOSA Account No." <> '' then begin
            if Vend.Get(Rec."FOSA Account No.") then begin
                FosaName := Vend.Name;
            end;
        end;

        lblIDVisible := true;
        lblDOBVisible := true;
        lblRegNoVisible := false;
        lblRegDateVisible := false;
        lblGenderVisible := true;
        txtGenderVisible := true;
        lblMaritalVisible := true;
        txtMaritalVisible := true;

        if Rec."Account Category" <> Rec."account category"::Individual then begin
            lblIDVisible := false;
            lblDOBVisible := false;
            lblRegNoVisible := true;
            lblRegDateVisible := true;
            lblGenderVisible := false;
            txtGenderVisible := false;
            lblMaritalVisible := false;
            txtMaritalVisible := false;

        end;
        OnAfterGetCurrRecords;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Rec.Find(Which);
        CurrPage.Editable := RecordFound or (Rec.GetFilter("No.") = '');
        exit(RecordFound);
    end;

    trigger OnInit()
    begin
        txtMaritalVisible := true;
        lblMaritalVisible := true;
        txtGenderVisible := true;
        lblGenderVisible := true;
        lblRegDateVisible := true;
        lblRegNoVisible := true;
        lblDOBVisible := true;
        lblIDVisible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Customer Type" := Rec."customer type"::Member;
        Rec.Status := Rec.Status::Active;
        Rec."Customer Posting Group" := 'BOSA';
        Rec."Registration Date" := Today;
        Rec.Advice := true;
        Rec."Advice Type" := Rec."advice type"::"New Member";
        if GeneralSetup.Get(0) then begin
            Rec."Welfare Contribution" := GeneralSetup."Welfare Contribution";
            Rec."Registration Fee" := GeneralSetup."Registration Fee";

        end;
        OnAfterGetCurrRecords();
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin
        ActivateFields;
        /*
        IF NOT MapMgt.TestSetup THEN
          CurrForm.MapPoint.VISIBLE(FALSE);
        */


        /*StatusPermissions.RESET;
        StatusPermissions.SETRANGE(StatusPermissions."User ID",USERID);
        StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::Edit);
        IF StatusPermissions.FIND('-') = FALSE THEN
        ERROR('You do not have permissions to edit member information.');*/

    end;

    var
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        PictureExists: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        Vend: Record Vendor;
        Cust: Record "Members Register";
        LineNo: Integer;
        UsersID: Record User;
        GeneralSetup: Record "Sacco General Set-Up";
        Loans: Record "Loans Register";
        AvailableShares: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        TotalRecovered: Decimal;
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        LoansR: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        Accounts: Record Vendor;
        FosaName: Text[50];
        
        lblIDVisible: Boolean;
        
        lblDOBVisible: Boolean;
        
        lblRegNoVisible: Boolean;
        
        lblRegDateVisible: Boolean;
        
        lblGenderVisible: Boolean;
        
        txtGenderVisible: Boolean;
        
        lblMaritalVisible: Boolean;
        
        txtMaritalVisible: Boolean;
        AccNo: Code[20];
        Vendor: Record Vendor;
        TotalAvailable: Decimal;
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        TotalDefaulterR: Decimal;
        value2: Decimal;
        Value1: Decimal;
        RoundingDiff: Decimal;
        Statuschange: Record "Status Change Permision";
        "WITHDRAWAL FEE": Decimal;
        "AMOUNTTO BE RECOVERED": Decimal;
        "Remaining Amount": Decimal;
        TotalInsuarance: Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        FileMovementTracker: Record "File Movement Tracker";
        EntryNo: Integer;
        ApprovalsSetup: Record "Approvals Set Up";
        MovementTracker: Record "Movement Tracker";
        ApprovalUsers: Record "Approvals Users Set Up";
        "Change Log": Integer;
        openf: File;
        FMTRACK: Record "File Movement Tracker";
        CurrLocation: Code[30];
        "Number of days": Integer;
        Approvals: Record "Approvals Set Up";
        Description: Text[30];
        Section: Code[10];
        station: Code[10];
        Joint2DetailsVisible: Boolean;
        Joint3DetailsVisible: Boolean;


    procedure ActivateFields()
    begin
    end;

    local procedure OnAfterGetCurrRecords()
    begin
        xRec := Rec;
        ActivateFields;
    end;
}




