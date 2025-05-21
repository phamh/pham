<cfset arguments.Email = 'pham_mn@yahoo.com'>
<cfset arguments.Password = '0338511'>

<cfquery name="getUsers" datasource="#application.PhamDataSource#">
  SELECT * 
  FROM Users 
 WHERE email = <cfqueryparam cfsqltype="varchar" value="#arguments.Email#">

</cfquery>
<cfdump var="#getUsers#">
<cfif NOT getUsers.recordCount>
	not found <cfabort>
<cfelse>

<cfloop query="getUsers">
  <cfset variables.passwordSalt = hash(generateSecretKey('AES'),'SHA-512')>
  <cfquery name="setHashedPassword" datasource="#application.PhamDataSource#">
    UPDATE Users
    SET
      passwordHash = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#hash(arguments.Password & variables.passwordSalt,'SHA-512')#">,
      passwordSalt = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#variables.passwordSalt#">
 	WHERE email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
  </cfquery>
</cfloop>
<cfdump var="#hash(arguments.Password & variables.passwordSalt,'SHA-512')#">
<cfquery name="getUsers" datasource="#application.PhamDataSource#">
  SELECT * 
  FROM Users 
  WHERE email = <cfqueryparam cfsqltype="varchar" value="#arguments.Email#">

</cfquery>


<cfset variables.AuthenticateStatus = '' >
<cfquery name="Authenticate" datasource="#application.PhamDataSource#">
  SELECT	*
  FROM		Users
  WHERE		email = <cfqueryparam cfsqltype="varchar" value="#arguments.Email#">
 

	<!---	  SELECT	email, passwordHash, passwordSalt, roleId_fk, firstName, rolename
		  FROM		Users, Roles
		  WHERE		email = <cfqueryparam cfsqltype="varchar" value="#arguments.Email#"> AND 
		  			roleId_pk = roleID_fk	--->
</cfquery>		  			
<cfdump var="#Authenticate.passwordHash#">		  			
<cfdump var="#hash(arguments.Password & Authenticate.passwordSalt, 'SHA-512')#">
<cfif Authenticate.passwordHash eq hash(arguments.Password & Authenticate.passwordSalt, 'SHA-512')>yes
	<!--- User is authenticated. Run whatever code is needed to establish a user session. --->
	<cfset variables.AuthenticateStatus = 1>
	<cfset session.email = Authenticate.email>
<cfelse>
  <!--- User is not authenticated. Redirect them to the login page with an error message. --->
  NO
  	<cfset variables.AuthenticateStatus = 0>
  	<cfset StructClear(Session)>
</cfif>
</cfif>
		