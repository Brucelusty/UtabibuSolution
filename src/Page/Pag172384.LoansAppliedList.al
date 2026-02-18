//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172384 "Loans Applied  List"
{
    CardPageID = "Loan Application BOSA(New)";
    DeleteAllowed = true;
    Editable = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loans Register";
    SourceTableView = where(Posted = filter(false),
                            "Approval Status" = filter(Open),
                            "Application type" = filter(System));

    layout
    {
        area(content)
        {
            repeater(Control1000000010)
            {
                field("Loan  No.";Rec."Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code";Rec."Client Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                }
                field("Client Name";Rec."Client Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                }
                field("ID NO";Rec."ID NO")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date";Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Requested Amount";Rec."Requested Amount")
                {
                    ApplicationArea = Basic;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status";Rec."Loan Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001; "Member Statistics FactBox")
            {
                SubPageLink = "No." = field("Client Code");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Member Accounts")
            {
                ApplicationArea = Basic;
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Member Accounts List";
                RunPageLink = "BOSA Account No" = field("Client Code");
            }
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'Member Statistics';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Client Code");
            }
        }
    }

    trigger OnOpenPage()
    begin
        //IF UserSet.GET(USERID) THEN BEGIN
        //SETRANGE("Captured By",USERID);
        //END;
        /*ObjUserSetup.RESET;
        ObjUserSetup.SETRANGE("User ID",USERID);
        IF ObjUserSetup.FIND('-') THEN BEGIN
          IF ObjUserSetup."Approval Administrator"<>TRUE THEN
            SETRANGE("Captured By",USERID);
          END;*/

    end;

    var
        UserSet: Record User;
        ObjUserSetup: Record "User Setup";
        ShowWorkflowStatus: Boolean;
}




