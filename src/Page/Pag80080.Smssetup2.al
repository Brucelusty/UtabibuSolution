Page 80080 "Sms setup 2"
{
    CardPageID = "SetupCard 2";
    PageType = List;
    SourceTable = "Sms Setup 2";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User id";Rec."User id")
                {
                    ApplicationArea = Basic;
                }
                field("Authenticatio Mode";Rec."Authenticatio Mode")
                {
                    ApplicationArea = Basic;
                }
                field(Username;Rec.Username)
                {
                    ApplicationArea = Basic;
                }
                field(Vendor;Rec.Vendor)
                {
                    ApplicationArea = Basic;
                }
                field("Sms balance";Rec."Sms balance")
                {
                    ApplicationArea = Basic;
                }
                field(Package;Rec.Package)
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

