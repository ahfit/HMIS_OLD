<%@ page language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="Pathology_Administrator_Admin_MachineComponent, App_Web_zvadaqir" title="Untitled Page" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:Panel ID="PanelMenu" runat="server" Visible="false" > <asp:Label ID="LabelMenu" runat="server"></asp:Label></asp:Panel>


<asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label>

<div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" id="TABLE1" onclick="return TABLE1_onclick()">
                       
<tr>
                              <td align="right" style="width: 138px; height: 18px"   >Group : </td>
                              <td style="width: 143px; height: 18px" ><asp:DropDownList AutoPostBack="True"  DataTextField="TGName" DataValueField="TGID" ID="DropDownList_Group" runat="server"  DataSourceID="SqlDataSource_MainGroup" Width="216px"> </asp:DropDownList></td>
                              <td align="right" style="height: 18px; width: 38px;" ></td>
                              <td   width="25%" style="height: 18px"></td>
                            </tr>
                            <tr>
                              <td align="right" style="width: 138px"  >
                                  Component/Parameter Name : </td>
                              <td style="width: 143px"  >
                                  &nbsp;<asp:TextBox ID="TextBox_Name" runat="server" CssClass="input_txt" Width="208px"></asp:TextBox>
                              <asp:Button ID="ButtonSearch" runat="server" Text="Search" Width="88px" OnClick="ButtonSearch_Click" /></td>
                              <td  align="right" style="width: 38px"></td>
                              <td  ></td>
                            </tr>
    <tr>
        <td  align="right" style="width: 138px; height: 18px;" >
            Component/Parameters : 
        </td>
        <td style="width: 143px; height: 18px;"  >
                                  <asp:DropDownList ID="DropDownList_Component" runat="server"  AutoPostBack="True" DataSourceID="SqlDataSource_Component" DataTextField="ComponentName" DataValueField="TCID" Width="264px">
                                  </asp:DropDownList></td>
        <td style="height: 18px; width: 38px;"  >
        </td>
        <td style="height: 18px" >
                              </td>
    </tr>
    <tr>
        <td align="right" style="width: 138px; height: 18px">
            Lab Machines :</td>
        <td style="width: 143px; height: 18px">
            <asp:DropDownList ID="DropDownList_Machine" runat="server"  AutoPostBack="True" DataSourceID="SqlDataSource_LabMachines" DataTextField="Machine_Name" DataValueField="Machine_Id" Width="264px">
            </asp:DropDownList></td>
        <td style="height: 18px; width: 38px;">
        </td>
        <td style="height: 18px">
        </td>
    </tr>
    <tr>
        <td style="width: 138px; height: 18px; text-align: right" >
            Machine Component/Parameters :</td>
        <td style="width: 143px; height: 18px" >
            <asp:TextBox ID="TextBox_CompMachineName" runat="server" Width="168px"></asp:TextBox></td>
        <td style="height: 18px; width: 38px;" >
        </td>
        <td style="height: 18px" >
        </td>
    </tr>
    <tr>
        <td style="width: 138px; height: 18px; text-align: right">
            Machine Code :</td>
        <td style="width: 143px; height: 18px">
            <asp:TextBox ID="TextBox_Machine_Code" runat="server" CssClass="input_txt" Width="112px"></asp:TextBox></td>
        <td style="height: 18px; width: 38px;">
        </td>
        <td style="height: 18px">
        </td>
    </tr>
    <tr>
        <td style="width: 138px; height: 18px; text-align: right">
            Start Index :</td>
        <td style="width: 143px; height: 18px">
            &nbsp;<asp:TextBox ID="TextBox_StartIndex" runat="server" CssClass="input_txt" Width="112px"></asp:TextBox></td>
        <td style="height: 18px; width: 38px;">
            </td>
        <td style="height: 18px">
        </td>
    </tr>
    <tr>
        <td style="width: 138px; height: 18px; text-align: right">
            End Index :</td>
        <td style="width: 143px; height: 18px">
            &nbsp;<asp:TextBox ID="TextBox_EndIndex" runat="server" CssClass="input_txt" Width="112px"></asp:TextBox></td>
        <td style="height: 18px; width: 38px;">
            </td>
        <td style="height: 18px">
        </td>
    </tr>
    <tr>
        <td style="width: 138px; height: 18px; text-align: right">
        </td>
        <td style="width: 143px; height: 18px">
            <asp:TextBox ID="TextBox1" runat="server" CssClass="input_txt" Width="112px"></asp:TextBox></td>
        <td style="width: 38px; height: 18px">
        </td>
        <td style="height: 18px">
        </td>
    </tr>
    <tr>
        <td style="width: 138px; height: 18px; text-align: right">
        </td>
        <td style="width: 143px; height: 18px">
            <asp:CheckBox ID="CheckBox_Calculated" runat="server" /></td>
        <td style="width: 38px; height: 18px">
        </td>
        <td style="height: 18px">
        </td>
    </tr>
    <tr>
        <td style="width: 138px; height: 18px; text-align: right">
        </td>
        <td style="width: 143px; height: 18px">
            <asp:Button ID="ButtonSave" runat="server" Text="Save New" /></td>
        <td style="width: 38px; height: 18px">
            Lab Order Components<br />
            <br />
            <br />
            <br />
            <br />
            <br />
        </td>
        <td style="height: 18px">
            <asp:TextBox ID="TextBox_Services" runat="server"></asp:TextBox>&nbsp;
            <asp:Button ID="ButtonSearchServices" runat="server" Text="Search" />
            <asp:DropDownList AutoPostBack="True"  DataTextField="TB_Name2" DataValueField="TB_ID" ID="DropDownList_Services" runat="server"  DataSourceID="SqlDataSource_AdminServices" Width="264px">
            </asp:DropDownList>
            <asp:DropDownList ID="DropDownList1" runat="server" Width="80px">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="S1">S1-Serum/Plasma</asp:ListItem>
                <asp:ListItem Value="S2">S2-Urine</asp:ListItem>
                <asp:ListItem Value="S3">S3-CSF</asp:ListItem>
                <asp:ListItem Value="S4">S4-Suprnt</asp:ListItem>
                <asp:ListItem Value="S5">S5-Others</asp:ListItem>
            </asp:DropDownList>
            <asp:HiddenField ID="HiddenField_Services" runat="server" />
        </td>
    </tr>
    <tr>
        <td colspan="2" style="height: 18px; text-align: right">
    <asp:GridView ID="GridView_LabComp" runat="server" AutoGenerateColumns="False" DataKeyNames="Lab_M_Id"
        DataSourceID="SqlDataSource_ComponetGrid" Width="488px">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" />
            <asp:BoundField DataField="TCID" HeaderText="TCID" InsertVisible="False" ReadOnly="True"
                SortExpression="TCID" />
            <asp:BoundField DataField="ComponentName" HeaderText="ComponentName" SortExpression="ComponentName" />
            <asp:BoundField DataField="start_index" HeaderText="start_index" SortExpression="start_index" />
            <asp:BoundField DataField="End_index" HeaderText="End_index" SortExpression="End_index" />
            <asp:BoundField DataField="Machine_Comp_Name" HeaderText="Machine_Comp_Name" SortExpression="Machine_Comp_Name" />
            <asp:BoundField DataField="Machine_Test_Code" HeaderText="Machine_Test_Code" SortExpression="Machine_Test_Code" />
            <asp:TemplateField HeaderText="Lab_M_Id" InsertVisible="False" SortExpression="Lab_M_Id">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Lab_M_Id") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label_M_Lab_Id" runat="server" Text='<%# Bind("Lab_M_Id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    &nbsp;<asp:CheckBox ID="CheckBox_TestComponent" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
        </td>
        <td style="width: 38px; height: 18px">
            &nbsp;<asp:Button ID="Button_ServiceTestComp" runat="server" Text=">>" Width="56px" />
            <asp:HiddenField ID="HiddenField_MachineComp_Id" runat="server" />
        </td>
        <td style="height: 18px">
            <asp:GridView ID="GridView_ServiceComp" runat="server" AutoGenerateColumns="False"
                DataKeyNames="Lab_M_Id,TB_ID" DataSourceID="SqlDataSource_ServiceTestComp" Height="136px"
                Width="264px">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" />
                    <asp:BoundField DataField="ComponentName" HeaderText="ComponentName" SortExpression="ComponentName" />
                    <asp:BoundField DataField="Sample_Type" HeaderText="Sample_Type" SortExpression="Sample_Type" />
                    <asp:BoundField DataField="Lab_M_Id" HeaderText="Lab_M_Id" ReadOnly="True" SortExpression="Lab_M_Id" />
                    <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" ReadOnly="True" SortExpression="TB_ID" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource_AdminServices" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                SelectCommand="SELECT Test_Booking.TB_ID, Test_Booking.TB_Name + '-----' + TestGroup.TGName  as TB_Name2  FROM Test_Booking INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID&#13;&#10;where Test_Booking.TB_Name  like  @TBName&#13;&#10;order by Test_Booking.TB_Name  asc">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField_Services" Name="TBName" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource_ServiceTestComp" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                DeleteCommand="DELETE FROM Lab_Machine_TestServices WHERE (Lab_M_Id = @Lab_M_Id) AND (TB_ID = @TB_Id)"
                InsertCommand="INSERT INTO Lab_Machine_TestServices(Lab_M_Id, TB_ID, Sample_Type) VALUES (@Lab_M_Id, @TB_ID, @Sample_Type)"
                SelectCommand="SELECT TestComponent.ComponentName, Lab_Machine_TestServices.Sample_Type, Lab_Machine_TestServices.Lab_M_Id, Lab_Machine_TestServices.TB_ID FROM Lab_Machine_TestServices INNER JOIN Lab_Machine_Tests ON Lab_Machine_TestServices.Lab_M_Id = Lab_Machine_Tests.Lab_M_Id INNER JOIN TestComponent ON Lab_Machine_Tests.Component_Id = TestComponent.TCID&#13;&#10;where Lab_Machine_TestServices.TB_ID=@TB_ID">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="GridView_ServiceComp" Name="Lab_M_Id" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="GridView_ServiceComp" Name="TB_Id" PropertyName="SelectedValue" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="HiddenField_MachineComp_Id" Name="Lab_M_Id" PropertyName="Value" />
                    <asp:ControlParameter ControlID="DropDownList_Services" Name="TB_ID" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList1" Name="Sample_Type" PropertyName="SelectedValue" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList_Services" Name="TB_ID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
   
    </table>
    <asp:SqlDataSource ID="SqlDataSource_ComponetGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        DeleteCommand="delete from Lab_Machine_Tests where lab_M_Id=@lab_M_Id" SelectCommand="SELECT TestComponent.TCID, TestComponent.ComponentName, Lab_Machine_Tests.start_index, Lab_Machine_Tests.End_index, Lab_Machine_Tests.Machine_Comp_Name, Lab_Machine_Tests.Machine_Test_Code, Lab_Machine_Tests.Lab_M_Id FROM TestComponent INNER JOIN Lab_Machine_Tests ON TestComponent.TCID = Lab_Machine_Tests.Component_Id WHERE (Lab_Machine_Tests.Machine_Id = @Machine_Id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Machine" Name="Machine_Id" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView_LabComp" Name="lab_M_Id" PropertyName="SelectedValue" />
        </DeleteParameters>
    </asp:SqlDataSource>
</div><br />
    &nbsp;<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                  <!--DWLayoutTable-->
                  <tr>
                    <td  width="50%" valign="top">
                        &nbsp;
                    </td>
                              
                              <td width="50%" valign="top">
                                  &nbsp;</td>
      </tr>
                  
    </table>
    <asp:HiddenField ID="HiddenField_ComponentName" runat="server" />
    &nbsp; &nbsp;&nbsp;
   
                <asp:SqlDataSource ID="SqlDataSource_MainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="Select_Group" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    &nbsp;
                <asp:SqlDataSource ID="SqlDataSource_Component" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="SELECT TCID, ComponentName  FROM TestComponent where TGID =@TGID  and ComponentName  like @ComponentName   order by ComponentName  asc" InsertCommand="INSERT INTO Lab_Machine_Tests(Component_Id, Machine_Id, start_index, End_index, Machine_Comp_Name, Active_Status, Machine_Test_Code) VALUES (@Component_Id, @Machine_Id, @start_index, @End_index, @Machine_Comp_Name, @Active_Status,@Machine_Test_Code)">
                  <SelectParameters>
                      <asp:ControlParameter ControlID="DropDownList_Group" DefaultValue="%" Name="TGID"
                          PropertyName="SelectedValue" />
                      <asp:ControlParameter DefaultValue="%" Name="ComponentName" ControlID="HiddenField_ComponentName" PropertyName="Value" />
                  </SelectParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="DropDownList_Component" Name="Component_Id" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DropDownList_Machine" Name="Machine_Id" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="TextBox_StartIndex" Name="start_index" PropertyName="Text" />
                        <asp:ControlParameter ControlID="TextBox_EndIndex" Name="End_index" PropertyName="Text" />
                        <asp:ControlParameter ControlID="TextBox_CompMachineName" Name="Machine_Comp_Name"
                            PropertyName="Text" />
                        <asp:Parameter DefaultValue="1" Name="Active_Status" />
                        <asp:ControlParameter ControlID="TextBox_Machine_Code" Name="Machine_Test_Code" PropertyName="Text" />
                    </InsertParameters>
                </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_LabMachines" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        SelectCommand="SELECT [Machine_Id], [Machine_Name] FROM [Lab_Machines]"></asp:SqlDataSource>
   <br />
<br />
  </asp:Content>
