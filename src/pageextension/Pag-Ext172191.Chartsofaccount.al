pageextension 172191 "Charts of account" extends "Chart of Accounts"
{

    layout
    {
        modify("No.")
        {
            Editable = IsCOAEditable;
        }
        modify(Name)
        {
            Editable = IsCOAEditable;
        }
        modify("Account Type")
        {
            Editable = IsCOAEditable;
        }
    }

    actions
    {
        // modify("New")
        // {
        //     Enabled = IsCOAEditable;
        //     Visible = IsCOAEditable;
        // }
        // modify("Delete")
        // {
        //     Enabled = IsCOAEditable;
        //     Visible = IsCOAEditable;
        // }
        addafter("Detail Trial Balance")
        {
            action("Trial Balance V2")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Trial Balance Custom';
                Image = "Report";
                RunObject = Report "Trial Balance Ver2";
                ToolTip = 'View the chart of accounts that have balances and net changes.';
                AboutTitle = 'Get the financial overview';
                AboutText = 'With the **Trial Balance** reports you get the balance sheet, income statement, or the full trial balance.';
            }
        }
    }

    trigger OnOpenPage()
    begin
        IsCOAEditable := CanEditCOA();
        if not IsCOAEditable then
            CurrPage.Editable(false);
    end;

    var
        IsCOAEditable: Boolean;

    local procedure CanEditCOA(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then
            exit(UserSetup."Can Edit COA");
        exit(false);
    end;

}
