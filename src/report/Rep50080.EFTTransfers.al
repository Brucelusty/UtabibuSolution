
Report 50080 "EFT Transfers"
{
	RDLCLayout = 'Layouts/EFT Transfers.rdlc'; DefaultLayout = RDLC;

	dataset
	{
		dataitem("Bank Transfer Header Details";"EFT/RTGS Header")
		{
			column(ReportForNavId_1000000014; 1000000014) {}
			column(No_EFTHeaderDetails; "Bank Transfer Header Details".No)
			{
			}
			column(NoSeries_EFTHeaderDetails; "Bank Transfer Header Details"."No. Series")
			{
			}
			column(Transferred_EFTHeaderDetails; "Bank Transfer Header Details".Transferred)
			{
			}
			column(DateTransferred_EFTHeaderDetails; "Bank Transfer Header Details"."Date Transferred")
			{
			}
			column(TimeTransferred_EFTHeaderDetails; "Bank Transfer Header Details"."Time Transferred")
			{
			}
			column(TransferredBy_EFTHeaderDetails; "Bank Transfer Header Details"."Transferred By")
			{
			}
			column(DateEntered_EFTHeaderDetails; "Bank Transfer Header Details"."Date Entered")
			{
			}
			column(TimeEntered_EFTHeaderDetails; "Bank Transfer Header Details"."Time Entered")
			{
			}
			column(EnteredBy_EFTHeaderDetails; "Bank Transfer Header Details"."Entered By")
			{
			}
			column(Remarks_EFTHeaderDetails; "Bank Transfer Header Details".Remarks)
			{
			}
			column(PayeeBankName_EFTHeaderDetails; "Bank Transfer Header Details"."Payee Bank Name")
			{
			}
			column(BankNo_EFTHeaderDetails; "Bank Transfer Header Details"."Bank  No")
			{
			}
			column(SalaryProcessingNo_EFTHeaderDetails; "Bank Transfer Header Details"."Salary Processing No.")
			{
			}
			column(SalaryOptions_EFTHeaderDetails; "Bank Transfer Header Details"."Salary Options")
			{
			}
			column(Total_EFTHeaderDetails; "Bank Transfer Header Details".Total)
			{
			}
			column(TotalCount_EFTHeaderDetails; "Bank Transfer Header Details"."Total Count")
			{
			}
			column(RTGS_EFTHeaderDetails; "Bank Transfer Header Details".RTGS)
			{
			}
			column(DocumentNoFilter_EFTHeaderDetails; "Bank Transfer Header Details"."Document No. Filter")
			{
			}
			column(DateFilter_EFTHeaderDetails; "Bank Transfer Header Details"."Date Filter")
			{
			}
			column(Bank_EFTHeaderDetails; "Bank Transfer Header Details".Bank)
			{
			}
			dataitem("EFT Details";"EFT/RTGS Details")
			{
				column(ReportForNavId_1000000000; 1000000000) {} 
				column(DateEntered_EFTDetails; Format("EFT Details"."Date Entered"))
				{
				}
				column(TimeEntered_EFTDetails; Format("EFT Details"."Time Entered"))
				{
				}
				column(CompanyInfo_Name; CompanyInfo.Name)
				{
				}
				column(CompanyInfo_Picture; CompanyInfo.Picture)
				{
				}
				column(CompanyInfo_Address; CompanyInfo.Address)
				{
				}
				column(No_EFTDetails; "EFT Details".No)
				{
				}
				column(DateTransferred_EFTDetails; "EFT Details"."Date Transferred")
				{
				}
				column(TimeTransferred_EFTDetails; "EFT Details"."Time Transferred")
				{
				}
				column(DestinationAccountNo_EFTDetails; "EFT Details"."Destination Account No")
				{
				}
				column(DestinationAccountName_EFTDetails; "EFT Details"."Destination Account Name")
				{
				}
				column(DestinationAccountType_EFTDetails; "EFT Details"."Destination Account Type")
				{
				}
				column(AccountNo_EFTDetails; "EFT Details"."Account No")
				{
				}
				column(AccountName_EFTDetails; "EFT Details"."Account Name")
				{
				}
				column(AccountType_EFTDetails; "EFT Details"."Account Type")
				{
				}
				column(Amount_EFTDetails; "EFT Details".Amount)
				{
				}
				trigger OnPreDataItem();
				begin
					CompanyInfo.Get();
					CompanyInfo.CalcFields(CompanyInfo.Picture);
				end;
				
			}
		}
	}

	requestpage
	{

  
		SaveValues = false;	  layout
		{
			area(content)
			{
				group(Options)
				{
					Caption = 'Options';
					
				}
			}
		}

		actions
		{
		}
		trigger OnOpenPage()
		begin
	
		end;
	}

	trigger OnInitReport()
	begin
	

	end;

	trigger OnPostReport()
	begin
	
	end;

	trigger OnPreReport()
	begin
	
	end;
	var
		CompanyInfo: Record "Company Information";
		NumberText: array [2] of Text[80];
		CheckReport: Report Check;







}

