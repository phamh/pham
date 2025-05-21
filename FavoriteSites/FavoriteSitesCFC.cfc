<cfcomponent>

<!---******** GET PHOTO DIRECTORY ********--->
<cffunction name="getPortal" returntype="query" >
	<cfargument name="categoryId_pk" default="">
	<cfquery name="queryGetPortal" datasource="#application.PhamDataSource#">
		SELECT ctrl_panel_id, categoryId_fk, url, name, login_info, more_info, sort_id,category
		FROM portal_category, portal
		WHERE portal_category.categoryId_pk = portal.categoryId_fk 
		<cfif #arguments.categoryId_pk# NEQ ''>
			AND portal_category.categoryId_pk = <cfqueryparam value="#arguments.categoryId_pk#" cfsqltype="cf_sql_integer">
		</cfif>
		ORDER BY name
	</cfquery>
		
	<cfreturn queryGetPortal>
</cffunction>	

<cffunction name="fSearchPortal" returntype="query" access="remote">
	<cfargument name="searchText" type="string">
	<cfquery name="qSearchPortal" datasource="#application.PhamDataSource#">
		SELECT 		ctrl_panel_id, categoryId_fk, url, name, login_info, more_info, sort_id,category
		FROM 		portal,portal_category
		WHERE		name LIKE <cfqueryparam value="%#arguments.searchText#%" cfsqltype="cf_sql_varchar"> AND 
					portal_category.categoryId_pk = portal.categoryId_fk
		ORDER BY 	name
	</cfquery>
	<cfreturn qSearchPortal>
</cffunction>	

<cffunction name="fGetCategoryName" returntype="string" >
	<cfargument name="categoryId_" default="">
 	<cfquery name="qGetCategoryName" datasource="#application.PhamDataSource#">
		SELECT *
		FROM portal_category
		WHERE portal_category.categoryId_pk = <cfqueryparam value="#arguments.category_id#" cfsqltype="cf_sql_integer"> 
	</cfquery>
	<cfreturn qGetCategoryName.category>
</cffunction>	

<cffunction name="fDeleteThisItem" returntype="string" access="remote">
	<cfargument name="ctrl_panel_id" type="numeric">
	<cftry>
	 	<cfquery name="qDeleteThisItem" datasource="#application.PhamDataSource#">
			DELETE 
			FROM 	portal
			WHERE	ctrl_panel_id = <cfqueryparam value="#arguments.ctrl_panel_id#" cfsqltype="cf_sql_integer">
		</cfquery>  	    
    <cfcatch type="Any" >
    	<cfset session.message = cfcatch.message>
    </cfcatch>
    </cftry>
	<cfreturn session.message>
</cffunction>
			
</cfcomponent>
