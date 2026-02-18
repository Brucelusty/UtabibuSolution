report 50053 "AML Listings"
{
    ApplicationArea = All;
    Caption = 'AML Listings';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/AML Listing.rdlc';
    dataset
    {
        dataitem(Customer; Customer)
        {

            RequestFilterFields = "No.";
            column(No; "No.")
            { }
            column(Name; Name)
            { }
            column(CurrentShares; "Current Shares")
            { }

            trigger OnAfterGetRecord()
            begin
                AmountContributed := 0;
                FrequencyCntribution := 0;
                DetailedLedgerEntries.Reset();
                DetailedLedgerEntries.SetRange("Customer No.", "No.");
                DetailedLedgerEntries.SetRange("Transaction Type", DetailedLedgerEntries."Transaction Type"::"Deposit Contribution");
                DetailedLedgerEntries.SetFilter("Posting Date", '%1..%2', CalcDate('-CM', Today), CalcDate('CM', Today));
                IF DetailedLedgerEntries.Find('-') THEN begin
                    DetailedLedgerEntries.CalcSums("Credit Amount");
                    AmountContributed := Round(DetailedLedgerEntries."Credit Amount", 1, '=');
                    FrequencyCntribution := DetailedLedgerEntries.Count;
                    CustomerNet.Reset();
                    CustomerNet.SetCurrentKey("Min Monthly Income");
                    if CustomerNet.Find('-') then begin
                        repeat
                            if (AmountContributed >= CustomerNet."Max Monthlyl Income") and (AmountContributed <= CustomerNet."Min Monthly Income") then begin

                                AMLDetails.Reset();
                                AMLDetails.SetRange("Member No", Customer."No.");
                                if not AMLDetails.Find('-') then begin
                                    AMLDetails.Init();
                                    AMLDetails."Member No" := Customer."No.";
                                    AMLDetails."Member Name" := Customer.Name;
                                    AMLDetails."Current Deposits" := Customer."Current Shares";
                                    AMLDetails."Current Share Capital" := Customer."Shares Retained";
                                    AMLDetails."Customer Risk Rate" := CustomerNet."Risk Rate";
                                    AMLDetails."Frequency Contribution" := FrequencyCntribution;
                                    AMLDetails."Deposits Analysis" := AmountContributed;
                                    AMLDetails."Date Listed" := Today;
                                    AMLDetails.Insert(true);

                                end
                            end;
                        until CustomerNet.Next() = 0;
                    end;
                end;
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
        DetailedLedgerEntries: Record "Detailed Cust. Ledg. Entry";
        AMLDetails: record "AML Details";
        CustomerNet: Record "Customer Net Income Risk Rates";//Customer Net Income Risk Rates
        AmountContributed: Decimal;
        FrequencyCntribution: Integer;
}
