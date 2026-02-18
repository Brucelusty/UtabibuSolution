//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 50011 "Members List"
{
    Caption = 'Member List';
    CardPageID = "Member Account Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Member Reports';
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Customer;
    SourceTableView = order(ascending) where(ISNormalMember = filter(true), "Account Category" = filter(Individual));

    layout
    {
        area(content)
        {
            repeater(Control1)
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
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = Basic;
                }

                field("Mobile Phone No"; Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }

                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {

                }

                // field("Group No"; Rec."Group No")
                // {
                //     ApplicationArea = basic;

                // }
                field("E-Mail (Personal)"; Rec."E-Mail (Personal)")
                {
                    ApplicationArea = basic;
                    Caption = 'E-Mail';
                }
                field(BlackListed; Rec.BlackListed)
                {
                    ApplicationArea = basic;
                    Caption = 'Utapesa Defaulter';
                    Editable = true;

                }
                field("Data Protection"; Rec."Data Protection")
                {
                    ApplicationArea = basic;


                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    StyleExpr = StatusSyle;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    StyleExpr = StatusSyle;
                }
                field(Pin;Rec.Pin)
                {
                    ApplicationArea = basic;
                    Caption='Kra Pin';


                }
                
                
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = basic;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = basic;
                }

                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                    Editable = false;
                }
                field("Registration Fee Paid"; Rec."Registration Fee Paid")
                {
                    ApplicationArea = Basic;
                }
                field("Current Shares"; Rec."Current Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Disbursment Account"; Rec."Disbursment Account")
                {
                    ApplicationArea = Basic;
                }
                field("Referee Member No"; Rec."Referee Member No")
                {
                    ApplicationArea = basic;

                }
                field("Referee Name"; Rec."Referee Name")
                {
                    ApplicationArea = basic;

                }

                field("Member Last Transaction Date"; Rec."Member Last Transaction Date")
                {
                    ApplicationArea = basic;
                    Caption = 'Dormancy Base Date';
                }

            }
        }
        area(factboxes)
        {
            part(Control14; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
            part(Control13; "Member Picture-Uploaded")
            {
                Caption = 'Picture';
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
            part(Control12; "Member Signature-Uploaded")
            {
                Caption = 'Signature';
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Process)
            {
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                    Visible = false;
                }
                action("Bank Account")
                {
                    ApplicationArea = Basic;
                    Image = BankAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = field("No.");
                    Visible = false;
                }
                action(Contacts)
                {
                    ApplicationArea = Basic;
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.ShowContact;
                    end;
                }
                action("Member Accounts")
                {
                    ApplicationArea = Basic;
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Accounts List";
                    RunPageLink = "BOSA Account No" = field("No.");
                }
                action("CRB Query Charge")
                {
                    ApplicationArea = Basic;
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "CRB Check Charge List";
                    RunPageLink = "Member No" = field("No.");
                    Visible = false;
                }
            }
            group("Issued Documents")
            {
                Caption = 'Issued Documents';
                Visible = false;
                action("Loans Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guarantors';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin

                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.", Rec."No.");
                        IF Cust.FIND('-') THEN
                            //REPORT.RUN(,TRUE,FALSE,Cust);

                            Message('home');
                    end;
                }
                action("Loans Guarantors")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Cust);
                        */
                        LGurantors.Reset;
                        LGurantors.SetRange(LGurantors."Loan No", Rec."No.");
                        if LGurantors.Find('-') then begin
                            Report.Run(172504, true, false, Cust);
                        end;

                    end;
                }
            }
            group(ActionGroup1102755013)
            {
                action("Members Kin Details List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Members Kin Details List';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Nominee Details List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Details';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("No.");

                    trigger OnAction()
                    begin
                        //SFactory."FnRunGetMembersLoanDue&ArrearsAmount"("No.");
                    end;
                }
                action("Members Guaranteed")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Loans Guarantee Details";
                    RunPageLink = Name = field(Name);
                    RunPageMode = View;

                    trigger OnAction()
                    begin
                        LGurantors.Reset;
                        LGurantors.SetRange(LGurantors."Loan No", Rec."No.");
                        if LGurantors.Find('-') then begin
                            Report.Run(172504, true, false, Cust);
                        end;
                    end;
                }
                separator(Action1102755008)
                {
                }
            }
            group(ActionGroup1102755007)
            {
                action("Member Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        if (Rec."Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                            if UserSetup.Get(UserId) then begin
                                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                            end;

                        end;
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(80007, true, false, Cust);
                    end;
                }
                action("Loan Statement")
                {
                    ApplicationArea = Basic;
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.Run(80027, true, false, Cust);

                    end;
                }
                action("Account Closure Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(80008, true, false, Cust);
                    end;
                }
                action("Group Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'House Group Statement  Internal';
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ObjCellGroups.Reset;
                        ObjCellGroups.SetRange(ObjCellGroups."Cell Group Code", Rec."Member House Group");
                        if ObjCellGroups.Find('-') then
                            Report.run(172920, true, false, ObjCellGroups);
                    end;
                }
                action(HouseGroupStatement)
                {
                    ApplicationArea = Basic;
                    Caption = 'House Group Statement';
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        ObjCellGroups.Reset;
                        ObjCellGroups.SetRange(ObjCellGroups."Cell Group Code", Rec."Member House Group");
                        if ObjCellGroups.Find('-') then
                            Report.run(172946, true, false, ObjCellGroups);
                    end;
                }
                action("Send Member Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Detailed Statement';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."No.");
                        if Cust.Find('-') then
                            Report.run(172073, true, false, Cust);
                    end;
                }
                action(ImportMultipleCustomerPictures)
                {
                    Caption = 'Import Multiple Customer Pictures';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;
                    ToolTip = 'Import Multiple Customer Pictures';

                    trigger OnAction()
                    begin
                        ImportMultipleCustomerPicturesFromZip();
                    end;
                }

                action(ImportMultipleCustomerSignatures)
                {
                    Caption = 'Import Multiple Customer Signatures';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;
                    ToolTip = 'Import Multiple Customer Signatures';

                    trigger OnAction()
                    begin
                        ImportMultipleCustomerSignaturesFromZip();
                    end;
                }

                action("MemberList")
                {
                    Caption = 'Member List';
                    ApplicationArea = basic;
                    Promoted = true;
                    image = Report;
                    PromotedCategory = Category4;
                    RunObject = report "Member List Report";//"Member List Report"
                }
                action("Member Application List")
                {
                    Caption = 'Member Application List';
                    ApplicationArea = basic;
                    image = Report;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = report "Members Applications List";
                }
                action("Share Capital Balances")
                {
                    Caption = 'Share Capital Balances';
                    ApplicationArea = basic;
                    Promoted = true;
                    image = Report;
                    PromotedCategory = Category4;
                    RunObject = report "Share Capital Balances Report.";
                }
                action("Disbursement Account")
                {
                    Caption = 'Disbursement Account Report ';
                    ApplicationArea = basic;
                    Promoted = true;
                    image = Report;
                    PromotedCategory = Category4;
                    RunObject = report "Disbursement  Acc.Report";
                }
                action("Benevolent Fund")
                {
                    Caption = 'Benevolent Fund';
                    ApplicationArea = basic;
                    Promoted = true;
                    image = Report;
                    PromotedCategory = Category4;
                    RunObject = report "Benovelent Report ";
                }
                action("Member Deposits Balances")
                {
                    Caption = 'Member Deposit Balances';
                    ApplicationArea = basic;
                    Promoted = true;
                    image = Report;
                    PromotedCategory = Category4;
                    RunObject = report "Member Deposit Balances Repor.";//"Member List Report"
                }
                action("Member Referee")
                {
                    Caption = 'Member Referee Report';
                    ApplicationArea = basic;
                    Promoted = true;
                    image = Report;
                    PromotedCategory = Category4;
                    RunObject = report "Member Referee Report";//"Member List Report"
                }
                action("Member Group Reports")
                {
                    Caption = 'Member Deposits Per Group';
                    ApplicationArea = basic;
                    Promoted = true;
                    image = Report;
                    PromotedCategory = Category4;
                    RunObject = report "Member Deposits Per Group";//"Member List Report"50037
                }
                action("Interest On Programmed Deposits")
                {
                    Caption = 'Interest On Programmed Deposits';
                    ApplicationArea = basic;
                    Promoted = true;
                    image = Report;
                    PromotedCategory = Category4;
                    RunObject = report "Interest On PD"; //"Member List Report"50037
                }
                action("Member dividends Reports")
                {
                    Caption = 'Member dividends Reports';
                    ApplicationArea = basic;
                    Promoted = true;
                    image = Report;
                    PromotedCategory = Category4;
                    RunObject = report "Member Dividends Report";
                }
                action("Members Without Passports")
                {
                    Caption = 'Members Without Passports';
                    ApplicationArea = basic;
                    Promoted = true;
                    image = Report;
                    PromotedCategory = Category4;
                    RunObject = report "Members Without Passports";
                }

                action("Members Without Signature")
                {
                    Caption = 'Members Without Signature';
                    ApplicationArea = basic;
                    Promoted = true;
                    image = Report;
                    PromotedCategory = Category4;
                    RunObject = report "Members Without Signature";
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.Status = Rec.Status::"Awaiting Exit" then begin
            StatusSyle := 'Unfavorable'
        end else
            if Rec.Status = Rec.Status::Active then begin
                StatusSyle := 'Favorable'
            end else
                if Rec.Status = Rec.Status::Dormant then begin
                    StatusSyle := 'Favorable'
                end
                else
                    if Rec.Status = Rec.Status::Deceased then begin
                        StatusSyle := 'Unfavorable'
                    end;
        // if Rec."Special Accounts" then begin
        //     if UserSetup.Get(UserId) then begin
        //         if not UserSetup."View Special Accounts" then
        //             Error('You do not have permission to view Insider member accounts. Contact your system administrator.');
        //     end else
        //         Error('User setup record not found. Contact your system administrator.');
        // end;

        //MemberLiability:=SFactory.FnGetMemberLiability("No.");
    end;

    trigger OnOpenPage()
    begin

        // if UserSetup.Get(UserId) then begin
        //     if not UserSetup."View Special Accounts" then begin

        //         //  Rec.SetFilter("Assigned System ID", UserId);

        //         Rec.SetFilter("Special Accounts", '=%1', false);
        //     end;
        // end else begin
        //     //Rec.SetFilter("Assigned System ID", UserId);
        //     Rec.SetFilter("Special Accounts", '=%1', false);
        // end;
    end;

    var
        Cust: Record Customer;
        GeneralSetup: Record "Sacco General Set-Up";
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        TotalAvailable: Integer;
        Loans: Record "Loans Register";
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        StatusSyle: Text[200];
        TotalDefaulterR: Decimal;
        Value2: Decimal;
        AvailableShares: Decimal;
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        RoundingDiff: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        UserSetup: Record "User Setup";
        MemberLiability: Decimal;
        SFactory: Codeunit "Au Factory";
        ObjCellGroups: Record "Member House Groups";

    local procedure ImportMultipleCustomerPicturesFromZip()
    var
        FileMgt: Codeunit "File Management";
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        EntryList: List of [Text];
        EntryListKey: Text;
        ZipFileName: Text;
        FileName: Text;
        FileExtension: Text;
        InStream: InStream;
        EntryOutStream: OutStream;
        EntryInStream: InStream;
        Length: Integer;
        SelectZIPFileMsg: Label 'Select ZIP File';
        FileCount: Integer;
        Cust: Record Customer;

        //DocAttach: Record "Document Attachment";
        NoCustError: Label 'Customer %1 does not exist.';
        ImportedMsg: Label '%1 pictures imported successfully.';
    begin
        //Upload zip file
        if not UploadIntoStream(SelectZIPFileMsg, '', 'Zip Files|*.zip', ZipFileName, InStream) then
            Error('');

        //Extract zip file and store files to list type
        DataCompression.OpenZipArchive(InStream, false);
        DataCompression.GetEntryList(EntryList);

        FileCount := 0;

        //Loop files from the list type
        foreach EntryListKey in EntryList do begin
            FileName := CopyStr(FileMgt.GetFileNameWithoutExtension(EntryListKey), 1, MaxStrLen(FileName));
            FileExtension := CopyStr(FileMgt.GetExtension(EntryListKey), 1, MaxStrLen(FileExtension));
            TempBlob.CreateOutStream(EntryOutStream);
            DataCompression.ExtractEntry(EntryListKey, EntryOutStream, Length);
            TempBlob.CreateInStream(EntryInStream);

            //Import each file where you want
            //if not Cust.Find('=') then
            //  Error(NoCustError, FileName);
            Cust.SETRANGE(Cust."No.", FileName);
            IF Cust.FINDSET THEN BEGIN
                Clear(Cust.Piccture);
                Cust.Piccture.ImportStream(EntryInStream, FileName);
                Cust.Modify(true);
                FileCount += 1;
            END;

        end;

        //Close the zip file
        DataCompression.CloseZipArchive();

        if FileCount > 0 then
            Message(ImportedMsg, FileCount);
    end;



    local procedure ImportMultipleCustomerSignaturesFromZip()
    var
        FileMgt: Codeunit "File Management";
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        EntryList: List of [Text];
        EntryListKey: Text;
        ZipFileName: Text;
        FileName: Text;
        FileExtension: Text;
        InStream: InStream;
        EntryOutStream: OutStream;
        EntryInStream: InStream;
        Length: Integer;
        SelectZIPFileMsg: Label 'Select ZIP File';
        FileCount: Integer;
        Cust: Record Customer;

        //DocAttach: Record "Document Attachment";
        NoCustError: Label 'Customer %1 does not exist.';
        ImportedMsg: Label '%1 signatures imported successfully.';
    begin
        //Upload zip file
        if not UploadIntoStream(SelectZIPFileMsg, '', 'Zip Files|*.zip', ZipFileName, InStream) then
            Error('');

        //Extract zip file and store files to list type
        DataCompression.OpenZipArchive(InStream, false);
        DataCompression.GetEntryList(EntryList);

        FileCount := 0;

        //Loop files from the list type
        foreach EntryListKey in EntryList do begin
            FileName := CopyStr(FileMgt.GetFileNameWithoutExtension(EntryListKey), 1, MaxStrLen(FileName));
            FileExtension := CopyStr(FileMgt.GetExtension(EntryListKey), 1, MaxStrLen(FileExtension));
            TempBlob.CreateOutStream(EntryOutStream);
            DataCompression.ExtractEntry(EntryListKey, EntryOutStream, Length);
            TempBlob.CreateInStream(EntryInStream);


            Cust.SETRANGE(Cust."No.", FileName);
            IF Cust.FINDSET THEN BEGIN
                Clear(Cust.Signature);
                Cust.Signature.ImportStream(EntryInStream, FileName);
                Cust.Modify(true);
                FileCount += 1;
            END;

        end;

        //Close the zip file
        DataCompression.CloseZipArchive();

        if FileCount > 0 then
            Message(ImportedMsg, FileCount);
    end;

    procedure GetSelectionFilter(): Code[80]
    var
        Cust: Record Customer;
        FirstCust: Code[30];
        LastCust: Code[30];
        SelectionFilter: Code[250];
        CustCount: Integer;
        More: Boolean;
    begin
        /*CurrPage.SETSELECTIONFILTER(Cust);
        CustCount := Cust.COUNT;
        IF CustCount > 0 THEN BEGIN
          Cust.FIND('-');
          WHILE CustCount > 0 DO BEGIN
            CustCount := CustCount - 1;
            Cust.MARKEDONLY(FALSE);
            FirstCust := Cust."No.";
            LastCust := FirstCust;
            More := (CustCount > 0);
            WHILE More DO
              IF Cust.NEXT = 0 THEN
                More := FALSE
              ELSE
                IF NOT Cust.MARK THEN
                  More := FALSE
                ELSE BEGIN
                  LastCust := Cust."No.";
                  CustCount := CustCount - 1;
                  IF CustCount = 0 THEN
                    More := FALSE;
                END;
            IF SelectionFilter <> '' THEN
              SelectionFilter := SelectionFilter + '|';
            IF FirstCust = LastCust THEN
              SelectionFilter := SelectionFilter + FirstCust
            ELSE
              SelectionFilter := SelectionFilter + FirstCust + '..' + LastCust;
            IF CustCount > 0 THEN BEGIN
              Cust.MARKEDONLY(TRUE);
              Cust.NEXT;
            END;
          END;
        END;
        EXIT(SelectionFilter);
        */

    end;


    procedure SetSelection(var Cust: Record Customer)
    begin
        //CurrPage.SETSELECTIONFILTER(Cust);
    end;
}




