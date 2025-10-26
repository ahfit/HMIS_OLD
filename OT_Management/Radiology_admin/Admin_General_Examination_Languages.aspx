<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Admin_General_Examination_Languages.aspx.vb" Inherits="Admin_General_Examination_Languages" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>

<link href="../../images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../../images/sheet_form.css" rel="stylesheet" type="text/css" />
<script src="../../images/highlight.js" type="text/javascript"></script>
<style type="text/css">
body {
	background-image:none;
	margin-top:0px;
}
html {
	background-image:none;
}
</style>

</head>

<body >

<form id="form1" runat = "server">
  <div id="forms_items" class="forms_items"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="tbl_form">
                  <!--DWLayoutTable-->
                  
                  <tr>
                    <td align="right" valign="middle" ><strong>&nbsp;History Complaints :&nbsp;</strong></td>
                              <td valign="middle"><asp:DropDownList ID="DropDownListMainGroup" runat="server" DataSourceID="SqlDataSourceGeneralExam"
                                      DataTextField="MG_Name" DataValueField="Radiology_id" Width="226px" AutoPostBack="True"> </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourceGeneralExam" runat="server"
                                      ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>" SelectCommand="SELECT [MG_Name], [Radiology_id] FROM [Admin_Radiology_MainGroup]"> </asp:SqlDataSource>
                              </td>
                              <td colspan="2" valign="middle"><asp:Button ID="ButtonSave" runat="server" CssClass="btn1" Text="Save"   />                              
                                <asp:Button
                    ID="Buttonrefresh" runat="server" Text="Refresh" CssClass="btn1"  />                                
                              <asp:Label  ForeColor="Red" ID="Label1" runat="server" ></asp:Label></td>
                            </tr>
                  
                  
                  
                  
                  
                  

                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                </table>

<br />
<asp:HiddenField ID="HiddenField2" runat="server" />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                                    DataKeyNames="Rd_element_id" DataSourceID="SqlDataSource_ComplaintLanguages" Width="100%"><Columns>
<asp:BoundField DataField="Rd_element_name" SortExpression="Rd_element_name" HeaderText="Element">
<ControlStyle Width="100px"></ControlStyle>
</asp:BoundField>
<asp:BoundField DataField="rd_element_type" SortExpression="rd_element_type" HeaderText="Element Type">
<ControlStyle Width="100px"></ControlStyle>
</asp:BoundField>
<asp:TemplateField SortExpression="priority" HeaderText="Priority"><EditItemTemplate>
                      <asp:DropDownList ID="DropDownList_Priority" runat="server"> </asp:DropDownList>
                    
</EditItemTemplate>

<ControlStyle Width="25px"></ControlStyle>
<ItemTemplate>
<asp:Label id="Label4" runat="server" Text='<%# Bind("priority") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="Text_BeforeElement" HeaderText="Text Before Element"><EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Text_BeforeElement") %>'></asp:TextBox>
                    
</EditItemTemplate>

<ControlStyle Width="125px"></ControlStyle>
<ItemTemplate>
                      <asp:Label ID="Label2" runat="server" Text='<%# Bind("Text_BeforeElement") %>'></asp:Label>
                    
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="Text_AfterElement" HeaderText="Text After Element"><EditItemTemplate>
                      <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Text_AfterElement") %>'></asp:TextBox>
                    
</EditItemTemplate>

<ControlStyle Width="100px"></ControlStyle>
<ItemTemplate>
                      <asp:Label ID="Label3" runat="server" Text='<%# Bind("Text_AfterElement") %>'></asp:Label>
                    
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="Element_ValueRequired" HeaderText="Required"><EditItemTemplate>
                      <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Element_ValueRequired") %>' />                
                    
</EditItemTemplate>

<ControlStyle Width="50px"></ControlStyle>
<ItemTemplate>
                      <asp:Label ID="Label2" runat="server" Text='<%# Bind("Element_ValueRequired") %>'></asp:Label>
                    
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="Group_para_Start" SortExpression="Group_para_Start" HeaderText="Group Para Start">
<ControlStyle Width="175px"></ControlStyle>
</asp:BoundField>
<asp:BoundField DataField="Report_Sub_Group" SortExpression="Report_Sub_Group" HeaderText="Sub Group">
<ControlStyle Width="25px"></ControlStyle>
</asp:BoundField>
                                        <asp:TemplateField>
                                            <EditItemTemplate>
                                                <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />&nbsp;<asp:ImageButton
                                                    ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                                                    OnClientClick="return confirmation_edit(this)" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
</Columns>

<RowStyle CssClass="GridItem"></RowStyle>

<HeaderStyle CssClass="GridHeader"></HeaderStyle>

<AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
</asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_ComplaintLanguages" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                                    SelectCommand="SELECT     Rd_element_id, Rd_element_name, rd_element_type, priority, ToolTip, Text_BeforeElement, Text_AfterElement, Element_ValueRequired, 
                      Group_para_Start, Report_Sub_Group
FROM         Admin_Radiology_Element
 WHERE (Radiology_ID = @Radiology_ID)"
                                    UpdateCommand="UPDATE Admin_Radiology_Element SET Text_BeforeElement = @BeforeLanguage, Text_AfterElement = @AfterLanguage, Report_Sub_Group = @report_Sub_Group, Element_ValueRequired = @ele_Value_Required, Group_para_Start = @Group_Para_Start, priority = @Priority WHERE (Rd_element_id = @Rd_element_id)">
                  <UpdateParameters>
                    <asp:ControlParameter PropertyName="Value" Name="BeforeLanguage" ControlID="HiddenFieldBefore"></asp:ControlParameter>
                    <asp:ControlParameter PropertyName="Value" Name="AfterLanguage" ControlID="HiddenFieldAfter"></asp:ControlParameter>
                    <asp:ControlParameter PropertyName="Value" Name="report_Sub_Group" ControlID="HiddenField_ReportSubGroup"></asp:ControlParameter>
                    <asp:ControlParameter PropertyName="Value" Name="ele_Value_Required" ControlID="HiddenField_ElementValueReq"></asp:ControlParameter>
                    <asp:ControlParameter PropertyName="Value" Name="Group_Para_Start" ControlID="HiddenField_GroupPara"></asp:ControlParameter>
                    <asp:ControlParameter ControlID="GridView1" Name="Rd_element_id" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="HiddenField_Priority" Name="Priority" PropertyName="Value" />
                  </UpdateParameters>
                  <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListMainGroup" Name="Radiology_ID" PropertyName="SelectedValue" />
                  </SelectParameters>
                </asp:SqlDataSource>
&nbsp; &nbsp;
<asp:HiddenField ID="HiddenField_ReportSubGroup" runat="server" />
<asp:HiddenField ID="HiddenField_GroupPara" runat="server" />
<asp:HiddenField ID="HiddenField_Priority" runat="server" />
&nbsp;
<asp:HiddenField ID="HiddenField_ElementValueReq" runat="server" />
<asp:HiddenField ID="HiddenFieldAfter" runat="server" />
                </span></span>
                  <asp:HiddenField ID="HiddenFieldBefore" runat="server" />

</div>
</form>
</body>
</html>

