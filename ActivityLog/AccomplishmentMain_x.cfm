<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<cfif 1 EQ 2>
<cfelse>
	<table class="ActivityDate">
		<tr style="vertical-align:top">
			<td style="border: 0px solid red; width: 10%; padding-left:0px">
				<cfdiv id="ActivityDateContain_ForAccomplishement" name="ActivityDateContain_ForAccomplishement" bind="url:AccomplishmentMonthItem.cfm?url.AccomplishmentMonthID=0"/>
			</td>
			<td style="border-left: 2px double gray; padding:5px">
				<div id="ActivityLogItem">
					<cfdiv id="AccomplishmentItemContain" name="AccomplishmentItemContain" bind="url:AccomplishmentDetail.cfm?DailyActivityId=0"/>
				</div>
			</td>
		</tr>
	</table>	
</cfif>
