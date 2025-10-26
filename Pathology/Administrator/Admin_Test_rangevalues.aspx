<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_Test_rangevalues, App_Web_plqsd34j" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
 <%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
  <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  
  
  
<script type="text/javascript"> $(document).ready(function(){ $('.Grid_1 tr').click(function() { $('.Grid_1 tr').removeClass('gridedit'); $(this).addClass('gridedit');	}); });</script> 
  
  <style type="text/css">
  
  .Grid_1 td input {width:100%;}
   .Grid_1 td input:focus {width:100%;}
  </style>
  
  
  
  </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <br />



  <div class="bxmain">
  
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" >
      <tr>
        <td align="right"   >Main Group : </td>
        <td width="25%">
            <asp:UpdatePanel id="UpdatePanel1" runat="server">
                <contenttemplate><asp:DropDownList AutoPostBack="True"  DataTextField="TGName" DataValueField="TGID" ID="DropDownListMGroup" runat="server" DataSourceID="SqlDataSourceMGroup"> </asp:DropDownList>
</contenttemplate>
            </asp:UpdatePanel></td>
        <td width="25%" align="right"  >Sub Group :</td>
        <td width="25%"  >
            <asp:UpdatePanel id="UpdatePanel2" runat="server">
                <contenttemplate><asp:DropDownList AutoPostBack="True"  DataTextField="TSGName" DataValueField="TSGID" ID="DropDownListSubGroup" runat="server" DataSourceID="SqlDataSourceSubGroup"> </asp:DropDownList>
</contenttemplate>
            </asp:UpdatePanel></td>
      </tr>
      <tr>
        <td align="right"  > Test :</td>
        <td  >
            <asp:UpdatePanel id="UpdatePanel3" runat="server">
                <contenttemplate><asp:DropDownList  DataTextField="TestName" DataValueField="TID" ID="DropDownListTest" runat="server"  DataSourceID="SqlDataSourceTest" AutoPostBack="True"  > </asp:DropDownList>
</contenttemplate>
            </asp:UpdatePanel></td>
        <td align="right"  > Test Component : </td>
        <td  >
            <asp:UpdatePanel id="UpdatePanel4" runat="server">
                <contenttemplate>
                 <asp:TextBox id="TextBox_test_com" runat="server" AutoPostBack="True" OnTextChanged="TextBox_test_com_TextChanged" Width="100px"></asp:TextBox> 
  <asp:DropDownList  DataTextField="ComponentName" DataValueField="TCID" ID="DropDownListTestComponent" runat="server"  DataSourceID="SqlDataSourceTestComponent" AutoPostBack="True" Width="97px"> </asp:DropDownList> 




</contenttemplate>
            </asp:UpdatePanel></td>
      </tr>
      <tr>
        <td align="right"    > Start Value :</td>
        <td ><asp:TextBox ID="TextBoxStart" runat="server"  CssClass="input_txt"></asp:TextBox></td>
        <td align="right"   > End Value :</td>
        <td   ><asp:TextBox ID="TextBoxEnd" runat="server" CssClass="input_txt" ></asp:TextBox></td>
      </tr>
        <tr>
            <td align="right" >
                Report Values :</td>
            <td>
                <asp:TextBox ID="TextBox_Report_value" runat="server" CssClass="input_txt"></asp:TextBox></td>
            <td align="right">
            </td>
            <td>
            </td>
        </tr>
      <tr>
        <td align="right"   > Gender : </td>
        <td  ><asp:DropDownList ID="DropDownList_Gender" runat="server" Width="102px"  DataSourceID="SqlDataSourceGender" DataTextField="Gender" DataValueField="Gender_ID"> </asp:DropDownList></td>
        <td align="right"  > Age Start :</td>
        <td  ><asp:TextBox ID="TextBox_Age_Start" runat="server" CssClass="input_txt" Width="100px"></asp:TextBox>
          <asp:DropDownList
                ID="DropDownList_Age_Start" runat="server" Width="75px">
            <asp:ListItem Value="365">Year</asp:ListItem>
            <asp:ListItem Value="30">Month</asp:ListItem>
            <asp:ListItem Value="1">Day</asp:ListItem>
          </asp:DropDownList></td>
      </tr>
      <tr>
        <td align="right"   > Age End :</td>
        <td  ><asp:TextBox ID="TextBox_Age_End" runat="server" Width="100px" CssClass="input_txt"></asp:TextBox>
          <asp:DropDownList
                ID="DropDownList_Age_End" runat="server" Width="97px">
            <asp:ListItem Value="365">Year</asp:ListItem>
            <asp:ListItem Value="30">Month</asp:ListItem>
            <asp:ListItem Value="1">Day</asp:ListItem>
          </asp:DropDownList></td>
        <td align="right"  >
            Condition :</td>
        <td  ><asp:DropDownList  DataTextField="Condition_Name" DataValueField="Condition_ID" ID="DropDownList1" runat="server"  DataSourceID="SqlDataSource_Condition" Width="183px">
        </asp:DropDownList>
            <asp:LinkButton ID="LinkButton_Condition_new" runat="server" CssClass="add_icon">New</asp:LinkButton></td>
      </tr>
        <tr>
            <td align="right" >
        Unit : </td>
            <td>
                <asp:UpdatePanel id="UpdatePanel5" runat="server">
                    <contenttemplate>
                <asp:DropDownList ID="DropDownListUnit" runat="server" DataSourceID="SqlDataSourceUnit"
                    DataTextField="TUnitName" DataValueField="TMUnitID"  >
                </asp:DropDownList>
