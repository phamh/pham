
<!--- This example displays the information provided by  
    the Designer & Developer Center XML feed, 
    http://www.adobe.com/devnet/resources/_resources.xml  
    See http://www.adobe.com/devnet/articles/xml_resource_feed.html  
    for more information on this feed. ---> 
  
<!--- Set the URL address. ---> 
<cfset urlAddress="http://www.adobe.com/devnet/resources/_resources.xml"> 
  
<!--- Use the CFHTTP tag to get the file content represented by urladdress.  
        Note that />, not an end tag, terminates this tag. ---> 
<cfhttp url="#urladdress#" method="GET" resolveurl="Yes" throwOnError="Yes"/> 
  
<!--- Parse the XML and output a list of resources. ---> 
<cfset xmlDoc = XmlParse(CFHTTP.FileContent)> 
<!--- Get the array of resource elements, the xmlChildren of the xmlroot. ---> 
<cfset resources=xmlDoc.xmlroot.xmlChildren> 
<cfset numresources=ArrayLen(resources)> 
  
<cfloop index="i" from="1" to="#numresources#"> 
    <cfset item=resources[i]> 
    <cfoutput> 
        <strong><a href=#item.url.xmltext#>#item.title.xmltext#</strong></a><br> 
        <strong>Author</strong>&nbsp;&nbsp;#item.author.xmltext#<br> 
        <strong>Applies to these products</strong><br> 
        <cfloop index="i" from="4" to="#arraylen(item.xmlChildren)#"> 
            #item.xmlChildren[i].xmlAttributes.Name#<br> 
        </cfloop> 
        <br> 
    </cfoutput> 
</cfloop>