Page 17384 "TwoFactorAuth"
{
    Caption = 'Authentication Page';
    PageType = StandardDialog;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = '  ';
                Editable = true;
                field("Input OTP"; InputOTP)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Promoted;
                }
            }
        }
    }

    actions
    {
    }

    var
        InputOTP: Integer;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        OTPLog: Record "OTP LOGS";
        ExpirationTime: DateTime;
    begin
        if CloseAction = Action::Cancel then begin
            Error('Canceling is not allowed.Please Enter OTP Sent ');
        end;
        //ExpirationTime := CurrentDateTime + (2 * 60);
        if CloseAction = Action::OK then begin

            OTPLog.Reset();
            OTPLog.SetRange("User Id", UserId);
            if OTPLog.FindLast() then begin
                ExpirationTime := OTPLog."Generated On" + (2 * 60);
                if ExpirationTime > CurrentDateTime then Error('your OTP has expired kindly login to get another otp');
                if InputOTP <> OTPLog.OTP then begin
                    Error('Enter a valid One Time Password sent to your phone');
                end;
            end;
        end;
    end;

    procedure GetEnteredOTP(): Integer
    begin
        exit(InputOTP);
    end;
}

