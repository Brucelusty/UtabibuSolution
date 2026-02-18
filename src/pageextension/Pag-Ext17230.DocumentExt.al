pageextension 17230 "Document Ext" extends "Document Attachment Details"
{
    layout
    {
        addbefore("File Extension")
        {
            field("Document Description"; Rec."Document Description")
            {
                Caption = 'Document Name';
            }
        }
    }
}
