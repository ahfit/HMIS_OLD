<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Rd_Projection.aspx.vb" Inherits="Rd_Projection" %>


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
<table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                  <!--DWLayoutTable-->
                 
                  <tr>
                    <td width="19%" height="25" align="right" valign="middle" ><strong>Body Part   :&nbsp;</strong></td>
                              <td width="32%" valign="middle"><asp:DropDownList 
                            DataTextField="Rd_body_part" DataValueField="Rd_body_part_id" ID="DropDownList1" runat="server" Width="300px" DataSourceID="SqlDataSourceSaveInfo" AutoPostBack="True"> </asp:DropDownList></td>
                              <td width="22%" align="right" valign="middle"><strong >Projection   :&nbsp;</strong></td>
                              <td width="27%" valign="middle"><asp:TextBox ID="TextBoxProjection" runat="server"  Width="125px"  ></asp:TextBox></td>
      </tr>
                  <tr>
                    <td height="25" align="right" valign="middle"><span  style="width: 245px"><strong>Alias :&nbsp;</strong></span></td>
                      <td colspan="3" valign="middle"><asp:TextBox ID="TextBoxAlias" runat="server"  Width="146px"  ></asp:TextBox>
                        <span style="height: 24px">
                                                                        
                        <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                            InsertCommand="Rd_insert_projection" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>"
                            SelectCommand="Rd_select_body_part" SelectCommandType="StoredProcedure">
                          <InsertParameters>
                            <asp:ControlParameter ControlID="DropDownList1" Name="Rd_Body_part_Id" PropertyName="SelectedValue"
                                    Type="Int32" />
                            <asp:ControlParameter ControlID="TextBoxProjection" Name="Projections" PropertyName="Text"
                                    Type="String" />
                            <asp:ControlParameter ControlID="TextBoxAlias" Name="Alias" PropertyName="Text" Type="String" />
                          </InsertParameters>
                        </asp:SqlDataSource>
                        </span></td>
      </tr>
                  
                  
                  
                  
                  
                  

                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                </table><br /><div align="center"><asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="btn1" /></div>
<asp:GridView ID="GridViewRdProjection" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                DataKeyNames="Projection_ID" DataSourceID="SqlDataSourceProjection" CssClass="Grid_1" Width="100%">
                  <Columns>
                      <asp:TemplateField>
                          <EditItemTemplate>
                              <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />&nbsp;<asp:ImageButton
                                  ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                          </EditItemTemplate>
                          <ItemTemplate>
                              <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.gif"
                                  OnClientClick="return confirmation_edit(this)" />&nbsp;<asp:ImageButton ID="ImageButton2"
                                      runat="server" CommandName="Delete" ImageUrl="~/images/icon_delete.gif" OnClientClick="return confirmation(this)" />
                          </ItemTemplate>
                      </asp:TemplateField>
                  <asp:BoundField DataField="Rd_Body_part_Id" HeaderText="Rd_Body_part_Id" SortExpression="Rd_Body_part_Id"
                        Visible="False" >
                    <HeaderStyle CssClass="GridHeader" />                
                  </asp:BoundField>
                  <asp:TemplateField HeaderText="Rd_body_part" SortExpression="Rd_body_part">
                    <EditItemTemplate>
                      <asp:TextBox ID="TextBoxBodyPart" runat="server" Text='<%# Bind("Rd_body_part") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                      <asp:Label ID="Label1" runat="server" Text='<%# Bind("Rd_body_part") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="activeinsidetwo" />
                    <HeaderStyle CssClass="GridHeader" />                
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Projections" SortExpression="Projections">
                    <EditItemTemplate>
                      <asp:TextBox ID="TextBoxProjections" runat="server" Text='<%# Bind("Projections") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                      <asp:Label ID="Label2" runat="server" Text='<%# Bind("Projections") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="activeinsidetwo" />
                    <HeaderStyle CssClass="GridHeader" />                
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Alias" SortExpression="Alias">
                    <EditItemTemplate>
                      <asp:TextBox ID="TextBoxAlias2" runat="server" Text='<%# Bind("Alias") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                      <asp:Label ID="Label3" runat="server" Text='<%# Bind("Alias") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="activeinsidetwo" />
                    <HeaderStyle CssClass="GridHeader" />                
                  </asp:TemplateField>
                  <asp:BoundField DataField="Projection_ID" HeaderText="Projection_ID" InsertVisible="False"
                        ReadOnly="True" SortExpression="Projection_ID" Visible="False" >
                    <HeaderStyle CssClass="GridHeader" />                
                  </asp:BoundField>
                  <asp:HyperLinkField DataNavigateUrlFields="Rd_Body_Part_Id,Projection_ID" DataNavigateUrlFormatString="Rd_Xray_entry.aspx?BodyPart={0}&amp;Projection={1}"
                        DataTextField="Projections" HeaderText="Projection" >
                    <ControlStyle CssClass="gridlinktwo" />
                    <HeaderStyle CssClass="GridHeader" />                
                  </asp:HyperLinkField>
                  </Columns>
                  <RowStyle CssClass="GridItem" />
                  <HeaderStyle CssClass="GridHeader" />                
                  <AlternatingRowStyle CssClass="GridAltItem" />
                  <PagerStyle CssClass="gridpager" />                
                  <EditRowStyle CssClass="Selected" />
                </asp:GridView>
                  <asp:SqlDataSource ID="SqlDataSourceProjection" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                SelectCommand="SELECT Rd_xray_projections.Rd_Body_part_Id, Rd_xray_projections.Projections, Rd_xray_projections.Alias, Rd_xray_projections.Projection_ID, Rd_body_part.Rd_body_part FROM Rd_xray_projections INNER JOIN Rd_body_part ON Rd_xray_projections.Rd_Body_part_Id = Rd_body_part.Rd_body_part_id WHERE (Rd_xray_projections.Rd_Body_part_Id = @Rd_Body_part_Id)"
                UpdateCommand="Rd_update_xrayproject" UpdateCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>" DeleteCommand="DELETE FROM Rd_xray_projections WHERE (Projection_ID = @Projection_ID)">
                    <UpdateParameters>
                      <asp:Parameter DefaultValue="1" Name="Projection_ID" Type="Int32" />
                      <asp:Parameter DefaultValue="Basic projectionss" Name="Projections" Type="String" />
                      <asp:Parameter DefaultValue="Basic projectionss" Name="Alias" Type="String" />
                    </UpdateParameters>
                      <DeleteParameters>
                          <asp:ControlParameter ControlID="GridViewRdProjection" Name="Projection_ID" PropertyName="SelectedValue" />
                      </DeleteParameters>
                      <SelectParameters>
                          <asp:ControlParameter ControlID="DropDownList1" Name="Rd_Body_part_Id" PropertyName="SelectedValue" />
                      </SelectParameters>
                  </asp:SqlDataSource>
                  <asp:HiddenField ID="HiddenFieldBodyPart" runat="server" />
                  <asp:HiddenField ID="HiddenFieldProjection" runat="server" />
                  <asp:HiddenField ID="HiddenFieldAlias" runat="server" />
</div>
</form>
</body>
</html>

