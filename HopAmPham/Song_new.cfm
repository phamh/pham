
<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<cfquery name="qGetSongTypes" datasource="#application.PhamDataSource#">
    SELECT 		SongTypeID_pk, SongTypeDescription
    FROM		songtype
    ORDER BY 	SongTypeDescription DESC
</cfquery>

<style>
	.songLabel
	{
		font-weight:bold;
	}

	.songLabelRequired
	{
		font-weight:bold;
		color:red;
	}

	tr.song{
		margin-bottom:5px;
	}
</style>
<table>
	<tr class="song">
		<td colspan="3">
			<input type="button" value="Submit" onclick="SubmitNewSong()" class="button"></input>
			<input type="button" value="Cancel" onclick="Cancel()"  class="button"></input>
		</td>
	</tr>
	<tr class="song">
		<td>
			<label class="songLabelRequired">Song Name (Tên bài hát)</label><br>
			<input id="songName" name="songName" size="20"required="true" placeholder="Required value"></input><br><br>
		</td>
		<td>
			<label class="songLabel">Song Writer (Nhạc sĩ)</label><br>
			<input id="songWriter" name="songWriter" size="20"required="true"></input><br><br>
		</td>
		<td>
			<label class="songLabel">Poem Writer (Tác giả thơ)</label><br>
			<input id="poemWriter" name="poemWriter" size="20"required="true"></input><br><br>
		</td>

	</tr>
	<tr class="song">
		<td>
			<label class="songLabel">Song Type (Thể loại)</label><br>
			<select id="songType" name="songType">
				<option value="0">
					select
				</option>
				<cfoutput query="qGetSongTypes">
					<option value="#SongTypeID_pk#">#SongTypeDescription#</option>
				</cfoutput>
			</select><br><br>
		</td>
		<td colspan="2">
			<label class="songLabelRequired">Tone (Tone chủ bài hát)</label><br>
			<input id="songTone" name="songTone" size="20" required="true"  placeholder="Required value"></input><br><br>
		</td>
	</tr>

	<tr class="song">
		<td>
			<label class="songLabel">Singer (Ca Sĩ thể hiện bài hát)</label><br>
			<input id="singer" name="singer" size="20"required="true"></input><br><br>
		</td>

		<td colspan="2">
			<label class="songLabel">Link of Song (Thông tin ca sĩ thể hiện và link bài hát)</label><br>
			<input id="songLink" name="songLink" size="58"required="true"></input><br><br>
		</td>
	</tr>

	<tr class="song">
		<td colspan="3">
			<label class="songLabelRequired">Song Lyrics (Lời và hợp âm.</label> <span style="color:red; font-style:italic">Hợp âm phải bỏ trong dấu ngoặc vuông [ ].</span><br>
			<textarea cols="100" rows="50" id="songContent" name="songContent" required="true" placeholder="Thí dụ: Hoa vẫn [C] hồng trước sân nhà [G] tôi..."></textarea>
		</td>
	</tr>
</table>