</contenttemplate>
                </asp:UpdatePanel>
                <asp:LinkButton ID="LinkButton_add_conversion_rate" runat="server" CssClass="add_icon">Add Conversion Rate</asp:LinkButton></td>
            <td align="right">
            </td>
            <td>
            </td>
        </tr>
  </table></div>
    <br />
    <div align="center">
      <asp:Button ID="ButtonSave" runat="server" Text="Save"  />
      <asp:Button
                    ID="Buttonrefresh" runat="server" Text="Refresh"  />
        <asp:Button ID="btn_search" runat="server" Text="Search" />
      <asp:Label CssClass="err" ID="Label1" runat="server" ></asp:Label>
    </div>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="Refid" DataSourceID="SqlDataSourceForGridView" Width="100%">
     
      <Columns>
          <asp:TemplateField ShowHeader="False">
              <EditItemTemplate>
                  <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" Width="16px" Height="16px" ImageUrl="~/images_hacims/icon_ok.gif"
                      ToolTip="Update" /><asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel"
                          ImageUrl="~/images_hacims/icon_err.gif" Width="14px" Height="15px" ToolTip="Cancel" />
              </EditItemTemplate>
              <ItemTemplate>
                   <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" Width="16px" Height="16px" ImageUrl="~/images_hacims/icon_edit.gif"
                      OnClientClick="return confirmation_edit(this)" ToolTip="Edit" /><asp:ImageButton
                          ID="ImageButton2" runat="server" CommandName="Delete" Width="16px" Height="16px" ImageUrl="~/images_hacims/icon_delete.gif"
                          OnClientClick="return confirmation(this)" ToolTip="Delete" />
              </ItemTemplate>
          </asp:TemplateField>
      <asp:BoundField DataField="TestName" HeaderText="TestName" ReadOnly="True" SortExpression="TestName" >
          <ControlStyle  />
          <ItemStyle />
      </asp:BoundField>
          <asp:BoundField DataField="ComponentName" HeaderText="Component Name" ReadOnly="True"
              SortExpression="ComponentName" >
              <ControlStyle  />
              <ItemStyle   />
          </asp:BoundField>
      <asp:BoundField DataField="StartValue" HeaderText="StartValue" 
              SortExpression="StartValue" >
          <ControlStyle   />
          </asp:BoundField>
      <asp:BoundField DataField="EndValue" HeaderText="EndValue" 
              SortExpression="EndValue" >
          <ControlStyle />
          </asp:BoundField>
          <asp:TemplateField HeaderText="Report Values" SortExpression="Report_Values">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Report_Values") %>' TextMode="MultiLine"
                      ></asp:TextBox>
              </EditItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label2" runat="server" Text='<%# Bind("Report_Values") %>'></asp:Label>
              </ItemTemplate>
              <ControlStyle  />
          </asp:TemplateField>
      <asp:TemplateField HeaderText="Gender" SortExpression="Gender">
        <EditItemTemplate>
          <asp:DropDownList ID="DropDownListGender" runat="server" DataSourceID="SqlDataSourceGender"
                        DataTextField="Gender" DataValueField="Gender_ID" SelectedValue='<%# Bind("Gender_ID", "{0}") %>'
                         > </asp:DropDownList>
        </EditItemTemplate>
        <ItemTemplate>
          <asp:Label ID="Label1" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
        </ItemTemplate>
          <ControlStyle />
      </asp:TemplateField>
      <asp:BoundField DataField="Refid" HeaderText="Refid" InsertVisible="False" ReadOnly="True"
                SortExpression="Refid" Visible="False" >
          <ControlStyle  />
          </asp:BoundField>
          <asp:TemplateField HeaderText="Min_Age" SortExpression="Min_Age">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Min_Age") %>'></asp:TextBox>
              </EditItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label3" runat="server" Text='<%# Eval("Min_Age1", "{0}") %>'></asp:Label>
              </ItemTemplate>
              <ControlStyle  />
              <ItemStyle />
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Max_Age" SortExpression="Max_Age">
              <EditItemTemplate>
                  <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Max_Age") %>'></asp:TextBox>
              </EditItemTemplate>
              <ItemTemplate>
                  <asp:Label ID="Label4" runat="server" Text='<%# Bind("Max_Age1", "{0}") %>'></asp:Label>
              </ItemTemplate>
              <ControlStyle   />
              <ItemStyle   />
          </asp:TemplateField>
          <asp:BoundField DataField="Expr1" HeaderText="Expr1" InsertVisible="False" 
              SortExpression="Expr1" ReadOnly="True" Visible="False" >
              <ControlStyle  />
          </asp:BoundField>
      </Columns>
      <RowStyle CssClass="GridItem" />
      <FooterStyle CssClass="GridPager" />
      <SelectedRowStyle CssClass="gridselect" />     
      <HeaderStyle CssClass="GridHeader" />
      <EditRowStyle CssClass="gridedit" />
      <AlternatingRowStyle CssClass="GridAltItem" />
      
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                DeleteCommand="DELETE FROM Test_RangeValues WHERE (Refid = @Refid)"
                ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" 
        SelectCommand="supSearchTest" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE Test_RangeValues SET StartValue = @StartValue, EndValue = @EndValue, Report_Values = @Report_Values, Min_Age = @Min_Age, Max_Age = @Max_Age, Gender_Id =@Gender_Id  WHERE (Refid = @Refid)">
      <DeleteParameters>
        <asp:ControlParameter ControlID="GridView1" Name="Refid" PropertyName="SelectedValue" />
      </DeleteParameters>
      <SelectParameters>
        <asp:ControlParameter ControlID="DropDownListMGroup"    Name="tgid" PropertyName="SelectedValue" />
      </SelectParameters>
      <UpdateParameters>
        <asp:ControlParameter ControlID="HiddenFieldstartvalue" Name="StartValue" PropertyName="Value" />
        <asp:ControlParameter ControlID="HiddenFieldEndValue" Name="EndValue" PropertyName="Value" />
        <asp:ControlParameter ControlID="GridView1" Name="Refid" PropertyName="SelectedValue" />
          <asp:ControlParameter ControlID="GridView1" Name="Report_Values" PropertyName="SelectedValue" />
          <asp:ControlParameter ControlID="GridView1" Name="Min_Age" PropertyName="SelectedValue" />
          <asp:ControlParameter ControlID="GridView1" Name="Max_Age" PropertyName="SelectedValue" />
          <asp:ControlParameter ControlID="HiddenField_GenderId" Name="Gender_Id" PropertyName="Value" />
      </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_GenderId" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceMGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" SelectCommand="SELECT '0' AS TGID, ' All' AS TGName UNION SELECT CONVERT (varchar, TGID) AS TGID, TGName FROM TestGroup ORDER BY TGName" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTest" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT '%' AS TID, 'All' AS TestName, '0' AS unit UNION SELECT CONVERT (varchar, TID) AS TID, TestName, '1' AS unit FROM Test WHERE (CONVERT (varchar, TSGID) LIKE @tsgid) AND (CONVERT (varchar, TGID) LIKE @tgid) ORDER BY unit, TestName">
      <SelectParameters>
        <asp:ControlParameter ControlID="DropDownListSubGroup" Name="tsgid" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="DropDownListMGroup" Name="tgid" PropertyName="SelectedValue" />
      </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTestComponent" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT '%' AS TCID, 'All' AS ComponentName, '0' AS unit UNION SELECT CONVERT (varchar, TestComponent.TCID) AS TCID, TestComponent.ComponentName, '1' AS unit FROM TestComponent INNER JOIN Test ON TestComponent.TID = Test.TID WHERE (CONVERT (varchar, TestComponent.TID) LIKE @Tid) AND (CONVERT (varchar, Test.TSGID) LIKE @tsgid) AND (CONVERT (varchar, Test.TGID) LIKE @tgid) AND (TestComponent.ComponentName LIKE '%' + @ComponentName + '%') ORDER BY unit, ComponentName" UpdateCommand="UPDATE TestComponent SET TMUnitID = @TMUnitID WHERE (TCID = @TCID)">
      <SelectParameters>
        <asp:ControlParameter ControlID="DropDownListTest" Name="Tid" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="DropDownListSubGroup" Name="tsgid" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="DropDownListMGroup" Name="tgid" PropertyName="SelectedValue" />
          <asp:ControlParameter ControlID="HiddenField_test_com" Name="ComponentName" PropertyName="Value" />
      </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="DropDownListUnit" Name="TMUnitID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenField_TCID" Name="TCID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSubGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" SelectCommand="SELECT '%' AS TSGID, 'All' AS TSGName, '0' AS unit UNION SELECT CONVERT (varchar, TSGID) AS TSGID, TSGName, '1' AS unit FROM TestSubGroup WHERE (CONVERT (varchar, TGID) LIKE @tgid) ORDER BY unit, TSGName" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>">
      <SelectParameters>
        <asp:ControlParameter ControlID="DropDownListMGroup" Name="tgid" PropertyName="SelectedValue" />
      </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" InsertCommand="Insert_Test_RangeValues" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" InsertCommandType="StoredProcedure">
      <InsertParameters>
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
          <asp:ControlParameter ControlID="TextBox_Report_value" Name="Report_Values" PropertyName="Text"
              Type="String" />
      </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldstartvalue" runat="server" />
    <asp:HiddenField ID="HiddenFieldEndValue" runat="server" />
    <asp:HiddenField ID="HiddenField_Age_Start" runat="server" />
    <asp:HiddenField ID="HiddenField_Age_End" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceGender" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT Gender_ID, Gender FROM Gender"> </asp:SqlDataSource><asp:SqlDataSource ID="SqlDataSource_Condition" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT [Condition_ID], [Condition_Name] FROM [Condition]" DeleteCommand="DELETE FROM [Condition] WHERE [Condition_ID] = @Condition_ID" InsertCommand="INSERT INTO [Condition] ([Condition_Name]) VALUES (@Condition_Name)" UpdateCommand="UPDATE [Condition] SET [Condition_Name] = @Condition_Name WHERE [Condition_ID] = @Condition_ID">
            <DeleteParameters>
                <asp:Parameter Name="Condition_ID" Type="Decimal" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Condition_Name" Type="String" />
                <asp:Parameter Name="Condition_ID" Type="Decimal" />
            </UpdateParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="TextBox_Condition" Name="Condition_Name" PropertyName="Text"
                    Type="String" />
            </InsertParameters>
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceUnit" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT [TMUnitID], [TUnitName] FROM [TestMUnit]">
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_TCID" runat="server" />
    <asp:HiddenField ID="HiddenField_test_com" runat="server" />
  
  
  
    <asp:Panel ID="Panel_Condition" runat="server" Width="100%" CssClass="lightbox_bg" Visible="False">
        <div class="lightbox">
          <div class="bxmain">
         <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
            <tr>
                <td align="right" width="40%" >
                    Condition :</td>
                <td >
                    <asp:TextBox ID="TextBox_Condition" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td >&nbsp;</td>
                <td ><asp:Button ID="Button_Condition_Save" runat="server" Text="Save" />                
                  <asp:Button ID="Button_Close" runat="server" Text="Close" /></td>
            </tr>
        </table></div>
        <br />
