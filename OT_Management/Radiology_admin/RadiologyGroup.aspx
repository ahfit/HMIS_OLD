<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RadiologyGroup.aspx.vb" Inherits="RadiologyGroup" %>

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
                    <td height="25" align="right" valign="middle" ><strong>Group Name   :&nbsp;</strong></td>
                              <td valign="middle"><span style="height: 25px">
                                <asp:TextBox CssClass="d-active" ID="TextBoxGName" runat="server" ></asp:TextBox>
                              </span></td>
                              <td align="right" valign="middle"><strong >&nbsp;Fee   :&nbsp;</strong></td>
                              <td valign="middle"><span style="width: 151px"><span style="height: 25px">
                                <asp:TextBox ID="TextBoxFee" runat="server" CssClass="d-active" Width="50px"  ></asp:TextBox>
                              </span><span style="height: 25px"> <span style="vertical-align: top; text-align: left"> &nbsp;
                                                            
</span>
                              <asp:RangeValidator ControlToValidate="TextBoxFee" CssClass="text_lables"
                        ErrorMessage="Enter Numbers only" ID="RangeValidatorFee" MaximumValue="10000000" MinimumValue="0" runat="server" Type="Integer"></asp:RangeValidator>
                              </span></span></td>
      </tr>
                  
                  
                  
                  
                  
                  

                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                </table><br /><div align="center"><asp:Button CssClass="btn1" ID="btnSave" runat="server" Text="Save"/></div><br />

<asp:Label CssClass="text_lables_login" ID="LabelMessage" runat="server" Width="168px"></asp:Label>
                  <br />
                  <asp:SqlDataSource ID="SqlDataSourceTestGroupSave" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                              InsertCommand="INSERT INTO [RadiologyGroup] ([RGName], [Fee]) VALUES (@RGName, @Fee)" ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>" DeleteCommand="DELETE FROM [RadiologyGroup] WHERE [RGID] = @original_RGID AND [RGName] = @original_RGName AND [Fee] = @original_Fee" SelectCommand="SELECT * FROM [RadiologyGroup]" ConflictDetection="CompareAllValues" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [RadiologyGroup] SET [RGName] = @RGName, [Fee] = @Fee WHERE [RGID] = @original_RGID AND [RGName] = @original_RGName AND [Fee] = @original_Fee">
                  <InsertParameters>
                    <asp:ControlParameter ControlID="TextBoxGName" Name="RGName" PropertyName="Text"
                              Type="String" />
                    <asp:ControlParameter ControlID="TextBoxFee" Name="Fee" PropertyName="Text" Type="Decimal" />
                  </InsertParameters>
                  <DeleteParameters>
                    <asp:Parameter Name="original_RGID" Type="Decimal" />
                    <asp:Parameter Name="original_RGName" Type="String" />
                    <asp:Parameter Name="original_Fee" Type="Decimal" />
                  </DeleteParameters>
                  <UpdateParameters>
                    <asp:Parameter Name="RGName" Type="String" />
                    <asp:Parameter Name="Fee" Type="Decimal" />
                    <asp:Parameter Name="original_RGID" Type="Decimal" />
                    <asp:Parameter Name="original_RGName" Type="String" />
                    <asp:Parameter Name="original_Fee" Type="Decimal" />
                  </UpdateParameters>
                </asp:SqlDataSource>
                  <asp:GridView ID="GridViewGroup" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceTestGroupSave" Width="100%" CssClass="Grid_1">
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
                    <asp:BoundField DataField="RGID" HeaderText="RGID" InsertVisible="False" ReadOnly="True"
                            SortExpression="RGID" >
                      <HeaderStyle CssClass="GridHeader" />                  
                    </asp:BoundField>
                    <asp:BoundField DataField="RGName" HeaderText="RGName" SortExpression="RGName" >
                      <HeaderStyle HorizontalAlign="Left" CssClass="GridHeader" />                  
                      <ControlStyle CssClass="activeinside" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" >
                      <ControlStyle CssClass="activeinside" />
                      <HeaderStyle CssClass="GridHeader" />                  
                    </asp:BoundField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />                  
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <EditRowStyle CssClass="Selected" />
                  </asp:GridView>
</div>
</form>
</body>
</html>

