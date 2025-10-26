<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Pathology_Administrator_Admin_ComponentValue_Transfer, App_Web_plqsd34j" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



 
<asp:Panel ID="PanelMenu" runat="server" Visible="false" > <asp:Label ID="LabelMenu" runat="server"></asp:Label></asp:Panel>


<asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label>

<div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" id="TABLE1" onclick="return TABLE1_onclick()">
                       
<tr>
                              <td align="right" width="25%"   >Group : </td>
                              <td  width="25%" ><asp:DropDownList AutoPostBack="True"  DataTextField="TGName" DataValueField="TGID" ID="DropDownList_Group" runat="server"  DataSourceID="SqlDataSource_MainGroup"> </asp:DropDownList></td>
                              <td align="right" width="25%" >Main Group Part :</td>
                              <td   width="25%"><asp:DropDownList AutoPostBack="True"  DataTextField="TGName" DataValueField="TGID" ID="DropDownList_MainGroup2" runat="server" DataSourceID="SqlDataSource_MainGroup">
                              </asp:DropDownList></td>
                            </tr>
                            <tr>
                              <td align="right"    >
                              Sub Group :</td>
                                <td   >
                                    <asp:DropDownList ID="DropDownList_SubGroup" runat="server" AutoPostBack="True" 
                                        DataSourceID="SqlDataSource_SubGroup" DataTextField="TSGName" DataValueField="TSGID"
                                        >
                                    </asp:DropDownList></td>
                                <td align="right"  >
                            Element Group :</td>
                                <td  >
                                    <asp:DropDownList AutoPostBack="True"  DataTextField="TSGName" DataValueField="TSGID" ID="DropDownList_SGroup2" runat="server"  DataSourceID="SqlDataSource_SGroup">                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                              <td align="right" >Test : </td>
                              <td  >
                                  <asp:DropDownList ID="DropDownList_Test" runat="server" DataSourceID="SqlDataSource_Test" DataTextField="TestName" DataValueField="TID" AutoPostBack="True">
                                  </asp:DropDownList></td>
                              <td align="right" >Element Name :</td>
                              <td >
                                  <asp:DropDownList ID="DropDownList_Test2" runat="server" DataSourceID="SqlDataSource_Test2"
                                      DataTextField="TestName" DataValueField="TID"  AutoPostBack="True">
                                  </asp:DropDownList></td>
                            </tr>
                            <tr>
                              <td align="right"  >
                                  Element Value : </td>
                              <td  >
                                  <asp:DropDownList ID="DropDownList_Component" runat="server"  AutoPostBack="True" DataSourceID="SqlDataSource_Component" DataTextField="ComponentName" DataValueField="TCID">
                                  </asp:DropDownList></td>
                              <td  align="right">
                                  Element Value :
                              </td>
                              <td  ><asp:DropDownList ID="DropDownList_Component2" runat="server" DataSourceID="SqlDataSource_Component2" DataTextField="ComponentName" DataValueField="TCID" >
                              </asp:DropDownList></td>
                            </tr>
    <tr>
        <td  align="right" >Value : 
        </td>
        <td  >
            <asp:TextBox ID="TextBox_Value" runat="server"  CssClass="input_txt"></asp:TextBox></td>
        <td  >
        </td>
        <td >
                              <asp:Button  ID="ButtonRefresh" runat="server" Text="search" /></td>
    </tr>
    <tr>
        <td >
        </td>
        <td >
                <asp:Button ID="ButtonSave" runat="server" Text="Save New" /></td>
        <td ><asp:Button ID="Button_save" runat="server" Text="« Transfer" />        
        </td>
        <td >
        </td>
    </tr>
   
    </table></div><br />

