<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="Pt_View_Xray.aspx.cs" Inherits="Radiology_Pt_View_Xray"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

 <style type="text/css">
 
 .small_f {color:#f08f68 ; font-size:10px; }
  #nav {display:none; }
  .leftnav {display:none;}
 #header {display:none;}
 #navigation {display:none;}
#p_info {display:none;}
 #footer {display:none;}
   A.rpt_link {display:none;}
   .hinfo {display:none; }
 </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


<div align="center">



    <asp:Panel ID="pnlXrayImages" runat="server" Width="80%">
    </asp:Panel>
    <br />
    <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label>
    
    
    
</div>
</asp:Content>
