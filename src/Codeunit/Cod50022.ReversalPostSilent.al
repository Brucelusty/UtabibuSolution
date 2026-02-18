//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50022 "Reversal-Post(Silent)"
{
    TableNo = "Reversal Entry";

    trigger OnRun()
    var
        GLReg: Record "G/L Register";
        GenJnlTemplate: Record "Gen. Journal Template";
        PostedDeferralHeader: Record "Posted Deferral Header";
        DeferralUtilities: Codeunit "Deferral Utilities";
        GenJnlPostReverse: Codeunit "Gen. Jnl.-Post Reverse";
        Txt: Text[1024];
        WarningText: Text[250];
        Number: Integer;
    begin
        Rec.Reset;
        Rec.SetRange("Entry Type", Rec."entry type"::"Fixed Asset");
        if Rec.FindFirst then
            WarningText := Text007;
        Rec.SetRange("Entry Type");
        if PrintRegister then
            Txt := Text004 + WarningText + '\' + Text005
        else
            Txt := Text004 + WarningText + '\' + Text002;
        if not Rec.FindFirst then
            Error(Text006);

        /*IF NOT HideDialog THEN
          IF NOT CONFIRM(Txt,FALSE) THEN
            EXIT;*///=================================================Addon

        ReversalEntry := Rec;
        if Rec."Reversal Type" = Rec."reversal type"::Transaction then
            ReversalEntry.SetReverseFilter(Rec."Transaction No.", Rec."Reversal Type")
        else
            ReversalEntry.SetReverseFilter(Rec."G/L Register No.", Rec."Reversal Type");
        ReversalEntry.CheckEntries;
        Rec.Get(1);
        if Rec."Reversal Type" = Rec."reversal type"::Register then
            Number := Rec."G/L Register No."
        else
            Number := Rec."Transaction No.";
        if not ReversalEntry.VerifyReversalEntries(Rec, Number, Rec."Reversal Type") then
            Error(Text008);
        GenJnlPostReverse.Reverse(ReversalEntry, Rec);
        if PrintRegister then begin
            GenJnlTemplate.Validate(Type);
            if GenJnlTemplate."Posting Report ID" <> 0 then
                if GLReg.FindLast then begin
                    ;
                    GLReg.SetRecfilter;
                    Report.Run(GenJnlTemplate."Posting Report ID", false, false, GLReg);
                end;
        end;
        Rec.DeleteAll;
        // PostedDeferralHeader.DeleteForDoc(DeferralUtilities.GetGLDeferralDocType, ReversalEntry."Document No.", '', 0, '');
        /*IF NOT HideDialog THEN
          MESSAGE(Text003);*///========================================================Addon

    end;

    var
        Text002: label 'Do you want to reverse the entries?';
        Text003: label 'The entries were successfully reversed.';
        Text004: label 'To reverse these entries, correcting entries will be posted.';
        Text005: label 'Do you want to reverse the entries and print the report?';
        Text006: label 'There is nothing to reverse.';
        Text007: label '\There are one or more FA Ledger Entries. You should consider using the fixed asset function Cancel Entries.';
        Text008: label 'Changes have been made to posted entries after the window was opened.\Close and reopen the window to continue.';
        ReversalEntry: Record "Reversal Entry";
        PrintRegister: Boolean;
        HideDialog: Boolean;

    procedure SetPrint(NewPrintRegister: Boolean)
    begin
        PrintRegister := NewPrintRegister;
    end;

    procedure SetHideDialog(NewHideDialog: Boolean)
    begin
        HideDialog := NewHideDialog;
    end;
}




