page 17447 "Bank Acc. Recon Lines Conv"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    Editable = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Bank Acc. Reconciliation Line";
    SourceTableView = WHERE ("Statement Type"=CONST("Bank Reconciliation"));

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field("Transaction Date"; Rec."Transaction Date")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Value Date"; Rec."Value Date")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Check No."; Rec."Check No.")
                {
                    Editable = false;
                    Visible = true;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        SetUserInteractions;
                    end;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                }
                field("Statement Amount"; Rec."Statement Amount")
                {
                    Editable = false;
                    StyleExpr = StyleTxt;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                }
                field(Reconciled; Rec.Reconciled)
                {
                }
                field(Difference; Rec.Difference)
                {
                    Editable = false;
                }
                field("Applied Entries"; Rec."Applied Entries")
                {
                    Visible = false;
                }
                field("Related-Party Name"; Rec."Related-Party Name")
                {
                    Visible = false;
                }
                field("Additional Transaction Info"; Rec."Additional Transaction Info")
                {
                    Editable = false;
                    Visible = false;
                }
            }
            group(Totals)
            {
                // label()
                // {
                // }
                field(Balance; Balance + Rec."Statement Amount")
                {
                    AutoFormatExpression = Rec.GetCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Balance';
                    Editable = false;
                    Enabled = BalanceEnable;
                }
                field(TotalBalance; TotalBalance + Rec."Statement Amount")
                {
                    AutoFormatExpression = Rec.GetCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Cash Book Balance';
                    Editable = false;
                    Enabled = TotalBalanceEnable;
                }
                field(TotalDiff; TotalDiff + Rec.Difference)
                {
                    AutoFormatExpression = Rec.GetCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Total Difference';
                    Editable = false;
                    Enabled = TotalDiffEnable;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ShowStatementLineDetails)
            {
                Caption = 'Details';
                RunObject = Page 1221;
                RunPageLink = "Data Exch. No."=FIELD("Data Exch. Entry No."),
                              "Line No."=FIELD("Data Exch. Line No.");
                // RunObject = Page 1221;
                // RunPageLink = "Data Exch. No."=FIELD("Posting Exch. Entry No."),
                //               "Line No."=FIELD("Posting Exch. Line No.");
            }
            action(ApplyEntries1)
            {
                Caption = '&Apply Entries...';
                Enabled = ApplyEntriesAllowed;
                Image = ApplyEntries;

                trigger OnAction()
                begin
                    ApplyEntries;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        IF Rec."Statement Line No." <> 0 THEN
          CalcBalance(REC."Statement Line No.");
        SetUserInteractions;
    end;

    trigger OnAfterGetRecord()
    begin
        SetUserInteractions;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        SetUserInteractions;
    end;

    trigger OnInit()
    begin
        BalanceEnable := TRUE;
        TotalBalanceEnable := TRUE;
        TotalDiffEnable := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF BelowxRec THEN
          CalcBalance(xRec."Statement Line No.")
        ELSE
          CalcBalance(xRec."Statement Line No." - 1);
    end;

    var
        BankAccRecon: Record 273;
        StyleTxt: Text;
        TotalDiff: Decimal;
        Balance: Decimal;
        TotalBalance: Decimal;
      
        TotalDiffEnable: Boolean;
  
        TotalBalanceEnable: Boolean;
               BalanceEnable: Boolean;
        ApplyEntriesAllowed: Boolean;

    local procedure CalcBalance(BankAccReconLineNo: Integer)
    var
        TempBankAccReconLine: Record 274;
    begin
        IF BankAccRecon.GET(Rec."Statement Type",Rec."Bank Account No.",Rec."Statement No.") THEN;

        TempBankAccReconLine.COPY(Rec);

        TotalDiff := - Rec.Difference;
        IF TempBankAccReconLine.CALCSUMS(Difference) THEN BEGIN
          TotalDiff := TotalDiff + TempBankAccReconLine.Difference;
          TotalDiffEnable := TRUE;
        END ELSE
          TotalDiffEnable := FALSE;

        TotalBalance := BankAccRecon."Balance Last Statement" - Rec."Statement Amount";
        IF TempBankAccReconLine.CALCSUMS("Statement Amount") THEN BEGIN
          TotalBalance := TotalBalance + TempBankAccReconLine."Statement Amount";
          TotalBalanceEnable := TRUE;
        END ELSE
          TotalBalanceEnable := FALSE;

        Balance := BankAccRecon."Balance Last Statement" - Rec."Statement Amount";
        TempBankAccReconLine.SETRANGE("Statement Line No.",0,BankAccReconLineNo);
        IF TempBankAccReconLine.CALCSUMS("Statement Amount") THEN BEGIN
          Balance := Balance + TempBankAccReconLine."Statement Amount";
          BalanceEnable := TRUE;
        END ELSE
          BalanceEnable := FALSE;
    end;

    local procedure ApplyEntries()
    var
        BankAccReconApplyEntries: Codeunit 374;
    begin
        Rec."Ready for Application" := TRUE;
        CurrPage.SAVERECORD;
        COMMIT;
        // BankAccReconApplyEntries.ApplyEntries(Rec);
    end;

    [Scope('Internal')]
    procedure GetSelectedRecords(var TempBankAccReconciliationLine: Record 274 temporary)
    var
        BankAccReconciliationLine: Record 274;
    begin
        CurrPage.SETSELECTIONFILTER(BankAccReconciliationLine);
        IF BankAccReconciliationLine.FINDSET THEN
          REPEAT
            TempBankAccReconciliationLine := BankAccReconciliationLine;
            TempBankAccReconciliationLine.INSERT;
          UNTIL BankAccReconciliationLine.NEXT = 0;
    end;

    local procedure SetUserInteractions()
    begin
        StyleTxt := Rec.GetStyle;
        ApplyEntriesAllowed := Rec.Type = Rec.Type::"Check Ledger Entry";
    end;

  //  [Scope('Internal')]
    procedure ToggleMatchedFilter(SetFilterOn: Boolean)
    begin
        IF SetFilterOn THEN
          Rec.SETFILTER(Difference,'<>%1',0)
        ELSE
          Rec.RESET;
        CurrPage.UPDATE;
    end;
}

