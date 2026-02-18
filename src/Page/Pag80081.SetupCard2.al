Page 80081 "SetupCard 2"
{
    PageType = Card;
    SourceTable = "Sms Setup 2";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("User id";Rec."User id")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field(Vendor;Rec.Vendor)
                {
                    ApplicationArea = Basic;
                }
                field("Price per sms";Rec."Price per sms")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Sms balance";Rec."Sms balance")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field(Package;Rec.Package)
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
            }
            group("Set up")
            {
                field("Authenticatio Mode";Rec."Authenticatio Mode")
                {
                    ApplicationArea = Basic;
                }
                field("EndPoint link";Rec."EndPoint link")
                {
                    ApplicationArea = Basic;
                }
                field(Username;Rec.Username)
                {
                    ApplicationArea = Basic;
                }
                field(Password;Rec.Password)
                {
                    ApplicationArea = Basic;
                }
                field("Jwt Token";Rec."Jwt Token")
                {
                    ApplicationArea = Basic;
                }
                field("Api Key";Rec."Api Key")
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
            action("Test connection")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin

                    //smsManagement.TestConnection(Rec);
                    Rec.Modify;
                end;
            }
            action("Refresh balance")
            {
                ApplicationArea = Basic;
                Image = RefreshDiscount;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                   // smsManagement.RefreshBalance(Rec);
                    Rec.Modify;
                end;
            }
        }
    }

    var
        smsManagement: Codeunit "Sms Management";
}