<div style="height:300px; overflow:auto; overflow-x:hidden; width:100%;">
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="Condition_ID" DataSourceID="SqlDataSource_Condition" Width="100%">
          
            <Columns>
                <asp:BoundField DataField="Condition_Name" HeaderText="Condition Name" SortExpression="Condition_Name" />
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            </Columns>
            <RowStyle CssClass="GridItem" />
<FooterStyle CssClass="GridPager" />
<SelectedRowStyle CssClass="gridselect" />     
<HeaderStyle CssClass="GridHeader" />
<EditRowStyle CssClass="gridedit" />
<AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
        </div>
        </div>
    </asp:Panel>
    
    
    
    
    
    <asp:Panel ID="Panel_Conversion" runat="server" Visible="False" CssClass="lightbox_bg">
    <div class="lightbox">
    <div class="bxmain">
  <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
            <tr>
                <td align="right" >
                    Unit : </td>
                <td >
                    <asp:DropDownList ID="DropDownList_Conversion_Unit" runat="server" DataSourceID="SqlDataSourceUnit"
                    DataTextField="TUnitName" DataValueField="TMUnitID"  >
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="right" >
                    Conversion Rate :</td>
                <td >
              <asp:TextBox ID="TextBox_Conversion_rate" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right" >
                    </td>
                <td >
              <asp:Button ID="Button_conversion_save" runat="server" Text="Save" /><asp:Button ID="Button_conversion_close" runat="server" Text="Close" /></td>
            </tr>
        </table></div>
        <asp:SqlDataSource ID="SqlDataSource_conversion" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>" SelectCommand="SELECT TMUnitID, TCID, Conversion_Rate FROM Conversion WHERE (CONVERT (varchar, TCID) LIKE @TCID)" DeleteCommand="DELETE FROM [Conversion] WHERE [TMUnitID] = @TMUnitID AND [TCID] = @TCID" InsertCommand="INSERT INTO [Conversion] ([TMUnitID], [TCID], [Conversion_Rate]) VALUES (@TMUnitID, @TCID, @Conversion_Rate)" UpdateCommand="UPDATE [Conversion] SET [Conversion_Rate] = @Conversion_Rate WHERE [TMUnitID] = @TMUnitID AND [TCID] = @TCID">
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenField_TCID" Name="TCID" PropertyName="Value" />
          </SelectParameters>
            <DeleteParameters>
                <asp:Parameter Name="TMUnitID" Type="Int32" />
                <asp:Parameter Name="TCID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Conversion_Rate" Type="Double" />
                <asp:Parameter Name="TMUnitID" Type="Int32" />
                <asp:Parameter Name="TCID" Type="Int32" />
            </UpdateParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="DropDownList_Conversion_Unit" Name="TMUnitID" PropertyName="SelectedValue"
                    Type="Int32" />
                <asp:ControlParameter ControlID="HiddenField_TCID" Name="TCID" PropertyName="Value"
                    Type="Int32" />
                <asp:ControlParameter ControlID="TextBox_Conversion_rate" Name="Conversion_Rate"
                    PropertyName="Text" Type="Double" />
            </InsertParameters>
      </asp:SqlDataSource>
      <br />

      <div style="height:300px; overflow:auto; overflow-x:hidden; width:100%;">
        <asp:GridView ID="GridView_conversion" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="TMUnitID,TCID" DataSourceID="SqlDataSource_conversion" Width="100%">
            <RowStyle CssClass="GridItem" />
            <Columns>
                <asp:BoundField DataField="Conversion_Rate" HeaderText="Conversion Rate" SortExpression="Conversion_Rate" />
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            </Columns>
            <FooterStyle CssClass="GridPager" />
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
        </div>
        </div>
    </asp:Panel>
  </asp:Content>