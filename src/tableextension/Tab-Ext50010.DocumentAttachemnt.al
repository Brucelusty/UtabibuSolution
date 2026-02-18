tableextension 50010 "Document Attachemnt" extends "Document Attachment"
{
    fields
    {
        field(16; "Document Description"; Text[2048])
        {
            Caption = 'Document Description';
            DataClassification = ToBeClassified;
        }
    }
}
