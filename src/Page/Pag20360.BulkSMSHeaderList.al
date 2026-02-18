//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 14125503 "Bulk SMS Header List"
{
    CardPageID = "Bulk SMS Header";
    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Bulk SMS Header";
    //SourceTableView = where (Posted= Filter(false));
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
                field(Message; Rec.Message)
                {
                    ApplicationArea = Basic;
                }
                field("SMS Type"; Rec."SMS Type")
                {
                    ApplicationArea = Basic;
                }
                field("Date Entered"; Rec."Date Entered")
                {
                    ApplicationArea = Basic;
                }
                field("Time Entered"; Rec."Time Entered")
                {
                    ApplicationArea = Basic;
                }
                field("SMS Status"; Rec."SMS Status")
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




