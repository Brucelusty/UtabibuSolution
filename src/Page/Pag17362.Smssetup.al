Page 17362 "Sms setup"
{
    CardPageID = SetupCard;
    PageType = List;
    SourceTable = "Sms Setup2";
   

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User id"; Rec."User id")
                {
                    ApplicationArea = Basic;
                }
                field("Authenticatio Mode"; Rec."Authenticatio Mode")
                {
                    ApplicationArea = Basic;
                }
                field(Username; Rec.Username)
                {
                    ApplicationArea = Basic;
                }
                field(Vendor; Rec.Vendor)
                {
                    ApplicationArea = Basic;
                }
                field("Sms balance"; Rec."Sms balance")
                {
                    ApplicationArea = Basic;
                }
                field(Package; Rec.Package)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {

    }
}

