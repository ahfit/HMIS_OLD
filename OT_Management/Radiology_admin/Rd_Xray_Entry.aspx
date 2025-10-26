<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Rd_Xray_Entry.aspx.vb" Inherits="Rd_Xray_Entry" %>


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
                    <td height="25" align="right" valign="middle" ><strong>Body Part   :&nbsp;</strong></td>
                    <td colspan="3" valign="middle"><span style="height: 22px">
                      <asp:DropDownList AutoPostBack="True"  DataTextField="Rd_body_part" DataValueField="Rd_body_part_id" ID="DropDownListBodyPart" runat="server" Width="582px" DataSourceID="SqlDataSourceBodyPart"> </asp:DropDownList>
                    </span></td>
                    </tr>
                  <tr>
                    <td height="25" align="right" valign="middle" ><strong>Projection :&nbsp;</strong></td>
                    <td valign="middle">
                      <asp:DropDownList AutoPostBack="True"  DataTextField="Projections" DataValueField="Projection_ID" ID="DropDownListProjection" runat="server" Width="275px" DataSourceID="SqlDataSourceProjection"> </asp:DropDownList>
                  </td>
                    <td align="right" valign="middle"><strong >X-ray Beam   :&nbsp;</strong></td>
                    <td valign="middle"><strong >
                      <asp:TextBox CssClass="d-active" ID="TextBoxBeam" runat="server" Width="146px"   ></asp:TextBox>
                    </strong></td>
                  </tr>
                  <tr>
                    <td height="25" align="right" valign="middle" ><strong >X-ray Position   :</strong>&nbsp;</td>
                    <td valign="middle"><strong >
                      <asp:TextBox CssClass="d-active" ID="TextBoxposition" runat="server" Width="146px"   ></asp:TextBox>
                    </strong></td>
                    <td align="right" valign="middle"><span ><strong>X-Ray Characteristics :&nbsp;</strong></span></td>
                    <td valign="middle"><asp:TextBox CssClass="d-active" ID="TextBoxCharacteristics" runat="server" Width="146px"   ></asp:TextBox></td>
                  </tr>
                  <tr>
                    <td height="25" align="right" valign="middle" ><strong >X-ray Images   :&nbsp;</strong></td>
                              <td colspan="3" valign="middle"><strong >
                                <asp:TextBox CssClass="d-active" ID="TextBoxImages" runat="server" Width="146px"   ></asp:TextBox>
                              </strong>
                              </td>
                            </tr>
               
                  
                  
                  
                  
                  

                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                </table><br /><div align="center"><asp:Button ID="ButtonSave" runat="server" Text="Save" CssClass="btn1" /></div><br />

<asp:Label CssClass="text_lables_login" ID="Label1" runat="server" Width="268px"></asp:Label>
                  <br />
                  <asp:SqlDataSource ID="SqlDataSourceBodyPart" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>" SelectCommand="Rd_select_body_part" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSourceProjection" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>" SelectCommand="Rd_Projection" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                      <asp:ControlParameter ControlID="DropDownListBodyPart" Name="BodyPart" PropertyName="SelectedValue"
                                    Type="Int32" />
                    </SelectParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>" InsertCommand="Rd_Insert_Xray_projection" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>">
                    <InsertParameters>
                      <asp:ControlParameter ControlID="TextBoxBeam" Name="Xray_beam" PropertyName="Text"
                                    Type="String" />
                      <asp:ControlParameter ControlID="TextBoxCharacteristics" Name="Characteristics" PropertyName="Text"
                                    Type="String" />
                      <asp:ControlParameter ControlID="TextBoxImages" Name="images" PropertyName="Text"
                                    Type="String" />
                      <asp:ControlParameter ControlID="TextBoxposition" Name="Position" PropertyName="Text"
                                    Type="String" />
                      <asp:ControlParameter ControlID="DropDownListProjection" Name="Projection_ID" PropertyName="SelectedValue"
                                    Type="Int32" />
                    </InsertParameters>
                  </asp:SqlDataSource>
               
                  <asp:GridView ID="GridViewXray" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceGrid"
                Style="position: static" CssClass="Grid_1" Width="100%">
                    <Columns>
                    <asp:BoundField DataField="Rd_body_part" HeaderText="body part" SortExpression="Rd_body_part" >
                      <ItemStyle Width="120px" />                  
                      <HeaderStyle CssClass="GridHeader" />                    </asp:BoundField>
                    <asp:BoundField DataField="Projections" HeaderText="Projections" SortExpression="Projections" >
                      <HeaderStyle CssClass="GridHeader" />                    </asp:BoundField>
                    <asp:BoundField DataField="Xray_beam" HeaderText="Xray beam" SortExpression="Xray_beam" >
                      <ItemStyle Width="150px" />                  
                      <HeaderStyle CssClass="GridHeader" />                    </asp:BoundField>
                    <asp:BoundField DataField="Position" HeaderText="Position" SortExpression="Position" >
                      <HeaderStyle CssClass="GridHeader" />                    </asp:BoundField>
                    <asp:BoundField DataField="images" HeaderText="images" SortExpression="images" >
                      <HeaderStyle CssClass="GridHeader" />                    </asp:BoundField>
                    <asp:BoundField DataField="Characteristics" HeaderText="Characteristics" SortExpression="Characteristics" >
                      <HeaderStyle CssClass="GridHeader" />                    </asp:BoundField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />                  
                    <AlternatingRowStyle CssClass="GridAltItem" />
                  </asp:GridView>
                  <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                SelectCommand="SELECT Rd_xray_projection_beam.Xray_beam, Rd_xray_projections.Projections, Rd_xray_projection_characteristics.Characteristics, Rd_xray_projection_images.images, Rd_Xray_projection_position.Position, Rd_body_part.Rd_body_part FROM Rd_xray_projection_beam INNER JOIN Rd_xray_projections ON Rd_xray_projection_beam.Projection_ID = Rd_xray_projections.Projection_ID INNER JOIN Rd_xray_projection_characteristics ON Rd_xray_projection_beam.ID = Rd_xray_projection_characteristics.ID INNER JOIN Rd_xray_projection_images ON Rd_xray_projection_beam.ID = Rd_xray_projection_images.ID INNER JOIN Rd_Xray_projection_position ON Rd_xray_projection_beam.ID = Rd_Xray_projection_position.ID INNER JOIN Rd_body_part ON Rd_xray_projections.Rd_Body_part_Id = Rd_body_part.Rd_body_part_id WHERE (Rd_body_part.Rd_body_part_id = @Rd_body_part_id) AND (Rd_xray_projections.Projection_ID = @Projection_ID)" ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>">
                    <SelectParameters>
                      <asp:ControlParameter ControlID="DropDownListBodyPart" Name="Rd_body_part_id" PropertyName="SelectedValue" />
                      <asp:ControlParameter ControlID="DropDownListProjection" Name="Projection_ID" PropertyName="SelectedValue" />
                    </SelectParameters>
                  </asp:SqlDataSource>
                  <br />
<br />

</div>
</form>
</body>
</html>

