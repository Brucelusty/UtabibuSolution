//************************************************************************
// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 172101 "customerListExtension" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field("ID No."; Rec."ID No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ID Number.';
            }
            field("Name of the Group/Corporate"; Rec."Name of the Group/Corporate")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Name of the Group/Corporate.';
            }

        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange(ISNormalMember, false);
    end;



}
pageextension 172103 "CustomerLookupExt" extends "Customer Lookup"
{
    layout
    {
        addafter(Name)
        {

            field("ID No."; Rec."ID No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the ID Number.';
            }
            field("Name of the Group/Corporate"; Rec."Name of the Group/Corporate")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Name of the Group/Corporate.';
            }


        }
    }


    trigger OnOpenPage()
    begin
        //  Rec.SetRange(ISNormalMember, false);
    end;
}




