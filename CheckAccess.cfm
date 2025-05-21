<!---The below codes will log the users out and take them to log in page without going through Portal page --->

<!---<cfif NOT isDefined('session.email') OR session.email EQ ''>
    <cfset exists= structdelete(session, 'Email', true)/>  
    <cfset exists = StructClear(Session)>
    <cftry>
    	<cflocation url="Login.cfm" >    
    <cfcatch type="Any" >
    	<cflocation url="../Login.cfm" > 
    </cfcatch>
    </cftry>
</cfif>--->