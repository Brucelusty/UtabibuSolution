
report 50027 PaybillTransactions
{
    ApplicationArea = All;
    Caption = 'PaybillTransactions Postins';
    UsageCategory = Administration;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layout/paybillTest.rdlc';
    dataset
    {
        dataitem(PaybillTransactions; "Paybill Transactions")
        {
            column(BillRefNumber; BillRefNumber)
            {

            }
            trigger OnAfterGetRecord()
            begin

                paybill.FunctionChoice(PaybillTransactions.TransID);
            end;
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
        paybill: Codeunit "AU Paybill Automations";
        CustomerRecord: Record Customer;
}

