<!---<cfinclude template="../checkAccess.cfm">--->
<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<script>
	var cfc = new PhamPortalCFC();
	cfc.setHTTPMethod("POST");
	Logout = function()
	{
		var confirmLogout = confirm('Are you sure you want to log out?');
		if(confirmLogout == true)
		{
			var LogoutStatus = cfc.Logout();
			ColdFusion.navigate('login.cfm');
		}
	}

	BackToPortal=function()
	{
		ColdFusion.navigate('portal.cfm');
	}

	downloadThisFile=function(thisFile)
	{
		//alert(thisFile);
		//window.location.href = thisFile;
		//window.location.target = "_blank";

		var a = document.createElement('a');
		a.href=thisFile;
		a.target = '_blank';
		document.body.appendChild(a);
		a.click();
	}
</script>