Page 17214 "Transfer Header Card"
{
    PageType = Card;
    SourceTable = "EFT/RTGS Header";

    layout
    {
        area(content)
        {
            group("EFT Batch")
            {
                Caption = 'EFT Batch';
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank  No"; Rec."Bank  No")
                {
                    ApplicationArea = Basic;
                    Visible = true;
                }
                field(Bank; Rec.Bank)
                {
                    ApplicationArea = Basic;
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = Basic;
                }
                field("Total Count"; Rec."Total Count")
                {
                    ApplicationArea = Basic;
                    Caption = 'Record Count';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                    MultiLine = TRUE;
                }
                field(Transferred; Rec.Transferred)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Transferred"; Rec."Date Transferred")
                {
                    ApplicationArea = Basic;
                }
                field("Time Transferred"; Rec."Time Transferred")
                {
                    ApplicationArea = Basic;
                }
                field("Transferred By"; Rec."Transferred By")
                {
                    ApplicationArea = Basic;
                }
                field(RTGS; Rec.RTGS)
                {
                    ApplicationArea = Basic;
                }
                field("Direct EFT"; Rec."Direct EFT")
                {
                    Caption = 'EFT';
                }
            }
            part(Control1; "EFT Details")
            {
                SubPageLink = "Header No" = field(No);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Get)
            {
                Visible = false;
                Caption = 'Get';
                action("Standing Orders EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Orders EFT';
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Rec.Transferred = true then
                            Error('EFT Batch already transfered. Please use another one.');

                        STORegister.Reset;
                        STORegister.SetRange(STORegister.EFT, true);
                        STORegister.SetRange(STORegister."Transfered to EFT", false);
                        if STORegister.Find('-') then begin
                            repeat
                                EFTDetails.Init;
                                EFTDetails.No := '';
                                EFTDetails."Header No" := Rec.No;
                                EFTDetails."Account No" := STORegister."Source Account No.";
                                //EFTDetails."Account Name":=STORegister."Account Name";
                                EFTDetails.Validate(EFTDetails."Account No");
                                //IF Accounts.GET(EFTDetails."Account No") THEN BEGIN
                                //EFTDetails."Account Type":=Accounts."Account Type";
                                //EFTDetails."Staff No":=Account."Staff No";
                                //END;
                                EFTDetails.Amount := STORegister."Amount Deducted";
                                EFTDetails."Destination Account Type" := EFTDetails."destination account type"::External;
                                //EFTDetails."Destination Account No":=STORegister."Destination Account No.";
                                if STO.Get(STORegister."Standing Order No.") then begin
                                    EFTDetails."Destination Account No" := STO."Destination Account No.";
                                    EFTDetails."Bank No" := STO."Bank Code";
                                    EFTDetails.Validate(EFTDetails."Bank No");
                                end;
                                EFTDetails."Destination Account Name" := CopyStr(STORegister."Destination Account Name", 1, 28);
                                EFTDetails."Standing Order No" := STORegister."Standing Order No.";
                                EFTDetails."Standing Order Register No" := STORegister."Register No.";
                                EFTDetails.Charges := 0;
                                if EFTDetails.Amount > 0 then
                                    EFTDetails.Insert(true)

                            until STORegister.Next = 0
                        end;
                    end;
                }

                separator(Action1102760024)
                {
                }

                separator(Action1102760027)
                {
                }
                action("Re-genarate EFT Format")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-genarate EFT Format';
                    Visible = false;

                    trigger OnAction()
                    begin

                        EFTDetails.Reset;
                        EFTDetails.SetRange(EFTDetails."Header No", Rec.No);
                        if EFTDetails.Find('-') then begin
                            repeat
                                EFTDetails.TestField(EFTDetails."Destination Account No");
                                EFTDetails.TestField(EFTDetails.Amount);
                                EFTDetails.TestField(EFTDetails."Destination Account Name");
                                EFTDetails.TestField(EFTDetails."Bank No");

                                if StrLen(EFTDetails."Destination Account Name") > 28 then
                                    Error('Destnation account name of staff no %1 more than 28 characters.', EFTDetails."Staff No");

                                if StrLen(EFTDetails."Destination Account No") > 14 then
                                    Error('Destnation account of staff no %1 more than 14 characters.', EFTDetails."Staff No");

                                //For STIMA, replace staff No with stima
                                ReffNo := 'shofco';

                                if EFTDetails.Amount <> ROUND(EFTDetails.Amount, 1) then begin
                                    if EFTDetails.Amount <> ROUND(EFTDetails.Amount, 0.1) then begin
                                        EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                                 PadStr('', 5, ' ') +
                                                                 PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                                 EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                                 PadStr('', 9 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                        DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') +
                                                                 PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                    end else begin
                                        EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                                 PadStr('', 5, ' ') +
                                                                 PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                                 EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                                 PadStr('', 8 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                        DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') + '0' +
                                                                 PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                    end;
                                end else begin
                                    TextGen := Format(EFTDetails."Staff No");

                                    EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                             PadStr('', 5, ' ') +
                                                             PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                             EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                             PadStr('', 7 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                    DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') + '00' +
                                                             PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                end;



                                EFTDetails.Modify;
                            until EFTDetails.Next = 0;
                        end;




                        // EFTDetails.Reset;
                        // EFTDetails.SetRange(EFTDetails."Header No",No);
                        // if EFTDetails.Find('-') then

                    end;

                }
                separator(Action1102760032)
                {
                }

                separator(Action1102760035)
                {
                }

                separator(Action1102760034)
                {
                }
                action("Generate Dividends EFT")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Dividends EFT';

                    trigger OnAction()
                    begin

                        EFTDetails.Reset;
                        EFTDetails.SetRange(EFTDetails."Header No", Rec.No);
                        if EFTDetails.Find('-') then begin
                            repeat
                                EFTDetails.TestField(EFTDetails."Destination Account No");
                                EFTDetails.TestField(EFTDetails.Amount);
                                EFTDetails.TestField(EFTDetails."Destination Account Name");
                                EFTDetails.TestField(EFTDetails."Bank No");

                                if StrLen(EFTDetails."Destination Account Name") > 28 then
                                    Error('Destnation account name of staff no %1 more than 28 characters.', EFTDetails."Staff No");

                                if StrLen(EFTDetails."Destination Account No") > 14 then
                                    Error('Destnation account of staff no %1 more than 14 characters.', EFTDetails."Staff No");

                                //For STIMA, replace staff No with stima
                                ReffNo := 'STIMA';

                                if EFTDetails.Amount <> ROUND(EFTDetails.Amount, 1) then begin
                                    if EFTDetails.Amount <> ROUND(EFTDetails.Amount, 0.1) then begin
                                        EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                                 PadStr('', 5, ' ') +
                                                                 PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                                 EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                                 PadStr('', 9 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                        DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') +
                                                                 PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                    end else begin
                                        EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                                 PadStr('', 5, ' ') +
                                                                 PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                                 EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                                 PadStr('', 8 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                        DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') + '0' +
                                                                 PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                    end;
                                end else begin
                                    TextGen := Format(EFTDetails."Staff No");

                                    EFTDetails.ExportFormat := PadStr('', 14 - StrLen(EFTDetails."Destination Account No"), ' ') + EFTDetails."Destination Account No" +
                                                             PadStr('', 5, ' ') +
                                                             PadStr('', 6 - StrLen(EFTDetails."Bank No"), ' ') + EFTDetails."Bank No" + ' ' +
                                                             EFTDetails."Destination Account Name" + PadStr('', 30 - StrLen(EFTDetails."Destination Account Name"), ' ') +
                                                             PadStr('', 7 - StrLen(DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',')), ' ') +
                                                                    DelChr(DelChr(Format(EFTDetails.Amount), '=', '.'), '=', ',') + '00' +
                                                             PadStr('', 8 - StrLen(CopyStr(ReffNo, 1, 8)), ' ') + ReffNo;
                                end;



                                EFTDetails.Modify;
                            until EFTDetails.Next = 0;
                        end;




                    end;

                }
            }
        }
        area(processing)
        {
            action("View Schedule")
            {
                ApplicationArea = Basic;
                Caption = 'View Schedule';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    EFTHeader.Reset;
                    EFTHeader.SetRange(EFTHeader.No, Rec.No);
                    if EFTHeader.Find('-') then
                        Report.Run(50080, true, true, EFTHeader)
                end;
            }
            action(Transfer)
            {
                ApplicationArea = Basic;
                Caption = 'Transfer';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    GenJournalBatch: Record "Gen. Journal Batch";
                    US: Record "User Setup";
                    Branch: code[20];
                begin

                    Rec.TestField(Rec.Remarks);

                    if Rec.Transferred = true then
                        Error('Funds transfers has already been done.');

                    if Confirm('Are you absolutely sure you want to post the EFT/RTGS tranfers.', false) = false then
                        exit;
                    Branch := '';
                    US.Reset();
                    ;
                    US.SetRange("User ID", UserId);
                    if US.Find('-') then begin
                        Branch := US."Branch Code";
                    end;

                    GenJournalBatch.Reset();
                    GenJournalBatch.SetRange("Journal Template Name", 'PURCHASES');
                    GenJournalBatch.SetRange(GenJournalBatch.Name, 'EFT');
                    if not GenJournalBatch.Find('-') then begin

                        GenJournalBatch."Journal Template Name" := 'PURCHASES';
                        GenJournalBatch.Name := 'EFT';
                        GenJournalBatch.Description := 'EFT transfers';
                        GenJournalBatch.Insert(true);
                    end;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'EFT');
                    if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll;



                    EFTDetails.Reset;
                    EFTDetails.SetRange(EFTDetails."Header No", Rec.No);
                    if EFTDetails.Find('-') then begin
                        repeat



                            if EFTDetails."Destination Account Type" = EFTDetails."destination account type"::Internal then begin

                                EFTDetails.TestField(EFTDetails."Destination Account No");
                                EFTDetails.TestField(EFTDetails.Amount);
                                EFTDetails.TestField(EFTDetails."Destination Account Name");
                                //EFTDetails.TESTFIELD(EFTDetails."Bank No");


                                //Source Account***************************************************************************
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := Rec.No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'EFT to Account ' + EFTDetails."Destination Account No" + ' account: ' + EFTDetails."Destination Account Name";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := EFTDetails.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := Branch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                end;
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Balancing Account*********************************************************************
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := Rec.No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Destination Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'EFT from Account ' + EFTDetails."Account No" + ' account: ' + EFTDetails."Account Name";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -EFTDetails.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := Branch;
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                end;
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Charges*****************************************************************
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := Rec.No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                if Rec.RTGS = true then
                                    GenJournalLine.Description := 'RTGS Charges'
                                else
                                    GenJournalLine.Description := 'EFT Charges';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := EFTDetails.Charges;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := EFTDetails."EFT Charges Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                end;
                                GenJournalLine."Shortcut Dimension 2 Code" := Branch;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");

                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Excise Duty*****************************************************************
                                GenSetup.Get();
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := Rec.No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Excise Duty';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := EFTDetails.Charges * GenSetup."Excise Duty(%)" / 100;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");

                                end;
                                GenJournalLine."Shortcut Dimension 2 Code" := Branch;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;



                            end;




                            //External EFT**************************************************************
                            if EFTDetails."Destination Account Type" = EFTDetails."destination account type"::External then begin

                                EFTDetails.TestField(EFTDetails."Bank No");


                                //Source Account***************************************************************************
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := Rec.No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                if Rec.RTGS = true then
                                    GenJournalLine.Description := 'RTGS ' + EFTDetails."Payee Bank Name" + ' for: ' + EFTDetails."Destination Account Name"
                                else
                                    GenJournalLine.Description := 'EFT to Account ' + EFTDetails."Payee Bank Name" + ' for: ' + EFTDetails."Destination Account Name";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := EFTDetails.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Shortcut Dimension 2 Code" := Branch;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Balancing Account*********************************************************************
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := Rec.No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                GenJournalLine."Account No." := Rec."Bank  No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'EFT ' + EFTDetails."Account No" + '-' + EFTDetails."Account Name";
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -EFTDetails.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Shortcut Dimension 2 Code" := Branch;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Charges*****************************************************************
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := Rec.No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                if Rec.RTGS = true then
                                    GenJournalLine.Description := 'RTGS Charges'
                                else
                                    GenJournalLine.Description := 'EFT Charges';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := EFTDetails.Charges;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := EFTDetails."EFT Charges Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Shortcut Dimension 2 Code" := Branch;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Excise Duty*****************************************************************
                                GenSetup.Get();
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'EFT';
                                GenJournalLine."Document No." := Rec.No;
                                GenJournalLine."External Document No." := CopyStr(EFTDetails."Destination Account No", 1, 20);
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := EFTDetails."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Excise Duty';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := EFTDetails.Charges * GenSetup."Excise Duty(%)" / 100;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := GenSetup."Excise Duty Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                end;
                                GenJournalLine."Shortcut Dimension 2 Code" := Branch;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                            end;

                        until EFTDetails.Next = 0;
                    end;


                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                    GenJournalLine.SetRange("Journal Batch Name", 'EFT');
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;


                    Rec.Transferred := true;
                    Rec."Date Transferred" := Today;
                    Rec."Time Transferred" := Time;
                    Rec."Transferred By" := UserId;
                    Rec.Modify;


                    Message('Transaction Posted successfully.');
                end;
            }
        }
    }

    var
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        LineNo: Integer;
        EFTDetails: Record "EFT/RTGS Details";
        STORegister: Record "Standing Order Register";
        Accounts: Record Vendor;
        EFTHeader: Record "EFT/RTGS Header";
        Transactions: Record Transactions;
        TextGen: Text[250];
        STO: Record "Standing Orders";
        ReffNo: Code[20];
        GenSetup: Record "Sacco General Set-Up";
}

