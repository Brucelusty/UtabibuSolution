//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172198 "HR Transport Requisition Pass"
{
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "HR Transport Allocations";
    SourceTableView = sorting("Allocation No", "Requisition No");

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field("Requisition No";Rec."Requisition No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No";Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Passenger/s Full Name/s";Rec."Passenger/s Full Name/s")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = Basic;
                }
                field("To";Rec."To")
                {
                    ApplicationArea = Basic;
                }
                field(Dept; Rec.Dept)
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




