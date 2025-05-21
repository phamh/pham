<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>
<cfajaxproxy cfc="phamportal.ajaxFunc.PhamPortal" jsclassname="PhamPortalCFC">
<script>

	var e = new PhamPortalCFC();
	e.setHTTPMethod("POST");

	function logout()
	{
		theConfirm = confirm('Log out?');
		if(theConfirm == true)
		{
			ColdFusion.navigate('login.cfm');
			jsLogout = e.function_logout();
		}

		return true;
	}


	AddNewSong=function()
	{
		$.ajax({
		  url: "HopAmPham/song_new.cfm",
		  type: "get", //send it through get method
		  data: {
		    //Estimate: qGetAllEstimates.estimateNumber

		  },
        success: function(data, textStatus, jqXHR)
        {
            //data: return data from server
            document.getElementById('EstimateDetails').style.display = 'block';
            $("#EstimateDetails").html(data);
        },
		  error: function(XMLHttpRequest,textStatus,errorThrown) {
		    alert('An error has occurred making this request: ' + errorThrown)
		  }
		});
	}

	SubmitNewSong=function()
	{
		try
        {
	 		var songName = $('#songName').val();
			var songWriter = $('#songWriter').val();
			var songContent = $('#songContent').val();

			var jsInsertNewSongStatus = e.fInsertNewSong(songName,songWriter,songContent);

        }
        catch(error)
        {
        	alert(error.message);
        }

	}


	ViewThisSong=function(HopAmPhamID_pk,FileName)
	{
		$.ajax({
		  url: "HopAmPham/"+FileName+"?HopAmPhamID_pk=+"+HopAmPhamID_pk,
		  type: "get", //send it through get method
		  data: {
		    //Estimate: qGetAllEstimates.estimateNumber

		  },
        success: function(data, textStatus, jqXHR)
        {
            //data: return data from server
            document.getElementById('SongDetails').style.display = 'block';
            $("#SongDetails").html(data);
           // $("#SongDetails").css(background: green,color: red);
            $('#SongDetails').css({"color":"black","background":"yellow"});
            $("#SongDetails").css("font-size", "20pt");

        },
		  error: function(XMLHttpRequest,textStatus,errorThrown) {
		    alert('An error has occurred making this request: ' + errorThrown)
		  }
		});
	}

</script>

<style>


	.prev
	{
		font-size:20px
	}

</style>

<cfquery name="qGetAllSongs" datasource="#application.PhamDataSource#">
    SELECT 		HopAmPhamID_pk, SongName, SongWriter, PoemWriter, SongTypeID_fk, SongCreatedDate, Tone, SongContent
    FROM		hopampham
    ORDER BY 	HopAmPhamID_pk DESC
</cfquery>

<div id="dialog_newEstimate" title="New Estimate" style="display:none">
	<cfdump var="#now()#">
</div>

<div style="width: 100%; border:0px solid red; padding:5px" id="EstimateMenuDiv">
	<table>
		<tr>
			<td style="vertical-align:top">
				<div class="vertical-align-content">
					<input type="button" value="[+] New Song" class="button" onclick="AddNewSong()">
				</div>
				<div style="border:1px solid black; height:700px; overflow-y:scroll;width:120px">

					<table class="EstimateMenu" id="estimateMenuTable">
						<cfoutput query="qGetAllSongs">
							<cfif currentRow MOD 2 EQ 1>
								<cfset rowBackgroundColor = 'white'>
							<cfelse>
								<cfset rowBackgroundColor = '##eceaf2'>
							</cfif>
							<tr style="height:25px;background-color: #rowBackgroundColor#; cursor: pointer" onclick="ViewThisSong(#HopAmPhamID_pk#,'Song_view.cfm')" id="currentRow_#currentRow#" >
								<td id="data" style="font-size:14px;">#SongName#</td>
							</tr>
						</cfoutput>
					</table>
				</div>
			</td>
			<td style="vertical-align:top">
				<div id="SongDetails" class="prev"></div>
			</td>
		</tr>
	</table>
</div>
<div>

</div>

