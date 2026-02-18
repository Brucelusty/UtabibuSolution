page 17293 Denomminations
{
    ApplicationArea = All;
    Caption = 'Denomminations';
    PageType = List;
    SourceTable = Denominations;
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code;Rec.Code){}
                field(Description;Rec.Description){}
                field(Type;Rec.Type){}
                field(Value;Rec.Value){}
                field(Priority;Rec.Priority){}
            }
        }
    }
}
