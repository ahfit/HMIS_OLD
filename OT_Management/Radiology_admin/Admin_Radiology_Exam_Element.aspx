<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Admin_Radiology_Exam_Element.aspx.vb" Inherits="Administrator_Admin_Gestational_Ultrasound" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

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

<body>

<form id="form1" runat = "server">
<div id="forms_items" class="forms_items"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="138" height="37" align="right" valign="middle" ><strong>&nbsp;Main Group Name   :&nbsp; </strong></td>
                              <td width="278" valign="middle">
                                <asp:DropDownList AutoPostBack="True" 
                            DataTextField="MG_Name" DataValueField="MG_Code" ID="DropDownListMainGroup" runat="server"
                            Width="250px" DataSourceID="SqlDataSourceMainGroup" Style="position: static"> </asp:DropDownList>
                              </td>
                              <td width="83" align="right" valign="middle"><strong >&nbsp;Sub Group   :&nbsp;</strong></td>
                              <td width="214" valign="middle">
                                <asp:TextBox ID="TextBoxMainGroup" runat="server" CssClass="d-active" Width="146px"  ></asp:TextBox>
                              </td>
                            </tr>
                          <tr>
                            <td height="25" align="right" valign="middle"><span  style="width: 245px"><strong>Control Type :&nbsp;</strong> </span></td>
                              <td valign="middle">
                                <asp:DropDownList  ID="DropDownListControlName" runat="server" Width="250px" style="position: static">
                                  <asp:ListItem>RadioButtonList</asp:ListItem>
                                  <asp:ListItem>TextBox</asp:ListItem>
                              </asp:DropDownList>
                           </td>
                              <td colspan="2" valign="middle">
                                                                
                             </td>
    </tr>
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                        </table><br />
<div align="center"><asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="btn1"  /></div>
                        <br />
<asp:GridView ID="GridViewMainGroup" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" DataSourceID="SqlDataSourceGUMainGroup" Width="100%">
  <Columns>
      <asp:TemplateField>
          <ItemTemplate>

              <script src="../../Validate.js" type="text/javascript"></script>

              <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif"
                  OnClientClick="return confirmation(this)" />

          </ItemTemplate>
      </asp:TemplateField>
  <asp:BoundField DataField="MG_Name" HeaderText="Main Group" SortExpression="radiology_type" >
      <HeaderStyle CssClass="GridHeader" />
  </asp:BoundField>
  <asp:BoundField DataField="Rd_element_id" HeaderText="Rd_element_id" InsertVisible="False"
                                    ReadOnly="True" SortExpression="Rd_element_id" Visible="False" >
      <HeaderStyle CssClass="GridHeader" />
  </asp:BoundField>
  <asp:HyperLinkField DataNavigateUrlFields="Rd_element_id,Radiology_id" DataNavigateUrlFormatString="Admin_Radiology_Exam_Element_Values.aspx?ElementID={0}&amp;RadiologyID={1}"
                                    DataTextField="Rd_element_name" HeaderText="Element Name " >
      <HeaderStyle CssClass="GridHeader" />
  </asp:HyperLinkField>
  <asp:BoundField DataField="rd_element_type" HeaderText="Control Type" SortExpression="rd_element_type" >
      <HeaderStyle CssClass="GridHeader" />
  </asp:BoundField>
  <asp:BoundField DataField="Radiology_id" HeaderText="Radiology_id" SortExpression="Radiology_id"
                                    Visible="False" >
      <HeaderStyle CssClass="GridHeader" />
  </asp:BoundField>
  <asp:BoundField DataField="Rd_element_name" HeaderText="Element Name" SortExpression="Rd_element_name" Visible="False" >
      <HeaderStyle CssClass="GridHeader" />
  </asp:BoundField>
  <asp:BoundField DataField="priority" HeaderText="priority" SortExpression="priority" Visible="False" >
      <HeaderStyle CssClass="GridHeader" />
  </asp:BoundField>
  </Columns>
  <RowStyle CssClass="GridItem" />
  <HeaderStyle CssClass="GridHeader" />
  <AlternatingRowStyle CssClass="GridAltItem" />
</asp:GridView>
<span style="vertical-align: top; height: 523px; text-align: center">
<asp:SqlDataSource ID="SqlDataSourceGUMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                DeleteCommand="DELETE FROM Admin_Rd_Exam_type WHERE (Rd_element_id = @ID)" InsertCommand="INSERT INTO Admin_Radiology_Element(Rd_element_name, rd_element_type, Radiology_id) VALUES (@Rd_element_name, @rd_element_type, @Radiology_id)" SelectCommand="SELECT Admin_Radiology_Element.Rd_element_id, Admin_Radiology_Element.Rd_element_name, Admin_Radiology_Element.rd_element_type, Admin_Radiology_Element.Radiology_id, Admin_Radiology_Element.priority, Admin_Radiology_Exam_MainGroup.MG_Name, Admin_Radiology_Exam_MainGroup.Radiology_id AS Expr1 FROM Admin_Radiology_Element INNER JOIN Admin_Radiology_Exam_MainGroup ON Admin_Radiology_Element.Radiology_id = Admin_Radiology_Exam_MainGroup.Radiology_id WHERE (Admin_Radiology_Element.Radiology_id = @ID)">
  <DeleteParameters>
    <asp:ControlParameter ControlID="GridViewMainGroup" Name="ID" PropertyName="SelectedValue" />
  </DeleteParameters>
  <InsertParameters>
    <asp:ControlParameter ControlID="TextBoxMainGroup" Name="Rd_element_name" PropertyName="Text" />
    <asp:ControlParameter ControlID="DropDownListControlName" Name="rd_element_type"
                        PropertyName="SelectedValue" />
    <asp:ControlParameter ControlID="DropDownListMainGroup" DefaultValue="" Name="Radiology_id"
                        PropertyName="SelectedValue" />
  </InsertParameters>
  <SelectParameters>
    <asp:ControlParameter ControlID="DropDownListMainGroup" Name="ID" PropertyName="SelectedValue" />
  </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT [MG_Name], [MG_Code] FROM [Admin_Radiology_Exam_MainGroup]"> </asp:SqlDataSource>
<asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />
<asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server"  Visible="false"/>
<asp:ImageButton ID="ImageButtonlogout" ImageUrl="images/image_logout_up.gif" Width="71" Height="30" runat="server" Visible="false" />
<asp:Button ID="Button1" runat="server" Text="      Body Parts" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'"  Visible="false"/>                                                                        
				  
				    <asp:Button ID="Button2" runat="server" Text="      Projection" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>                                                                                
				  
				    <asp:Button ID="Button3" runat="server" Text="      X-ray Entry" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>                                                                                
				  
				    <asp:Button ID="Button4" runat="server" Text="      Exam Main Group" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button5" runat="server" Text="      Exam Sub Group" CssClass="bt5over" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5up'" onmouseout="this.className='bt5over'" Visible="false"/>
				    <asp:Button ID="Button6" runat="server" Text="      Exam Element Values" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button7" runat="server" Text="      Group Entries" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button8" runat="server" Text="      Sub Group Entries" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button9" runat="server" Text="      Radiology Entries" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
				    <asp:Button ID="Button10" runat="server" Text="      Exam Type Relation" CssClass="bt5up" onmousedown="this.className='bt5down'" onmouseover="this.className='bt5over'" onmouseout="this.className='bt5up'" Visible="false"/>
                    
                    
                    </div>
</form>
</body>
</html>
