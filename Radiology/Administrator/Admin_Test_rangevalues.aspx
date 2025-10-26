<%@ page language="VB" autoeventwireup="false" inherits="Administrator_Admin_Test_rangevalues, App_Web_42zygch0" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:spry="http://ns.adobe.com/spry">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link href="../../images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../../images/sheet_form.css" rel="stylesheet" type="text/css" />


<script src="../../images/highlight.js" type="text/javascript"></script>

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
                                    <strong> Test Component :&nbsp;</strong>                                </td>
                  <td valign="middle" >
                                    <asp:DropDownList  DataTextField="ComponentName" DataValueField="TCID" ID="DropDownListTestComponent" runat="server" Width="250px" DataSourceID="SqlDataSourceTestComponent">
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td align="right" valign="middle" style="height: 25px" >
                                    <strong>
                                    Start Value&nbsp;:&nbsp;</strong></td>
      <td colspan="2" valign="middle" style="height: 25px">
                                    <asp:TextBox ID="TextBoxStart" runat="server" Width="248px" CssClass="input_txt"></asp:TextBox></td>
                                <td align="right" valign="middle" style="height: 25px" >                                     <strong>
                                    End Value :&nbsp;</strong></td>
                  <td valign="middle" style="height: 25px" >
                                    <asp:TextBox ID="TextBoxEnd" runat="server" CssClass="input_txt" Width="248px"></asp:TextBox></td>
                            </tr>
    <tr>
        <td align="right" style="height: 25px" valign="middle">
          <strong>Gender :&nbsp;</strong> </td>
<td colspan="2" style="height: 25px" valign="middle">
            <asp:DropDownList ID="DropDownList_Gender" runat="server" Width="251px" DataSourceID="SqlDataSourceGender" DataTextField="Gender" DataValueField="Gender_ID">
            </asp:DropDownList></td>
        <td align="right" style="height: 25px" valign="middle">
            <strong>Age start :&nbsp;</strong></td>
<td style="height: 25px" valign="middle">
            <asp:TextBox ID="TextBox_Age_Start" runat="server" CssClass="input_txt" Width="170px"></asp:TextBox>&nbsp;<asp:DropDownList
                ID="DropDownList_Age_Start" runat="server" Width="75px">
                <asp:ListItem Value="365">Year</asp:ListItem>
                <asp:ListItem Value="30">Month</asp:ListItem>
                <asp:ListItem Value="1">Day</asp:ListItem>
            </asp:DropDownList></td>
    </tr>
    <tr>
        <td align="right" style="height: 25px" valign="middle">
            <strong>Age End :&nbsp;</strong></td>
