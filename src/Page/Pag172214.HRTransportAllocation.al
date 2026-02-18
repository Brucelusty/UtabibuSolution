//************************************************************************
#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Page 172214 "HR Transport Allocation"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SourceTable = "HR Transport Allocations H";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Transport Allocation No";Rec."Transport Allocation No")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Destination(s)";Rec."Destination(s)")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Vehicle Reg Number";Rec."Vehicle Reg Number")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Passenger Capacity";Rec."Passenger Capacity")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Assigned Driver";Rec."Assigned Driver")
                {
                    ApplicationArea = Basic;
                }
                field("Driver Name";Rec."Driver Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Date of Allocation";Rec."Date of Allocation")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Date of Trip";Rec."Date of Trip")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Time of Trip";Rec."Time of Trip")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field("Linked to Invoice No";Rec."Linked to Invoice No")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("<Invoice Posting Description>";Rec."Invoice Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Invoice Posting Description';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = true;
                }
            }
            // part("Passenger List";"HR Transport Requisition Pass")
            // {
            //     Caption = 'Passenger List';
            //     SubPageLink = "Allocation No"=field("Transport Allocation No");
            // }
            group("Closing Remarks")
            {
                Caption = 'Closing Remarks';
                field("Opening Odometer Reading";Rec."Opening Odometer Reading")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Closing Odometer Reading";Rec."Closing Odometer Reading")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Journey Route";Rec."Journey Route")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Time out";Rec."Time out")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
                field("Time In";Rec."Time In")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HR Transport Alloc. Factbox")
            {
                Caption = 'HR Transport Allocations Factbox';
                SubPageLink = "Transport Allocation No" = field("Transport Allocation No");
            }
            systempart(Control1102755006; Outlook)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("&Print")
                {
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRTransportAllocationsH.Reset;
                        HRTransportAllocationsH.SetRange(HRTransportAllocationsH."Transport Allocation No", Rec."Transport Allocation No");
                        if HRTransportAllocationsH.Find('-') then
                            Report.Run(55596, true, true, HRTransportAllocationsH);
                    end;
                }
                action("<Action1102755035>p")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
                        Message('Transport Allocation No :: :: has been Re-Opened', Rec."Transport Allocation No");
                    end;
                }
                action(Release)
                {
                    ApplicationArea = Basic;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Question := Text001;
                        if Confirm(Question) then begin
                            Rec.Status := Rec.Status::Released;
                            Rec.Modify;
                            Message('Transport Allocation No :: :: has been released', Rec."Transport Allocation No");
                        end else begin
                            Message('You selected :: NO :: Release Cancelled');
                        end;
                    end;
                }
            }
        }
    }

    var
        HRTransportAllocationsH: Record "HR Transport Allocations H";
        Text19021002: label 'Passenger List';
        Text001: label 'Are you sure you want to Release this Document?';
        Question: Text;
}




