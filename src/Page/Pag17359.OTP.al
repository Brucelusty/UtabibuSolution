page 17359 OTP
{

    PageType = ConfirmationDialog;

    layout
    {
        area(content)
        {
            field(InputOTP; InputOTP)
            {
                ApplicationArea = Basic;
                MultiLine = true;
            }
        }
    }

    actions
    {
    }

    var
        InputOTP: Integer;


    procedure GetEnterOTP(): Integer
    begin
        exit(InputOTP);
    end;

    procedure GetEnteredOTP(): Integer
    begin
        exit(InputOTP);
    end;
}
