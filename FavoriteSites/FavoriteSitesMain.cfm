<cfif application.dumpSrcFilenames>
	<cfoutput>
	<font color="maroon" face="Arial" size="-2" >&nbsp;&nbsp;file: #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br/></font>
	</cfoutput>
</cfif>

<style>
	table.FavoriteMenu{
		border-collapse:collapse;
		width:100%;
		overflow-y: scroll;
	}

	table.FavoriteMenu td{
		border: 0px solid gray;
		border-right: 1px solid gray;
		border-bottom: 1px solid gray;
		color: blue;
		font-weight: normal;
		font-family: Century Gothic;
		font-size: 14px;
		font-weight: bold;
		height:25px;
		padding:3px;
	}

	table.FavoriteMenu td:hover{
		text-decoration: underline;
	}

	.vertical-align-center-content {
	  background-color: lightGray;
	  border: 1px solid black;
	  border-bottom: 0px solid black;
	  height:36px;
	  display:flex;
	  align-items:center;
	  /* Uncomment next line to get horizontal align also */
	  justify-content:center;
	}
	.vertical-align-left-content {
        height: 37px;
        line-height: 37px;
        text-align: left;
        border: 1px solid black;
        width: 700px;
        background-color: lightGrey;
        margin-left: 5px;
        display : block;

	}

	input.searchCategoryInput,
	input.searchItemInput{
		border: 1px solid gray;
		font-weight: normal;
		font-family: Century Gothic;
		font-size: 14px;
		/*height:25px;*/
		padding:3px;
		width: 150px;
	}


	input.searchItemInput{
		width: 250px;
	}

</style>
<cfajaxproxy cfc="FavoriteSitesCFC" jsclassname="FavoriteSitesCFC">
<script type="text/javascript">
/*	$(document).ajaxStart(function () {
	  $('##overlay').fadeIn();
	}).ajaxStop(function () {
	  $('##overlay').fadeOut();
	});*/

	var favoriteSitesCFC = new FavoriteSitesCFC();
	favoriteSitesCFC.setHTTPMethod("POST");

	selectThisCategory=function(categoryId_pk)
	{
		$.ajax({
		  url: "FavoriteSites/FavoriteSiteDetails.cfm?categoryId_pk="+categoryId_pk+'&searchText=',
		  type: "get", //send it through get method
		  data: {
		    //Estimate: qGetAllEstimates.estimateNumber

		  },
        success: function(data, textStatus, jqXHR)
        {
            //data: return data from server
            document.getElementById('FavoriteSiteDetails').style.display = 'block';
            $("#FavoriteSiteDetails").html(data);
        },
		  error: function(XMLHttpRequest,textStatus,errorThrown) {
		    alert('An error has occurred making this request: ' + errorThrown)
		  }
		});
	}

	OpenCategoryModalWindow = function(Id_pk, TheWidth, TheHeight,FileName,Title)
	{
		if(Id_pk == 0)
		{
			var ButtonId = 'submitButton';
			var ButtonName = 'Submit';
		}
		else
		{
			var ButtonId = 'updateButton';
			var ButtonName = 'Update';
		}
		var errorMessage = '';
	    $("#FavoriteModalWindow").dialog({
            modal: true,
            height: TheHeight,
            width: TheWidth,
            show: 'slide',//scale, fold, slide, fade,explode, drop, bounce,blind
            cache: false,
            title: Title,
            open: function ()
            {
               $(this).load(FileName + '?Id_pk='+Id_pk);
            },

 			buttons:
			[
			    {
			        id : ButtonId,
			        text: ButtonName,
			        cache: false,
			        click: function()
			        {
						switch(Id_pk) {
						  case 0:
						    alert('SUBMIT NEW CAT');
						    break;

						  default:
						    alert('UPDATE CAT');
						    // code block
						}
						$(this).dialog('close');
						//$(this).dialog('destroy').remove();
			       	}
			    },

			    {
			    	//Cancel Button
			        text: "Cancel",
			        id: "CancelButton",
			        cache: false,
			        click: function()
			        {
						//$(this).dialog('destroy').remove();
						$(this).dialog('close');
			        }
			    }
			 ]
	    });
	}

	$("#searchCategory").on("change",function() {
	    //var jSearchStatus = FavoriteSitesCFC.fSearchPortal(this.value);
	    alert(cfc);
	});


	searchSites = function(searchText)
	{
		$.ajax({
		  url: "FavoriteSites/FavoriteSiteDetails.cfm?searchText="+searchText+'&categoryId_pk=0',
		  type: "get", //send it through get method
		  data: {
		    //Estimate: qGetAllEstimates.estimateNumber

		  },
        success: function(data, textStatus, jqXHR)
        {
            //data: return data from server
            document.getElementById('FavoriteSiteDetails').style.display = 'block';
            $("#FavoriteSiteDetails").html(data);
            document.getElementById('selectedCategory').innerHTML = '';
        },
		  error: function(XMLHttpRequest,textStatus,errorThrown) {
		    alert('An error has occurred making this request: ' + errorThrown)
		  }
		});
	}
