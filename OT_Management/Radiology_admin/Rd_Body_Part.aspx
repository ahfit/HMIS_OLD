<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Rd_Body_Part.aspx.vb" Inherits="Rd_Body_Part" %>

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
                    <td width="12%" align="right" valign="middle"  style="height: 32px"><strong>Body Part   :</strong>&nbsp;</td>
                              <td width="38%" valign="middle" style="height: 32px"><asp:TextBox ID="TextBox1" runat="server"  Width="146px"  ></asp:TextBox></td>
                              <td width="25%" align="right" valign="middle" style="height: 32px"><strong >&nbsp;Body Part Group   :&nbsp;</strong></td>
                              <td width="25%" valign="middle" style="height: 32px"><span style="width: 151px">
                                <asp:TextBox ID="TextBox2" runat="server"  Width="146px"  ></asp:TextBox>
                                                                
                                <asp:SqlDataSource ID="SqlDataSourceSave" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                            InsertCommand="Rd_Insert_BodyPart" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>">
                                  <InsertParameters>
                                    <asp:ControlParameter ControlID="TextBox1" Name="Rd_body_part" PropertyName="Text"
                                    Type="String" />
                                    <asp:ControlParameter ControlID="TextBox2" Name="body_part_group" PropertyName="Text"
                                    Type="String" />
                                  </InsertParameters>
                                </asp:SqlDataSource>
</span></td>
      </tr>
             
                  
                  
                  
                  

                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                </table><br /><div align="center"><asp:Button ID="ButtonSave" runat="server" CssClass="btn1" Text="Save"  /></div>
                <br />

<asp:GridView ID="GridView_BodyPart" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                DataKeyNames="Rd_body_part_id" DataSourceID="SqlDataSourceBodyPart" CssClass="Grid_1" Width="100%">
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
                  <asp:BoundField DataField="Rd_body_part_id" HeaderText="Rd_body_part_id" InsertVisible="False"
                        ReadOnly="True" SortExpression="Rd_body_part_id" Visible="False" >
                    <HeaderStyle CssClass="GridHeader" />                
                    <ControlStyle CssClass="activeinside" />
                  </asp:BoundField>
                  <asp:BoundField DataField="Rd_body_part" HeaderText="Body Part" SortExpression="Rd_body_part" >
                    <HeaderStyle CssClass="GridHeader" />                
                    <ControlStyle CssClass="activeinside" />
                  </asp:BoundField>
                  <asp:BoundField DataField="body_part_group" HeaderText="Body Part Group" SortExpression="body_part_group" >
                    <HeaderStyle CssClass="GridHeader" />                
                    <ControlStyle CssClass="activeinside" />
                  </asp:BoundField>
                  </Columns>
                  <RowStyle CssClass="GridItem" />
                  <HeaderStyle CssClass="GridHeader" />                
                  <AlternatingRowStyle CssClass="GridAltItem" />
                  <PagerStyle CssClass="Gridpager" />                
                  <EditRowStyle CssClass="Selected" />
                </asp:GridView>
                  <asp:SqlDataSource ID="SqlDataSourceBodyPart" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                DeleteCommand="DELETE FROM [Rd_body_part] WHERE [Rd_body_part_id] = @Rd_body_part_id"
                InsertCommand="INSERT INTO [Rd_body_part] ([Rd_body_part], [body_part_group]) VALUES (@Rd_body_part, @body_part_group)"
                SelectCommand="SELECT * FROM [Rd_body_part]" UpdateCommand="UPDATE [Rd_body_part] SET [Rd_body_part] = @Rd_body_part, [body_part_group] = @body_part_group WHERE [Rd_body_part_id] = @Rd_body_part_id" ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>">
                    <DeleteParameters>
                      <asp:Parameter Name="Rd_body_part_id" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                      <asp:Parameter Name="Rd_body_part" Type="String" />
                      <asp:Parameter Name="body_part_group" Type="String" />
                      <asp:Parameter Name="Rd_body_part_id" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                      <asp:Parameter Name="Rd_body_part" Type="String" />
                      <asp:Parameter Name="body_part_group" Type="String" />
                    </InsertParameters>
                  </asp:SqlDataSource>
</div>
</form>
</body>
</html>

