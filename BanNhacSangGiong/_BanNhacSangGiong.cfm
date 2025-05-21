
<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<cfprocessingdirective pageencoding = "utf-8">
<div class="outer" style="margin-bottom:5px;">
<cfset songDestination = expandPath("\") & 'BanNhacSangGiong\Songs'>

<script>
	uploaFile=function()
	{
		GoToThisPage('BanNhacSangGiong/_BanNhacSangGiong.cfm','SangGiong',0)
	}
</script>
<script>

/*	GoToThisPage=function(ThisPage,ThisMenu, SoCauType )
	{
		alert(1);
	}*/

</script>
<cfif isDefined('form.submitForm')>


</cfif>

<cfdump var="#form#">
<!---<form id="BanNhacSangGiongForm" name="BanNhacSangGiongForm" method="post" enctype="multipart/form-data"  onsubmit="GoToThisPage()" action="BanNhacSangGiong/_BanNhacSangGiong.cfm">--->
<form id="BanNhacSangGiongForm" name="BanNhacSangGiongForm" method="post" enctype="multipart/form-data"  onsubmit="GoToThisPage()" action="Index.cfm?Id=SangGiong">
	<input type="file" name="LoadSong" id="LoadSong"></input>
	<input type="submit"  name="submitForm" id="submitForm" value="Load Song">
</form>
</div>


