page 17370 MemberPhoto
{
    ApplicationArea = All;
    Caption = 'MemberPhoto';
    PageType = Card;
    SourceTable = "Membership Applications";


    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = Basic;
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for the member.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take';
                Image = Camera;

                ToolTip = 'Activate the camera on the device.';

                trigger OnAction()
                begin
                    TakeNewPicture;
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                Visible = HideActions = false;

                trigger OnAction()
                begin
                    ImportFromDevice;
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the picture to a file.';
                Visible = (CameraAvailable = false) and (HideActions = false);

                trigger OnAction()
                var
                    NameValueBuffer: Record "Name/Value Buffer";
                    TempNameValueBuffer: Record "Name/Value Buffer" temporary;
                    FileManagement: Codeunit "File Management";
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    Rec.TestField("No.");
                    // NameValueBuffer.DeleteAll;
                    // ExportPath := TemporaryPath + Rec."No." + Format(Rec.Picture.MediaId);
                    // Rec.Picture.ExportFile(ExportPath);
                    // FileManagement.GetServerDirectoryFilesList(TempNameValueBuffer, TemporaryPath);
                    // TempNameValueBuffer.SetFilter(Name, StrSubstNo('%1*', ExportPath));
                    // TempNameValueBuffer.FindFirst;
                    // ToFile := StrSubstNo('%1 %2.jpg', Rec."No.", ConvertStr(Rec."No.", '"/\', '___'));
                    // Download(TempNameValueBuffer.Name, DownloadImageTxt, '', '', ToFile);
                    // if FileManagement.DeleteServerFile(TempNameValueBuffer.Name) then;
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                //Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';
                Visible = HideActions = false;

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Approved then begin
                        DeleteItemPicture;
                    end;

                end;
            }
        }
    }

    var
        // [RunOnClient]
        // [WithEvents]
        // CameraProvider: dotnet CameraProvider;
        CameraAvailable: Boolean;
        DeleteExportEnabled: Boolean;
        HideActions: Boolean;
        OverrideImageQst: label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: label 'Select a picture to upload';
        DownloadImageTxt: label 'Download image';

    procedure TakeNewPicture()
    var
        Camera: Codeunit Camera;
        inst: InStream;
        CameraOp: Page Camera;
        oust: OutStream;
        Filename: Text;
        MimeTypeTok: Label 'image/jpeg';

        ImageEnc: Enum "Image Encoding";
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        Rec.Find;
        Rec.TestField("No.");
        PictureDescription := Rec.Name;
        //TESTFIELD(Description);
        if not Camera.IsAvailable() then Message('Camera Unavailable');
        if Camera.IsAvailable() then begin

            if Camera.GetPicture(inst, Filename) then begin
                Clear(Rec.Picture);
                Rec.Picture.ImportStream(inst, Filename, MimeTypeTok);
                Rec.Modify(true);
            end;

        end;
        // if not Camera.IsAvailable() then Message('Unavailable');

        // if Camera.GetPicture(PictureInstream, PictureDescription) then begin
        //     Clear(Rec.Picture);
        //     Rec.Picture.ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
        //     Rec.Modify(true)
        // end;

        // CameraInteraction.SetAllowEdit(true);
        // CameraInteraction.SetQuality(100);
        // CameraInteraction.SetEncodingType(ImageEnc::JPEG);
        // CameraInteraction.RunModal();
        // CameraInteraction.GetPicture(inst);
        // Rec.Picture.ImportStream(inst, 'FileName');
        // if  not Rec.Insert(true) then Rec.modify(true);

    end;

    procedure ImportFromDevice()
    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ClientFileName: Text;

        PictureStream: InStream;
    begin
        Rec.Find;
        Rec.TestField("No.");
        //TESTFIELD(Description);

        if Rec.Picture.Count > 0 then
            if not Confirm(OverrideImageQst) then
                Error('');
        if Rec.Picture.Count > 0 then
            if not Confirm(OverrideImageQst) then
                Error('');

        ClientFileName := '';
        if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FileName, PictureStream) then begin
            Clear(Rec.Picture);
            Rec.Picture.ImportStream(PictureStream, FileName);
            Rec.Modify(true);
        end;


    end;

    local procedure SetEditableOnPictureActions()
    begin
        if Rec.Picture.Count > 0 then
            DeleteExportEnabled := true;
    end;

    procedure IsCameraAvailable(): Boolean
    begin
        // exit(CameraProvider.IsAvailable);
    end;

    procedure SetHideActions()
    begin
        HideActions := true;
    end;


    procedure DeleteItemPicture()
    begin
        Rec.TestField("No.");
        if Rec.Status = Rec.Status::Approved then Error('Approved documents cannot be deleted. status %1', Rec.Status);
        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec.Picture);
        Rec.Modify(true);
    end;


}




