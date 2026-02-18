//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172515 "Product Card Editable"
{
    Caption = 'Account Card';
    DeleteAllowed = true;
    Editable = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = Vendor;
    SourceTableView = where("Creditor Type" = const("FOSA Account"),
                            "Debtor Type" = const("FOSA Account"));

    layout
    {
        area(content)
        {
            group(AccountTab)
            {
                Caption = 'General Info';
                Editable = true;
                field("No.";Rec."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Account Category";Rec."Account Category")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";Rec."ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = true;
                }
                field("Passport No.";Rec."Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Personal No.";Rec."Personal No.")
                {
                    ApplicationArea = Basic;
                }
                field("Pension No";Rec."Pension No")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA Account No";Rec."BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Mobile Phone No";Rec."Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Employer Code";Rec."Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Station/Sections";Rec."Station/Sections")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Phone No.";Rec."Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Date of Birth";Rec."Date of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = true;
                }
                field(txtGender; Rec.Gender)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status";Rec."Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Registration Date";Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Uncleared Cheques";Rec."Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Balance (LCY)";Rec."Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Book Balance';
                    Enabled = false;
                    Visible = false;
                }
                field(AvailableBal; Rec."Balance (LCY)" - (Rec."Uncleared Cheques" + Rec."ATM Transactions" + Rec."EFT Transactions" + MinBalance))
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawable Balance';
                    Editable = false;
                }
                field("Cheque Discounted";Rec."Cheque Discounted")
                {
                    ApplicationArea = Basic;
                }
                field("Vendor Posting Group";Rec."Vendor Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Reason For Blocking Account";Rec."Reason For Blocking Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        //TESTFIELD("Resons for Status Change");
                    end;
                }
                field("Account Frozen";Rec."Account Frozen")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM No.";Rec."ATM No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque Book Account No";Rec."Cheque Book Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified";Rec."Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Picture; Rec.Image)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Standard;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        Rec.TestField("Resons for Status Change");

                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Account Status");
                        if StatusPermissions.Find('-') = false then
                            Error('You do not have permissions to change the account status.');

                        if Rec."Account Type" = 'FIXED' then begin
                            if Rec."Balance (LCY)" > 0 then begin
                                Rec.CalcFields("Last Interest Date");

                                if Rec."Call Deposit" = true then begin
                                    if Rec.Status = Rec.Status::Dormant then begin
                                        if Rec."Last Interest Date" < Today then
                                            Error('Fixed deposit interest not UPDATED. Please update interest.');
                                    end else begin
                                        if Rec."Last Interest Date" < Rec."FD Maturity Date" then
                                            Error('Fixed deposit interest not UPDATED. Please update interest.');
                                    end;
                                end;
                            end;
                        end;

                        if Rec.Status = Rec.Status::Active then begin
                            if Confirm('Are you sure you want to re-activate this account? This will recover re-activation fee.', false) = false then begin
                                Error('Re-activation terminated.');
                            end;

                            Rec.Blocked := Rec.Blocked::" ";
                            Rec.Modify;





                        end;


                        //Account Closure
                        if Rec.Status = Rec.Status::Dormant then begin
                            Rec.TestField("Closure Notice Date");
                            if Confirm('Are you sure you want to close this account? This will recover closure fee and any '
                            + 'interest earned before maturity will be forfeited.', false) = false then begin
                                Error('Closure terminated.');
                            end;


                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                            if GenJournalLine.Find('-') then
                                GenJournalLine.DeleteAll;



                            AccountTypes.Reset;
                            AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                            if AccountTypes.Find('-') then begin
                                Rec."Date Closed" := Today;

                                //Closure charges
                                /*Charges.RESET;
                                IF CALCDATE(AccountTypes."Closure Notice Period","Closure Notice Date") > TODAY THEN
                                Charges.SETRANGE(Charges.Code,AccountTypes."Closing Prior Notice Charge") */

                                Charges.Reset;
                                if CalcDate(AccountTypes."Closure Notice Period", Rec."Closure Notice Date") > Today then
                                    Charges.SetRange(Charges.Code, AccountType."Closing Charge")

                                else
                                    Charges.SetRange(Charges.Code, AccountTypes."Closing Charge");
                                if Charges.Find('-') then begin
                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No." + '-CL';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := Rec."No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := Charges.Description;
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := Charges."Charge Amount";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := Charges."GL Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                end;
                                //Closure charges


                                //Interest forfeited/Earned on maturity
                                Rec.CalcFields("Untranfered Interest");
                                if Rec."Untranfered Interest" > 0 then begin
                                    ForfeitInterest := true;
                                    //If FD - Check if matured
                                    if AccountTypes."Fixed Deposit" = true then begin
                                        if Rec."FD Maturity Date" <= Today then
                                            ForfeitInterest := false;
                                        if Rec."Call Deposit" = true then
                                            ForfeitInterest := false;

                                    end;

                                    //PKK INGORE MATURITY
                                    ForfeitInterest := false;
                                    //If FD - Check if matured

                                    if ForfeitInterest = true then begin
                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := Rec."No." + '-CL';
                                        GenJournalLine."External Document No." := Rec."No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                        GenJournalLine."Account No." := AccountTypes."Interest Forfeited Account";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Interest Forfeited';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := -Rec."Untranfered Interest";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                        GenJournalLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        InterestBuffer.Reset;
                                        InterestBuffer.SetRange(InterestBuffer."Account No", Rec."No.");
                                        if InterestBuffer.Find('-') then
                                            InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);


                                    end else begin
                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := Rec."No." + '-CL';
                                        GenJournalLine."External Document No." := Rec."No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        if AccountTypes."Fixed Deposit" = true then
                                            GenJournalLine."Account No." := Rec."Savings Account No."
                                        else
                                            GenJournalLine."Account No." := Rec."No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'Interest Earned';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        GenJournalLine.Amount := -Rec."Untranfered Interest";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                        GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
                                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        InterestBuffer.Reset;
                                        InterestBuffer.SetRange(InterestBuffer."Account No", Rec."No.");
                                        if InterestBuffer.Find('-') then
                                            InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);



                                    end;


                                    //Transfer Balance if Fixed Deposit
                                    if AccountTypes."Fixed Deposit" = true then begin
                                        Rec.CalcFields("Balance (LCY)");

                                        Rec.TestField("Savings Account No.");

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := Rec."No." + '-CL';
                                        GenJournalLine."External Document No." := Rec."No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := Rec."Savings Account No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'FD Balance Tranfers';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        if Rec."Amount to Transfer" <> 0 then
                                            GenJournalLine.Amount := -Rec."Amount to Transfer"
                                        else
                                            GenJournalLine.Amount := -Rec."Balance (LCY)";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;

                                        LineNo := LineNo + 10000;

                                        GenJournalLine.Init;
                                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                                        GenJournalLine."Line No." := LineNo;
                                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                                        GenJournalLine."Document No." := Rec."No." + '-CL';
                                        GenJournalLine."External Document No." := Rec."No.";
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Account No." := Rec."No.";
                                        GenJournalLine.Validate(GenJournalLine."Account No.");
                                        GenJournalLine."Posting Date" := Today;
                                        GenJournalLine.Description := 'FD Balance Tranfers';
                                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                                        if Rec."Amount to Transfer" <> 0 then
                                            GenJournalLine.Amount := Rec."Amount to Transfer"
                                        else
                                            GenJournalLine.Amount := Rec."Balance (LCY)";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;


                                    end;

                                    //Transfer Balance if Fixed Deposit


                                end;

                                //Interest forfeited/Earned on maturity
                                /*
                                //Post New
                                GenJournalLine.RESET;
                                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                                GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                                IF GenJournalLine.FIND('-') THEN BEGIN
                                CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                                END;
                                //Post New
                                */

                                Message('Funds transfered successfully to main account and account closed.');




                            end;
                        end;


                        //Account Closure

                    end;
                }
                field("Closure Notice Date";Rec."Closure Notice Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Resons for Status Change";Rec."Resons for Status Change")
                {
                    ApplicationArea = Basic;
                }
                field("Signing Instructions";Rec."Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field("Interest Earned";Rec."Interest Earned")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Allowable Cheque Discounting %";Rec."Allowable Cheque Discounting %")
                {
                    ApplicationArea = Basic;
                }
                field("Salary Processing";Rec."Salary Processing")
                {
                    ApplicationArea = Basic;
                }
                field("Assigned System ID";Rec."Assigned System ID")
                {
                    ApplicationArea = Basic;
                }
                field("Staff Account";Rec."Staff Account")
                {
                    ApplicationArea = Basic;
                }
            }
            group(AccountTab1)
            {
                Caption = 'Communication Info';
                Editable = true;
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic;
                }
                field("Post Code";Rec."Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code/City';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic;
                }
                field("Address 2";Rec."Address 2")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail";Rec."E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Home Page";Rec."Home Page")
                {
                    ApplicationArea = Basic;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = Basic;
                }
                field("ContacPerson Phone";Rec."ContacPerson Phone")
                {
                    ApplicationArea = Basic;
                }
                field("ContactPerson Occupation";Rec."ContactPerson Occupation")
                {
                    ApplicationArea = Basic;
                }
                field(CodeDelete; Rec.CodeDelete)
                {
                    ApplicationArea = Basic;
                }
                field("Home Address";Rec."Home Address")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Fixed Deposit Details")
            {
                Caption = 'Fixed Deposit Details';
                field("Fixed Deposit Type";Rec."Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = true;
                }
                field(regdate; Rec."Registration Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Registration Date';
                    Editable = false;
                }
                field("FD Duration";Rec."FD Duration")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Enabled = true;
                }
                field("FD Maturity Date";Rec."FD Maturity Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Maturity Date';
                    Editable = true;
                }
                field("Date Renewed";Rec."Date Renewed")
                {
                    ApplicationArea = Basic;
                }
                field("Fixed Deposit Status";Rec."Fixed Deposit Status")
                {
                    ApplicationArea = Basic;
                }
                field("FDR Deposit Status Type";Rec."FDR Deposit Status Type")
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate";Rec."Interest rate")
                {
                    ApplicationArea = Basic;
                }
                field("Savings Account No.";Rec."Savings Account No.")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Amount to Transfer";Rec."Amount to Transfer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount to Transfer';
                }
                field("Transfer Amount to Savings";Rec."Transfer Amount to Savings")
                {
                    ApplicationArea = Basic;
                }
            }
            group("ATM Details")
            {
                Caption = 'ATM Details';
                field("ATM No.B";Rec."ATM No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Transactions";Rec."ATM Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Atm card ready";Rec."Atm card ready")
                {
                    ApplicationArea = Basic;
                    Caption = 'ATM Card Ready For Collection';
                }
                field("ATM Issued";Rec."ATM Issued")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Self Picked";Rec."ATM Self Picked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector Name";Rec."ATM Collector Name")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector's ID";Rec."ATM Collector's ID")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector's Mobile";Rec."ATM Collector's Mobile")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000034; "FOSA Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Account)
            {
                Caption = 'Account';
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = field("No.");
                    RunPageView = sorting("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Vendor),
                                  "No." = field("No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = const(23),
                                  "No." = field("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                separator(Action108)
                {
                }
                action("Account Agent Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Mandate';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Account Agent List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Re-new Fixed Deposit")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-new Fixed Deposit';
                    Image = "Report";

                    trigger OnAction()
                    begin

                        if AccountTypes.Get(Rec."Account Type") then begin
                            if AccountTypes."Fixed Deposit" = true then begin
                                if Rec."Call Deposit" = false then begin
                                    Rec.TestField("Fixed Duration");
                                    Rec.TestField("FD Maturity Date");
                                    if Rec."FD Maturity Date" > Today then
                                        Error('Fixed deposit has not matured.');

                                end;

                                if Rec."Don't Transfer to Savings" = false then
                                    Rec.TestField("Savings Account No.");

                                Rec.CalcFields("Last Interest Date");

                                if Rec."Call Deposit" = true then begin
                                    if Rec."Last Interest Date" < Today then
                                        Error('Fixed deposit interest not UPDATED. Please update interest.');
                                end else begin
                                    if Rec."Last Interest Date" < Rec."FD Maturity Date" then
                                        Error('Fixed deposit interest not UPDATED. Please update interest.');
                                end;




                                if Confirm('Are you sure you want to renew this Fixed deposit. Interest will be transfered accordingly?') = false then
                                    exit;


                                Rec.CalcFields("Untranfered Interest");

                                if Rec."Call Deposit" = false then begin
                                    Rec."Date Renewed" := Rec."FD Maturity Date";
                                end else
                                    Rec."Date Renewed" := Today;
                                Rec.Validate("Date Renewed");
                                Rec.Modify;

                                GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;



                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No." + '-RN';
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                if Rec."Don't Transfer to Savings" = false then
                                    GenJournalLine."Account No." := Rec."Savings Account No."
                                else
                                    GenJournalLine."Account No." :=Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'Interest Earned';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := -Rec."Untranfered Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := AccountTypes."Interest Payable Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                InterestBuffer.Reset;
                                InterestBuffer.SetRange(InterestBuffer."Account No", Rec."No.");
                                if InterestBuffer.Find('-') then
                                    InterestBuffer.ModifyAll(InterestBuffer.Transferred, true);


                                //Post
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);
                                end;




                                Message('Fixed deposit renewed successfully');
                            end;
                        end;
                    end;
                }
                separator(Action1102760068)
                {
                }
                separator(Action1102760082)
                {
                }
                action("<Page Member Page - BOSA>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Page';
                    Image = Planning;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = New;
                    RunObject = Page "Member Account Card";
                    RunPageLink = "No." = field("BOSA Account No");
                }
                action("<Action11027600800>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Statements';
                    Image = "Report";
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,TRUE,Cust)
                        */

                    end;
                }
                action("BOSA Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", Rec."BOSA Account No");
                        if Cust.Find('-') then
                            Report.run(172360, true, true, Cust);
                    end;
                }
                action("FOSA Loans")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    RunObject = Page "Loans Sub-Page List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Close Account")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to Close this Account?', false) = true then begin
                            if Rec."Balance (LCY)" - (Rec."Uncleared Cheques" + Rec."ATM Transactions" + Rec."EFT Transactions" + MinBalance + UnclearedLoan) < 0 then
                                Error('This Member does not enough Savings to recover Withdrawal Fee')
                            else
                                LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."account type"::Vendor;
                            Gnljnline."Account No." := Rec."No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No." := 'LR-' + Rec."No.";
                            Gnljnline."Posting Date" := Today;
                            Gnljnline.Amount := 500;
                            Gnljnline.Description := 'Account Closure Fee';
                            Gnljnline.Validate(Gnljnline.Amount);
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;

                            LineN := LineN + 10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name" := 'GENERAL';
                            Gnljnline."Journal Batch Name" := 'ACC CLOSED';
                            Gnljnline."Line No." := LineN;
                            Gnljnline."Account Type" := Gnljnline."bal. account type"::"G/L Account";
                            Gnljnline."Bal. Account No." := '105113';
                            Gnljnline.Validate(Gnljnline."Bal. Account No.");
                            Gnljnline."Document No." := 'LR-' + Rec."No.";
                            Gnljnline."Posting Date" := Today;
                            Gnljnline.Amount := -500;
                            Gnljnline.Description := 'Account Closure Fee';
                            Gnljnline.Validate(Gnljnline.Amount);
                            if Gnljnline.Amount <> 0 then
                                Gnljnline.Insert;


                        end;
                    end;
                }
                separator(Action1102760142)
                {
                }
                action("<Action110276013300>")
                {
                    ApplicationArea = Basic;
                    Caption = 'Update FDR Interest';
                    Image = "Report";

                    trigger OnAction()
                    begin
                        if Rec."Account Type" <> 'FIXED' then
                            Error('Only applicable for Fixed Deposit accounts.');

                        Rec.CalcFields("Last Interest Date");

                        if Rec."Last Interest Date" >= Today then
                            Error('Interest Up to date.');

                        //IF CONFIRM('Are you sure you want to update the Fixed deposit interest.?') = FALSE THEN
                        //EXIT;

                        /*
                        Vend.RESET;
                        Vend.SETRANGE(Vend."No.","No.");
                        IF Vend.FIND('-') THEN
                        REPORT.RUN(,TRUE,TRUE,Vend)
                        */

                    end;
                }
            }
            group(ActionGroup1102755009)
            {
                action(" Account Nominee Details")
                {
                    ApplicationArea = Basic;
                    Caption = ' Account Nominee Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "FOSA Account  NOK Details";
                    RunPageLink = "Account No" = field("No.");
                }
                separator(Action1102755005)
                {
                }
                action("Transfer FD Amnt from Savings")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        //Transfer Balance if Fixed Deposit

                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                        if AccountTypes.Find('-') then begin
                            //IF AccountTypes."Fixed Deposit" <> TRUE THEN BEGIN
                            if Vend.Get(Rec."Savings Account No.") then begin
                                if Confirm('Are you sure you want to effect the transfer from the savings account', false) = false then
                                    exit else
                                    GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                Vend.Reset;
                                if Vend.Find('-') then
                                    Vend.CalcFields(Vend."Balance (LCY)");
                                //IF (Vend."Balance (LCY)" - 500) < "Fixed Deposit Amount" THEN
                                //ERROR('Savings account does not have enough money to facilate the requested trasfer.');
                                //MESSAGE('Katabaka ene!');
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No." + '-OP';
                                GenJournalLine."External Document No." :=Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."Savings Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'FD Balance Tranfers';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                //GenJournalLine.Amount:="Fixed Deposit Amount";
                                GenJournalLine.Amount := Rec."Amount to Transfer";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                                //MESSAGE('The FDR amount is %1 ',"Fixed Deposit Amount");
                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." := Rec."No." + '-OP';
                                GenJournalLine."External Document No." := Rec."No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := 'FD Balance Tranfers';
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                //GenJournalLine.Amount:=-"Fixed Deposit Amount";
                                GenJournalLine.Amount := -Rec."Amount to Transfer";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                //END;
                            end;
                        end;
                        /*
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        REPEAT
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",GenJournalLine);
                        UNTIL GenJournalLine.NEXT = 0;
                        END;
                        */


                        /*//Post New
                        
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        END;
                        
                        //Post New
                        */

                        /*
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                        GenJournalLine.DELETEALL;
                        
                           */
                        //Transfer Balance if Fixed Deposit

                    end;
                }
                action("Transfer FD Amount to Savings")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        //Transfer Balance if Fixed Deposit

                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                        if AccountTypes.Find('-') then begin
                            if AccountTypes."Fixed Deposit" = true then begin
                                if Vend.Get(Rec."No.") then begin
                                    if Confirm('Are you sure you want to effect the transfer from the Fixed Deposit account', false) = false then
                                        exit;

                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                    if GenJournalLine.Find('-') then
                                        GenJournalLine.DeleteAll;

                                    Vend.CalcFields(Vend."Balance (LCY)");
                                    if (Vend."Balance (LCY)") < Rec."Transfer Amount to Savings" then
                                        Error('Fixed Deposit account does not have enough money to facilate the requested trasfer.');

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No." + '-OP';
                                    GenJournalLine."External Document No." := Rec."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := Rec."No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'FD Balance Tranfers';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := Rec."Transfer Amount to Savings";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No." + '-OP';
                                    GenJournalLine."External Document No." := Rec."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := Rec."Savings Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'FD Balance Tranfers';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := -Rec."Transfer Amount to Savings";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                end;
                            end;
                        end;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            repeat
                            //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        Message('Amount transfered successfully.');
                    end;
                }
                action("Renew Fixed deposit")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        if AccountTypes.Get(Rec."Account Type") then begin
                            if AccountTypes."Fixed Deposit" = true then begin
                                if Confirm('Are you sure you want to renew the fixed deposit.', false) = false then
                                    exit;

                                Rec.TestField("FD Maturity Date");
                                if FDType.Get(Rec."Fixed Deposit Type") then begin
                                    Rec."FD Maturity Date" := CalcDate(FDType.Duration, Rec."FD Maturity Date");
                                    Rec."Date Renewed" := Today;
                                    Rec."FDR Deposit Status Type" := Rec."fdr deposit status type"::New;
                                    Rec.Modify;

                                    Message('Fixed deposit renewed successfully');
                                end;
                            end;
                        end;
                    end;
                }
                action("Terminate Fixed Deposit")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin

                        //Transfer Balance if Fixed Deposit

                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                        if AccountTypes.Find('-') then begin
                            if AccountTypes."Fixed Deposit" = true then begin
                                if Vend.Get(Rec."No.") then begin
                                    if Confirm('Are you sure you want to Terminate this Fixed Deposit Contract?', false) = false then
                                        exit;

                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                    GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                    if GenJournalLine.Find('-') then
                                        GenJournalLine.DeleteAll;

                                    Vend.CalcFields(Vend."Balance (LCY)");
                                    if (Vend."Balance (LCY)") < Rec."Transfer Amount to Savings" then
                                        Error('Fixed Deposit account does not have enough money to facilate the requested trasfer.');

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." := Rec."No." + '-OP';
                                    GenJournalLine."External Document No." :=Rec."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." :=Rec."No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'FD Termination Tranfer';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount :=Rec."Balance (LCY)";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                    LineNo := LineNo + 10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name" := 'PURCHASES';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Journal Batch Name" := 'FTRANS';
                                    GenJournalLine."Document No." :=Rec."No." + '-OP';
                                    GenJournalLine."External Document No." :=Rec."No.";
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." :=Rec."Savings Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Posting Date" := Today;
                                    GenJournalLine.Description := 'FD Termination Tranfer';
                                    GenJournalLine.Validate(GenJournalLine."Currency Code");
                                    GenJournalLine.Amount := -Rec."Balance (LCY)";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;

                                end;
                            end;
                        end;

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            repeat
                            //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                            until GenJournalLine.Next = 0;
                        end;


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        Message('Amount transfered successfully back to the savings Account.');
                        Rec."FDR Deposit Status Type" :=Rec."fdr deposit status type"::Renewed;

                        /*
                       //Renew Fixed deposit - OnAction()

                       IF AccountTypes.GET("Account Type") THEN BEGIN
                       IF AccountTypes."Fixed Deposit" = TRUE THEN BEGIN
                       IF CONFIRM('Are you sure you want to renew the fixed deposit.',FALSE) = FALSE THEN
                       EXIT;

                       TESTFIELD("FD Maturity Date");
                       IF FDType.GET("Fixed Deposit Type") THEN BEGIN
                       "FD Maturity Date":=CALCDATE(FDType.Duration,"FD Maturity Date");
                       "Date Renewed":=TODAY;
                       "FDR Deposit Status Type":="FDR Deposit Status Type"::Renewed;
                       MODIFY;

                       MESSAGE('Fixed deposit renewed successfully');
                       END;
                       END;
                       END;
                         */

                    end;
                }
                action("Page Vendor Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        Vend.Reset;
                        Vend.SetRange(Vend."No.", Rec."No.");
                        if Vend.Find('-') then
                            Report.run(172476, true, false, Vend)
                    end;
                }
                action("Page Vendor Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No." = field("No."),
                                  "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                    Visible = false;
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("BOSA Account No");
                }
                action("Charge Fosa Statement")
                {
                    ApplicationArea = Basic;
                    Image = PostApplication;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to charge statement fee? This will recover statement fee.', false) = false then
                            exit;

                        Rec.CalcFields("Balance (LCY)", "ATM Transactions");
                        if (Rec."Balance (LCY)" - Rec."ATM Transactions") <= 0 then
                            Error('This Account does not have sufficient funds');


                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                        if AccountTypes.Find('-') then begin

                            //Closure charges
                            Charges.Reset;
                            Charges.SetRange(Charges.Code, AccountTypes."Statement Charge");
                            if Charges.Find('-') then begin
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." :=Rec."No." + '-STM';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." :=Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := Charges.Description;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Charges."Charge Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := Charges."GL Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Post New
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then begin
                                    //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                                end;

                                //Post New


                            end;
                            //Closure charges

                        end;
                    end;
                }
                action("Recover Class B Shares")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Image = PostApplication;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin

                        if Rec."Account Type" = 'SPECIAL' then
                            Error('You cannot recover Class B Shares from this account');

                        if Rec."Shares Recovered" = true then
                            Error('Class B shares already recovered');

                        if Confirm('Are you sure you want to recover Class B shares? This will recover Class B shares.', false) = false then
                            exit;


                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                        if AccountTypes.Find('-') then begin

                            // charges
                            Charges.Reset;
                            Charges.SetRange(Charges.Code, AccountTypes."FOSA Shares");
                            if Charges.Find('-') then begin
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                Rec.CalcFields("Balance (LCY)", "ATM Transactions");
                                if (Rec."Balance (LCY)" - Rec."ATM Transactions") <= Charges."Charge Amount" then
                                    Error('This Account does not have sufficient funds');

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." :=Rec."No." + '-FSH';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." :=Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := Charges.Description;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Charges."Charge Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := Charges."GL Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Post New
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then begin
                                    //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                                end;

                                //Post New


                            end;
                            //Closure charges

                        end;

                        Rec."Shares Recovered" := true;
                        Rec."ClassB Shares" := -Charges."Charge Amount";
                        Rec.Modify;
                    end;
                }
                action("Charge ATM Card Placement")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Image = PostApplication;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to post the ATM Charges fee?') = false then
                            exit;


                        Rec.CalcFields("Balance (LCY)", Rec."ATM Transactions");
                        if (Rec."Balance (LCY)" - Rec."ATM Transactions") <= 0 then
                            Error('This Account does not have sufficient funds');


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." :=Rec."No.";
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." :=Rec."Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges: ' + Rec."Card No.";
                        GenJournalLine.Amount := 550;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No." := 'BNK000001';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." :=Rec."Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges: No.' + Rec."Card No.";
                        GenJournalLine.Amount := -500;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Comms to Commissions account
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := '4-11-000310';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." :=Rec."Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges' + 'No.' + Rec."Card No.";
                        GenJournalLine.Amount := -50;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;



                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        end;
                        //Post New
                    end;
                }
                action("Charge ATM Card Replacement")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Image = PostApplication;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to post the ATM Charges fee?') = false then
                            exit;


                        Rec.CalcFields("Balance (LCY)", Rec."ATM Transactions");
                        if (Rec."Balance (LCY)" - Rec."ATM Transactions") <= 0 then
                            Error('This Account does not have sufficient funds');


                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        GenJournalLine.DeleteAll;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." :=Rec."No.";
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." :=Rec."Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges: ' + Rec."Card No.";
                        GenJournalLine.Amount := 600;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;


                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No." := 'BNK000001';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." :=Rec."Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges: No.' + Rec."Card No.";
                        GenJournalLine.Amount := -500;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        //Comms to Commissions account
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PURCHASES';
                        GenJournalLine."Journal Batch Name" := 'FTRANS';
                        GenJournalLine."Line No." := GenJournalLine."Line No." + 1000;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := '4-11-000310';
                        GenJournalLine."Posting Date" := Today;
                        GenJournalLine."Document No." :=Rec."Card No.";
                        GenJournalLine.Description := 'Sacco Link Card Charges' + 'No.' + Rec."Card No.";
                        GenJournalLine.Amount := -100;
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;



                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                        GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                        if GenJournalLine.Find('-') then begin
                            //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        end;
                        //Post New
                    end;
                }
                action("Charge Pass Book")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Image = PostApplication;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Confirm('Are you sure you want to charge Pass book fee? This will recover passbook fee.', false) = false then
                            exit;

                        Rec.CalcFields("Balance (LCY)", "ATM Transactions");
                        if (Rec."Balance (LCY)" - Rec."ATM Transactions") <= 0 then
                            Error('This Account does not have sufficient funds');


                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Rec."Account Type");
                        if AccountTypes.Find('-') then begin

                            //Closure charges
                            Charges.Reset;
                            Charges.SetRange(Charges.Code, AccountTypes."Statement Charge");
                            if Charges.Find('-') then begin
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange(GenJournalLine."Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then
                                    GenJournalLine.DeleteAll;

                                LineNo := LineNo + 10000;

                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PURCHASES';
                                GenJournalLine."Journal Batch Name" := 'FTRANS';
                                GenJournalLine."Document No." :=Rec."No." + '-STM';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." :=Rec."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Description := Charges.Description;
                                GenJournalLine.Validate(GenJournalLine."Currency Code");
                                GenJournalLine.Amount := Charges."Charge Amount";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := Charges."GL Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Post New
                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'PURCHASES');
                                GenJournalLine.SetRange("Journal Batch Name", 'FTRANS');
                                if GenJournalLine.Find('-') then begin
                                    //CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                                end;

                                //Post New


                            end;
                            //Closure charges

                        end;
                    end;
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    RunObject = Page "Account Signatories Card";
                    RunPageLink = "Account No" = field("No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        //Hide balances for hidden accounts
        /*IF CurrForm.UnclearedCh.VISIBLE=FALSE THEN BEGIN
        CurrForm.BookBal.VISIBLE:=TRUE;
        CurrForm.UnclearedCh.VISIBLE:=TRUE;
        CurrForm.AvalBal.VISIBLE:=TRUE;
        CurrForm.Statement.VISIBLE:=TRUE;
        CurrForm.Account.VISIBLE:=TRUE;
        END;
        
        
        IF Hide = TRUE THEN BEGIN
        IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID."Show Hiden" = FALSE THEN BEGIN
        CurrForm.BookBal.VISIBLE:=FALSE;
        CurrForm.UnclearedCh.VISIBLE:=FALSE;
        CurrForm.AvalBal.VISIBLE:=FALSE;
        CurrForm.Statement.VISIBLE:=FALSE;
        CurrForm.Account.VISIBLE:=FALSE;
        END;
        END;
        END;
        //Hide balances for hidden accounts
          */
        MinBalance := 0;
        if AccountType.Get(Rec."Account Type") then
            MinBalance := AccountType."Minimum Balance";

        /*CurrForm.lblID.VISIBLE := TRUE;
        CurrForm.lblDOB.VISIBLE := TRUE;
        CurrForm.lblRegNo.VISIBLE := FALSE;
        CurrForm.lblRegDate.VISIBLE := FALSE;
        CurrForm.lblGender.VISIBLE := TRUE;
        CurrForm.txtGender.VISIBLE := TRUE;
        if Rec."Account Category" <> "Account Category"::Single THEN BEGIN
        CurrForm.lblID.VISIBLE := FALSE;
        CurrForm.lblDOB.VISIBLE := FALSE;
        CurrForm.lblRegNo.VISIBLE := TRUE;
        CurrForm.lblRegDate.VISIBLE := TRUE;
        CurrForm.lblGender.VISIBLE := FALSE;
        CurrForm.txtGender.VISIBLE := FALSE;
        END;*/
        OnAfterGetCurrRecords;

        Statuschange.Reset;
        Statuschange.SetRange(Statuschange."User ID", UserId);
        Statuschange.SetRange(Statuschange."Function", Statuschange."function"::"Account Status");
        if not Statuschange.Find('-') then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;

        Rec.CalcFields(NetDis);
        UnclearedLoan := Rec.NetDis;
        //MESSAGE('Uncleared loan is %1',UnclearedLoan);

    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Rec.Find(Which);
        CurrPage.Editable := RecordFound or (Rec.GetFilter(Rec."No.") = '');
        exit(RecordFound);
    end;

    trigger OnInit()
    begin
        if Rec."Assigned System ID" <> '' then begin
            UsersRec.Reset;
            UsersRec.SetRange(UsersRec."User Name", UserId);
            if UsersRec.Find('-') then begin
                // if (UsersRec."View Special Accounts" = false) and (UserId <> "Assigned System ID") then
                //     Error('You dont have permissions to view this account, Contact your system administrator! ')
            end;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Creditor Type" :=Rec."creditor type"::"FOSA Account";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecords();
    end;

    trigger OnOpenPage()
    begin
        ActivateFields;
        /*
        IF NOT MapMgt.TestSetup THEN
          CurrForm.MapPoint.VISIBLE(FALSE);
        */


        //Filter based on branch
        /*IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID.Branch <> '' THEN
        SETRANGE("Global Dimension 2 Code",UsersID.Branch);
        END;*/
        //Filter based on branch

    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        PictureExists: Boolean;
        AccountTypes: Record "Account Types-Saving Products";
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        ForfeitInterest: Boolean;
        InterestBuffer: Record "Interest Buffer";
        FDType: Record "Fixed Deposit Type";
        Vend: Record Vendor;
        Cust: Record "Members Register";
        LineNo: Integer;
        UsersID: Record User;
        DActivity: Code[20];
        DBranch: Code[20];
        MinBalance: Decimal;
        OBalance: Decimal;
        OInterest: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loan GuarantorsFOSA";
        Loans: Record "Loans Register";
        DefaulterType: Code[20];
        LastWithdrawalDate: Date;
        AccountType: Record "Account Types-Saving Products";
        ReplCharge: Decimal;
        Acc: Record Vendor;
        SearchAcc: Code[10];
        Searchfee: Decimal;
        Statuschange: Record "Status Change Permision";
        UnclearedLoan: Decimal;
        LineN: Integer;
        UsersRec: Record User;


    procedure ActivateFields()
    begin
        //CurrForm.Contact.EDITABLE("Primary Contact No." = '');
    end;

    local procedure OnAfterGetCurrRecords()
    begin
        xRec := Rec;
        ActivateFields;
    end;
}




