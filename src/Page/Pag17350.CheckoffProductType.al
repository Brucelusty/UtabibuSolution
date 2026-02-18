Page 17350 "Checkoff Product Type"
{
    PageType = List;
    SourceTable = "Checkoff Products";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code";Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Type;Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product";Rec."Loan Product")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

