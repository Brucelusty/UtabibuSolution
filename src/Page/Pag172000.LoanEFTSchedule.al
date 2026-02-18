//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172000 "Loan EFT Schedule"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Loans Register";
    SourceTableView = where("Bank Account No" = filter(<> ''),
                            Posted = const(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff No";Rec."Staff No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ref No';
                }
                field("Client Code";Rec."Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";Rec."Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type Name";Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic;
                }
                field("Client Name";Rec."Client Name")
                {
                    ApplicationArea = Basic;
                }
                field("Beneficiary Account";Rec."Bank Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Bank code";Rec."Bank code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Branch";Rec."Bank Branch")
                {
                    ApplicationArea = Basic;
                }
                field("Net Disbursed";Rec."Loan Disbursed Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date";Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        ObjLoanProductCharges: Record "Loan Product Charges";
    begin
        GenSetUp.Get;
        Upfronts := 0;
        "Net Disbursed" := 0;
        ProductChargesAmount := 0;
        ObjLoanProductCharges.Reset;
        ObjLoanProductCharges.SetRange(ObjLoanProductCharges."Product Code", Rec."Loan Product Type");
        if ObjLoanProductCharges.Find('-') then begin


            if ObjLoanProductCharges."Use Perc" then begin
                ProductChargesAmount := ProductChargesAmount + ((ObjLoanProductCharges.Percentage * Rec."Approved Amount") / 100);

            end
            else
                ProductChargesAmount := ProductChargesAmount + ObjLoanProductCharges.Amount;
        end;

        Rec.CalcFields("Loan Offset Amount", "Offset Commission");
        Upfronts := Rec."Loan Offset Amount" + Rec."Offset Commission" + GenSetUp."Loan Trasfer Fee-Cheque" +
       Rec. "Boosted Amount" + Rec."Deposit Reinstatement" + ProductChargesAmount + Rec."Share Capital Due";
        "Net Disbursed" := Rec."Approved Amount" - Upfronts;
    end;

    var
        "Net Disbursed": Decimal;
        Upfronts: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        ProductChargesAmount: Decimal;
}




