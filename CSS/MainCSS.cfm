<cfif application.dumpSrcFilenames>
  <cfoutput>
    <font color="maroon" face="Arial" size="-2"
      >&nbsp;&nbsp;file:
      #getDirectoryFromPath(getCurrentTemplatePath())##GetFileFromPath(GetCurrentTemplatePath())#<br
    /></font>
  </cfoutput>
</cfif>
<style>
  body {
    margin: 0px;
    border: 0px solid red;
  }

  body,
  select,
  input,
  td,
  textarea {
    font-size: 12px;
    font-family:Arial;
  }

  div.container {
    height: 500px;
    position: relative;
    border: 0px solid red;
  }

  div.center {
    margin: 0;
    position: absolute;
    top: 25%;
    left: 50%;
    -ms-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
    text-align: center;
    border: 0px solid red;
    width: 70%;
    border: 0px solid red;
    text-align: center;
  }

  table.headerMenu {
    background-color: #6b7381;
    border-collapse: collapse;
    width: 100%;
    padding: 10px;
    border: 1px solid black;
  }


  table.headerMenu_TuVienPhuocLoc {
    background-color: #664c28;
    border-collapse: collapse;
    width: 100%;
    padding: 10px;
    border: 1px solid black;
  }


  table.headerMenu_AC {
    background-color: #a9a9a9;
    border-collapse: collapse;
    width: 100%;
    padding: 10px;
    border: 1px solid black;
  }

  table.headerMenu td,
  table.headerMenu_TuVienPhuocLoc td,
  table.headerMenu_AC td
   {
    padding: 10px;
    color: white;
    border: 0px solid blue;
    font-size: 12px;
    font-weight: bold;
    font-family: Arial;
  }

  span.header {
    color: white;
    padding: 10px;
  }

  span.header_TuVienPhuocLoc {
    color: white;
    padding: 10px;
  }

  span.header:hover,
  span.header_TuVienPhuocLoc:hover {
    text-decoration: underline;
    cursor: pointer;
  }

  input.button {
    font-size: 12px;
    padding-left: 10px;
    padding-right: 10px;
    border-radius: 20px;
    border: 1px solid #4169e1;
    background-color: #4169e1;
    color: white;
    min-width:70px;
    min-height:20px;
  }

  input.button_TuVienPhuocLoc {
    font-size: 12px;
    color: black;
    padding-left: 10px;
    padding-right: 10px;
    border-radius: 20px;
    border: 1px solid black;
    background-color: #fada5e;
    min-width:70px;
    min-height:22px;
  }


  input.button:hover,
  input.button_TuVienPhuocLoc:hover  {
    text-decoration: underline;
  }

  input.DeleteButton {
    background-color: #804040;
    font-size: 12px;
    color: #af2010;
    padding-left: 5px;
    padding-right: 5px;
    border-radius: 20px;
    border: thin solid #804040;
    height: 20px;
    color: white;
    min-width:70px;
    min-height:20px;
  }

  input.DeleteButton:hover {
   text-decoration: underline;
  }
</style>

<style>
.navbar {
  overflow: hidden;
  background-color: #664c28;
    font-weight: bold;
    font-family: Arial;
}

.navbar a {
  float: left;
  font-size: 12px;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

.dropdown {
  float: left;
  overflow: hidden;
}

.dropdown .dropbtn {
  cursor: pointer;
  font-size: 12px;
  border: none;
  outline: none;
  color: white;
  padding: 14px 16px;
  background-color: inherit;
  font-family: inherit;
  margin: 0;
}

.navbar a:hover, .dropdown:hover .dropbtn, .dropbtn:focus {
  background-color: #804040;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  float: none;
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
}

.dropdown-content a:hover {
  background-color: #ddd;
}

.show {
  display: block;
}
</style>
