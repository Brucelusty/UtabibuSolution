//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172052 "Receipt Types List"
{
    CardPageID = "Receipt Types Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Funds Transaction Types";
    SourceTableView = where("Transaction Type" = const(Receipt));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Code";Rec."Transaction Code")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Description";Rec."Transaction Description")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                }
                field("Default Grouping";Rec."Default Grouping")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."transaction type"::Receipt;
    end;
}




