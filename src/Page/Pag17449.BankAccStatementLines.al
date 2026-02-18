page 17449 "Bank Acc Statement Lines"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    Editable = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Bank Acc. Statement Line Conv";
    SourceTableView = WHERE("Statement Type" = CONST("Bank Reconciliation"));

    layout
    {
        area(content)
        {

            repeater(GroupName)
            {
                field("Transaction Date"; Rec."Transaction Date")
                {
                    StyleExpr = StyleTxt;
                }
                field("Value Date"; Rec."Value Date")
                {
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
                field("Check No."; Rec."Check No.")
                {
                    Visible = true;
                }
                field(Type; Rec.Type)
                {

                    trigger OnValidate()
                    begin
                        SetUserInteractions;
                    end;
                }
                field(Description; Rec.Description)
                {
                    StyleExpr = StyleTxt;
                }
                field("Statement Amount"; Rec."Statement Amount")
                {
                    StyleExpr = StyleTxt;
                }
                field("Applied Amount"; Rec."Applied Amount")
                {
                }
                field(Reconciled; Rec.Reconciled)
                {
                    // Visible = false;
                }
                field(Difference; Rec.Difference)
                {
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
                    Visible = false;
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
                RunPageLink = "Data Exch. No." = FIELD("Posting Exch. Entry No."),
                              "Line No." = FIELD("Posting Exch. Line No.");
                Visible = false;
            }
            action(ApplyEntries1)
            {
                Caption = '&Apply Entries...';
                Enabled = ApplyEntriesAllowed;
                Image = ApplyEntries;
                Visible = false;

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
            CalcBalance(Rec."Statement Line No.");
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
        /*
        IF BankAccRecon.GET("Statement Type","Bank Account No.","Statement No.") THEN;
        
        TempBankAccReconLine.COPY(Rec);
        
        TotalDiff := -Difference;
        IF TempBankAccReconLine.CALCSUMS(Difference) THEN BEGIN
          TotalDiff := TotalDiff + TempBankAccReconLine.Difference;
          TotalDiffEnable := TRUE;
        END ELSE
          TotalDiffEnable := FALSE;
        
        TotalBalance := BankAccRecon."Balance Last Statement" - "Statement Amount";
        IF TempBankAccReconLine.CALCSUMS("Statement Amount") THEN BEGIN
          TotalBalance := TotalBalance + TempBankAccReconLine."Statement Amount";
          TotalBalanceEnable := TRUE;
        END ELSE
          TotalBalanceEnable := FALSE;
        
        Balance := BankAccRecon."Balance Last Statement" - "Statement Amount";
        TempBankAccReconLine.SETRANGE("Statement Line No.",0,BankAccReconLineNo);
        IF TempBankAccReconLine.CALCSUMS("Statement Amount") THEN BEGIN
          Balance := Balance + TempBankAccReconLine."Statement Amount";
          BalanceEnable := TRUE;
        END ELSE
          BalanceEnable := FALSE;
        */

    end;

    local procedure ApplyEntries()
    var
        BankAccReconApplyEntries: Codeunit 374;
    begin
        /*
        "Ready for Application" := TRUE;
        CurrPage.SAVERECORD;
        COMMIT;
        BankAccReconApplyEntries.ApplyEntries(Rec);
        */

    end;


    procedure GetSelectedRecords(var TempBankAccReconciliationLine: Record "Bank Acc. Statement Line Conv" temporary)
    var
        BankAccReconciliationLine: Record "Bank Acc. Statement Line Conv";
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
        // StyleTxt := Rec.GetStyle();
        ApplyEntriesAllowed := Rec.Type = Rec.Type::"Check Ledger Entry";
    end;

    //[Scope('Internal')]
    procedure ToggleMatchedFilter(SetFilterOn: Boolean)
    begin
        IF SetFilterOn THEN
            Rec.SETFILTER(Difference, '<>%1', 0)
        ELSE
            Rec.RESET;
        CurrPage.UPDATE;
    end;
}

