report 50046 societyinformation
{
    ApplicationArea = All;
    Caption = 'societyinformation';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'layouts/saccoinformation.rdlc';
    dataset
    {
        dataitem(InsiderLending; InsiderLending)
        {
            column(BoardStaff; "Board/Staff")
            {
            }
            column(EMail; "E-Mail")
            {
            }
            column(IDNo; "ID No.")
            {
            }
            column(MemberName; "Member Name")
            {
            }
            column(MemberNo; "Member No")
            {
            }
            column(PositionHeld; "Position Held")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }


        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        Company: Record "Company Information";
}


