<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RadiologySubGroup.aspx.vb" Inherits="RadiologySubGroup" %>


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


<script type="text/javascript" src="../../../Validate.js"></script>
</head>

<body >

<form id="form1" runat = "server">
  <div id="forms_items" class="forms_items"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                  <!--DWLayoutTable-->
                 
                  <tr>
                    <td width="20%" height="25" align="right" valign="middle" ><strong>Group Name   :&nbsp;</strong></td>
                              <td width="30%" valign="middle"><asp:DropDownList  DataTextField="RGName"
                              DataValueField="RGID" ID="Dropdownlist_GName" runat="server" Width="250px" DataSourceID="SqlDataSourceGName" AutoPostBack="True"> </asp:DropDownList></td>
                              <td width="12%" align="right" valign="middle"><strong >Sub Group Name   :&nbsp;</strong></td>
                              <td width="38%" valign="middle"><asp:TextBox ID="TxtRSGName" runat="server" CssClass="d-active" Width="146px"  ></asp:TextBox></td>
      </tr>
                  <tr>
                    <td height="25" align="right" valign="middle"><strong><span  style="width: 245px">Fee :&nbsp;</span></strong></td>
                      <td colspan="3" valign="middle"><asp:TextBox ID="txtFee" runat="server" CssClass="d-active" Width="100px"  ></asp:TextBox>
                        <span style="height: 120px">
                        </span>
                        <asp:RangeValidator ControlToValidate="txtFee" CssClass="text_lables"
                          ErrorMessage="Enter Numbers only" ID="RangeValidator1" MaximumValue="10000000" MinimumValue="0" runat="server" Type="Integer"></asp:RangeValidator></td>
      </tr>
                 
                  
                  
                  

                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                </table><br /><div align="center"><asp:Button CssClass="btn1" ID="btnSave" runat="server" Text="Save" /></div>
<asp:Label  ID="LabelMessage" runat="server" Width="293px"></asp:Label>
                  </span><br />
                  <asp:SqlDataSource ID="SqlDataSourceGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                              SelectCommand="SELECT RGID, RGName FROM RadiologyGroup" ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>"></asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSourceRSGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                              InsertCommand="INSERT INTO [RadiologySubGroup] ([RSGName], [Fee], [RGID]) VALUES (@RSGName, @Fee, @RGID)"
                              ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>" SelectCommand="SELECT RSGID, RSGName, Fee, RGID FROM RadiologySubGroup WHERE (RGID = @RGID)" DeleteCommand="DELETE FROM [RadiologySubGroup] WHERE [RSGID] = @original_RSGID AND [RSGName] = @original_RSGName AND [Fee] = @original_Fee AND [RGID] = @original_RGID" UpdateCommand="UPDATE [RadiologySubGroup] SET [RSGName] = @RSGName, [Fee] = @Fee, [RGID] = @RGID WHERE [RSGID] = @original_RSGID AND [RSGName] = @original_RSGName AND [Fee] = @original_Fee AND [RGID] = @original_RGID" ConflictDetection="CompareAllValues" OldValuesParameterFormatString="original_{0}">
                    <InsertParameters>
                      <asp:ControlParameter ControlID="TxtRSGName" Name="RSGName" PropertyName="Text" Type="String" />
                      <asp:ControlParameter ControlID="txtFee" Name="Fee" PropertyName="Text" Type="Decimal" />
                      <asp:ControlParameter ControlID="Dropdownlist_GName" Name="RGID" PropertyName="SelectedValue"
                        Type="Decimal" />
                    </InsertParameters>
                    <DeleteParameters>
                      <asp:Parameter Name="original_RSGID" Type="Decimal" />
                      <asp:Parameter Name="original_RSGName" Type="String" />
                      <asp:Parameter Name="original_Fee" Type="Decimal" />
                      <asp:Parameter Name="original_RGID" Type="Decimal" />
                    </DeleteParameters>
                    <UpdateParameters>
                      <asp:Parameter Name="RSGName" Type="String" />
                      <asp:Parameter Name="Fee" Type="Decimal" />
                      <asp:Parameter Name="RGID" Type="Decimal" />
                      <asp:Parameter Name="original_RSGID" Type="Decimal" />
                      <asp:Parameter Name="original_RSGName" Type="String" />
                      <asp:Parameter Name="original_Fee" Type="Decimal" />
                      <asp:Parameter Name="original_RGID" Type="Decimal" />
                    </UpdateParameters>
                    <SelectParameters>
                      <asp:ControlParameter ControlID="Dropdownlist_GName" Name="RGID" PropertyName="SelectedValue" />
                    </SelectParameters>
                  </asp:SqlDataSource>
                </span>
                  <asp:GridView ID="GridViewSubGroup" runat="server" AutoGenerateColumns="False" DataKeyNames="RSGID" DataSourceID="SqlDataSourceRSGName" Width="100%" AllowPaging="True" CssClass="Grid_1">
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
                    <asp:BoundField DataField="RSGID" HeaderText="RSGID" InsertVisible="False" ReadOnly="True"
                        SortExpression="RSGID" >
                      <HeaderStyle CssClass="GridHeader" />                  
                    </asp:BoundField>
                    <asp:HyperLinkField DataNavigateUrlFields="RSGID,RGID" DataNavigateUrlFormatString="RadiologyEnteries.aspx?SubGroup={0}&amp;MainGroup={1}"
                        DataTextField="RSGName" HeaderText="Sub Group Name " >
                      <ControlStyle CssClass="gridlinktwo" />
                      <HeaderStyle CssClass="GridHeader" />                  
                    </asp:HyperLinkField>
                    <asp:BoundField DataField="RSGName" HeaderText="RSGName" SortExpression="Radiology Sub Group Name" Visible="False" >
                      <HeaderStyle CssClass="GridHeader" />                  
                    </asp:BoundField>
                    <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" >
                      <ControlStyle CssClass="activeinside" />
                      <HeaderStyle CssClass="GridHeader" />                  
                    </asp:BoundField>
                    <asp:BoundField DataField="RGID" HeaderText="RGID" SortExpression="RGID" >
                      <ControlStyle CssClass="activeinside" />
                      <HeaderStyle CssClass="GridHeader" />                  
                    </asp:BoundField>
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />                  
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <EditRowStyle CssClass="Selected" />
                  </asp:GridView><br />
<br />

</div>
</form>
</body>
</html>

