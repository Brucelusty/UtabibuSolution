report 80036 "Updating Age Report"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Update Member Ages';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where(ISNormalMember = filter(true), "Account Category" = filter(Individual));

            trigger OnAfterGetRecord()
            begin
                Age := CalculateAge(ReferenceDate);
                Modify();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(ReferenceDate; ReferenceDate)
                {
                    Caption = 'Reference Date for Age';
                    ApplicationArea = All;
                }
            }
        }

        trigger OnOpenPage()
        begin
            ReferenceDate := WorkDate();
        end;
    }

    trigger OnPreReport()
    begin
        if ReferenceDate = 0D then
            ReferenceDate := WorkDate();
    end;

    var
        ReferenceDate: Date;
}