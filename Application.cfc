
<cfcomponent output="false">

	<!--- Set application name and Session variables test  --->
  	<cfset this.name="phamportal">
	<cfset this.sessionManagement=true>
	<cfset this.sessiontimeout = createtimespan(0,2,0,0)>

	<!---
	Make sure the cookies are reset so the Session is closed if the user closes the browser window
	--->
	<cfif IsDefined("Cookie.CFID") and IsDefined("Cookie.CFTOKEN")>
		<cfset localCFID = Cookie.CFID>
		<cfset localCFTOKEN = Cookie.CFTOKEN>
<!---		<cfcookie name="CFID" value="#localCFID#">
		<cfcookie name="CFTOKEN" value="#localCFTOKEN#">--->
	</cfif>

	<!--- function to check to see if the current user is logged in or not --->
	<cffunction name="checkLogin">
		<cfif isDefined('session.email')>
		<!---<cfdump var="#session.email#">--->
		<cfelse>
			<!---<a href="http://localhost:8500/phamportal/Login.cfm">YOu ar enot lgg in</a>--->
		</cfif>
	</cffunction>

	<cffunction name="onRequestStart" returntype="boolean" output="true">
		<!--- Any variables set here can be used by every page. --->
		<cfswitch expression="#cgi.SERVER_NAME#">
			<!---PRODUCTION --->
			<cfcase value="phamportal.phamhomesite.com">
				<cfset application.PhamDataSource="pham">
				<cfset application.Environment="Production">
			</cfcase>
			<!---Local Host --->
			<cfcase value="localhost">
				<cfset application.PhamDataSource="pham"><!---pham_dev --->
				<cfset application.Environment="Development">
			</cfcase>
			<cfcase value="phamportal.test.phamhomesite.com">
				<!---Test --->
				<cfset application.PhamDataSource="pham_test">
				<cfset application.Environment="TEST">
			</cfcase>
			<cfdefaultcase>
				<cfset application.PhamDataSource="pham_test">
				<cfset application.Environment="Unknown Environment">
			</cfdefaultcase> 
		</cfswitch>
		<!--- RETRIEVE HOSTNAME OR COMPUTER NAME--->
 			<!--- <cfset inet = CreateObject("java", "java.net.InetAddress")>
    		<cfset inet = inet.getLocalHost()>
    		<cfset REQUEST.computerName = #inet.getHostName()#>  --->
		<!--- set default system privileges --->
		<cfset checkLogin()>
	<cfreturn true>
	</cffunction>

  	<!--- event-based functions --->
	<cffunction name="onApplicationStart">
		<cfset Application.cfdump = 'false'>
		<cfset Application.borderWidth  = '0px'>

		<cfset application.siteroot_directory = expandPath("\")>
		<cfset application.webroot_directory = listlast(application.siteroot_directory, "\")>
		<cfset application.reportsDir = listFirst(application.siteroot_directory, "\") & "\" & listGetAt(application.siteroot_directory, 2, "\") & "\reports\">
		<cfset application.dumpSrcFilenames = "true">

	</cffunction>

	<cffunction name="onError" returnType="void">
	    <cfargument name="Exception" required=true/>
	    <cfargument name="EventName" type="String" required=true/>
	    <cfif cgi.HTTP_HOST CONTAINS 'localhost'>
	    	<cfdump var="#EventName#">
	    	<cfdump var="#Exception#">
			<!---<cfset application.Exception =  arguments.Exception>
			<cflocation url="error.cfm">--->
		<cfabort>
	    </cfif>

<!---		<cfset application.Exception =  arguments.Exception>
		<cflocation url="error.cfm">--->
	</cffunction>

<!---	<cfset variables.errorFile = 'err_request.cfm'>
	<cferror type="REQUEST" template="#variables.errorFile#" mailto="pham_mn@yahoo.com">
	<cferror type="VALIDATION" template="#variables.errorFile#" mailto="pham_mn@yahoo.com">
	<cferror type="exception" template="#variables.errorFile#" mailto="pham_mn@yahoo.com">--->

</cfcomponent>

