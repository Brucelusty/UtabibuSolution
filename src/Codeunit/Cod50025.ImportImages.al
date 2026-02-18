//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Codeunit 50025 "Import Images"
{

    trigger OnRun()
    begin
        GetImages();
    end;

    var
        objMembers: Record Vendor;
        InStream1: InStream;
        InputFile: File;
        OutStream1: OutStream;


    procedure GetImages()
    var
        filename: Text[100];
            InStream1: InStream;
    OutStream1: OutStream;
    //objMembers: Record "Members Register";
    begin
        objMembers.Reset;
        if objMembers.FindSet() then begin
            repeat
                filename := 'C:\Downloads\' + objMembers."Sacco No" + '.gif';
                if objMembers.Signature.count > 0 then
                    Clear(objMembers.Signature);
                // if FILE.Exists(filename) then begin
                //     InputFile.Open(filename);
                //     InputFile.CreateInstream(InStream1);
                //     objMembers.Signature.ImportStream(InStream1, 'signature', 'jpg');
                //     CopyStream(OutStream1, InStream1);
                //     objMembers.Modify;
                //     InputFile.Close;
                    
                // end;
            until objMembers.Next = 0;
            Message('Imported successfully');
        end;
    end;
}




