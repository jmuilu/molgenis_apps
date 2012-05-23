<#macro plugins_catalogueTree_catalogueTreePlugin screen>


<!-- normally you make one big form for the whole plugin-->
<form method="post" enctype="multipart/form-data" id="plugins_catalogueTree_catalogueTreePlugin" name="${screen.name}" action="">
	<!--needed in every form: to redirect the request to the right screen-->
	<input type="hidden" name="__target" value="${screen.name}">
	<!--needed in every form: to define the action. This can be set by the submit button-->
	<input type="hidden" name="__action" id="test" value="">
	<!-- hidden input for measurementId -->
	<input type="hidden" name="measurementId" id="measureId" value="">
	<input type="hidden" name="DemoName" id="DemoName" value="%= demoName %">
	
<!-- this shows a title and border -->


	<div class="formscreen">
		
		<div class="form_header" id="${screen.getName()}">
			${screen.label}
		</div>
		
		<#--optional: mechanism to show messages-->
		<#list screen.getMessages() as message>
			<#if message.success>
		<p class="successmessage">${message.text}</p>
			<#else>
		<p class="errormessage">${message.text}</p>
			</#if>
		</#list>
		
		<div class="screenbody">
			<div class="screenpadding">
				
						   <#if screen.isSelectedInv() == true>
								<table class="box" width="100%" cellpadding="0" cellspacing="0">
								    <tr><td class="box-header" colspan="2">  
								        <label>Choose a cohort:
										<!--select name="investigation" id="investigation"--> 
											<#list screen.arrayInvestigations as inv>
												<#assign invName = inv.name>
												<!--option value="${invName}" <#if screen.selectedInvestigation??><#if screen.selectedInvestigation == invName>selected="selected"</#if></#if> >${invName}</option-->			
													<input class="cohortSelect" type="submit" id="cohortSelectSubmit" name="cohortSelectSubmit" value= ${invName}
														onclick="__action.value='cohortSelect';" 
														style="color: #000; background: #8EC7DE;
												   		border: 2px outset #d7b9c9;
												   		font-size:12px;
												   	"/>
											
											</#list>
										<!--/select-->
										<script>$('#investigation').chosen();</script>
										<!--input type="submit" name="chooseInvestigation" value="refresh tree" onclick="__action.value='chooseInvestigation';"></input-->
										<!--input type="image" src="res/img/refresh.png" alt="Submit" 
											name="chooseInvestigation" style="vertical-align: middle;" 
											value="refresh tree" onclick="__action.value='chooseInvestigation';DownloadMeasurementsSubmit.style.display='inline'; 
											DownloadMeasurementsSubmit.style.display='inline';" title="load another study"	/-->	
										</label>
										<div id="masstoggler"> 	
										<label>Browse protocols and their variables '${screen.selectedInvestigation}':click to expand, collapse or show details</label>
						 				
						 				<a title="Collapse entire tree" href="#"><img src="res/img/toggle_collapse_tiny.png"  style="vertical-align: bottom;"></a> 
						 				<a title="Expand entire tree" href="#"><img src="res/img/toggle_expand_tiny.png"  style="vertical-align: bottom;"></a> 
			 							</div>
					    			</td></tr>
					    			<tr><td class="box-body" style="width:50%;">
					    
			
				<select id="selectedField" name="selectedField" title="choose field" name="chooseField" style="display:none"> 
					<#list screen.arraySearchFields as field>
								<!--#assign FieldName = field.name-->
						<option value="${field}" <#if screen.selectedField??>
							<#if screen.selectedField == field>selected="selected"</#if></#if> >Search ${field}</option>			
					</#list>
					 <!--option value="All fields">All fields</option-->
				</select>
				
				<input title="fill in search term" type="text" name="InputToken" 
					onfocus="selectedField.style.display='inline'; selectedField.style.display='inline';searchingInvestigation.style.display='inline'; searchingInvestigation.style.display='inline'; " 
					onkeydown="if (event.keyCode==13)__action.value='SearchCatalogueTree';return true;">	
				
				<input type="submit" name="SearchCatalogueTree" value="search" onclick="__action.value='SearchCatalogueTree';"/>
					    <!--
					    <#list screen.getFilters() as filters>
							<div class="filterslabel">
								<b>Search results for ${filters}</b>
								<img id="remove_filter" height="16" class="navigation_button" src="generated-res/img/cancel.png" alt="Cancel" onclick="__action.value='removeFilters';" title="remove filter"
							</div>
						</#list>
						-->
						
						<#list screen.getFilters() as filter>			
							<!--<b>${filter}</b> <img id="remove_filter_${filter_index}" height="16" class="navigation_button" src="generated-res/img/cancel.png" alt="Cancel" onclick="setInput('${screen.name}_form','_self','','${screen.name}','removeFilters','iframe'); document.forms.${screen.name}_form.filter_id.value='${filter_index}'; document.forms.${screen.name}_form.submit();" title="remove filter"/>-->
							<!--<b>${filter}</b> <img id="remove_filter_${filter_index}" height="16" class="navigation_button" src="generated-res/img/cancel.png" alt="Cancel" onclick="setInput('${screen.name}_form','_self','','${screen.name}','removeFilters','iframe');  document.forms.${screen.name}_form.submit();" title="remove filter"/>-->
							<b>${filter}</b>
							<input type="image" src="generated-res/img/cancel.png" alt="Remove filter" 
											name="chooseInvestigation" style="vertical-align: middle;" 
											value="refresh tree" onclick="__action.value='chooseInvestigation';DownloadMeasurementsSubmit.style.display='inline'; 
											DownloadMeasurementsSubmit.style.display='inline';" title="load another study"	/>	
						<#if filter_has_next> and </#if>
						</#list>
					    
					    </td><td class="box-body" style="width: 50%;">Details:</td></tr>
					    <tr><td class="box-body">
								<div id="leftSideTree">  
									${screen.getTreeView()}
								</div><br/>
						    </td>
						    
						    <td class="box-body">
						    	<!--div id="scrollingDiv"--> 
      								<div id="details"></div><br/><br/>
      							<!--/div-->

						   </td>
						</tr>
						<tr>
							<td class="box-body">


							</td>
							<td class="box-body">
							<input title="fill in selection name" type="text" name="SelectionName" >
							<input class="saveSubmit" type="submit" id="SaveSelectionSubmit" name="SaveSelectionSubmit" value="Save selection" 
									onclick="__action.value='SaveSelectionSubmit';" 
									style="color: #000; background: #8EC7DE;
										   border: 2px outset #d7b9c9;
										   font-size:15px;
										   font-weight:bold;
										   "/>
							</td>
						</tr>
					</table>
			   </#if>	
			    				<label> 	<#if screen.getStatus()?exists>${screen.getStatus()} </#if>  </label>	
			   
			</div>
		</div>
	</div>
</form>

</#macro>
