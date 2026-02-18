//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17279 "Salary Processing List"
{
    CardPageID = "Salary Processing Header";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Salary Processing Headerr";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                }
                field("Account No";Rec."Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Account No';
                }
                field("Account Name";Rec."Account Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Account Name';
                }
                field("Account Type";Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Entered By";Rec."Entered By")
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered";Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered";Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Posting date";Rec."Posting date")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No.";Rec."Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code";Rec."Employer Code")
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




