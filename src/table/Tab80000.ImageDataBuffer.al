

table 80000 "Image Data Buffer"
{
    Caption = 'Image Data Buffer';
    DataClassification = ToBeClassified;
    ReplicateData = false;

    fields
    {
        field(1; "File Name"; Text[260])
        {
            Caption = 'File Name';
        }
        field(2; Picture; Media)
        {
            Caption = 'Picture';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(4; "Item Description"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Caption = 'Item Description';
            FieldClass = FlowField;
        }

        field(6; "Picture Already Exists"; Boolean)
        {
            Caption = 'Picture Already Exists';
        }
        field(7; "File Size (KB)"; BigInteger)
        {
            Caption = 'File Size (KB)';
        }
        field(8; "File Extension"; Text[30])
        {
            Caption = 'File Extension';
        }
        field(9; "Modified Date"; Date)
        {
            Caption = 'Modified Date';
        }
        field(10; "Modified Time"; Time)
        {
            Caption = 'Modified Time';
        }
    }

    keys
    {
        key(Key1; "File Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "File Name", "Item No.", "Item Description", Picture)
        {
        }
    }

    var
        SelectZIPFileMsg: Label 'Select ZIP File';

    [Scope('Cloud')]
    procedure LoadZIPFile(ZipFileName: Text; var TotalCount: Integer; ReplaceMode: Boolean): Text
    var
        Item: Record "Image Data";
        FileMgt: Codeunit "File Management";
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        Window: Dialog;
        EntryList: List of [Text];
        EntryListKey: Text;
        ServerFile: File;
        InStream: InStream;
        EntryOutStream: OutStream;
        EntryInStream: InStream;
        ServerFileOpened: Boolean;
        Length: Integer;
        CustRecord: Record Customer;
    begin
        if ZipFileName <> '' then begin
            //ServerFileOpened := ServerFile.Open(ZipFileName);
            //ServerFile.CreateInStream(InStream)
        end else begin
            if not UploadIntoStream(SelectZIPFileMsg, '', 'Zip Files|*.zip', ZipFileName, InStream) then
                Error('');
        end;

        DataCompression.OpenZipArchive(InStream, false);
        DataCompression.GetEntryList(EntryList);

        Window.Open('#1##############################');

        TotalCount := 0;
        DeleteAll();
        foreach EntryListKey in EntryList do begin
            Init;
            "File Name" :=
                CopyStr(FileMgt.GetFileNameWithoutExtension(EntryListKey), 1, MaxStrLen("File Name"));
            "File Extension" :=
                CopyStr(FileMgt.GetExtension(EntryListKey), 1, MaxStrLen("File Extension"));
            TempBlob.CreateOutStream(EntryOutStream);
            DataCompression.ExtractEntry(EntryListKey, EntryOutStream, Length);
            TempBlob.CreateInStream(EntryInStream);

            if not IsNullGuid(Picture.ImportStream(EntryInStream, FileMgt.GetFileName(EntryListKey))) then begin
                Window.Update(1, "File Name");
                "File Size (KB)" := Length;
                TotalCount += 1;

                Item.Reset();
                Item.SetRange("Member No.", "File Name");
                if Item.FindFirst() then begin
                    "Item No." := Item."ID No.";
                    "Item Description" := Item.Description;
                    if Item."Picture ID".Count > 0 then begin
                        "Picture Already Exists" := true;

                    end;
                    Insert;
                end;
            end;
        end;

        DataCompression.CloseZipArchive;
        Window.Close;

        if ServerFileOpened then
            //ServerFile.Close;
        exit(ZipFileName);
    end;


    [Scope('Cloud')]
    procedure LoadZIPFile2(ZipFileName: Text; var TotalCount: Integer; ReplaceMode: Boolean): Text
    var
        Item: Record "Image Data";
        FileMgt: Codeunit "File Management";
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        Window: Dialog;
        EntryList: List of [Text];
        EntryListKey: Text;
        ServerFile: File;
        InStream: InStream;
        EntryOutStream: OutStream;
        EntryInStream: InStream;
        ServerFileOpened: Boolean;
        Length: Integer;
        CustRecord: Record Customer;
    begin
        if ZipFileName <> '' then begin
            //ServerFileOpened := ServerFile.Open(ZipFileName);
            //ServerFile.CreateInStream(InStream)
        end else begin
            if not UploadIntoStream(SelectZIPFileMsg, '', 'Zip Files|*.zip', ZipFileName, InStream) then
                Error('');
        end;

        DataCompression.OpenZipArchive(InStream, false);
        DataCompression.GetEntryList(EntryList);

        Window.Open('#1##############################');

        TotalCount := 0;
        DeleteAll();
        foreach EntryListKey in EntryList do begin
            Init;
            "File Name" :=
                CopyStr(FileMgt.GetFileNameWithoutExtension(EntryListKey), 1, MaxStrLen("File Name"));
            "File Extension" :=
                CopyStr(FileMgt.GetExtension(EntryListKey), 1, MaxStrLen("File Extension"));
            TempBlob.CreateOutStream(EntryOutStream);
            DataCompression.ExtractEntry(EntryListKey, EntryOutStream, Length);
            TempBlob.CreateInStream(EntryInStream);

            if not IsNullGuid(Picture.ImportStream(EntryInStream, FileMgt.GetFileName(EntryListKey))) then begin
                Window.Update(1, "File Name");
                "File Size (KB)" := Length;
                TotalCount += 1;

                Item.Reset();
                Item.SetRange("Member No.", "File Name");
                if Item.FindFirst() then begin
                    "Item No." := Item."ID No.";
                    "Item Description" := Item.Description;
                    if Item."Signature ID".Count > 0 then begin
                        "Picture Already Exists" := true;

                    end;
                    Insert;
                end;
            end;
        end;

        DataCompression.CloseZipArchive;
        Window.Close;

        if ServerFileOpened then
            //ServerFile.Close;
        exit(ZipFileName);
    end;

    [Scope('Cloud')]
    procedure ImportPictures(ReplaceMode: Boolean)
    var
        Item: Record "Image Data";
        Window: Dialog;
        ImageID: Guid;
    begin
        Window.Open('#1############################################');

        if FindSet() then
            repeat

                if ("Item No." <> '') and ShouldImport(ReplaceMode, "Picture Already Exists") then begin
                    Window.Update(1, "Item No.");

                    Item.Reset();
                    Item.SetRange("ID No.", "Item No.");
                    if Item.FindFirst() then
                        ImageID := Picture.MediaId;
                    if "Picture Already Exists" then
                        Clear(Item."Picture ID");
                    Item."Picture ID".Insert(ImageID);
                    Item.Modify();

                end;
            until Next() = 0;

        Window.Close;
    end;

    procedure ImportSignature(ReplaceMode: Boolean)
    var
        Item: Record "Image Data";
        Window: Dialog;
        ImageID: Guid;
    begin
        Window.Open('#1############################################');

        if FindSet() then
            repeat

                if ("Item No." <> '') and ShouldImport(ReplaceMode, "Picture Already Exists") then begin
                    Window.Update(1, "Item No.");

                    Item.Reset();
                    Item.SetRange("Member No.", "Item No.");
                    if Item.FindFirst() then
                        ImageID := Picture.MediaId;
                    if "Picture Already Exists" then
                        Clear(Item."Signature ID");
                    Item."Signature ID".Insert(ImageID);
                    Item.Modify();

                end;
            until Next() = 0;

        Window.Close;
    end;

    local procedure ShouldImport(ReplaceMode: Boolean; PictureExists: Boolean): Boolean
    begin
        if not ReplaceMode and PictureExists then
            exit(false);

        exit(true);
    end;

    [Scope('Cloud')]
    procedure GetAddCount(): Integer
    var
        TempItemPictureBuffer2: Record "Image Data Buffer" temporary;
    begin
        TempItemPictureBuffer2.Copy(Rec, true);
        TempItemPictureBuffer2.SetRange("Picture Already Exists", false);
        exit(Count);
    end;

    [Scope('Cloud')]
    procedure GetAddedCount(): Integer
    var
        TempItemPictureBuffer2: Record "Image Data Buffer" temporary;
    begin

        TempItemPictureBuffer2.Copy(Rec, true);

        TempItemPictureBuffer2.SetRange("Picture Already Exists", false);
        exit(Count);
    end;

    [Scope('Cloud')]
    procedure GetReplaceCount(): Integer
    var
        TempItemPictureBuffer2: Record "Image Data Buffer" temporary;
    begin

        TempItemPictureBuffer2.Copy(Rec, true);

        TempItemPictureBuffer2.SetRange("Picture Already Exists", true);
        exit(Count);
    end;

    [Scope('Cloud')]
    procedure GetReplacedCount(): Integer
    var
        TempItemPictureBuffer2: Record "Image Data Buffer" temporary;
    begin

        TempItemPictureBuffer2.Copy(Rec, true);

        TempItemPictureBuffer2.SetRange("Picture Already Exists", true);
        exit(Count);

    end;

}