<td colspan="2" style="height: 25px" valign="middle">
            <asp:TextBox ID="TextBox_Age_End" runat="server" Width="170px" CssClass="input_txt"></asp:TextBox>&nbsp;<asp:DropDownList
                ID="DropDownList_Age_End" runat="server" Width="75px">
                <asp:ListItem Value="365">Year</asp:ListItem>
                <asp:ListItem Value="30">Month</asp:ListItem>
                <asp:ListItem Value="1">Day</asp:ListItem>
            </asp:DropDownList></td>
        <td align="right" style="height: 25px" valign="middle">
        </td>
        <td style="height: 25px" valign="middle">
        </td>
    </tr>
                         
                          
                          
                          
                          
                          
                          
                          

                        </table><br />
                     <div align="center">   <asp:Button ID="ButtonSave" runat="server" CssClass="btn1" Text="Save"  />                                                                                                                        
                              <asp:Button
                    ID="Buttonrefresh" runat="server" Text="Refresh" CssClass="btn1"  />&nbsp;                                
                            <asp:Label CssClass="err" ID="Label1" runat="server" ></asp:Label></div><br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
        DataKeyNames="Refid" DataSourceID="SqlDataSourceForGridView" Width="100%">
        <FooterStyle CssClass="GridPager" />
        <Columns>
            <asp:CommandField   ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="TestName" HeaderText="TestName" ReadOnly="True" SortExpression="TestName" />
            <asp:BoundField DataField="StartValue" HeaderText="StartValue" SortExpression="StartValue" />
            <asp:BoundField DataField="EndValue" HeaderText="EndValue" SortExpression="EndValue" />
            <asp:TemplateField HeaderText="Gender" SortExpression="Gender">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownListGender" runat="server" DataSourceID="SqlDataSourceGender"
                        DataTextField="Gender" DataValueField="Gender_ID" SelectedValue='<%# Bind("Gender_ID", "{0}") %>'
                        Width="176px">
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Refid" HeaderText="Refid" InsertVisible="False" ReadOnly="True"
                SortExpression="Refid" Visible="False" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>

                          <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                DeleteCommand="DELETE FROM Test_RangeValues WHERE (Refid = @Refid)"
                ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" SelectCommand="SELECT Test_RangeValues.TCId, TestComponent.ComponentName, Test_RangeValues.StartValue, Test_RangeValues.EndValue, Test.TestName, Test.TID, Test_RangeValues.Refid, Gender.Gender, Gender.Gender_ID FROM Gender INNER JOIN Test_RangeValues ON Gender.Gender_ID = Test_RangeValues.Gender_ID LEFT OUTER JOIN TestComponent INNER JOIN Test ON TestComponent.TID = Test.TID ON Test_RangeValues.TCId = TestComponent.TCID WHERE (Test.TSGID = @tsgid)" UpdateCommand="UPDATE Test_RangeValues SET StartValue = @StartValue, EndValue = @EndValue WHERE (Refid = @Refid)">
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="GridView1" Name="Refid" PropertyName="SelectedValue" />
                            </DeleteParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownListSubGroup" Name="tsgid" PropertyName="SelectedValue" />
                            </SelectParameters>
                              <UpdateParameters>
                                  <asp:ControlParameter ControlID="HiddenFieldstartvalue" Name="StartValue" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HiddenFieldEndValue" Name="EndValue" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="GridView1" Name="Refid" PropertyName="SelectedValue" />
                              </UpdateParameters>
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceMGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>" SelectCommand="SELECT TGID, TGName FROM TestGroup" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" SelectCommand="SELECT TestName, TID FROM Test WHERE (TSGID = @tsgid) AND (TGID = @tgid)">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="DropDownListSubGroup" Name="tsgid" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="DropDownListMGroup" Name="tgid" PropertyName="SelectedValue" />
                              </SelectParameters>
                          </asp:SqlDataSource><asp:SqlDataSource ID="SqlDataSourceTestComponent" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" SelectCommand="SELECT TestComponent.TCID, TestComponent.ComponentName FROM TestComponent INNER JOIN Test ON TestComponent.TID = Test.TID WHERE (TestComponent.TID = @Tid) AND (Test.TSGID = @tsgid) AND (Test.TGID = @tgid)">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="DropDownListTest" Name="Tid" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="DropDownListSubGroup" Name="tsgid" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="DropDownListMGroup" Name="tgid" PropertyName="SelectedValue" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                              <asp:SqlDataSource ID="SqlDataSourceSubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>" SelectCommand="SELECT TSGID, TSGName FROM TestSubGroup WHERE (TGID = @tgid)" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>">
    <SelectParameters>
        <asp:ControlParameter ControlID="DropDownListMGroup" Name="tgid" PropertyName="SelectedValue" />
    </SelectParameters>
</asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>" InsertCommand="Insert_Test_RangeValues" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" InsertCommandType="StoredProcedure">
                            <InsertParameters>
                                <asp:ControlParameter ControlID="DropDownListTest" Name="TId" PropertyName="SelectedValue"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="DropDownListTestComponent" Name="TCId" PropertyName="SelectedValue"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="TextBoxStart" Name="StartValue" PropertyName="Text"
                                    Type="Double" />
                                <asp:ControlParameter ControlID="TextBoxEnd" Name="EndValue" PropertyName="Text"
                                    Type="Double" />
                                <asp:ControlParameter ControlID="DropDownList_Gender" Name="Gender_ID" PropertyName="SelectedValue"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="HiddenField_Age_Start" Name="Min_Age" PropertyName="Value"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="HiddenField_Age_End" Name="Max_Age" PropertyName="Value"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="HiddenField_Age_Start" Name="Age_Unit" PropertyName="Value"
                                    Type="String" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                              <asp:HiddenField ID="HiddenFieldstartvalue" runat="server" />
                              <asp:HiddenField ID="HiddenFieldEndValue" runat="server" />
    <asp:HiddenField ID="HiddenField_Age_Start" runat="server" />
    <asp:HiddenField ID="HiddenField_Age_End" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceGender" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
        ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>" SelectCommand="SELECT Gender_ID, Gender FROM Gender">
    </asp:SqlDataSource>


</div>

</form>
</body>
</html>