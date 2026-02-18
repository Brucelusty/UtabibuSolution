Import-Module -name "C:\Program Files\Microsoft Dynamics 365 Business Central\220\Service\Management\Microsoft.Dynamics.Nav.Management.dll";

Invoke-NAVCodeunit -ServerInstance BC220 -CompanyName 'DIMKES DT SACCO' -CodeunitId 80009 -MethodName 'resendSsms';
