<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>

<cfset url.KEYWORDS = replace(url.KEYWORDS, " ", "", "All")>
<cfset url.KEYWORDS = replace(url.KEYWORDS, ",", ";", "All")>

<cfquery name="getItems" datasource="#REQUEST.dataSource#"username="#REQUEST.username#" password="#REQUEST.password#">
    SELECT * FROM  portal
    WHERE 1 = 2
    <cfloop list="#url.keywords#" delimiters=";" index="keywordIndex">
    	OR name LIKE '%#keywordIndex#%'
    </cfloop>    
</cfquery>


<cfoutput>Key words: #url.KEYWORDS#</cfoutput>

<table border="1">
	<tr>
		<th>Name</th>
		<th>Category</th>
		<th></th>
	</tr>
	<cfoutput query="getItems">
		<cfquery name="getCategory" datasource="#REQUEST.dataSource#" username="#REQUEST.username#" password="#REQUEST.password#">
			SELECT * FROM portal_category
			WHERE category_id = '#getItems.category_id#'
		</cfquery>
		<tr>
			<td><a href="#url#" target="_blank">#name#</a></td>
			<td>#getCategory.category#</td>
			<td><cfif isDefined('SESSION.email')>#getItems.LOGIN_INFO# [#getItems.more_info#]</cfif></td>
		</tr>
	</cfoutput>	
			
</table>

</body>
</html>