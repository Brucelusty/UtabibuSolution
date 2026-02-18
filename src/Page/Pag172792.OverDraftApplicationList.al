//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172792 "OverDraft Application List"
{
    CardPageID = "OverDraft Application Card";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "OverDraft Application";
    SourceTableView = where("OD Application Effected" = filter(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No";Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No";Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Over Draft Account";Rec."Over Draft Account")
                {
                    ApplicationArea = Basic;
                }
                field("Over Draft Account Name";Rec."Over Draft Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Created By";Rec."Created By")
                {
                    ApplicationArea = Basic;
                }
                field("Security Type";Rec."Security Type")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("Qualifying Overdraft Amount";Rec."Qualifying Overdraft Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Overdraft Duration";Rec."Overdraft Duration")
                {
                    ApplicationArea = Basic;
                }
                field("OverDraft Expiry Date";Rec."OverDraft Expiry Date")
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




