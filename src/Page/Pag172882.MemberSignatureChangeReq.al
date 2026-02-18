//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
page 172882 "Member Signature-Change Req"
{
    PageType = CardPart;
    SourceTable = "Change Request";

    layout
    {
        area(content)
        {
            field(Signinature; Rec.signinature)
            {
                ApplicationArea = Basic, Suite;
                ShowCaption = false;
                ToolTip = 'Specifies the signature that has been inserted for the member.';
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
                Visible = CameraAvailable and (not HideActions);

                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a signature file.';
                Visible = not HideActions;

                trigger OnAction()
                begin
                    ImportFromDevice();
                end;
            }
            action(ExportFile)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Enabled = DeleteExportEnabled;
                Image = Export;
                ToolTip = 'Export the signature to a file.';
                Visible = (not CameraAvailable) and (not HideActions);

                trigger OnAction()
                var
                    InStream: InStream;
                    FileName: Text;
                begin
                    Rec.TestField("No");
                    if Rec.signinature.Count = 0 then
                        exit;

                    //  FileName := StrSubstNo('%1_Signature.jpg', Rec."No");
                    //  Rec.signinature.CreateInStream(InStream);
                    DownloadFromStream(InStream, '', '', '', FileName);
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the signature.';
                Visible = not HideActions;

                trigger OnAction()
                begin
                    DeleteItemPicture();
                end;
            }
        }
    }

    var
        OverrideImageQst: Label 'The existing signature will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the signature?';
        SelectPictureTxt: Label 'Select a signature to upload';
        DownloadImageTxt: Label 'Download signature';
        CameraAvailable: Boolean;
        DeleteExportEnabled: Boolean;
        HideActions: Boolean;

    procedure TakeNewPicture()
    begin
        Rec.Find;
        Rec.TestField(No);

        if not CameraAvailable then
            exit;

        // Camera integration (device upload) would go here
    end;

    procedure ImportFromDevice()
    var
        InStream: InStream;
        FileName: Text;
    begin
        Rec.Find;
        Rec.TestField(No);

        if Rec.signinature.Count > 0 then
            if not Confirm(OverrideImageQst) then
                Error('');

        if not UploadIntoStream(SelectPictureTxt, '', '', FileName, InStream) then
            exit;

        Clear(Rec.signinature);
        Rec.signinature.ImportStream(InStream, FileName);
        Rec.Modify(true);
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.signinature.Count <> 0;
    end;

    procedure IsCameraAvailable(): Boolean
    begin
        exit(CameraAvailable);
    end;

    procedure SetHideActions()
    begin
        HideActions := true;
    end;

    procedure DeleteItemPicture()
    begin
        Rec.TestField(No);

        if not Confirm(DeleteImageQst) then
            exit;

        Clear(Rec.signinature);
        Rec.Modify(true);
    end;
}
