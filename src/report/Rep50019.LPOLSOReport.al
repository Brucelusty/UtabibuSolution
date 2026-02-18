report 50019 "LPOLSOReport"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/LPOLSOReport.rdlc';


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(No_; "No.") { }

            column(Purcahse_Requisition_No; "RFQ No.") { }

            column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(Buy_from_Address; "Buy-from Address") { }
            column(Buy_from_Address_2; "Buy-from Address 2") { }
            column(Quote_No_; "Quote No.") { }
            column(Buy_from_Post_Code; "Buy-from Post Code") { }
            //column(Payee_Naration;"Payee Naration"){}
            column(Posting_Date; "Posting Date") { }
            column(Posting_Description; "Posting Description") { }
            column(CompanyInformation_Pic; CompanyInformation.Picture) { }
            column(CompanyInformation_address; CompanyInformation.Address) { }
            column(CompanyInformation_Phone; CompanyInformation."Phone No.") { }
            column(CompanyInformation_name; CompanyInformation.Name) { }
            column(CompanyInformation_Address2; CompanyInformation."Address 2") { }
            column(CompanyInformation_homepage; CompanyInformation."Home Page") { }
            column(CompanyInformation_Email; CompanyInformation."E-Mail") { }


            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Description; Description) { }
                column(No_PV; "No.") { }
                column(Amount; Amount) { }

                column(Currency_Code; "Currency Code") { }
                column(Description_2; "Description 2") { }

                column(Quantity; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure") { }

                column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
                column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code") { }


            }
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
            end;
        }

    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    // actions
    // {
    //     area(processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //         }
    //     }
    // }
    //  }



    var
        myInt: Integer;
        CompanyInformation: Record "Company Information";
}