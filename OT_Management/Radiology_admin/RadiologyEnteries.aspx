<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RadiologyEnteries.aspx.vb" Inherits="RadiologyEnteries" %>

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

<script type="text/javascript" >
function requireValue()
{
//alert(document.getElementById("TxtRSGName").value.length);
if(document.getElementById("TextBoxGName").value.length==0)
{
alert("Enter Group Name");
return false;
}
}
</script>

</head>

<body >

<form id="form1" runat = "server">
  <div id="forms_items" class="forms_items"> 
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
                  <!--DWLayoutTable-->
          
<tr>
                    <td width="26%" height="25" align="right" valign="middle" ><strong>Group Name   :&nbsp;</strong></td>
                              <td width="25%" valign="middle"><span style="height: 28px">
                                <asp:DropDownList AutoPostBack="True" 
                              DataTextField="RGName" DataValueField="RGID" ID="DropDownListGName" runat="server" Width="250px" DataSourceID="SqlDataSourceGName"> </asp:DropDownList>
                              </span></td>
                              <td width="24%" align="right" valign="middle"><strong >Sub Group Name   :&nbsp;</strong></td>
                              <td width="25%" valign="middle"><asp:DropDownList AutoPostBack="True" 
                            DataTextField="RSGName" DataValueField="RSGID" ID="DropDownListSGName" runat="server" Width="250px" DataSourceID="SqlDataSourceSGName"> </asp:DropDownList></td>
                    </tr>
                  <tr>
                    <td height="25" align="right" valign="middle"><strong><span  style="width: 245px">Radilogy Test Name :&nbsp;</span></strong></td>
                      <td valign="middle"><span style="height: 25px">
                        <asp:TextBox ID="TextBoxradiologyTName" runat="server" CssClass="d-active" Width="245px"  ></asp:TextBox>
                      </span></td>
                      <td align="right" valign="middle"><strong >Fee   :&nbsp;</strong></td>
                      <td valign="middle"><asp:TextBox ID="TextBoxFee" runat="server" CssClass="d-active" Width="50px"  ></asp:TextBox>
                        </td>
                    </tr>
                 
                  
                  
                  
                  

                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                </table>
                
                
                <br /><div align="center"><asp:Button CssClass="btn1" ID="btnSave" runat="server" Text="Save" /></div>
<br />
<asp:Label CssClass="text_lables_login" ID="LabelMessage" runat="server" ></asp:Label>
                  <asp:RangeValidator ControlToValidate="TextBoxFee" CssClass="text_lables"
                        ErrorMessage="Enter Numbers only" ID="RangeValidatorFee" MaximumValue="10000000" MinimumValue="0" runat="server" Type="Integer"></asp:RangeValidator>
                  <br />
                  <asp:SqlDataSource ID="SqlDataSourceGNameSave" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                        InsertCommand="INSERT INTO [Radiology] ([RGID], [RadiologyName], [Fee], [RSGID]) VALUES (@RGID, @RadiologyName, @Fee, @RSGID)"
                        ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>" ConflictDetection="CompareAllValues" OldValuesParameterFormatString="">
                  <InsertParameters>
                    <asp:ControlParameter ControlID="DropDownListGName" Name="RGID" PropertyName="SelectedValue"
                            Type="Decimal" />
                    <asp:ControlParameter ControlID="TextBoxradiologyTName" Name="RadiologyName" PropertyName="Text"
                            Type="String" />
                    <asp:ControlParameter ControlID="TextBoxFee" Name="Fee" PropertyName="Text" Type="Decimal" />
                    <asp:ControlParameter ControlID="DropDownListSGName" Name="RSGID" PropertyName="SelectedValue"
                            Type="Decimal" />
                  </InsertParameters>
                </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSourceSGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                        SelectCommand="SELECT RSGID, RSGName FROM RadiologySubGroup WHERE (RGID = @RGID)" ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>">
                    <SelectParameters>
                      <asp:ControlParameter ControlID="DropDownListGName" Name="RGID" PropertyName="SelectedValue" />
                    </SelectParameters>
                  </asp:SqlDataSource>
                  <asp:SqlDataSource ID="SqlDataSourceGName" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                        SelectCommand="SELECT [RGID], [RGName] FROM [RadiologyGroup]"></asp:SqlDataSource>
                  <asp:HiddenField ID="HiddenFieldGroupName" runat="server" />
                    <asp:HiddenField ID="HiddenFieldFee" runat="server" />
                    <asp:HiddenField ID="HiddenFieldName" runat="server" />
                    <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Rad_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Admin_Rad_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT * FROM [Radiology]&#13;&#10;where RSGID=@RSGID" UpdateCommand="UPDATE Radiology SET RadiologyName = @RadiologyName, Fee = @Fee WHERE (RID = @RID)">
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="HiddenFieldName" Name="RadiologyName" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HiddenFieldFee" Name="Fee" PropertyName="Value" />
                            <asp:ControlParameter ControlID="GridViewEnteries" Name="RID" PropertyName="SelectedValue" />
                        </UpdateParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownListSGName" Name="RSGID" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                  <asp:GridView ID="GridViewEnteries" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceGrid" Width="100%" AllowPaging="True" CssClass="Grid_1" DataKeyNames="RID">
                    <Columns>
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
                        <asp:BoundField DataField="RID" HeaderText="RID" InsertVisible="False" ReadOnly="True"
                            SortExpression="RID" />
                    <asp:BoundField DataField="RadiologyName" HeaderText="Radiology Test Name" SortExpression="RadiologyName" >
                      <ControlStyle CssClass="activeinsidetwo" />
                      <HeaderStyle CssClass="GridHeader" />                  
                    </asp:BoundField>
                    <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee" >
                      <ControlStyle CssClass="activeinsidetwo" />
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

