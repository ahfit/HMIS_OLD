<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Update_Component_Max_length.aspx.vb" Inherits="Pathology_Update_Component_Max_length" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xmlns:spry="http://ns.adobe.com/spry">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link href="../images-/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../images-/sheet_form.css" rel="stylesheet" type="text/css" />


<script src="../images-/highlight.js" type="text/javascript"></script>

<style type="text/css">
body{background-image:none; margin-top:0px; }
html{background-image:none;}
</style>

</head>

<body><form id="form1" runat = "server">

<div id="forms_items" class="forms_items">
    &nbsp;<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" >


                          <tr>
                            <td width="16%" align="right" valign="middle" ><strong>Main Group&nbsp; :&nbsp; </strong></td>
                            <td colspan="2" valign="middle"><asp:DropDownList AutoPostBack="True"  DataTextField="TGName" DataValueField="TGID" ID="DropDownListMGroup" runat="server" Width="250px" DataSourceID="SqlDataSourceMGroup"> </asp:DropDownList></td>
                              <td width="17%" align="right" valign="middle" ><strong >Sub Group :&nbsp;</strong></td>
                            <td width="33%"  valign="middle"><asp:DropDownList AutoPostBack="True"  DataTextField="TSGName" DataValueField="TSGID" ID="DropDownListSubGroup" runat="server" Width="250px" DataSourceID="SqlDataSourceSubGroup">
                            </asp:DropDownList></td>
      </tr>
                            <tr>
                                <td align="right" valign="middle">
                                    <strong>Test &nbsp;:&nbsp;</strong></td>
              <td colspan="2" valign="middle">
                                    <asp:DropDownList  DataTextField="TestName" DataValueField="TID" ID="DropDownListTest" runat="server" Width="250px" DataSourceID="SqlDataSourceTest" AutoPostBack="True">
                                    </asp:DropDownList></td>
                                <td align="right" valign="middle" >
                                    &nbsp;</td>
                  <td valign="middle" >
                                    </td>
                            </tr>
                            <tr>
                                <td align="right" valign="middle" style="height: 25px" >
                                    <strong>
                                    &nbsp;</strong></td>
      <td colspan="2" valign="middle" style="height: 25px">
          &nbsp;</td>
                                <td align="right" valign="middle" style="height: 25px" >                                     <strong>
                                    &nbsp;</strong></td>
                  <td valign="middle" style="height: 25px" >
                                    </td>
                            </tr>

                        </table><br />
                     <div align="center">   <asp:Button ID="ButtonSave" runat="server" CssClass="btn1" Text="Search"  />&nbsp;                                
                            <asp:Label CssClass="err" ID="Label1" runat="server" ></asp:Label></div><br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
        DataKeyNames="TCID" DataSourceID="SqlDataSourceForGridView" Width="100%">
        <FooterStyle CssClass="GridPager" />
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="TGName" HeaderText="Group Name" ReadOnly="True" SortExpression="TGName" />
            <asp:BoundField DataField="TSGName" HeaderText="Sub Group Name" ReadOnly="True" SortExpression="TSGName" />
            <asp:BoundField DataField="TestName" HeaderText="TestName" ReadOnly="True" SortExpression="TestName" />
            <asp:BoundField DataField="ComponentName" HeaderText="ComponentName" ReadOnly="True"
                SortExpression="ComponentName" />
            <asp:BoundField DataField="MaxLength" HeaderText="MaxLength" SortExpression="MaxLength" />
            <asp:BoundField DataField="Min_Value" HeaderText="Minimum Value" SortExpression="Min_Value" />
            <asp:BoundField DataField="Max_Value" HeaderText="Maximum Value" SortExpression="Max_Value" />
            <asp:BoundField DataField="TCID" HeaderText="TCID" InsertVisible="False" ReadOnly="True"
                SortExpression="TCID" Visible="False" />
            <asp:BoundField DataField="TID" HeaderText="TID" InsertVisible="False" ReadOnly="True"
                SortExpression="TID" Visible="False" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>

                          <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" SelectCommand="SELECT     TestGroup.TGName, TestSubGroup.TSGName, Test.TestName, TestComponent.ComponentName, TestComponent.MaxLength, &#13;&#10;                      TestComponent.Min_Value, TestComponent.Max_Value, TestComponent.TCID, Test.TID&#13;&#10;FROM         TestComponent INNER JOIN&#13;&#10;                      Test ON TestComponent.TID = Test.TID INNER JOIN&#13;&#10;                      TestGroup ON Test.TGID = TestGroup.TGID INNER JOIN&#13;&#10;                      TestSubGroup ON Test.TSGID = TestSubGroup.TSGID&#13;&#10;WHERE     (Test.TID = @TID)" UpdateCommand="UPDATE TestComponent SET MaxLength = @MaxLength, Min_Value = @Min_Value, Max_Value = @Max_Value WHERE (TCID = @TCID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownListTest" Name="TID" PropertyName="SelectedValue" />
                            </SelectParameters>
                              <UpdateParameters>
                                  <asp:ControlParameter ControlID="HiddenFieldMaxLength" Name="MaxLength" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HiddenFieldMinValue" Name="Min_Value" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HiddenFieldMaxValue" Name="Max_Value" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="GridView1" Name="TCID" PropertyName="SelectedValue" />
                              </UpdateParameters>
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceMGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>" SelectCommand="SELECT TGID, TGName FROM TestGroup" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" SelectCommand="SELECT TestName, TID FROM Test WHERE (TSGID = @tsgid) AND (TGID = @tgid)">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="DropDownListSubGroup" Name="tsgid" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="DropDownListMGroup" Name="tgid" PropertyName="SelectedValue" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                              <asp:SqlDataSource ID="SqlDataSourceSubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>" SelectCommand="SELECT TSGID, TSGName FROM TestSubGroup WHERE (TGID = @tgid)" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>">
    <SelectParameters>
        <asp:ControlParameter ControlID="DropDownListMGroup" Name="tgid" PropertyName="SelectedValue" />
    </SelectParameters>
</asp:SqlDataSource>
                              <asp:HiddenField ID="HiddenFieldMaxLength" runat="server" />
                              <asp:HiddenField ID="HiddenFieldMaxValue" runat="server" />
    <asp:HiddenField ID="HiddenFieldMinValue" runat="server" />
    &nbsp;&nbsp;


</div>

</form>
</body>
</html>