</script>
<cfquery name="queryGetCategory" datasource="#application.PhamDataSource#">
	SELECT categoryId_pk, category, active, orderID
	FROM portal_category
	WHERE active = 1
	ORDER BY category
</cfquery>

<div style="width: 100%; border:px solid red; padding:5px" id="FavoriteMenuDiv">
	<table>
		<tr>
			<td style="vertical-align:top">
				<div class="vertical-align-center-content">
					<input type="button" value="[+] New Category" class="button" onclick="OpenCategoryModalWindow(0,600,400,'FavoriteSites/FavoriteSiteModalContents.cfm', 'Add New Category')">&nbsp;&nbsp;
					<!---<input id="searchCategory" type="text" class="searchCategoryInput" placeholder="Search Category">	 --->
				</div>
				<div style="border:1px solid black; height:700px; overflow-y:scroll;width:300px; border-radius:0px">
					<table class="FavoriteMenu" id="FavoriteMenuTable">
						<cfoutput query="queryGetCategory">
							<cfif currentRow MOD 2 EQ 1>
								<cfset rowBackgroundColor = 'white'>
							<cfelse>
								<cfset rowBackgroundColor = '##e5e4e2'>
							</cfif>
							<tr style="height:25px;background-color: #rowBackgroundColor#; cursor: pointer">
								<td id="data" onclick="selectThisCategory(#queryGetCategory.categoryId_pk#)">
									#queryGetCategory.category# [#queryGetCategory.categoryId_pk#]
								</td>
								<td style="text-align: center"><i class="fa fa-edit" style="font-size: 20px; text-align:center;color: green"onclick="OpenCategoryModalWindow(#queryGetCategory.categoryId_pk#,600,400,'FavoriteSites/FavoriteSiteModalContents.cfm', 'Edit Category')"></i></td>
								<td style="text-align: center"><i class="fa fa-trash" style="font-size: 20px;text-align:center;color:##a52a2a" onclick="alert('delete')"></i>
								</td>
							</tr>
						</cfoutput>
					</table>
				</div>
			</td>
			<td style="vertical-align:top">
				<div class="vertical-align-left-content"style="display:none" id="searchDiv">
					&nbsp;&nbsp;
					<input type="button" value="[+] New Item" class="button" onclick="alert()" id="NewItemButton">
					&nbsp;&nbsp;
					<input onchange=searchSites(this.value); id="searchItem" type="text" class="searchItemInput" placeholder="Search Item"></input>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="selectedCategory" style="font-weight: bold; color: blue; font-size:14px"></span>
				</div>

				<div style="margin-left:5px;" id="FavoriteSiteDetails" name="FavoriteSiteDetails"></div>
			</td>
		</tr>
	</table>
</div>
