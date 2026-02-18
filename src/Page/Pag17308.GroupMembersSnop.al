Page 17308 "Group Members Snop"
{
    PageType = CardPart;
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            field(GroupMembers; Rec."Group Members Snapshort")
            {
                ApplicationArea = Basic, Suite;
                ShowCaption = false;
                ToolTip = 'Specifies the members list in a picture form.';
            }
        }
    }

    actions
    {
        area(processing)
        {

            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                Visible = HideActions = false;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Open);
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
                    //TESTFIELD(Description);


                    // NameValueBuffer.DeleteAll;
                    // ExportPath := TemporaryPath + Rec."No." + Format(Rec."Group Members Snapshort".MediaId);
                    // Rec."Group Members Snapshort".ExportFile(ExportPath);
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
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';
                Visible = HideActions = false;

                trigger OnAction()
                begin
                    DeleteItemPicture;
                end;
            }
        }
    }

    var
        //     [RunOnClient]
        //     [WithEvents]
        //     CameraProvider: dotnet CameraProvider;
        CameraAvailable: Boolean;
        DeleteExportEnabled: Boolean;
        OverrideImageQst: label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: label 'Select a picture to upload';
        DownloadImageTxt: label 'Download image';
        HideActions: Boolean;

    // procedure TakeNewPicture()
    // var
    //     CameraOptions: dotnet CameraOptions;
    // begin
    //     Find;
    //     TestField("Account No");
    //     //TESTFIELD(Description);

    //     if not CameraAvailable then
    //         exit;

    //     CameraOptions := CameraOptions.CameraOptions;
    //     CameraOptions.Quality := 50;
    //     CameraProvider.RequestPictureAsync(CameraOptions);
    // end;

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

        if Rec."Group Members Snapshort".Count > 0 then
            if not Confirm(OverrideImageQst) then
                Error('');
        if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FileName, PictureStream) then begin
            Clear(Rec."Group Members Snapshort");
            Rec."Group Members Snapshort".ImportStream(PictureStream, FileName);
            Rec.Modify(true);
        end;
        // ClientFileName := '';
        // FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
        // if FileName = '' then
        //     Error('');

        // Clear(Rec."Group Members Snapshort");
        // Rec."Group Members Snapshort".ImportFile(FileName, ClientFileName);
        // if not Rec.Insert(true) then
        //     Rec.Modify(true);

        // if FileManagement.DeleteServerFile(FileName) then;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec."Group Members Snapshort".Count <> 0;
    end;

    // procedure IsCameraAvailable(): Boolean
    // begin
    //     exit(CameraProvider.IsAvailable);
    // end;

    procedure SetHideActions()
    begin
        HideActions := true;
    end;


    procedure DeleteItemPicture()
    begin
        Rec.TestField("No.");

        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec."Group Members Snapshort");
        Rec.Modify(true);
    end;


}





