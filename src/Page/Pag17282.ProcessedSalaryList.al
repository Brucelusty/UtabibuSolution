//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 17282 "Processed Salary List"
{
    CardPageID = "Salary Processing Card(Posted)";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Salary Processing Headerr";
    SourceTableView = where(Posted = filter(true));

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
                field("Account No"; Rec."Account No")
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
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Posted By";Rec."Posted By")
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




