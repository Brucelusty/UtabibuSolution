//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 20383 "MOBILE Applications"
{
    CardPageID = "MOBILE Application Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "MOBILE Applications";
    Caption = 'Mobile Banking application';
    DeleteAllowed = false;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic;
                    trigger OnValidate()
                    var
                        MobileApp: Record "MOBILE Applications";
                    begin
                        if Rec."Account No" <> '' then begin
                            MobileApp.Reset();
                            MobileApp.SetRange("Account No", Rec."Account No");
                            if MobileApp.FindFirst() then
                                Error('Member %1 is already registered for Mobile Banking.', Rec."Account No");
                        end;
                    end;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = Basic;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Date Applied"; Rec."Date Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Time Applied"; Rec."Time Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field(SentToServer; Rec.SentToServer)
                {
                    ApplicationArea = Basic;
                }
                field(Whitelisted; Rec.Whitelisted) { }
                field(activated; Rec.Activated)
                {
                    ApplicationArea = Basic;
                }
                field(pinrequested; Rec."PIN Requested")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Activate)
            {
                ApplicationArea = Basic;
                Caption = 'Whitelist';
                Image = Activate;
                trigger OnAction()
                var
                    activate: Codeunit "Sms Management";
                    mobileApplications: Record "MOBILE Applications";
                    usersetup: Record "User Setup";
                begin
                    usersetup.get(UserId);
                    if usersetup."Can whitelist" = false then begin
                        error('You are not allowed to whitelist');
                        exit;
                    end;
                    CurrPage.SetSelectionFilter(mobileApplications);
                    mobileApplications.FindSet();
                    repeat
                        activate.Whitelist(mobileApplications);

                    until mobileApplications.Next() = 0;
                    Message('Selected %1 records for activation', mobileApplications.Count());
                    Message('Mobile Banking application has been whitelisted successfully');

                end;
            }


        }
    }
}




