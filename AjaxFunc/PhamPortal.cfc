<cfcomponent>

	<cffunction name="validateUser" access="remote" returntype="string">
		<cfargument name="Email"type="string">
		<cfquery name="qAuthenticate" datasource="#application.PhamDataSource#">
		  SELECT	Email, passwordHash, passwordSalt
		  FROM		Users
		  WHERE		Email = <cfqueryparam cfsqltype="varchar" value="#arguments.Email#">
		</cfquery>
		<cfreturn qAuthenticate.recordCount>
	</cffunction>

	<cfset session.message = 'no error'>
	<cffunction name="LogIn" access="remote" returntype="string">
		<cfargument name="Email"type="string">
		<cfargument name="Password"type="string">
		<cfargument name="rememberUserId" type="boolean">

		<cfset variables.AuthenticateStatus = '' >
		<cfquery name="Authenticate" datasource="#application.PhamDataSource#">
		  SELECT	user_id,email, passwordHash, passwordSalt, roleId_fk, firstName, rolename,roleId_pk
		  FROM		Users, Roles
		  WHERE		email = <cfqueryparam cfsqltype="varchar" value="#arguments.Email#"> 
		  			<!---AND roleId_pk = roleID_fk--->
		</cfquery>

		<cfif Authenticate.passwordHash eq hash(arguments.Password & Authenticate.passwordSalt, 'SHA-512')>
			<cfquery name="qyrGetUserRole" datasource="#application.PhamDataSource#">
				SELECT	roleId_fk
				FROM	Users
				WHERE	email = <cfqueryparam cfsqltype="varchar" value="#arguments.Email#"> 
			  </cfquery>

			<!--- User is authenticated. Run whatever code is needed to establish a user session. --->
			<cfset variables.AuthenticateStatus = 1>
			<cfset session.email = Authenticate.email>
			<cfset session.RoleId = qyrGetUserRole.roleId_fk>
			<cfset session.UserAccountId = Authenticate.user_id>

	        <cfif arguments.rememberUserId>
		     		<cfcookie name="LoginEmail" value="#arguments.Email#" expires="NEVER">
			<cfelse>
				<cfcookie name="LoginEmail" value="#arguments.Email#" expires="NOW">
		     </cfif>
		<cfelse>
		  <!--- User is not authenticated. Redirect them to the login page with an error message. --->
		  	<cfset variables.AuthenticateStatus = 0>
		  	<cfset StructClear(Session)>
		</cfif>
		<cfreturn variables.AuthenticateStatus>
	</cffunction>

	<cffunction name="Logout" access="remote" returntype="string">
		<!---<cfset StructClear(Session)>--->
		<cfcookie name="CFID" value="empty" expires="NOW">
		<cfcookie name="CFTOKEN" value="empty" expires="NOW">

        <cfset exists= structdelete(session, 'Email', true)/>
        <cfset exists= structdelete(session, 'UserAccountId', true)/>
        <cfset exists= structdelete(session, 'message', true)/>
        <cfset exists = StructClear(Session)>

		<cfreturn 'out'>
	</cffunction>

	<cffunction name="SetApplicationDumpSrcFilenames" access="remote">
		<cfset application.dumpSrcFilenames = !application.dumpSrcFilenames>
		<cfreturn application.dumpSrcFilenames>
	</cffunction>

	<cffunction name="fGetUserInformation" access="remote" returntype="Query" >
		<cfargument name="Email"type="string">
		<cfquery name="qGetUserInformation" datasource="#application.PhamDataSource#">
		  SELECT	email, passwordHash, passwordSalt, roleId_fk, firstName, rolename, CONCAT(firstName, ' ', lastname) as fullName
		  FROM		Users, Roles
		  WHERE		email = <cfqueryparam cfsqltype="varchar" value="#arguments.Email#"> AND
		  			roleId_pk = roleID_fk
		</cfquery>
		<cfreturn qGetUserInformation>
	</cffunction>

	<cffunction name="fSignupAccount" access="remote" returntype="string">
		<cfargument name="FirstName"  type="string">
		<cfargument name="LastName"  type="string">
		<cfargument name="Email"  type="string">
		<cfargument name="Password" type="string">

		<cfset session.error = 'NoError'>
		<cftry>
			<cfset variables.passwordSalt = hash(generateSecretKey('AES'),'SHA-512')>
			<cfquery name="qSignupAccount" datasource="#application.PhamDataSource#">
			  INSERT INTO Users (FirstName, LastName,Email,passwordHash,passwordSalt,RoleId_fk)
			  VALUES
			  (
			  	<cfqueryparam cfsqltype="varchar" value="#arguments.FirstName#">,
			  	<cfqueryparam cfsqltype="varchar" value="#arguments.LastName#">,
			  	<cfqueryparam cfsqltype="varchar" value="#arguments.Email#">,
			  	<cfqueryparam cfsqltype="varchar" value= "#hash(arguments.Password & variables.passwordSalt,'SHA-512')#">,
			  	<cfqueryparam cfsqltype="varchar" value= "#variables.passwordSalt#">,
			  	<cfqueryparam cfsqltype="cf_sql_integer" value= "6">
			  )
			</cfquery>
        <cfcatch type="Any" >
        	<cfset session.error = cfcatch>
        	<cflocation url="error.cfm" >
        </cfcatch>
        </cftry>
		<cfreturn 'good'>
	</cffunction>

	<cffunction name="fGetUser" access="remote" returntype="query">
		<cfset session.error = 'NoError'>
		<cftry>
		<cfquery name="qGetUsers" datasource="#application.PhamDataSource#">
		    SELECT 		email, roleId_fk, firstName, rolename<!---,passwordHash,passwordSalt--->
		    FROM		users, roles
		    WHERE		roleId_pk = roleID_fk
		</cfquery>
        <cfcatch type="Any" >
        	<cfset session.error = cfcatch>
        	<cflocation url="error.cfm" >
        </cfcatch>
        </cftry>
		<cfreturn qGetUsers>
	</cffunction>

	<cffunction name="fData" returnformat="JSON" access="remote">
		<cfset stateQuery=queryNew("Name, abbreviation","varchar, varchar")>
		<cfset QueryAddRow(stateQuery, 4)>
		<cfset QuerySetCell(stateQuery, "Name", "Alabama", 1)>
		<cfset QuerySetCell(stateQuery, "abbreviation", "AL", 1)>
		<cfset QuerySetCell(stateQuery, "Name", "Minnesota", 2)>
		<cfset QuerySetCell(stateQuery, "abbreviation", "MN", 2)>
		<cfset QuerySetCell(stateQuery, "Name", "Florida", 3)>
		<cfset QuerySetCell(stateQuery, "abbreviation", "FL", 3)>
		<cfset QuerySetCell(stateQuery, "Name", "California", 4)>
		<cfset QuerySetCell(stateQuery, "abbreviation", "CA", 4)>
		<cfreturn serializeJSON(stateQuery, "struct")>
	</cffunction>

	<cffunction name="fInsertNewSong" access="remote" returntype="string">
		<cfargument name="songName"  type="string">
		<cfargument name="songWriter"  type="string" default="">
		<cfargument name="poemWriter"  type="string" default="">
		<cfargument name="songType"  type="numeric"  default="0">
		<cfargument name="songTone"  type="string" default="">
		<cfargument name="songLink"  type="string" default="">
		<cfargument name="SongContent"  type="string">
		<cfargument name="Singer"  type="string">

		<cfset session.error = 'NoError'>
		<cftry>
			<cfquery name="qInsertNewSong" datasource="#application.PhamDataSource#">
			  INSERT INTO hopampham (SongName, SongWriter, PoemWriter, SongTypeID_fk, SongCreatedDate, MainTone, SongContent,singer,songLink)
			  VALUES
			  (
			  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.SongName#">,
			  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.SongWriter#">,
			  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.poemWriter#">,
			  	<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.songType#">,
			  	<cfqueryparam cfsqltype="cf_sql_date" value="#now()#">,
			  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.songTone#">,
			  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.SongContent#">,
			  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Singer#">,
			  	<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.songLink#">
			  )
			</cfquery>
        <cfcatch type="Any" >
        	<cfset session.error = cfcatch.message>
        	<cflocation url="error.cfm" >
        </cfcatch>
        </cftry>
		<cfreturn session.error>
	</cffunction>

	<cffunction name="fDeleteThisSong" access="remote" returntype="string">
		<cfargument name="HopAmPhamID_pk"  type="numeric">

		<cfset session.error = 'NoError'>
		<cftry>
			<cfquery name="dDeleteThisSong" datasource="#application.PhamDataSource#">
			  DELETE
			  FROM hopampham
			  WHERE	HopAmPhamID_pk = <cfqueryparam value="#arguments.HopAmPhamID_pk#">
			</cfquery>
        <cfcatch type="Any" >
        	<cfset session.error = cfcatch.message>
        	<cflocation url="error.cfm" >
        </cfcatch>
        </cftry>
		<cfreturn session.error>
	</cffunction>

</cfcomponent>


