codeunit 131070 "Send Birthday SMS"
{

    trigger OnRun()
    var
    begin
        BirthdayMessage()
    end;

    procedure BirthdayMessage()
    var
        Members: Record Customer;
        BirthMonth: Integer;
        BirthDate: integer;
        CurrMonth: Integer;
        CurrDate: integer;
        ProgressWindow: Dialog;
        smsManagement: Codeunit "Sms Management";
        CreationMessage: Text[2500];
        CurrentYear: Integer;
        Birthday: Date;
        AuPaybill: Codeunit "AU Paybill Automations";
        memberDOB: Date;
        MobilePhone: Text;
    begin
        memberDOB := 0D;
        Members.RESET;
        Members.SetFilter(Members."Mobile Phone No", '<>%1', '');
        //Members.SetRange("No.", MemberNo);
        IF Members.FINDFIRST THEN BEGIN
            REPEAT
                memberDOB := Members."Date of Birth";
                Evaluate(memberDOB, Format(Members."Date of Birth"));
                MobilePhone := Members."Mobile Phone No";
                IF memberDOB <> 0D THEN BEGIN

                    BirthMonth := DATE2DMY(memberDOB, 2);
                    BirthDate := DATE2DMY(memberDOB, 1);
                    CurrentYear := DATE2DMY(Today, 3);
                    IF (BirthMonth = 2) AND (BirthDate = 29) AND (NOT IsLeapYear(CurrentYear)) THEN BEGIN
                        // Skip invalid date for non-leap year
                        MESSAGE('Skipping record for %1 because %2 is not a leap year.', Members.Name, CurrentYear);

                    END ELSE begin
                        Birthday := DMY2Date(BirthDate, BirthMonth, CurrentYear);
                        CurrDate := DATE2DMY(TODAY, 1);
                        CurrMonth := DATE2DMY(TODAY, 2);
                        IF (Birthday = Today) THEN BEGIN
                            CreationMessage := 'Dear ' + AuPaybill.SplitString(Members.Name, ' ') + ', as you turn a year older, we want to make a toast to you for endless Love and Happiness in your new year. Keep smiling and making the world a better place. Happy Birthday.';
                            smsManagement.SendSmsResponse(MobilePhone, CreationMessage);
                        end;
                    end;
                end;
            until Members.next = 0;
        end;

    end;

    local procedure IsLeapYear(Year: Integer): Boolean
    begin
        exit((Year MOD 4 = 0) AND ((Year MOD 100 <> 0) OR (Year MOD 400 = 0)));
    end;
}
