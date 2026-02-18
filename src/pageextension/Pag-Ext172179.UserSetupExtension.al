//************************************************************************
pageextension 172179 "UserSetupExtension" extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {

            field("Branch Code"; Rec."Branch Code") { ApplicationArea = all; }
            field("Responsibility Center"; Rec."Responsibility Center") { ApplicationArea = all; }
            field("Allow FA Posting From"; Rec."Allow FA Posting From")
            {
                applicationarea = all;

            }
            field("Allow FA Posting To"; Rec."Allow FA Posting To")
            {
                applicationarea = all;

            }
            field("View Special Accounts"; Rec."View Special Accounts")
            {

            }
            field("Archiving User"; Rec."Archiving User")
            {
                applicationarea = all;

            }
            field("Is Manager"; Rec."Is Manager")
            {
                applicationarea = all;

            }
            field("Approval Administrator"; Rec."Approval Administrator")
            {
                applicationarea = all;
            }
            field("Allow Process Payroll"; Rec."Allow Process Payroll")
            {
                applicationarea = all;

            }
            field("View Payroll"; Rec."View Payroll") { ApplicationArea = all; }
            field("View Payslip"; Rec."View Payslip") { ApplicationArea = all; }
            field("Member Registration"; Rec."Member Registration")
            {
                applicationarea = all;

            }

            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                applicationarea = all;

            }
            field("Journal Template Name"; Rec."Journal Template Name")
            {
                applicationarea = all;

            }
            field("Petty C Amount Approval Limit"; Rec."Petty C Amount Approval Limit")
            {
                applicationarea = all;

            }
            field("Post Pv"; Rec."Post Pv") { ApplicationArea = all; }
            field("Password Does Not Expire"; Rec."Password Does Not Expire") { }
            field("Excempt OTP"; Rec."Excempt OTP") { }
            field("Send Login OTP"; Rec."Send Login OTP") { }
            field("Edit Branch"; Rec."Edit Branch") { }
            field("Allow viewing all orders"; Rec."Allow Open My Settings")
            {
                ApplicationArea = All;
            }
            field("Allow Change Role"; Rec."Allow Change Role")
            {
                ApplicationArea = All;
            }
            field("Allow Change Company"; Rec."Allow Change Company")
            {
                ApplicationArea = All;
            }
            field("Allow Change Work Day"; Rec."Allow Change Work Day")
            {
                ApplicationArea = All;
            }
            field("Can Delegate Requests"; Rec."Can Delegate Requests")
            {
                ApplicationArea = All;
            }
            field("Mark loan As Performing"; Rec."Mark loan As Performing")
            {
                ApplicationArea = All;
            }
            field("Allow Backdating"; Rec."Allow Backdating")
            {
                ApplicationArea = All;
            }
            field("Can Edit COA"; Rec."Can Edit COA") { }
            field("Can whitelist";Rec."Can whitelist"){}
        }
    }




    actions
    {
        // Add changes to page actions here
    }


    var
        myInt: Integer;
        usersettings: Record "User Settings";
}