<asp:Label ID="Label1" runat="server" CssClass="red"></asp:Label>

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                  <!--DWLayoutTable-->
                  <tr>
                    <td  width="50%" valign="top">
                      <asp:GridView ID="GridViewElementValues" runat="server" AutoGenerateColumns="False" DataKeyNames="TC_Value_ID" DataSourceID="SqlDataSourceForGrid" Width="100%" >
                        <FooterStyle CssClass="GridPager" />                      
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="TC_Value_ID" HeaderText="TC_Value_ID" InsertVisible="False"
                                SortExpression="TC_Value_ID" />
                            <asp:BoundField DataField="ComponentName" HeaderText="ComponentName" SortExpression="ComponentName" />
                            <asp:BoundField DataField="TC_Value" HeaderText="Test Component Value" SortExpression="TC_Value" />
                        </Columns>
                        <RowStyle CssClass="GridItem" />
                        <HeaderStyle CssClass="GridHeader" />                      
                        <AlternatingRowStyle CssClass="GridAltItem" />
                      </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource_SGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                            SelectCommand="Select_SubGroup" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList_MainGroup2" Name="tgid" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                              
                              <td width="50%" valign="top">
                                  <asp:GridView ID="GridView_Transfer" runat="server" AutoGenerateColumns="False" DataKeyNames="TC_Value_ID" DataSourceID="SqlDataSource_Grid2" Width="100%" >
                                      <FooterStyle CssClass="GridPager" />
                                      <Columns>
                                          <asp:BoundField DataField="TC_Value_ID" HeaderText="TC_Value_ID" InsertVisible="False"
                                SortExpression="TC_Value_ID" />
                                          <asp:BoundField DataField="ComponentName" HeaderText="ComponentName" SortExpression="ComponentName" />
                                          <asp:BoundField DataField="TC_Value" HeaderText="Test Component Value" SortExpression="TC_Value" />
                                          <asp:TemplateField>
                                              <ItemTemplate>
                                                  <asp:CheckBox ID="CheckBox1" runat="server" />
                                              </ItemTemplate>
                                          </asp:TemplateField>
                                      </Columns>
                                      <RowStyle CssClass="GridItem" />
                                      <HeaderStyle CssClass="GridHeader" />
                                      <AlternatingRowStyle CssClass="GridAltItem" />
                                  </asp:GridView>
                </td>
      </tr>
                  
    </table>

<asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" SelectCommand="SELECT TestComponent.ComponentName, TestComponent.TCID, TestComponent_Value.TC_Value_ID, TestComponent_Value.TC_Value FROM TestComponent INNER JOIN TestComponent_Value ON TestComponent.TCID = TestComponent_Value.TCID WHERE (TestComponent.TCID = @TCID)" UpdateCommand="UPDATE TestComponent_Value SET TC_Value = @TC_Value WHERE (TC_Value_ID = @TC_Value_ID)" DeleteCommand="DELETE FROM TestComponent_Value WHERE (TC_Value_ID = @TC_Value_ID)"><UpdateParameters>
    <asp:ControlParameter ControlID="GridViewElementValues" Name="TC_Value" PropertyName="SelectedValue" />
    <asp:ControlParameter ControlID="GridViewElementValues" Name="TC_Value_ID" PropertyName="SelectedValue" />
</UpdateParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="DropDownList_Component" Name="TCID" PropertyName="SelectedValue" />
    </SelectParameters>
    <DeleteParameters>
        <asp:ControlParameter ControlID="GridViewElementValues" Name="TC_Value_ID" PropertyName="SelectedValue" />
    </DeleteParameters>
</asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Component_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Test2" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        SelectCommand="Select_test" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_SGroup2" Name="tsgid" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource><asp:SqlDataSource ID="SqlDataSource_Grid2" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" SelectCommand="SELECT TestComponent.ComponentName, TestComponent.TCID, TestComponent_Value.TC_Value_ID, TestComponent_Value.TC_Value FROM TestComponent INNER JOIN TestComponent_Value ON TestComponent.TCID = TestComponent_Value.TCID WHERE (TestComponent.TCID = @TCID)" UpdateCommand="UPDATE TestComponent_Value SET TC_Value = @TC_Value WHERE (TC_Value_ID = @TC_Value_ID)" InsertCommand="INSERT INTO TestComponent_Value(TC_Value, TCID) VALUES (@TC_Value, @TCID)">
        <UpdateParameters>
            <asp:ControlParameter ControlID="GridViewElementValues" Name="TC_Value" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="GridViewElementValues" Name="TC_Value_ID" PropertyName="SelectedValue" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Component2" Name="TCID" PropertyName="SelectedValue" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_Value" Name="TC_Value" PropertyName="Text" />
            <asp:ControlParameter ControlID="DropDownList_Component" Name="TCID" PropertyName="SelectedValue" />
        </InsertParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSource_Test" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="Select_test"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_SubGroup" Name="tsgid" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_SubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="Select_SubGroup"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Group" Name="tgid" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
   
    <asp:HiddenField ID="HiddenField_Component_Value" runat="server" />
   
                <asp:SqlDataSource ID="SqlDataSource_MainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="Select_Group" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_Component2" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="Select_Component" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_Test2" Name="tid" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList_MainGroup2" Name="tgid" PropertyName="SelectedValue"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_Component" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="Select_Component" SelectCommandType="StoredProcedure">
                  <SelectParameters>
                      <asp:ControlParameter ControlID="DropDownList_Test" Name="tid" PropertyName="SelectedValue"
                          Type="Int32" />
                      <asp:ControlParameter ControlID="DropDownList_Group" Name="tgid" PropertyName="SelectedValue"
                          Type="Int32" />
                  </SelectParameters>
                </asp:SqlDataSource>
   <br />
<br />
  </asp:Content>