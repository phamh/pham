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
		  url: "HopAmPham/Song_new.cfm",
		  type: "get", //send it through get method
		  data: {
		    //Estimate: qGetAllEstimates.estimateNumber

		  },
        success: function(data, textStatus, jqXHR)
        {
            //data: return data from server
            document.getElementById('SongDetails').style.display = 'block';
            $("#SongDetails").html(data);
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
			var poemWriter = $('#poemWriter').val();
			var songType = $('#songType').val();
			var songTone = $('#songTone').val();
			var singer = $('#singer').val();
			var songLink = $('#songLink').val();
			var songContent = $('#songContent').val();
			var jsInsertNewSongStatus = e.fInsertNewSong(songName,songWriter,poemWriter,songType,songTone,songLink,songContent,singer);

        }
        catch(error)
        {
        	alert(error.message);
        }

	}

	ViewThisSong=function(HopAmPhamID_pk)
	{
		$.ajax({
		  url: "HopAmPham/Song_view.cfm?HopAmPhamID_pk="+HopAmPhamID_pk,
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
            $('#SongDetails').css({"color":"black","background":"white"});
            //$("#SongDetails").css("font-size", "20pt");

        },
		  error: function(XMLHttpRequest,textStatus,errorThrown) {
		    alert('An error has occurred making this request: ' + errorThrown)
		  }
		});
	}

	DeleteThisSong=function(HopAmPhamID_pk)
	{
		var theConfirm = confirm('Are you sure you want to delete this song?');
		if(theConfirm)
		{
			var jsDeleteThisSongStatus = e.fDeleteThisSong(HopAmPhamID_pk);
			Cancel();
		}

	}

	Cancel=function()
	{
		$.ajax({
		  url: "HopAmPham/Song_view.cfm?HopAmPhamID_pk=0",
		  type: "get", //send it through get method
		  data: {
		    //Estimate: qGetAllEstimates.estimateNumber

		  },
        success: function(data, textStatus, jqXHR)
        {
            //data: return data from server
            document.getElementById('SongDetails').style.display = 'block';
            $("#SongDetails").html(data);
        },
		  error: function(XMLHttpRequest,textStatus,errorThrown) {
		    alert('An error has occurred making this request: ' + errorThrown)
		  }
		});
	}

	EditThisSong=function(HopAmPhamID_pk)
	{
		$.ajax({
		  url: "HopAmPham/Song_Edit.cfm?HopAmPhamID_pk="+HopAmPhamID_pk,
		  type: "get", //send it through get method
		  data: {
		    //Estimate: qGetAllEstimates.estimateNumber

		  },
        success: function(data, textStatus, jqXHR)
        {
            //data: return data from server
            document.getElementById('SongDetails').style.display = 'block';
             $("#SongDetails").html(data);
        },
		  error: function(XMLHttpRequest,textStatus,errorThrown) {
		    alert('An error has occurred making this request: ' + errorThrown)
		  }
		});
	}

	SaveThisSong=function(HopAmPhamID_pk)
	{	alert('SaveThisSong'); return false;
		$.ajax({
		  url: "HopAmPham/Song_Edit.cfm?HopAmPhamID_pk="+HopAmPhamID_pk,
		  type: "get", //send it through get method
		  data: {
		    //Estimate: qGetAllEstimates.estimateNumber

		  },
        success: function(data, textStatus, jqXHR)
        {
            //data: return data from server
            document.getElementById('SongDetails').style.display = 'block';
             $("#SongDetails").html(data);
        },
		  error: function(XMLHttpRequest,textStatus,errorThrown) {
		    alert('An error has occurred making this request: ' + errorThrown)
		  }
		});
	}

</script>

<cfif isDefined('') AND session.error NEQ 'NoError'>
	<cfdump var="#session.error#">
</cfif>
<cfquery name="qGetAllSongs" datasource="#application.PhamDataSource#">
    SELECT 		HopAmPhamID_pk, SongName, SongWriter, PoemWriter, SongTypeID_fk, SongCreatedDate, MainTone, SongContent
    FROM		hopampham
    ORDER BY 	HopAmPhamID_pk DESC
</cfquery>

<div>
	<input type="button" value="[+] New Song" class="button" onclick="AddNewSong()">
</div>

<div style="width: 100%; border:0px solid red; padding:5px" id="EstimateMenuDiv">
	<table>
		<tr>
			<td style="vertical-align:top">
				<div style="border:1px solid black; height:700px; overflow-y:scroll;width:200px">

					<table class="EstimateMenu" id="estimateMenuTable">
						<cfoutput query="qGetAllSongs">
							<cfif currentRow MOD 2 EQ 1>
								<cfset rowBackgroundColor = 'white'>
							<cfelse>
								<cfset rowBackgroundColor = '##eceaf2'>
							</cfif>
							<tr style="height:25px;background-color: #rowBackgroundColor#; cursor: pointer" onclick="ViewThisSong(#HopAmPhamID_pk#)" id="currentRow_#currentRow#" >
								<td id="data" style="font-size:14px;">#SongName#</td>
							</tr>
						</cfoutput>
					</table>
				</div>
			</td>
			<td style="vertical-align:top">
				<div id="SongDetails" style="margin-left:2px; border: 0px solid red; padding:10px;"></div>
			</td>
		</tr>
	</table>
</div>
<div>

</div>

