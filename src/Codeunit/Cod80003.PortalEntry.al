codeunit 80003 "Portal Entry"
{






//     procedure PortalRequests(
//         FUNCTIONNAME: Text[100];
//         REQUESTHEADER: Text;
//         var RESPONSECODE: Integer;
//         var RESPONSEDATA: BigText;
//         var SUCCESSMESSAGE: Text
//           )
//     var
//         customerData: JsonObject;
//         portalFunctions: Codeunit PortalFunctions;
//         request: JsonObject;
//         response: JsonObject;
//         No: Code[40];
//         JT: JsonToken;
//     begin

//         if FUNCTIONNAME = 'GETCUSTOMER' THEN BEGIN
//             customerData := portalFunctions.GETCUSTOMER('DN004');
//             RESPONSECODE := 200;
//             RESPONSEDATA.AddText(Format(customerData));
//             SUCCESSMESSAGE := 'Customer';
//             exit;
//         END;
//         if FUNCTIONNAME = 'PURCHASEHEADER' THEN BEGIN
//             RESPONSECODE := 200;
//             request.ReadFrom(REQUESTHEADER);
//             RESPONSEDATA.AddText(format(portalFunctions.PURCHASEHEADER(browseJson(request, 'No').AsValue().AsText())));
//             exit;
//         END;

//         if FUNCTIONNAME = 'REQUESTFORMHEADERS' THEN BEGIN
//             RESPONSECODE := 200;
//             request.ReadFrom(REQUESTHEADER);
//             RESPONSEDATA.AddText(format(portalFunctions.REQUESTFORMHEADERS(browseJson(request, 'employeeNo').AsValue().AsText())));
//             exit;

//         END;

//         if FUNCTIONNAME = 'PURCHASEHEADERS' THEN BEGIN
//             RESPONSECODE := 200;
//             request.ReadFrom(REQUESTHEADER);
//             RESPONSEDATA.AddText(format(portalFunctions.PURCHASEHEADERS(browseJson(request, 'employeeNo').AsValue().AsText())));
//             exit;

//         END;



//         if FUNCTIONNAME = 'LOGIN' then begin
//             request.ReadFrom(REQUESTHEADER);
//             response.Add('authenticated', portalFunctions.LOGIN(
//             browseJson(request, 'username').AsValue().AsText(),
//             browseJson(request, 'password').AsValue().AsText()));
//             RESPONSEDATA.AddText(Format(response));
//             exit;
//         end;

//         if FUNCTIONNAME = 'REGISTER' then begin
//             request.ReadFrom(REQUESTHEADER);
//             response.Add('authenticated', portalFunctions.REGISTER(
//             browseJson(request, 'username').AsValue().AsText(),
//             browseJson(request, 'email').AsValue().AsText(),
//             browseJson(request, 'idno').AsValue().AsText()));
//             RESPONSEDATA.AddText(Format(response));
//             exit;
//         end;

//         if FUNCTIONNAME = 'CONFIRMREGISTRATION' then begin
//             request.ReadFrom(REQUESTHEADER);
//             response.Add('authenticated', portalFunctions.CONFIRMREGISTRATION(
//             browseJson(request, 'username').AsValue().AsText(),
//             browseJson(request, 'otp').AsValue().AsText(),
//             browseJson(request, 'password').AsValue().AsText()));
//             RESPONSEDATA.AddText(Format(response));
//             exit;
//         end;



//     end;

//     PROCEDURE Requesttypes() returnout: Text;
//     VAR
//         // ObjDimensionValue: Record 50023;
//         jarray: JsonArray;
//         jobject: JsonObject;
//         unitsofMeasure: Record "Unit of Measure";
//         BudgetMatrix: Record 172069;

//     BEGIN
//         jobject.Add('Code', '');
//         jobject.Add('Name', '');
//         jobject.Add('Type', 'Request');
//         jarray.Add(jobject);
//         jobject.Replace('Code', '');
//         jobject.Replace('Name', '');
//         jobject.Replace('Type', 'Unit');
//         jarray.Add(jobject);
//         jobject.Replace('Code', '');
//         jobject.Replace('Name', '');
//         jobject.Replace('Type', 'Budget');
//         jarray.Add(jobject);
//         // ObjDimensionValue.RESET;
//         // ObjDimensionValue.SETCURRENTKEY("Account Name");
//         // ObjDimensionValue.ASCENDING(TRUE);
//         // IF ObjDimensionValue.FINDFIRST THEN
//         //     REPEAT
//         //         jobject.Replace('Code', ObjDimensionValue."Type of Request");
//         //         jobject.Replace('Name', ObjDimensionValue."Type of Request");
//         //         jobject.Replace('Type', 'Request');
//         //         jarray.Add(jobject);
//         //     UNTIL ObjDimensionValue.NEXT = 0;

//         // unitsofMeasure.RESET;
//         // unitsofMeasure.SETCURRENTKEY(code);
//         // unitsofMeasure.ASCENDING(TRUE);
//         // IF ObjDimensionValue.FINDFIRST THEN
//         //     REPEAT
//         //         jobject.Replace('Code', unitsofMeasure.Code);
//         //         jobject.Replace('Name', unitsofMeasure.Description);
//         //         jobject.Replace('Type', 'Unit');
//         //         jarray.Add(jobject);
//         //     UNTIL unitsofMeasure.NEXT = 0;


//         // BudgetMatrix.RESET;
//         // BudgetMatrix.SETCURRENTKEY("Budget Line No Code");
//         // BudgetMatrix.SETCURRENTKEY("Budget Line No Code");
//         // BudgetMatrix.ASCENDING(TRUE);
//         // IF BudgetMatrix.FINDFIRST THEN
//         //     REPEAT
//         //         jobject.Replace('Code', BudgetMatrix."Budget Line No Code");
//         //         jobject.Replace('Name', BudgetMatrix."Budget Line Description.");
//         //         jobject.Replace('Type', 'Budget');
//         //         jarray.Add(jobject);
//         //     UNTIL BudgetMatrix.NEXT = 0;


//         // exit(Format(jarray));




//     END;

//     procedure browseJson(J: JsonObject; k: Text): JsonToken
//     var
//         jtoken: JsonToken;
//     begin
//         J.Get(k, jtoken);
//         exit(jtoken);
//     end;

//     PROCEDURE fnDimensionValuesSpecific(filterType: Code[30]; filter: Code[60]) returnout: Text;
//     VAR
//         ObjDimensionValue: Record 349;
//         jarray: JsonArray;
//         jobject: JsonObject;

//     BEGIN


//         // ObjDimensionValue.RESET;
//         // ObjDimensionValue.SetFilter("Global Dimension No.", filterType);
//         // ObjDimensionValue.SETRANGE(Code, filter);
//         // ObjDimensionValue.SETCURRENTKEY(Name);
//         // ObjDimensionValue.ASCENDING(TRUE);
//         // IF ObjDimensionValue.FINDFIRST THEN
//         //     REPEAT
//         //         jobject.Add('Code', ObjDimensionValue.Code);
//         //         jobject.Add('Name', ObjDimensionValue.Name);
//         //         jarray.Add(jobject);
//         //     UNTIL ObjDimensionValue.NEXT = 0;

//         // exit(Format(jarray));




//     END;

//     PROCEDURE FnGetBudgetCodes(filterType: Code[30]; Filter: Code[60]) returnout: Text;
//     VAR
//         BudgetMatrix: Record 172069;
//         jarray: JsonArray;
//         jobject: JsonObject;

//     BEGIN


//         // BudgetMatrix.RESET;
//         // BudgetMatrix.SETRANGE(BudgetMatrix."Budget Line No Code", filter);
//         // BudgetMatrix.SETCURRENTKEY("Budget Line No Code");
//         // BudgetMatrix.ASCENDING(TRUE);
//         // IF BudgetMatrix.FINDFIRST THEN
//         //     REPEAT
//         //         jobject.Add('Code', BudgetMatrix."Budget Line No Code");
//         //         jobject.Add('Name', BudgetMatrix."Budget Line Description.");
//         //         jarray.Add(jobject);
//         //     UNTIL BudgetMatrix.NEXT = 0;

//         // exit(Format(jarray));




//     END;

//     PROCEDURE FnGetExpenseCode() returnout: Text;
//     VAR
//         PurchaseHeader: Record 38;
//         jarray: JsonArray;
//         jobject: JsonObject;

//     BEGIN

//         PurchaseHeader.RESET;
//         // PurchaseHeader.SetRange("AU Form Type", PurchaseHeader."AU Form Type"::"Expense Requisition");
//         PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
//         PurchaseHeader.SETCURRENTKEY("No.");
//         PurchaseHeader.ASCENDING(TRUE);
//         IF PurchaseHeader.FINDFIRST THEN
//             REPEAT
//                 jobject.Add('Code', PurchaseHeader."No.");
//                 //jobject.Add('Name', PurchaseHeader."No." + ' - ' + PurchaseHeader."Payee Naration");
//                 jarray.Add(jobject);
//             UNTIL PurchaseHeader.NEXT = 0;

//         exit(Format(jarray));
//     END;

//     PROCEDURE FnGetGlAccounts() returnout: Text;
//     VAR
//         GLAccounts: Record 15;
//         jarray: JsonArray;
//         jobject: JsonObject;

//     BEGIN

//         GLAccounts.RESET;
//         GLAccounts.ASCENDING(TRUE);
//         IF GLAccounts.FindSet THEN
//             REPEAT
//                 jobject.Add('Code', GLAccounts."No.");
//                 jobject.Add('Name', GLAccounts.Name);
//                 jarray.Add(jobject);
//             UNTIL GLAccounts.NEXT = 0;

//         exit(Format(jarray));
//     END;

//     PROCEDURE FnGetBankAccounts() returnout: Text;
//     VAR
//         Banks: Record 270;
//         jarray: JsonArray;
//         jobject: JsonObject;

//     BEGIN

//         Banks.Reset();
//         Banks.SetCurrentKey("No.");
//         Banks.ASCENDING(TRUE);
//         IF Banks.FINDFIRST THEN
//             REPEAT
//                 jobject.Add('No', Banks."No.");
//                 jobject.Add('Name', Banks.Name);
//                 jarray.Add(jobject);
//             UNTIL Banks.NEXT = 0;

//         exit(Format(jarray));
//     end;




//     PROCEDURE fnDimensionValues(filterType: Code[30]; filter: Code[60]) returnout: Text;
//     VAR
//         ObjDimensionValue: Record 349;
//         jarray: JsonArray;
//         jobject: JsonObject;
//     BEGIN


//         jobject.Add('Code', '');
//         jobject.Add('Name', '');
//         jarray.Add(jobject);

//         jobject.Replace('Code', '');
//         jobject.Replace('Name', '');
//         jarray.Add(jobject);

//         ObjDimensionValue.RESET;
//         ObjDimensionValue.SetFilter("Global Dimension No.", filterType);
//         ObjDimensionValue.SETCURRENTKEY(Name);
//         ObjDimensionValue.ASCENDING(TRUE);


//         IF ObjDimensionValue.FINDFIRST THEN BEGIN

//             REPEAT

//                 jobject.Replace('Code', ObjDimensionValue.Code);
//                 jobject.Replace('Name', ObjDimensionValue.Name);
//                 jarray.Add(jobject);
//             UNTIL ObjDimensionValue.NEXT = 0;
//         END;
//         exit(Format(jarray))
//     END;

// }
// codeunit 80005 PortalFunctions
// {
//     var
//         jsonFunctionsG: Codeunit JsonFunctions;
//         objNumSeries: Codeunit NoSeriesManagement;
//         GenLedgerSetup: Record "Purchases & Payables Setup";
//         purchaseLine: record "Purchase Line";
//         lJObject: dotnet JObject;
//         lArrayString: Text;
//         lJSONString: Text;
//         lJsonArray2: Codeunit DotNet_Array;
//         lJsonArray: DotNet JObject;

//     procedure GETCUSTOMER(custId: Code[30]): JsonObject
//     var
//         ///JsonFunctions: Codeunit JsonFunctions;
//         cust: record Customer;
//         recVariant: Variant;
//     begin

//         cust.Get(custId);
//         recVariant := cust;

//         //exit(JsonFunctions.RecordToJson(recVariant));


//     end;

//     // Ref: AUTHENTICATION 
//     procedure LOGIN(username: Code[50]; password: Text): Boolean
//     var
//         hrEmployee: record "HR Employees";
//         authenticated: Boolean;
//     begin
//         authenticated := false;
//         hrEmployee.reset;
//         hrEmployee.SetRange("No.", username);
//         hrEmployee.SetRange("Portal Password", password);
//         if hrEmployee.FindFirst() then authenticated := true;
//         exit(authenticated);

//     end;
//     //Get otp
//     procedure REGISTER(username: Code[50]; email: Text; idno: code[20]): Boolean
//     //TODO: Create a better otp management for registering new users
//     VAR
//         hrEmployee: record "HR Employees";
//         otp: Text;
//         rand: Text;
//     begin
//         otp := '';
//         hrEmployee.Reset;
//         hrEmployee.SetRange("No.", username);
//         hrEmployee.SetRange(hrEmployee."E-Mail", email);
//         hrEmployee.SetRange("ID Number", idno);
//         if hrEmployee.FindFirst then begin
//             rand := Format(Random(99999));
//             hrEmployee."Portal Password" := rand;
//             hrEmployee.Modify(true);
//             exit(SENDEMAIL(email, 'Your O.T.P is ' + Format(rand)));

//         end else
//             exit(false);

//     end;

//     procedure SENDEMAIL(email: text; message: Text): Boolean;
//     var
//         smtp: Codeunit Email;
//         smtpsetup: Codeunit "Email Message";
//     begin

//         smtpsetup.Create(email, 'Self service portal communication', message);
//         smtp.Send(smtpsetup);

//         exit(true);
//     end;

//     procedure CONFIRMREGISTRATION(username: Code[50]; otp: Text; password: Text): Boolean
//     var
//         hremployee: record "HR Employees";
//         confirmed: Boolean;
//     begin
//         confirmed := false;
//         hremployee.Reset();
//         hremployee.SetRange("No.", username);
//         hremployee.SetRange("Portal Password", otp);
//         if hremployee.FindFirst() then begin
//             hremployee."Portal Password" := password;
//             hremployee.Modify(true);
//             confirmed := true;
//         end;
//         exit(confirmed);
//     end;

//     //GET 
//     procedure HREMPLOYEE(No: code[50]): JsonObject
//     var
//         ref: Variant;
//         hrEmployee: record "HR Employees";
//         JO: JsonObject;
//     begin
//         if hrEmployee.Get(No) then begin
//             ref := hrEmployee;
//             JO := jsonFunctionsG.RecordToJson(ref);
//         end;

//         exit(JO);

//     end;

//     // GET MANY
//     procedure HREMPLOYEES(): JsonArray
//     VAR
//         ref: Variant;
//         hremployee: record "HR Employees";
//         JA: JsonArray;
//         JO: JsonObject;

//     begin
//         hremployee.Find('-');
//         repeat

//             ref := hremployee;
//             JO := jsonFunctionsG.RecordToJson(ref);
//             JA.Add(JO);

//         until hremployee.Next = 0;

//         exit(JA);
//     end;
//     //GET 
//     procedure LEAVE(No: code[50]; LeaveType: Code[60]): JsonObject
//     var
//         ref: Variant;
//         hrLeave: Record "HR Leave Application";
//         JO: JsonObject;
//     begin
//         if hrLeave.Get(No, LeaveType) then begin
//             ref := hrLeave;
//             JO := jsonFunctionsG.RecordToJson(ref);
//         end;

//         exit(JO);

//     end;

//     // GET MANY
//     procedure LEAVES(): JsonArray
//     VAR
//         ref: Variant;
//         hrLeave: Record "HR Leave Application";
//         JA: JsonArray;
//         JO: JsonObject;

//     begin
//         hrLeave.Find('-');
//         repeat

//             ref := hrLeave;
//             JO := jsonFunctionsG.RecordToJson(ref);
//             JA.Add(JO);

//         until hrLeave.Next = 0;

//         exit(JA);
//     end;

//     procedure PURCHASEHEADER(No: code[50]): JsonObject
//     var
//         ref: Variant;
//         purchaseHeader: record "Purchase Header";
//         purchaseLine: Record "Purchase Line";
//         relationships: JsonArray;

//         JO: JsonObject;
//         JOR: JsonObject;
//     begin
//         if purchaseHeader.Get(purchaseHeader."Document Type"::Quote, No) then begin
//             ref := purchaseHeader;
//             JO := jsonFunctionsG.RecordToJson(ref);
//             purchaseLine.reset;
//             purchaseLine.SetRange("Document No.", no);
//             if purchaseLine.Find('-') then begin
//                 repeat
//                     ref := purchaseLine;
//                     relationships.Add(jsonFunctionsG.RecordToJson(ref));
//                 until purchaseLine.Next = 0;
//             end;
//             JO.Add('relationships', relationships);
//         end;

//         exit(JO);

//     end;

//     procedure REQUESTHEADER(No: code[50]): JsonObject
//     var
//         ref: Variant;
//         purchaseHeader: record "Purchase Header";
//         purchaseLine: Record "Purchase Line";
//         relationships: JsonArray;

//         JO: JsonObject;
//         JOR: JsonObject;
//     begin
//         if purchaseHeader.Get(purchaseHeader."Document Type"::Quote, No) then begin
//             ref := purchaseHeader;
//             JO := jsonFunctionsG.RecordToJson(ref);
//             purchaseLine.reset;
//             purchaseLine.SetRange("Document No.", no);
//             if purchaseLine.Find('-') then begin
//                 repeat
//                     ref := purchaseLine;
//                     relationships.Add(jsonFunctionsG.RecordToJson(ref));
//                 until purchaseLine.Next = 0;
//             end;
//             JO.Add('relationships', relationships);
//         end;

//         exit(JO);

//     end;



//     procedure REQUESTFORM(No: code[50]): JsonObject
//     var
//         ref: Variant;
//         purchaseHeader: record "Purchase Header";
//         purchaseLine: Record "Purchase Line";
//         relationships: JsonArray;
//         JO: JsonObject;
//         JOR: JsonObject;

//     begin
//         if purchaseHeader.Get(purchaseHeader."Document Type"::Quote, No) then begin

//             ref := purchaseHeader;
//             JO := jsonFunctionsG.RecordToJson(ref);
//             purchaseLine.Reset();
//             purchaseLine.SetRange("Document No.", No);
//             if purchaseLine.FindSet() then begin
//                 repeat
//                     relationships.Add(jsonFunctionsG.RecordToJson(purchaseLine));
//                 until purchaseLine.Next() = 0;
//             end;

//             JO.Add('relationships', relationships);

//         end;
//         // if purchaseHeader.Get(purchaseHeader."Document Type"::Quote, No) then begin
//         //     ref := purchaseHeader;
//         //     JO := jsonFunctionsG.RecordToJson(ref);
//         //     purchaseLine.reset;
//         //     purchaseLine.SetRange("Document No.", no);
//         //     if purchaseLine.Find('-') then begin
//         //         repeat
//         //             ref := purchaseLine;
//         //             relationships.Add(jsonFunctionsG.RecordToJson(ref));
//         //         until purchaseLine.Next = 0;
//         //     end;
//         //     JO.Add('relationships', relationships);
//         // end;

//         exit(JO);

//     end;

//     procedure PURCHASEHEADERS(employee: code[50]): JsonArray;
//     var
//         ref: Variant;
//         pHeader: record "Purchase Header";
//         JA: JsonArray;
//     begin
//         pHeader.Reset;
//         //pHeader.SetRange("Employee No", employee);
//         if pHeader.Find('-') then begin
//             repeat
//                 ref := pHeader;
//                 JA.Add(PURCHASEHEADER(pHeader."No."));
//             until pHeader.Next = 0;
//         end;
//         exit(JA);
//     end;


//     procedure REQUESTFORMHEADERS(employee: code[50]): JsonArray;
//     var
//         ref: Variant;
//         pHeader: record "Purchase Header";
//         JA: JsonArray;
//     begin
//         pHeader.Reset;
//         //pHeader.SetRange("Employee No", employee);
//         if pHeader.Find('-') then begin
//             repeat
//                 ref := pHeader;
//                 JA.Add(REQUESTFORM(pHeader."No."));
//             until pHeader.Next = 0;
//         end;
//         exit(JA);
//     end;









//     procedure FnInsertRequestForm(JsonData: Text[2048]) jsonObject: JsonObject
//     var
//         lineNo: Integer;
//         departuretime: DateTime;
//         arrivalTime: DateTime;
//         ModifyLineNo: Integer;
//         purchaseheader: Record "Purchase Header";
//         hrEmployee: Record "HR Employees";
//         customer: Record Customer;

//     begin

//         lJSONString := JsonData;
//         if lJSONString <> '' then
//             lJObject := lJObject.Parse(Format(lJSONString));
//         if Format(lJObject.GetValue('No')) = '' then begin
//             purchaseheader.Init;
//             GenLedgerSetup.Get;
//             // purchaseheader."No." := objNumSeries.GetNextNo(GenLedgerSetup."Mission Proposal Nos.", 0D, true);
//             // purchaseheader."No. Series" := GenLedgerSetup."Mission Proposal Nos.";
//             // purchaseheader."Document Type" := purchaseheader."document type"::Quote;
//         end
//         else
//             purchaseheader."No." := Format(lJObject.GetValue('No'));

//         purchaseheader."Shortcut Dimension 1 Code" := Format(lJObject.GetValue('ProgramCode'));
//         purchaseheader."Shortcut Dimension 2 Code" := Format(lJObject.GetValue('budgetdminesion'));
//         // purchaseheader.Purpose := Format(lJObject.GetValue('Purpose'));
//         // purchaseheader."Posting Description" := Format(lJObject.GetValue('Department'));
//         // purchaseheader.MP := true;
//         // hrEmployee.Get(purchaseHeader."Employee No");
//         // purchaseHeader."Employee Name" := hrEmployee."First Name" + ' ' + hrEmployee."Middle Name" + ' ' + hrEmployee."Last Name";
//         // purchaseHeader."Account No" := hrEmployee.Travelaccountno;
//         // customer.get(hrEmployee.Travelaccountno);
//         // purchaseHeader."Responsibility Center" := hrEmployee."Responsibility Center";
//         // purchaseHeader."Responsibility Center Name" := hrEmployee."Responsibility Center Name";
//         // purchaseheader.Validate("Employee No");
//         // Peformance
//         //Travel detials
//         lArrayString := lJObject.SelectToken('relationships').ToString;
//         Clear(lJObject);
//         lJsonArray := lJsonArray.Parse(lArrayString);

//         if ModifyLineNo = 0 then
//             purchaseline.Insert
//         else
//             purchaseline.Modify;

//         foreach lJObject in lJsonArray do begin
//             Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));

//             if ModifyLineNo = 0 then begin
//                 purchaseline.Init;
//                 purchaseline."Line No." := lineNo;
//             end else
//                 purchaseline."Line No." := ModifyLineNo;
//             purchaseline."Document No." := purchaseheader."No.";
//             // purchaseline."Line Type" := purchaseline."line type"::ActionPoints;


//             // Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));
//             // purchaseline.date := purchaseline.date;
//             // Evaluate(departuretime, Format(lJObject.GetValue('departureTime')));
//             // purchaseline.departureTime := Dt2Time(departuretime);
//             // purchaseline.departurePlace := Format(lJObject.GetValue('departurePlace'));
//             // purchaseline.arrivalPlace := Format(lJObject.GetValue('arrivalPlace'));
//             // Evaluate(arrivalTime, Format(lJObject.GetValue('arrivalTime')));
//             // purchaseline.arrivalTime := Dt2Time(arrivalTime);
//             // purchaseline.remarks := Format(lJObject.GetValue('remarks'));

//             if ModifyLineNo = 0 then
//                 purchaseline.Insert
//             else
//                 purchaseline.Modify;

//             lineNo += 1000;
//         end;
//         lJObject := lJObject.Parse(Format(lJSONString));
//         lArrayString := lJObject.SelectToken('AccomodationDetails').ToString;
//         Clear(lJObject);
//         lJsonArray := lJsonArray.Parse(lArrayString);

//         //Accoumodation detils
//         foreach lJObject in lJsonArray do begin
//             Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
//             if ModifyLineNo = 0 then begin
//                 purchaseline.Init;
//                 purchaseline."Line No." := lineNo;
//             end else
//                 purchaseline."Line No." := ModifyLineNo;
//             // purchaseline."Document No." := purchaseheader."No.";
//             // purchaseline."Line Type" := purchaseline."line type"::Activity;


//             // Evaluate(purchaseline.dateFrom, Format(lJObject.GetValue('dateFrom')));
//             // Evaluate(purchaseline.dateTo, Format(lJObject.GetValue('dateTo')));
//             // purchaseline.date := purchaseline.date;
//             // Evaluate(purchaseline.accomodtionCatered, Format(lJObject.GetValue('accomodationCatered')));


//             Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));


//             if ModifyLineNo = 0 then
//                 purchaseline.Insert
//             else
//                 purchaseline.Modify;

//             lineNo += 1000;
//         end;

//         /// Meals and incidentals
//         lJObject := lJObject.Parse(Format(lJSONString));
//         lArrayString := lJObject.SelectToken('MealsAndIncidentals').ToString;
//         Clear(lJObject);
//         lJsonArray := lJsonArray.Parse(lArrayString);

//         foreach lJObject in lJsonArray do begin
//             Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
//             if ModifyLineNo = 0 then begin
//                 purchaseline.Init;
//                 purchaseline."Line No." := lineNo;
//             end else
//                 purchaseline."Line No." := ModifyLineNo;
//             // purchaseline."Document No." := purchaseheader."No.";
//             // purchaseline."Line Type" := purchaseline."line type"::"Budget Info";


//             // Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));

//             // purchaseline."location." := Format(lJObject.GetValue('location'));
//             // purchaseline.Description := Format(lJObject.GetValue('description'));
//             // Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));
//             // Evaluate(purchaseline.noOfDays, Format(lJObject.GetValue('noOfDays')));


//             if ModifyLineNo = 0 then
//                 purchaseline.Insert
//             else
//                 purchaseline.Modify;

//             lineNo += 1000;
//         end;

//         // other expenses
//         lJObject := lJObject.Parse(Format(lJSONString));
//         lArrayString := lJObject.SelectToken('OtherExpenses').ToString;
//         Clear(lJObject);
//         lJsonArray := lJsonArray.Parse(lArrayString);


//         foreach lJObject in lJsonArray do begin
//             Evaluate(ModifyLineNo, Format(lJObject.GetValue('LineNo')));
//             if ModifyLineNo = 0 then begin
//                 purchaseline.Init;
//                 purchaseline."Line No." := lineNo;
//             end else
//                 //     purchaseline."Line No." := ModifyLineNo;
//                 // purchaseline."Document No." := purchaseheader."No.";
//                 // purchaseline."Line Type" := purchaseline."line type"::"Budget Notes";


//                 // Evaluate(purchaseline.date, Format(lJObject.GetValue('date')));

//                 // purchaseline."location." := Format(lJObject.GetValue('location'));
//                 // purchaseline.Description := Format(lJObject.GetValue('description'));
//                 // Evaluate(purchaseline.Amount, Format(lJObject.GetValue('amount')));


//                 if ModifyLineNo = 0 then
//                     purchaseline.Insert
//                 else
//                     purchaseline.Modify;
//             lineNo += 1000;
//         end;
//         if Format(lJObject.GetValue('No')) = '' then
//             purchaseheader.Insert
//         else
//             purchaseheader.Modify;
//     end;

//     procedure browseJson(J: JsonObject; k: Text): JsonToken
//     var
//         jtoken: JsonToken;
//     begin
//         J.Get(k, jtoken);
//         exit(jtoken);
//     end;


// }

// codeunit 80004 JsonFunctions
// {

//     // Convert records to json 
//     procedure RecordToJson(Rec: Variant): JsonObject
//     var
//         JRecord: JsonObject;
//         JMetaData: JsonObject;
//         RecRef: RecordRef;
//         i: Integer;
//     begin
//         RecRef.GetTable(Rec);

//         //Record Metadata       
//         JMetaData.Add('id', RecRef.Number());
//         JMetaData.Add('name', DelChr(RecRef.Name(), '=', ' /.-*+'));
//         JMetaData.Add('company', RecRef.CurrentCompany());
//         JMetaData.Add('position', RecRef.GetPosition(true));
//         JMetaData.Add('recordId', Format(RecRef.RecordId()));

//         // Record Primary keys
//         JRecord.Add('primaryKeys', PrimaryKeyToJson(RecRef));
//         JRecord.Add('metadata', JMetaData);

//         // Record Fields 

//         JRecord.Add('fields', FieldToJson(RecRef));
//         exit(JRecord);

//     end;

//     //Convert Fields to json 
//     procedure FieldToJson(RecRef: RecordRef): JsonObject
//     var
//         i: Integer;
//         FRef: FieldRef;
//         JField: JsonObject;
//         fieldName: Text;
//         keyExists: Boolean;
//         keys: Boolean;
//         KeyValue: Text;
//     begin
//         JField := JField;
//         for i := 1 to RecRef.FieldCount do begin
//             FRef := RecRef.FieldIndex(i);
//             if (i <> 273) and (i <> 270) then begin
//                 fieldName := DelChr(FRef.Name(), '=', ' /.-*+');
//                 keyExists := false;
//                 // Check if the key already exists
//                 if not JField.Contains(fieldName) then
//                     JField.Add(fieldName, FieldToJsonValue(FRef));
//             end;

//             // if i <> 273 then
//             //     //TODO Check on these indexes in future
//             //     if i <> 270 then
//             //         JField.add(DelChr(FRef.Name(), '=', ' /.-*+'), FieldToJsonValue(FRef));

//         end;


//         exit(JField);
//     end;


//     procedure PrimaryKeyToJson(RecRef: RecordRef): JsonObject
//     var
//         FR_PrimaryKey: FieldRef;
//         KeyRef_PrimaryKey: KeyRef;
//         JO_PrimaryKey: JsonObject;
//         JO_Key: JsonArray;
//         i: Integer;
//         JsonValue: JsonValue;
//     begin
//         KeyRef_PrimaryKey := RecRef.KeyIndex(1);
//         for i := 1 to KeyRef_PrimaryKey.FieldCount() do begin
//             FR_PrimaryKey := KeyRef_PrimaryKey.FieldIndex(i);
//             //JO_PrimaryKey.Add(FieldToJson(FR_PrimaryKey));
//             JO_PrimaryKey.Add(FR_PrimaryKey.Name, FieldToJsonValue(FR_PrimaryKey));

//         end;

//         exit(JO_PrimaryKey);
//     end;


//     //This method allows us to obtain the value of a FieldRef.
//     local procedure FieldToJsonValue(FieldRef: FieldRef): JsonValue
//     var
//         FieldValue: JsonValue;
//         BoolValue: Boolean;
//         IntValue: Integer;
//         DecimalValue: Decimal;
//         DateValue: Date;
//         TimeValue: Time;
//         DateTimeValue: DateTime;
//         DurationValue: Duration;
//         BigIntegerValue: BigInteger;
//         GuidValue: Guid;
//         RecordRefField: RecordRef;
//     begin
//         if (FieldRef.Class() = FieldClass::FlowField) then
//             FieldRef.CalcField();

//         if (FieldRef.Type() <> FieldType::Boolean) and (not HasValue(FieldRef)) then begin
//             FieldValue.SetValueToNull();
//             exit(FieldValue);
//         end;

//         case FieldRef.Type() of
//             FieldType::Boolean:
//                 begin
//                     BoolValue := FieldRef.Value();
//                     FieldValue.SetValue(BoolValue);
//                 end;
//             FieldType::Integer:
//                 begin
//                     IntValue := FieldRef.Value();
//                     FieldValue.SetValue(IntValue);
//                 end;
//             FieldType::Decimal:
//                 begin
//                     DecimalValue := FieldRef.Value();
//                     FieldValue.SetValue(DecimalValue);
//                 end;
//             FieldType::Date:
//                 begin
//                     DateValue := FieldRef.Value();
//                     FieldValue.SetValue(DateValue);
//                 end;
//             FieldType::Time:
//                 begin
//                     TimeValue := FieldRef.Value();
//                     FieldValue.SetValue(TimeValue);
//                 end;
//             FieldType::DateTime:
//                 begin
//                     DateTimeValue := FieldRef.Value();
//                     FieldValue.SetValue(DateTimeValue);
//                 end;
//             FieldType::Duration:
//                 begin
//                     DurationValue := FieldRef.Value();
//                     FieldValue.SetValue(DurationValue);
//                 end;
//             FieldType::BigInteger:
//                 begin
//                     BigIntegerValue := FieldRef.Value();
//                     FieldValue.SetValue(BigIntegerValue);
//                 end;
//             FieldType::Guid:
//                 begin
//                     GuidValue := FieldRef.Value();
//                     FieldValue.SetValue(GuidValue);
//                 end;
//             FieldType::MediaSet:
//                 begin
//                     RecordRefField := FieldRef.Record();
//                     FieldValue.SetValue(GetBase64(RecordRefField.Number, FieldRef));
//                 end;
//             FieldType::Media:
//                 begin
//                     RecordRefField := FieldRef.Record();
//                     FieldValue.SetValue(GetBase64(RecordRefField.Number, FieldRef));
//                 end;
//             else
//                 FieldValue.SetValue(Format(FieldRef.Value()));
//         end;

//         exit(FieldValue);
//     end;


//     //GetBase64: We use it to convert the images of the tables Vendor, Customer, Item, Employee in base 64.
//     local procedure GetBase64("Table ID": Integer; FieldRef: FieldRef): Text
//     var
//         RecordRefImage: RecordRef;
//         Base64: Codeunit "Base64 Convert";
//         TenantMedia: Record "Tenant Media";
//         ItemRec: Record Item;
//         CustomerRec: Record Customer;
//         VendorRec: Record Vendor;
//         EmployeeRec: Record Employee;
//         TextOutput: Text;
//         InStream: InStream;
//     begin

//         case "Table ID" of
//             DATABASE::Item:
//                 begin
//                     RecordRefImage := FieldRef.Record();
//                     ItemRec.Get(RecordRefImage.RecordId);
//                     if (ItemRec.Picture.Count > 0) then begin
//                         if TenantMedia.Get(ItemRec.Picture.Item(1)) then begin
//                             TenantMedia.CalcFields(Content);
//                             if TenantMedia.Content.HasValue() then begin
//                                 TenantMedia.Content.CreateInStream(InStream, TextEncoding::WINDOWS);
//                                 TextOutput := Base64.ToBase64(InStream);
//                                 exit(TextOutput);
//                             end;
//                         end else begin
//                             TextOutput := 'NOIMAGE';
//                             exit(TextOutput);
//                         end;
//                     end else begin
//                         TextOutput := 'NOIMAGE';
//                         exit(TextOutput);
//                     end;
//                 end;
//             DATABASE::Customer:
//                 begin
//                     RecordRefImage := FieldRef.Record();
//                     CustomerRec.Get(RecordRefImage.RecordId);
//                     if (CustomerRec.Image.HasValue) then begin
//                         if TenantMedia.Get(CustomerRec.Image.MediaId) then begin
//                             TenantMedia.CalcFields(Content);
//                             if TenantMedia.Content.HasValue() then begin
//                                 TenantMedia.Content.CreateInStream(InStream, TextEncoding::WINDOWS);
//                                 TextOutput := Base64.ToBase64(InStream);
//                                 exit(TextOutput);
//                             end;
//                         end else begin
//                             TextOutput := 'NOIMAGE';
//                             exit(TextOutput);
//                         end;
//                     end else begin
//                         TextOutput := 'NOIMAGE';
//                         exit(TextOutput);
//                     end;
//                 end;
//             DATABASE::Vendor:
//                 begin
//                     RecordRefImage := FieldRef.Record();
//                     VendorRec.Get(RecordRefImage.RecordId);
//                     if (VendorRec.Image.HasValue) then begin
//                         if TenantMedia.Get(VendorRec.Image) then begin
//                             TenantMedia.CalcFields(Content);
//                             if TenantMedia.Content.HasValue() then begin
//                                 TenantMedia.Content.CreateInStream(InStream, TextEncoding::WINDOWS);
//                                 TextOutput := Base64.ToBase64(InStream);
//                                 exit(TextOutput);
//                             end;
//                         end else begin
//                             TextOutput := 'NOIMAGE';
//                             exit(TextOutput);
//                         end;
//                     end else begin
//                         TextOutput := 'NOIMAGE';
//                         exit(TextOutput);
//                     end;
//                 end;
//             DATABASE::Employee:
//                 begin
//                     RecordRefImage := FieldRef.Record();
//                     EmployeeRec.Get(RecordRefImage.RecordId);
//                     if (EmployeeRec.Image.HasValue) then begin
//                         if TenantMedia.Get(EmployeeRec.Image) then begin
//                             TenantMedia.CalcFields(Content);
//                             if TenantMedia.Content.HasValue() then begin
//                                 TenantMedia.Content.CreateInStream(InStream, TextEncoding::WINDOWS);
//                                 TextOutput := Base64.ToBase64(InStream);
//                                 exit(TextOutput);
//                             end;
//                         end else begin
//                             TextOutput := 'NOIMAGE';
//                             exit(TextOutput);
//                         end;
//                     end else begin
//                         TextOutput := 'NOIMAGE';
//                         exit(TextOutput);
//                     end;
//                 end;
//             else begin
//                 TextOutput := 'Not Handled'
//             end;

//         end;
//     end;

//     local procedure AssignValueToFieldRef(FR: FieldRef; JsonVal: JsonValue)
//     begin
//         case FR.Type() of
//             FieldType::code,
//         FieldType::Text:
//                 fr.Value := JsonVal.AsText();
//             FieldType::Integer:
//                 fr.Value := JsonVal.AsInteger();
//             FieldType::date:
//                 fr.Value := JsonVal.AsDate();
//             FieldType::Decimal:
//                 fr.Value := JsonVal.AsDecimal();
//             FieldType::Boolean:
//                 fr.Value := JsonVal.AsBoolean();
//             FieldType::DateTime:
//                 fr.value := JsonVal.AsDateTime();
//             FieldType::Duration:
//                 fr.value := JsonVal.AsDuration();
//             FieldType::Option:
//                 Evaluate(fr, JsonVal.AsText());

//             else
//                 error('1% is not supported', fr.Type());
//         end;



//     end;

//     procedure HasValue(FieldRef: FieldRef): Boolean
//     var
//         HasValue: Boolean;
//         Int: Integer;
//         Dec: Decimal;
//         D: Date;
//         T: Time;
//     begin
//         case FieldRef.Type() of
//             FieldType::Boolean:
//                 HasValue := FieldRef.Value();
//             FieldType::Option:
//                 HasValue := true;
//             FieldType::Integer:
//                 begin
//                     Int := FieldRef.Value();
//                     HasValue := Int <> 0;
//                 end;
//             FieldType::Decimal:
//                 begin
//                     Dec := FieldRef.Value();
//                     HasValue := Dec <> 0;
//                 end;
//             FieldType::Date:
//                 begin
//                     D := FieldRef.Value();
//                     HasValue := D <> 0D;
//                 end;
//             FieldType::Time:
//                 begin
//                     T := FieldRef.Value();
//                     HasValue := T <> 0T;
//                 end;
//             FieldType::Blob:
//                 HasValue := false;
//             else
//                 HasValue := Format(FieldRef.Value()) <> '';
//         end;

//         exit(HasValue);
//     end;

//     procedure Json2Rec(JO: JsonObject; Rec: Variant): Variant
//     var
//         Ref: RecordRef;

//     begin
//         Ref.GetTable(Rec);
//         exit(Json2Rec(JO, Ref.Number()));

//     end;

//     procedure Json2Rec(JO: JsonObject; TableNo: Integer): Variant
//     var
//         Ref: RecordRef;
//         fieldHash: Dictionary of [Text, Integer];
//         i: Integer;
//         FR: FieldRef;
//         JsonKey: Text;
//         T: JsonToken;
//         JsonVal: JsonValue;
//         RecVariant: Variant;
//         JField: JsonObject;
//         fieldName: Text;
//     begin

//         Ref.Open(TableNo);
//         for i := 1 to Ref.FieldCount() do begin
//             FR := Ref.FieldIndex(i);
//             if i <> 273 then
//                 if i <> 270 then
//                     fieldName := DelChr(FR.Name(), '=', ' /.-*+');
//             if not JField.Contains(fieldName) then
//                 fieldHash.add(DelChr(FR.Name(), '=', ' /.-*+'), FR.Number);

//         end;

//         Ref.Init();
//         foreach Jsonkey in JO.keys() do begin
//             if JO.Get(JsonKey, T) then begin
//                 if T.IsValue then begin
//                     JsonVal := T.AsValue();

//                     FR := Ref.Field(fieldHash.get(JsonKey));
//                     AssignValueToFieldRef(FR, JsonVal);
//                 end;
//             end;

//         end;

//         RecVariant := Ref;
//         exit(RecVariant);
//     end;

//     procedure Json2Recs(JO: JsonObject; TableNo: Integer): Variant
//     var
//         Ref: RecordRef;
//         fieldHash: Dictionary of [Text, Integer];
//         i: Integer;
//         FR: FieldRef;
//         JsonKey: Text;
//         T: JsonToken;
//         JsonVal: JsonValue;
//         RecVariant: Variant;
//     begin

//         Ref.Open(TableNo);
//         for i := 1 to Ref.FieldCount() do begin
//             FR := Ref.FieldIndex(i);
//             if i <> 274 then
//                 if i <> 270 then
//                     fieldHash.add(DelChr(FR.Name(), '=', ' /.-*+'), FR.Number);
//         end;

//         Ref.Init();
//         foreach Jsonkey in JO.keys() do begin
//             if JO.Get(JsonKey, T) then begin
//                 if T.IsValue then begin
//                     JsonVal := T.AsValue();

//                     FR := Ref.Field(fieldHash.get(JsonKey));
//                     AssignValueToFieldRef(FR, JsonVal);
//                 end;
//             end;

//         end;

//         RecVariant := Ref;
//         exit(RecVariant);
//     end;

//     procedure intoDynamics()

//     begin

//     end;
}