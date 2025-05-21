
<cfdirectory directory="C:\ColdFusion2016\cfusion\wwwroot\phamPortal\QPC" name="qPhamPortalDirectory" action="list" recurse="true" type="file" >

<cfquery name="sortPhamPortalDirectory" dbtype="query" >
	SELECT *
	FROM 	qPhamPortalDirectory
	ORDER BY DateLastModified DESC
</cfquery>
<cfdump var="#sortPhamPortalDirectory#">