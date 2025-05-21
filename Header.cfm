<!---<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">--->
<!doctype html>
<html lang="en">	
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">	
	<!---<link rel="stylesheet" type="text/css" href="pham.css">--->
	<title>Pham Portal</title>
	<!--- <link rel="stylesheet" href="jQuery/jQuery_UI_V1_13_0.css" > --->
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

	<!---Bootstrap icons https://fontawesomeicons.com/bootstrap/icons --->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">	
			
	<!---Trash, edit icons --->	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

	<!---<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">--->
	<!---<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">--->	
		
	<!--- <script src="jQuery/jQuery_v3_6_0.js"></script> --->
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

	<!--- <script src="jQuery/jQuery_UI_v1.13.0.js"></script> --->
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

<!--- <link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>--->
  		
</head>

<body onload="BodyOnLoad();">

<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<script>
	BodyOnLoad=function()
	{	//alert('BodyOnLoad');
		var LoginStatus = document.getElementById('sessionEmail').value;
		if(LoginStatus == 'NO')
		{
			ColdFusion.navigate('Login.cfm');
		}
	}
		
</script>	
<style>
	body{
		/*background-color: #d5d3d2;*/
	}
</style>
<cfif NOT isDefined('session.email') OR session.email EQ ''>
	<input id="sessionEmail" value="NO" type="hidden"></input>
<cfelse>
	<input id="sessionEmail" type="hidden" value="<cfoutput>#session.email#</cfoutput>"></input>	
</cfif>
<cfinclude template="CSS/MainCSS.cfm" >	
<cfinclude template="Scripts/MainJS.cfm" >
<cfajaxproxy  cfc="AjaxFunc.PhamPortal" jsclassname="PhamPortalCFC">
<cfajaximport tags="cfwindow">






