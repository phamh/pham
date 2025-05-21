<cfif application.dumpSrcFilenames>
	<cfoutput>
		<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<script >
	DislayThisAccomplishment=function(AccomplishmentMonthID,AccomplishmentMonth)
	{
		try
        {
        	ColdFusion.navigate('ActivityLog/AccomplishmentDetail.cfm?AccomplishmentMonthID='+AccomplishmentMonthID+'&AccomplishmentMonth='+AccomplishmentMonth, 'ActivityLogItemContain');
			//$("#ActivityLogItem").load(location.href + " #ActivityLogItem");
        }
        catch(e)
        {
        	alert(e.message)
        }
	}
</script>

<style>
     table.ActivityDateItem {
        width: 100%;
        border: 1px solid gray;
        border-collapse: collapse;
    }

    table.ActivityDateItem td {
        border: 1px solid gray;
        padding:5px;
        color: blue;
        font-size:12px
    }

    table.ActivityDateItem td:hover {
        text-decoration: underline;
        cursor: pointer;

    }


    table.ActivityDateItem th {
        border: 1px solid gray;
        padding:5px;
        font-weight: bold;
        text-align: center;
        background-color: lightGray;
        font-size:12px
    }


    input.dottedBorder
    {
    	 border: 1px dotted black;
    	 width: 100%;
    }

</style>

<cfquery name="qGetAcomplishmentMonth" datasource="#application.PhamDataSource#">
	SELECT *
	FROM accomplishmentmonth
</cfquery>

<table class="ActivityDateItem">
	<tr>
		<th  style="width:180px">Highly Accomplishments</th>
	</tr>
	<cfoutput query="qGetAcomplishmentMonth">
		<cfif currentRow MOD 2 EQ 0>
			<cfset bgColor = 'white'>
		<cfelse>
			<cfset bgColor = '##eceaf2'>
		</cfif>
		<tr style="border-bottom: 1px solid gray; background-color:#bgColor#">
			<cfset variables.ThisAccomplishment = DateFormat(AccomplishmentMonth,  'mmmm YYYY')>
			<td class="DisplayActivityID" onclick="DislayThisAccomplishment(#AccomplishmentMonthID_pk#,'#dateFormat(AccomplishmentMonth,'short')#')">
				#variables.ThisAccomplishment#
			</td>
		</tr>
	</cfoutput>
</table>
