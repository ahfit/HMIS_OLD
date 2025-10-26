<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Pathology_Update_Component_Max_length, App_Web_plqsd34j" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



 
<div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" >

                          <tr>
                            <td  align="right"  width="25%" >Main Group : </td>
                            <td  width="25%" ><asp:DropDownList AutoPostBack="True"  DataTextField="TGName" DataValueField="TGID" ID="DropDownListMGroup" runat="server"  DataSourceID="SqlDataSourceMGroup"> </asp:DropDownList></td>
                              <td align="right"  width="25%">Sub Group :</td>
                            <td   width="25%"><asp:DropDownList AutoPostBack="True"  DataTextField="TSGName" DataValueField="TSGID" ID="DropDownListSubGroup" runat="server"  DataSourceID="SqlDataSourceSubGroup">
                            </asp:DropDownList></td>
      </tr>
                            <tr>
                                <td align="right" >
                                    Test :</td>
              <td >
                                    <asp:DropDownList  DataTextField="TestName" DataValueField="TID" ID="DropDownListTest" runat="server" DataSourceID="SqlDataSourceTest" AutoPostBack="True">
                                    </asp:DropDownList></td>
                                <td align="right"  >
                                    </td>
                  <td  >
                                    </td>
                            </tr>
                    

                        </table></div><br />
                     <div align="center">   <asp:Button ID="ButtonSave" runat="server"  Text="Search"  />                                
                            <asp:Label CssClass="err" ID="Label1" runat="server" ></asp:Label></div><br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
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
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />

    </asp:GridView>

                          <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT     TestGroup.TGName, TestSubGroup.TSGName, Test.TestName, TestComponent.ComponentName, TestComponent.MaxLength, &#13;&#10;                      TestComponent.Min_Value, TestComponent.Max_Value, TestComponent.TCID, Test.TID&#13;&#10;FROM         TestComponent INNER JOIN&#13;&#10;                      Test ON TestComponent.TID = Test.TID INNER JOIN&#13;&#10;                      TestGroup ON Test.TGID = TestGroup.TGID INNER JOIN&#13;&#10;                      TestSubGroup ON Test.TSGID = TestSubGroup.TSGID&#13;&#10;WHERE     (Test.TID = @TID)" UpdateCommand="UPDATE TestComponent SET MaxLength = @MaxLength, Min_Value = @Min_Value, Max_Value = @Max_Value WHERE (TCID = @TCID)">
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
                          <asp:SqlDataSource ID="SqlDataSourceMGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" SelectCommand="SELECT TGID, TGName FROM TestGroup" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT TestName, TID FROM Test WHERE (TSGID = @tsgid) AND (TGID = @tgid)">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="DropDownListSubGroup" Name="tsgid" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="DropDownListMGroup" Name="tgid" PropertyName="SelectedValue" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                              <asp:SqlDataSource ID="SqlDataSourceSubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" SelectCommand="SELECT TSGID, TSGName FROM TestSubGroup WHERE (TGID = @tgid)" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>">
    <SelectParameters>
        <asp:ControlParameter ControlID="DropDownListMGroup" Name="tgid" PropertyName="SelectedValue" />
    </SelectParameters>
</asp:SqlDataSource>
                              <asp:HiddenField ID="HiddenFieldMaxLength" runat="server" />
                              <asp:HiddenField ID="HiddenFieldMaxValue" runat="server" />
    <asp:HiddenField ID="HiddenFieldMinValue" runat="server" />
<br />
<br />


  </asp:Content>