report 80037 "BidAnalysisReport"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/BidAnalysis.rdlc';


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {

            column(No_; "No.") { }

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

            dataitem(Purchheader3; "Purchase Header")
            {
                DataItemLink = "RFQ No" = field("No.");
                column(RFQ_No2; "RFQ No") { }
                dataitem(PurchaseLine2; "Purchase Line")
                {
                    DataItemLink = "Document No." = field("No.");

                    column(Description; Description) { }
                    column(Item_Specification; "Description 2") { }
                    column(No_PV; "No.") { }
                    column(Amount; Amount) { }

                    column(Currency_Code; "Currency Code") { }
                    column(Description_2; "Description 2") { }
                    column(Quantity; Quantity) { }
                    column(Unit_of_Measure; "Unit of Measure") { }
                    column(Direct_Unit_Cost; "Direct Unit Cost") { }
                    column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code") { }
                    column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code") { }

                    column(Empty; Empty) { }
                }
            }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Description2; Description) { }
                column(No_PV2; "No.") { }
                column(Amount2; Amount) { }

                column(Currency_Code2; "Currency Code") { }
                column(Description_22; "Description 2") { }

                column(Quantity2; Quantity) { }
                column(Unit_of_Measure2; "Unit of Measure") { }

                column(Direct_Unit_Cost2; "Direct Unit Cost") { }
                column(Shortcut_Dimension_1_Code2; "Shortcut Dimension 1 Code") { }
                column(Shortcut_Dimension_2_Code2; "Shortcut Dimension 2 Code") { }
                column(Empty2; Empty) { }

            }

            dataitem("Bid Analysis Comment"; "Bid Analysis Comment")
            {
                DataItemLink = No = field("No.");
                column(No; No) { }
                column(Comment; Comment) { }
                column(EmptyP; EmptyP) { }
                trigger OnAfterGetRecord()
                begin
                    //Message('bid%1', "Purchase Header"."No.");
                end;
            }
            dataitem("Bid Analysis Committee"; "Bid Analysis Committee")
            {
                DataItemLink = No = field("No.");
                column(No3; No) { }
                column(Name_of_the_Member; "Name of the Member") { }
                column(Phone_No; "Phone No") { }
                column(Position; Position) { }
                column(EmptyC; EmptyC) { }
            }
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin

                //     ItemSpecification := '';
                //     Purchheader.Reset();
                //     Purchheader.SetRange(Purchheader."RFQ No", "No.");
                //     if Purchheader.Find() then begin
                //         Message('%1-%2-rrrcomment %3', Purchheader."No.", ItemSpecification);
                //         Purchheader2.Reset();
                //         Purchheader2.SetRange(Purchheader2."RFQ No", Purchheader."No.");
                //         if Purchheader2.Find() = false then begin
                //             Purchline.Reset();
                //             Purchline.SetRange(Purchline."Document No.", Purchheader."No.");
                //             if Purchline.Find() then begin
                //                 repeat
                //                     ItemSpecification := Purchline."Item Specification";
                //                     Message('%1-%2-comment %3', Purchheader."No.", ItemSpecification);
                //                 until Purchline.Next() = 0;
                //             end;
                //         end;
                //     end;

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
        BidAnalysisComm: Record "Bid Analysis Committee";
        BidAnysisComment: Record "Bid Analysis Comment";
        Comment2: Text[2048];
        Name: Code[150];
        Phone: Code[150];
        Position: Code[150];
        Purchheader: Record "Purchase Header";
        ItemSpecification: Text[2048];
        Purchline: Record "Purchase Line";
        EmptyC: Code[20];
        EmptyP: Code[20];
        Empty: Code[20];
        Purchheader2: Record "Purchase Header";
}