//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 14125501 "Bulk SMS Header"
{
    SourceTable = "Bulk SMS Header";

    layout
    {
        area(content)
        {
            field(No; Rec.No)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Date Entered"; Rec."Date Entered")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Time Entered"; Rec."Time Entered")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Entered By"; Rec."Entered By")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("SMS Type"; Rec."SMS Type")
            {
                ApplicationArea = Basic;
                trigger OnValidate()
                var
                begin
                end;
            }
            field("Member Status"; Rec."Member Status")
            {
                ApplicationArea = Basic;
                Caption = 'Member status';

            }
            field("SMS Status"; Rec."SMS Status")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Status Date"; Rec."Status Date")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Status Time"; Rec."Status Time")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Status By"; Rec."Status By")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field(Message; Rec.Message)
            {
                ApplicationArea = Basic;
                Editable = true;
                MultiLine = true;
            }
            part(Control1000000012; "Bulk SMS Lines Part")
            {
                Caption = '<Bulk SMS Lines>';
                Editable = true;
                SubPageLink = No = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Contacts")
            {
                ApplicationArea = Basic;
                Caption = 'Import Contacts';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    InStream: InStream;
                    FileName: Text;
                    TempBlob: Codeunit "Temp Blob";
                    Line: Text;
                    PhoneNumber: Text;
                    ContactName: Text;
                    LineParts: List of [Text];
                    MobileExt: Label '254';
                    FirstPart: Text;
                    MobileRest: Text;
                    ValidPhone: Boolean;
                begin
                    if UploadIntoStream('Select CSV File', '', 'CSV Files (*.csv)|*.csv', FileName, InStream) then begin
                        if Confirm('Are you sure you want to import contacts and replace existing lines?') then begin
                            // Clear existing lines
                            BulkSMSLines.Reset();
                            BulkSMSLines.SetRange(No, Rec.No);
                            if BulkSMSLines.FindSet() then
                                BulkSMSLines.DeleteAll();

                            while not InStream.EOS do begin
                                InStream.ReadText(Line);

                                if Line <> '' then begin
                                    LineParts := Line.Split(',');
                                    if LineParts.Count >= 2 then begin
                                        PhoneNumber := LineParts.Get(1).Trim();
                                        ContactName := LineParts.Get(2).Trim();
                                        ValidPhone := true;
                                        if PhoneNumber <> '' then begin
                                            FirstPart := CopyStr(PhoneNumber, 1, 1);
                                            MobileRest := CopyStr(PhoneNumber, 2, 200);
                                            if FirstPart = '0' then
                                                PhoneNumber := MobileExt + MobileRest
                                            else if FirstPart = '7' then
                                                PhoneNumber := '254' + PhoneNumber
                                            else begin
                                                if (CopyStr(PhoneNumber, 1, 3) <> '254') or (StrLen(PhoneNumber) <> 12) then
                                                    ValidPhone := false;
                                            end;
                                        end else
                                            ValidPhone := false;

                                        if ValidPhone then begin
                                            BulkSMSLines.Init();
                                            BulkSMSLines.No := Rec.No;
                                            BulkSMSLines.Code := PhoneNumber;
                                            BulkSMSLines.Description := ContactName;
                                            BulkSMSLines."Send Sms" := true;
                                            if not BulkSMSLines.Insert(true) then
                                                BulkSMSLines.Modify(true);
                                        end;
                                    end;
                                end;
                            end;
                            Message('Contacts imported successfully.');
                        end;
                    end else
                        Error('File upload cancelled.');
                end;
            }

            action("Update Sms List")
            {
                ApplicationArea = Basic;
                Image = PutawayLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to replace the numbers? ') = false then exit;
                    BulkSMSLines.Reset();
                    BulkSMSLines.SetRange(No, Rec.No);

                    if BulkSMSLines.Find('-') then begin
                        BulkSMSLines.DeleteAll();
                    end;

                    if Rec."SMS Type" = Rec."SMS Type"::Everyone then begin
                        Customer.Reset;
                        Customer.SetCurrentKey("No.");
                        Customer.SetFilter("Status", '<>%1&<>%2&<>%3', Customer.Status::Deceased, Customer.Status::Exited, Customer.Status::Withdrawn);
                        if Rec."Member Status" <> Rec."Member Status"::" " then begin
                            case Rec."Member Status" of
                                Rec."Member Status"::Active:
                                    Customer.SetFilter(Status, Format(Customer.Status::Active));
                                Rec."Member Status"::Dormant:
                                    Customer.SetFilter(Status, Format(Customer.Status::Dormant));
                                Rec."Member Status"::"Awaiting Exit":
                                    Customer.SetFilter(Status, Format(Customer.Status::"Awaiting Exit"));
                                // Rec."Member Status"::"Penalty balance":
                                //     Customer.SetFilter(penalty, '>0'); 
                                Rec."Member Status"::"Registration Date":
                                    Customer.SetFilter("Registration Date", '>=%1', Today);
                                Rec."Member Status"::"Occupation details":
                                    Customer.SetFilter(Occupation, '<>''''');
                                // Rec."Member Status"::"Utapesa Defaulter":
                                //      Customer.SetFilter(BlackListed, '=%1', true); 

                                else
                                    Error('Invalid Member Status value: %1', Format(Rec."Member Status"));
                            end;
                        end;
                        if Customer.FindSet() then begin
                            repeat
                                MobilePhoneNo2 := Format(Customer."Mobile Phone No");
                                Firstpart := CopyStr(MobilePhoneNo2, 1, 1);
                                MobileRest := CopyStr(MobilePhoneNo2, 2, 200);
                                if Firstpart = '0' then begin
                                    MobilePhoneNo := MobileExt + MobileRest
                                end else begin
                                    MobilePhoneNo := Customer."Mobile Phone No";
                                end;
                                if Firstpart = '7' then begin
                                    MobilePhoneNo := '254' + Format(Customer."Mobile Phone No");
                                end;

                                if MobilePhoneNo2 <> '' then begin
                                    BulkSMSLines.Init();
                                    BulkSMSLines.No := Rec.No;
                                    BulkSMSLines.Code := MobilePhoneNo;
                                    BulkSMSLines.Description := Customer.Name;
                                    BulkSMSLines."Member No" := Customer."No.";
                                    BulkSMSLines."Send Sms" := true;
                                    BulkSMSLines.Group := Customer."Group Code";
                                    BulkSMSLines."Member No" := Customer."No.";
                                    BulkSMSLines."Branch Code" := Customer."Global Dimension 2 Code";
                                    if not BulkSMSLines.Insert(true) then
                                        BulkSMSLines.Modify(true);
                                end;
                            until Customer.Next() = 0;
                        end
                    end;
                end;
            }
            action("Send Message")
            {
                ApplicationArea = Basic;
                Image = PutawayLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SmsEntry: Record "Sms Entry 2";
                    smsenty2: Record "Sms Entry 2";
                    MaxRetries: Integer;
                    RetryCount: Integer;
                begin
                    if not Confirm('Are you sure you want to send the message to enlisted Contacts?') then
                        exit;

                    BulkSMSLines.Reset();
                    BulkSMSLines.SetRange(No, Rec.No);
                    BulkSMSLines.SetRange("Message Status", BulkSMSLines."Message Status"::"Message Not Sent");

                    if BulkSMSLines.FindSet() then begin
                        MaxRetries := 3; // Limit retries to prevent infinite loops
                        repeat


                            SmsEntry.Init();
                            SmsEntry."Phone Number" := BulkSMSLines.Code;
                            SmsEntry.Message := 'Dear ' + GetFirstName(BulkSMSLines.Description) + ', ' + Rec.Message;
                            // RetryCount := 0;
                            SmsEntry."Message Date" := Today;
                            SmsEntry.Bulk := true;
                            smsenty2.Reset();
                            smsenty2.FindLast();
                            SmsEntry.EntryNo := smsenty2.EntryNo + 1;
                            SmsEntry.insert(true);
                            Commit();

                            BulkSMSLines."Message Status" := BulkSMSLines."Message Status"::"Message Sent";
                            BulkSMSLines.Modify(true);
                        until BulkSMSLines.Next() = 0;
                    end;

                    Rec."Status Date" := Today;
                    Rec."Status Time" := Time;
                    Rec."Status By" := UserId;
                    Rec."SMS Status" := Rec."SMS Status"::Sent;
                    Rec.Modify(true);
                end;
            }

            action(Send)
            {
                ApplicationArea = Basic;
                Image = PutawayLines;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to send this SMS?', true, false) = true then begin
                        Rec."Status Date" := Today;
                        Rec."Status Time" := Time;
                        Rec."Status By" := UserId;
                        Rec."SMS Status" := Rec."SMS Status"::Sent;
                        Rec.Modify();
                        Message('SMS successfully sent.');
                    end;
                end;
            }
        }
    }

    var
        Cust: Record Customer;
        smsManagement: Codeunit "Sms Management";
        BulkLines: Record "Bulk SMS Lines";
        Customer: Record Customer;
        MobilePhoneNo2: Text;
        MobilePhoneNo: Text;
        Firstpart: Text;
        MobileRest: Text;
        MobileExt: Label '254';
        GroupVisible: Boolean;
        BranchVisible: Boolean;
        BulkSMSLines: Record "Bulk SMS Lines";
        Prefix: Text[400];

    local procedure GetFirstName(FullName: Text): Text
    var
        NameParts: List of [Text];
    begin
        if FullName = '' then
            exit('');
        NameParts := FullName.Split(' ');
        if NameParts.Count > 0 then
            exit(NameParts.Get(1).Trim());
        exit('');
    end;
}