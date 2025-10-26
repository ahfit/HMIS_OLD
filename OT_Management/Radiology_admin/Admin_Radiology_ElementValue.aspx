<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Admin_Radiology_ElementValue.aspx.vb" Inherits="Administrator_Radiology_ElementValues" %>


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

<table width="100%" border="0" cellpadding="0" cellspacing="0" >
                  <!--DWLayoutTable-->
                
<tr>
                    <td align="right" valign="middle"  style="height: 25px"><strong>Organ :&nbsp;</strong></td>
                              <td valign="middle" style="height: 25px"><span style="text-align: left">
                                <asp:DropDownList AutoPostBack="True" 
                            DataTextField="MG_Name" DataValueField="Radiology_id" ID="DropDownListMainGroup" runat="server"
                            Width="240px" DataSourceID="SqlDataSourceMainGroup" Style="position: static"> </asp:DropDownList>
                              </span></td>
                              <td align="right" valign="middle" style="height: 25px"><strong >&nbsp;Element :&nbsp;</strong></td>
                              <td valign="middle" style="height: 25px"><span style="height: 20px; text-align: left">
                                <asp:DropDownList AutoPostBack="True" 
                            DataTextField="Rd_element_name" DataValueField="Rd_element_id" ID="DropDownListElement" runat="server" Width="200px" DataSourceID="SqlDataSourceElement"> </asp:DropDownList>
                              </span></td>
                    </tr>
                  <tr>
                    <td height="25" align="right" valign="middle"><span  style="width: 245px"><strong>Element Value  :</strong>&nbsp;</span></td>
                      <td valign="middle"><span style="height: 20px; text-align: left">
                        <asp:TextBox ID="TextBoxElementValue" runat="server" CssClass="d-active" Width="146px"  ></asp:TextBox>
                      </span></td>
                      <td valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
      </tr>
                  
                  
                  
                  
                  
                  

                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                </table>
                <br />
<div align="center">
                <asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="btn1"  />    </div>            
                <br />
<asp:GridView ID="GridViewElementValue" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceForGrid"
                            Width="100%" CssClass="Grid_1" DataKeyNames="Rd_id">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif"
                                    OnClientClick="return confirmation(this)" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    <asp:BoundField DataField="MG_Name" HeaderText="Organ" SortExpression="MG_Name" >
                      <HeaderStyle CssClass="GridHeader" />                  
                    </asp:BoundField>
                    <asp:BoundField DataField="Rd_element_name" HeaderText="Element" SortExpression="Rd_element_name" >
                      <HeaderStyle CssClass="GridHeader" />                  
                    </asp:BoundField>
                    <asp:BoundField DataField="Rd_id" HeaderText="Rd_id" InsertVisible="False" ReadOnly="True"
                                    SortExpression="Rd_id" Visible="False" >
                      <HeaderStyle CssClass="GridHeader" />                  
                    </asp:BoundField>
                    <asp:BoundField DataField="Rd_value" HeaderText="Element Value" SortExpression="Rd_value" >
                      <HeaderStyle CssClass="GridHeader" />                  
                    </asp:BoundField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />                  
                    <AlternatingRowStyle CssClass="GridAltItem" />
                  </asp:GridView>
                </span>
                <asp:SqlDataSource ID="SqlDataSourceElement" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Rd_element_name, Rd_element_id FROM Admin_Radiology_Element WHERE (Radiology_id = @id)">
                  <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListMainGroup" Name="id" PropertyName="SelectedValue" />
                  </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>" SelectCommand="SELECT Admin_Radiology_Element.Rd_element_name, Admin_Radiology_Elementvalue.Rd_id, Admin_Radiology_Elementvalue.Rd_value, Admin_Radiology_MainGroup.MG_Name FROM Admin_Radiology_Element INNER JOIN Admin_Radiology_MainGroup ON Admin_Radiology_Element.Radiology_id = Admin_Radiology_MainGroup.Radiology_id INNER JOIN Admin_Radiology_Elementvalue ON Admin_Radiology_Element.Rd_element_id = Admin_Radiology_Elementvalue.Rd_element_id WHERE (Admin_Radiology_Element.Radiology_id = @Radiology_ID) and (Admin_Radiology_Element.Rd_Element_id=@Element_Id)" DeleteCommand="DELETE FROM Admin_Radiology_Elementvalue WHERE (Rd_id = @Rd_ID)">
                  <DeleteParameters>
                    <asp:ControlParameter ControlID="GridViewElementValue" Name="Rd_ID" PropertyName="SelectedValue" />
                  </DeleteParameters>
                  <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownListMainGroup" Name="Radiology_ID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownListElement" Name="Element_Id" PropertyName="SelectedValue" />
                  </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT [MG_Name], [Radiology_id] FROM [Admin_Radiology_MainGroup]"> </asp:SqlDataSource>
                

</div>
</form>
</body>
</html>

