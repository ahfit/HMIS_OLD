<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="DB_Reports.aspx.cs" Inherits="DashBoards_DB_Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="<%# Page.ResolveClientUrl("~/css/js/jquery-ui.css") %>" rel="stylesheet"
        type="text/css" />
  <link href="<%# Page.ResolveClientUrl("~/jquery-ui-themes-1.10.3/themes/excite-bike/jquery-ui.css") %>" rel="stylesheet"
        type="text/css" />
    <script src="<%# Page.ResolveClientUrl("~/Scripts/jquery-1.9.1.js") %>" type="text/javascript"></script>
    <script src="<%# Page.ResolveClientUrl("~/Scripts/jquery-ui-1.10.3.custom.js") %>" type="text/javascript"></script>
    <link href="../css_mega/jquery-ui.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .ColumnLeftToRight
        {
           float: left;
            width: 33%;
            margin-right: 2px;
        }
        
        .LinksDiv
        {
            height: 200px;
            overflow: scroll;
            font-size: 11px;
        }
        
        .LinksDiv ul
        {
            padding-left: 0;
            margin-left: 0;
        }
        
       .LinksDiv ul li {
    margin-bottom: 8px;
    list-style-type: none;
}


                  .LinksDiv a:hover {
                 
                    background-color: #4095c1;
                color:white !important;
}
        
       .LinksDiv a {
    font-size: 14px !important;
    color: #3BAAE3;
      padding: 5px;
    font-weight: bold;
    text-decoration: none;
}


        
        .imgLink
        {
            height: 11px;
            width: 15px;
            margin-right: 5px;
        }
        
        .searchBox
        {
            height: 29px;
            width: 300px;
            font-size: 18px;
            vertical-align: top;
        }
               
        .dashboard-panel .ColumnLeftToRight
        {
            float: left;
            margin-right: 2px;
        }
        .dashboard-panel h3
        {
            font-weight: bold;
            color: #ffffff;
            display: block;
            cursor: pointer;
            position: relative;
            margin-top: 2px;
            padding: 4px 3px 0px 15px;
            min-height: 0;
            border-top-left-radius: 6px;
            border-top-right-radius: 6px;
        }
        .dashboard-panel .LinksDiv
        {
            border: 1px solid #dddddd;
            background: #f2f5f7 url(../images/ui-bg_highlight-hard_100_f2f5f7_1x100.png) 50% top repeat-x;
            color: #362b36 padding: 1em 2.2em;
            border-top: 0;
            margin-top: -2px;
            position: relative;
            top: 1px;
            margin-bottom: 2px;
            overflow: auto;
            display: none;
            zoom: 1;
            display: block;
            padding: 1em 2.2em;
            border-top: 0;
            overflow: auto;
            height: 200px;
            border-bottom-right-radius: 6px;
            border-bottom-left-radius: 6px;
            
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="width: 95.5%; margin: auto; overflow:hidden;" class="dashboard-panel">
        <asp:PlaceHolder ID="phMainMenu"   runat="server"></asp:PlaceHolder>
    </div>
</asp:Content>
