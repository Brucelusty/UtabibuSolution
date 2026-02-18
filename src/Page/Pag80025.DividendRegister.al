page 80025 "Dividend Register"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Dividends Register";

    layout
    {
        area(Content)
        {
            repeater(greneral)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;

                }
                field("Member Name"; Rec."Member Name") { ApplicationArea = All; }
                field("Employer Code"; Rec."Employer Code") { ApplicationArea = All; }
                field("Employer Name"; Rec."Employer Name") { ApplicationArea = All; }
                field("Qualifying Share Capital"; Rec."Qualifying Share Capital") { ApplicationArea = All; }
                field("Qualifying Shares"; Rec."Qualifying Shares") { ApplicationArea = All; }
                field("Gross Dividends"; Rec."Gross Dividends") { ApplicationArea = All; }
                field("Gross Interest On Deposit"; Rec."Gross Interest On Deposit") { ApplicationArea = All; }
                field("Net Dividends"; Rec."Net Dividends") { ApplicationArea = All; }
                field("Net Interest On Deposit"; Rec."Net Interest On Deposit") { ApplicationArea = All; }
                field("Witholding Tax"; Rec."Witholding Tax") { ApplicationArea = All; }
                field("Total Dividend"; Rec."Total Dividend") { ApplicationArea = all; }
                field("Dividend Withholding Tax"; Rec."Dividend Withholding Tax") { ApplicationArea = all; }
                field("IOD withholding Tax"; Rec."IOD withholding Tax") { ApplicationArea = all; }
                field("Qualifying Chama Savings"; Rec.QualifyingChama) { }
                field("Gross Interest On Chama Saving"; Rec."Gross Interest On Chama Saving") { }
                field("Chama withholding Tax"; Rec."Chama withholding Tax") { }
                field("Net Interest On Chama"; Rec."Net Interest On Chama") { }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}