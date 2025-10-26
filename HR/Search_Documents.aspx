<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_Search_Documents, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel1" runat="server" Visible="False"></asp:Panel>
</td>
<td  style="width:auto;" valign="top" >
     

 
 
 

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="50%" valign="top"><asp:RadioButtonList ID="RadioButtonList1" runat="server" DataSourceID="SqlDataSource_Document_Type"
                          DataTextField="Document_Name" DataValueField="Document_Type_ID" RepeatColumns="2" Width="100%">
                      </asp:RadioButtonList></td>
    <td  width="50%" valign="top">
    
    
    
    <div class="bxmain" >
 
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  <tr>
    <td width="32%" align="right">
      File No. : 
    </td>
    <td width="68%">
      <asp:TextBox ID="TextBox_File_No" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">Date :</td>
    <td>
      <asp:TextBox ID="TextBox_date_day" runat="server" CssClass="input_txt" Width="35px"></asp:TextBox>
-
<asp:TextBox ID="TextBox_Date_Month" runat="server" CssClass="input_txt"  Width="25px"></asp:TextBox>
-
<asp:TextBox ID="TextBox_date_Year" runat="server" CssClass="input_txt" Width="64px"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">
      Page No. : 
    </td>
    <td>
      <asp:TextBox ID="TextBox_page_no" CssClass="input_txt" runat="server" Width="150px"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">Refrence No. : </td>
    <td>
      <asp:TextBox ID="TextBox_reference_No" runat="server" CssClass="input_txt" Width="150px"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right">Address To : </td>
    <td>
      <asp:TextBox ID="TextBox_Address_To" CssClass="input_txt" runat="server" Width="150px"></asp:TextBox>
    </td>
  </tr>
  
 </table>
</div>
<br>
<div align="center" >
<asp:Button ID="Button_Search" runat="server" Text="Search"  /></div>
</td>
  </tr>
</table>

 
 
 
<br />
<asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
                  Width="100%"  >
                  <Columns>
                      <asp:HyperLinkField DataNavigateUrlFields="Image_URL" DataNavigateUrlFormatString="~/HR/{0}"
                          DataTextField="Document_Name" HeaderText="Document Name" />
                      <asp:BoundField DataField="file_No" HeaderText="file No" SortExpression="file_No" />
                      <asp:BoundField DataField="Page_No" HeaderText="Page No" SortExpression="Page_No" />
                      <asp:BoundField DataField="Address_To" HeaderText="Address To" SortExpression="Address_To" />
                      <asp:BoundField DataField="Reference_No" HeaderText="Reference No" SortExpression="Reference_No" />
                  </Columns>
                  <RowStyle CssClass="GridItem" />
                  <HeaderStyle CssClass="GridHeader" />
                  <AlternatingRowStyle CssClass="GridAltItem" />
  </asp:GridView>
              <asp:SqlDataSource ID="SqlDataSource_Document_Type" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                  SelectCommand="SELECT [Document_Type_ID], [Document_Name] FROM [Document_Type]">
              </asp:SqlDataSource>
           <asp:HiddenField ID="HiddenField_date"
                  runat="server" />
             
              <asp:SqlDataSource ID="SqlDataSource_employee_documents_Search" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>">
              </asp:SqlDataSource>
          




 

<br />
    <asp:HiddenField ID="HiddenField_name" runat="server" />
     
     
</td>
</tr>
</table>
 
  </asp:Content>