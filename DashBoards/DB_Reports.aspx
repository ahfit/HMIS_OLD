<%@ page title="" language="C#" masterpagefile="~/hacims_demo.master" autoeventwireup="true" inherits="DashBoards_DB_Reports, App_Web_0myvw0cp" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="<%# Page.ResolveClientUrl("~/jquery-ui-themes-1.10.3/themes/start/jquery-ui.css") %>" rel="stylesheet"
        type="text/css" />
    <script src="<%# Page.ResolveClientUrl("~/Scripts/jquery-1.9.1.js") %>" type="text/javascript"></script>
    <script src="<%# Page.ResolveClientUrl("~/Scripts/jquery-ui-1.10.3.custom.js") %>" type="text/javascript"></script>

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
        
        .LinksDiv ul li
        {
            list-style-type: none;
        }
        
        .LinksDiv a
        {
            color: #3BAAE3;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="width:95%;margin:auto;">
    <asp:PlaceHolder ID="phMainMenu" ClientIDMode="Static" runat="server"></asp:PlaceHolder>
    </div>
</asp:Content>
