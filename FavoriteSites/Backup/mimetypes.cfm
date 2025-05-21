<cfparam name="SESSION.MimeTypes" default="">

<cfset SESSION.MimeTypes = 'application/vnd.ms-excel, 
													application/excel, 
													application/x-excel,
													application/x-msexcel, 
													application/msexcel, 												
													application/msword, 
														
													application/vnd.ms-powerpoint, 
													application/mspowerpoint, 
													application/powerpoint, 
													application/x-mspowerpoint,
													
													application/vnd.ms-project,
													application/pdf,
													
													application/xls,
													application/doc,
													text/html,
													image/jpeg,
													image/gif,
													image/pjpeg,
													image/png,
application/vnd.openxmlformats-officedocument.wordprocessingml.document, <!---docm--->
application/vnd.ms-word.document.macroEnabled.12, <!---docx--->
application/vnd.ms-word.template.macroEnabled.12, <!---dotm--->
application/vnd.openxmlformats-officedocument.wordprocessingml.template, <!---dotx--->
application/vnd.ms-powerpoint.slideshow.macroEnabled.12, <!---ppsm--->
application/vnd.openxmlformats-officedocument.presentationml.slideshow, <!---ppsx--->
application/vnd.ms-powerpoint.presentation.macroEnabled.12, <!---pptm--->
application/vnd.openxmlformats-officedocument.presentationml.presentation, <!---pptx--->
application/vnd.ms-excel.sheet.binary.macroEnabled.12,  <!---xlsb--->
application/vnd.ms-excel.sheet.macroEnabled.12,  <!---xlsm--->
application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, <!---xlsx--->
application/vnd.ms-xpsdocument <!---xps--->'>




<cfif cgi.SERVER_NAME EQ 'localhost'>
	<cfset SESSION.myDocsDestination = 'C:\ColdFusion8\wwwroot\RCU\httpdocs\pham\documents\'>
<cfelse>
	<cfset SESSION.myDocsDestination =  'C:\Inetpub\vhosts\rocketcityunited.com\httpdocs\pham\documents\'>
</cfif>		
