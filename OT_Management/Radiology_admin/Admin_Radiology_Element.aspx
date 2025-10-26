

<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Admin_Radiology_Element.aspx.vb" Inherits="Administrator_Admin_Gestational_Ultrasound" %>

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
  
  
  <table width="100%" height="43" border="0" cellpadding="0" cellspacing="0"  >
                  <!--DWLayoutTable-->
                  <tr>
                    <td width="220" style="height: 3px"></td>
                              <td width="274" style="height: 3px"></td>
                              <td width="144" style="height: 3px"></td>
                              <td width="277" style="height: 3px"></td>
                    </tr>
                  <tr>
                    <td height="31" align="right" valign="middle"  style="height: 7px"><strong>&nbsp;Main Group Name   :&nbsp;</strong>&nbsp;</td>
                              <td valign="middle" style="height: 7px"><span style="width: 100px" >
                                <asp:DropDownList AutoPostBack="True" 
                            DataTextField="MG_Name" DataValueField="Radiology_ID" ID="DropDownListMainGroup" runat="server"
                            Width="250px" DataSourceID="SqlDataSourceMainGroup" Style="position: static"> </asp:DropDownList></span></td>
                              <td align="right" valign="middle" style="height: 7px"><strong ></strong></td>
                              <td valign="middle" style="height: 7px"><span style="width: 100px">&nbsp;</span></td>
      </tr>
                  
                  
                  
                  
                  

                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                </table>
                <br />
<asp:GridView ID="GridViewMainGroup" runat="server" AutoGenerateColumns="False" CssClass="Grid_1" DataSourceID="SqlDataSourceGUMainGroup" Width="100%" DataKeyNames="Rd_element_id">
                    <Columns>
                        <asp:BoundField DataField="Rd_element_id" HeaderText="Element ID" InsertVisible="False"
                            ReadOnly="True" SortExpression="Rd_element_id" Visible="False" />
                        <asp:BoundField DataField="MG_Name" HeaderText="Organ" SortExpression="MG_Name" />
                        <asp:BoundField DataField="Rd_element_name" HeaderText="Element" SortExpression="Rd_element_name" />
                        <asp:TemplateField HeaderText="Priority" SortExpression="priority">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList1" runat="server" Width="162px">
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                &nbsp;
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("priority", "{0}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ToolTip" HeaderText="ToolTip" SortExpression="ToolTip" />
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />&nbsp;<asp:ImageButton
                                    ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                                    OnClientClick="return confirmation_edit(this)" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />                  
                    <AlternatingRowStyle CssClass="GridAltItem" />
                  </asp:GridView>
                  
                  <asp:SqlDataSource ID="SqlDataSourceGUMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                DeleteCommand="DELETE FROM Admin_Rd_Exam_type WHERE (Rd_element_id = @ID)" InsertCommand="INSERT INTO Admin_Radiology_Element(Rd_element_name, rd_element_type, Radiology_id) VALUES (@Rd_element_name, @rd_element_type, @Radiology_id)" SelectCommand="SELECT     Admin_Radiology_Element.Rd_element_id, Admin_Radiology_Element.Rd_element_name, Admin_Radiology_Element.priority, &#13;&#10;                      Admin_Radiology_Element.ToolTip, Admin_Radiology_MainGroup.MG_Name&#13;&#10;FROM         Admin_Radiology_Element INNER JOIN&#13;&#10;                      Admin_Radiology_MainGroup ON Admin_Radiology_Element.Radiology_id = Admin_Radiology_MainGroup.Radiology_id&#13;&#10;WHERE     (Admin_Radiology_Element.Radiology_id = @ID)" UpdateCommand="UPDATE Admin_Radiology_Element SET priority = @priority, ToolTip = @ToolTip, Rd_element_name = @Rd_element_name WHERE (Rd_element_id = @Rd_element_id)">
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
                      <UpdateParameters>
                          <asp:ControlParameter ControlID="HiddenFieldPriority" Name="priority" PropertyName="Value" />
                          <asp:ControlParameter ControlID="HiddenFieldToolTip" Name="ToolTip" PropertyName="Value" />
                          <asp:ControlParameter ControlID="GridViewMainGroup" Name="Rd_element_id" PropertyName="SelectedValue" />
                          <asp:Parameter Name="Rd_element_name" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT [MG_Name], [Radiology_ID] FROM [Admin_Radiology_MainGroup]"> </asp:SqlDataSource>
                      <asp:HiddenField ID="HiddenFieldToolTip" runat="server" />
                      <asp:HiddenField ID="HiddenFieldPriority" runat="server" />
                      <asp:HiddenField ID="HiddenFieldName" runat="server" />
                  
</div>

</form>
</body>
</html>

