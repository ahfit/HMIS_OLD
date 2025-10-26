<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Message, App_Web_xjzmobwq" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
 <%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


 
 
 <br />
<br />
<br />
<br />
<br />
<br />
<div align="center">
          <asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>
          <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
              <asp:Timer ID="Timer1" runat="server" Interval="800"> </asp:Timer>
              <asp:Label ID="Label_Message" runat="server" style="color:#0e73d8; font-size:14px; font-weight:bold; background:url(../images_hacims/img_ok.png) 0 2px no-repeat; padding-left:15px; font-family:Calibri;" Text="Your Information has been Saved Successfully..."
       ></asp:Label>
            </ContentTemplate>
          </asp:UpdatePanel>
         
          <asp:HiddenField ID="HiddenField_hidd_val" runat="server" />
       <br />
<br />
<br />
<br />
<br />
<br /></div>
 
   </asp:Content>