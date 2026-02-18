
    
   table 80001 "Image Data"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "ID No."; Code[20])
        {
            Caption = 'ID No.';
            DataClassification = CustomerContent;
        }
        field(2; Picture; Media)
        {
            Caption = 'Picture';
            DataClassification = CustomerContent;
        }
        field(3; Signature; Media)
        {
            Caption = 'Signature';
            DataClassification = CustomerContent;
        }
        field(4; "Member No."; Code[20])
        {
            TableRelation =Customer;
            Caption = 'Member No.';
            DataClassification = CustomerContent;
        }
        field(5; "Old Account No."; Code[100])
        {
            Caption = 'Old Account No.';
            DataClassification = CustomerContent;
        }
        field(6; "Account No"; Code[100])
        {
            Caption = 'Account No';
            DataClassification = CustomerContent;
        }
        field(7; "ID Speciment [Front]"; Media)
        {
            Caption = 'ID Speciment [Front]';
            DataClassification = CustomerContent;
        }
        field(8; "ID Speciment [Back]"; Media)
        {
            DataClassification = CustomerContent;
            Caption = 'ID Speciment [Back]';
        }
        field(9; "Alien ID"; Media)
        {
            DataClassification = CustomerContent;
            Caption = 'Alien ID';
        }
        field(10; "Old Member No."; Code[100])
        {
            DataClassification = CustomerContent;

        }
        field(11; "Import Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Skip,Pending,Completed';
            OptionMembers = Skip,Pending,Completed;
            Editable = false;

        }
        field(12; "Picture Already Exists"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(13; "File Name"; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(14; "File Extension"; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Modified Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Modified Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Picture ID"; MediaSet)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Signature ID"; MediaSet)
        {
            DataClassification = CustomerContent;
        }
        field(19; Description; Text[150])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Member No.", "ID No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    // procedure CopyFromApplication(MemberApplication: Recordmember)
    // begin

    //     Picture := MemberApplication.Picture;
    //     Signature := MemberApplication.Signature;
    //     "Picture ID" := MemberApplication."Picture ID";
    //     "Signature ID" := MemberApplication."Signature ID";
    //     "ID Speciment [Back]" := MemberApplication."ID Specimen [Back]";
    //     "ID Speciment [Front]" := MemberApplication."ID Specimen [Back]";
    // end;

    // procedure CopyFromChanges(MemberApplication: Record "Member Changes")
    // begin

    //     Picture := MemberApplication.Picture;
    //     Signature := MemberApplication.Signature;
    // end;

    procedure LoadZIPFile(ZipFileName: Text; VAR TotalCount: Integer; ReplaceMode: Boolean): Text
    begin

    end;

    procedure ImportPictures(ReplaceMode: Boolean)
    begin

    end;

    local procedure ShouldImport(ReplaceMode: Boolean; PictureExists: Boolean): Boolean
    begin

    end;

    procedure GetAddCount(): Integer
    begin

    end;

    procedure GetAddedCount(): Integer
    begin

    end;

    procedure GetReplaceCount(): Integer
    begin

    end;

    procedure GetReplacedCount(): Integer
    begin

    end;

    procedure ImportImage()
    var
        myItemRec: Record "Image Data";
        fileName: Text;
        importFile: File;
        imageInStream: InStream;
        imageID: GUID;
        Text000: Label 'An image with the following ID has been imported on item %1: %2';
    begin
        if myItemRec.FindFirst() then begin
            fileName := 'C:\images\' + Format(myItemRec."Member No.") + '.jpg';
            if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', fileName, imageInStream) then begin
                Clear(myItemRec.Picture);
                myItemRec.Picture.ImportStream(imageInStream, fileName);
                myItemRec.Modify(true)
            end;
        end;
    end;
}

