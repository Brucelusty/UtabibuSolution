page 17376 "posted loan recovery"
{

    CardPageID = "Loan Recovery Header";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loan Recovery Header";
    SourceTableView = where(Posted = filter(true),
                            Status = filter(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = Basic;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic;
                }

                field("Recovery Type"; Rec."Recovery Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan to Attach"; Rec."Loan to Attach")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Distributed to Guarantors"; Rec."Loan Distributed to Guarantors")
                {
                    Caption = 'Amount Recovered';
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
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
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'Member Statistics';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field("Member No");
            }
        }
    }

    trigger OnOpenPage()
    begin
        //SetRange("Created By", UserId);
    end;

    var
        ObjLoanRecoveryH: Record "Loan Recovery Header";
}





