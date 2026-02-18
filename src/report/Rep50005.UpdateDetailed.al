report 50005 "UpdateDetailed"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    // DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/UpdateDetailed.Rdlc';



    dataset
    {

        dataitem("Detailed Cust. Ledg. Entry"; "Cust. Ledger Entry")
        {
            RequestFilterFields = "Customer No.";
            column(Customer_No_; "Customer No.")
            {

            }
            trigger
            OnAfterGetRecord()
            var
                DetariledL: Record "Detailed Cust. Ledg. Entry";


            begin
                DetariledL.Reset();
                DetariledL.SetRange("Customer No.", "Detailed Cust. Ledg. Entry"."Customer No.");
                DetariledL.SetRange("Document No.", "Detailed Cust. Ledg. Entry"."Document No.");
                DetariledL.SetRange("Posting Date", "Posting Date");
                if DetariledL.FindSet() then begin

                    repeat
                        if (DetariledL.Description = '') then begin
                            DetariledL.Description := "Detailed Cust. Ledg. Entry".Description;
                            DetariledL.Modify(true);

                        end;
                    until DetariledL.Next() = 0;

                end;
                DetariledL.Reset();
                DetariledL.SetRange("Customer No.", "Detailed Cust. Ledg. Entry"."Customer No.");
                DetariledL.SetRange("Document No.", "Detailed Cust. Ledg. Entry"."Document No.");
                DetariledL.SetRange("Posting Date", "Posting Date");
                if DetariledL.FindSet() then begin

                    repeat
                        if (DetariledL."Cust. Ledger Entry No." = 0) then begin
                            DetariledL."Cust. Ledger Entry No." := "Detailed Cust. Ledg. Entry"."Entry No.";
                            DetariledL.Modify(true);
                            //Message();
                        end;
                    until DetariledL.Next() = 0;

                end;
            end;


        }
    }

    requestpage
    {
        layout
        {
            area(Content)
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
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        myInt: Integer;
}