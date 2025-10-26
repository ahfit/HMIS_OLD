<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Admin_Test_Services.aspx.vb"
    MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Administrator_Admin_Test_Services" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="width: 100%" class="bxmain inner_content">
        <h2><span>Pathology Test Booking</span></h2>
        <div style="width: 99%">
            <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                <tr>
                    <td align="right" width="25%">
                        Main Group :
                    </td>
                    <td width="25%">
                        &nbsp;<asp:DropDownList ID="DropDownList_MGName" runat="server" DataSourceID="SqlDataSource_MG_Name"
                            DataTextField="TGName" DataValueField="TGID" AutoPostBack="True" Width="200px">
                        </asp:DropDownList>
                    </td>
                    <td align="right" width="25%">
                        <asp:TextBox ID="TextBox_Public_Price" CssClass="input_txt" runat="server" Visible="False"></asp:TextBox>
                    </td>
                    <td width="25%">
                        <asp:TextBox ID="TextBox_Private_Price" CssClass="input_txt" runat="server" Visible="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Name :
                    </td>
                    <td>
                        <asp:TextBox ID="TextBox_TBNAme" runat="server" CssClass="input_txt" Width="200px"></asp:TextBox>
                    </td>
                    <td align="right">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Services :
                    </td>
                    <td>
                        &nbsp;<asp:DropDownList ID="DropDownList_Service" runat="server" Width="200px" DataSourceID="SqlDataSource1"
                            DataTextField="S_Name" DataValueField="S_ID">
                        </asp:DropDownList>
                    </td>
                    <td align="right">
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div align="center">
            <asp:Button ID="Button_Save" runat="server" Text="Save" Width="88px" />&nbsp;</div>
        <hr />
        <div style="width: 100%; height: 864px; overflow: auto; overflow-x: hidden;">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TB_ID"
                DataSourceID="SqlDataSource_For_Grid" Width="100%" AutoGenerateEditButton="True"
                OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Height="72px">
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" Visible="false"/>
                    <asp:BoundField DataField="TB_Name" HeaderText="TB_Name" SortExpression="TB_Name" />
                    <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="TB_ID" Visible="False" />
                    <asp:BoundField DataField="TB_Code" HeaderText="TB_Code" SortExpression="TB_Code"
                        Visible="False" />
                    <asp:BoundField DataField="Specimen_Required_By_Test" HeaderText="Specimen_Required_By_Test"
                        SortExpression="Specimen_Required_By_Test" />
                    <asp:BoundField DataField="Test_Day" HeaderText="Test_Day" SortExpression="Test_Day"
                        Visible="False" />
                    <asp:BoundField DataField="Test_Time" HeaderText="Test_Time" SortExpression="Test_Time"
                        Visible="False" />
                    <asp:BoundField DataField="Collection_Time" HeaderText="Collection_Time" SortExpression="Collection_Time" />
                    <asp:BoundField DataField="Gender_Id" HeaderText="Gender_Id" SortExpression="Gender_Id"
                        Visible="False" />
                    <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                SelectCommand="SELECT S_ID, S_Name, S_Amount, S_Category FROM Admin_Services 
                    WHERE (S_Category IN (SELECT     distinct  Admin_Services.S_Category
					FROM         Admin_Services INNER JOIN
                      Test_Booking ON Admin_Services.S_ID = Test_Booking.S_Id))
order by  S_Name asc"></asp:SqlDataSource>
        </div>
        <hr />
        <asp:Label ID="Label_message" runat="server" CssClass="err"></asp:Label>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td valign="top" style="width: 18%; height: 200px">
                    <div class="bxmain" style="width: 54%;">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                            <tr>
                                <td align="right" width="25%">
                                    Main Group :
                                </td>
                                <td style="width: 29%">
                                    <asp:DropDownList ID="DropDownList_Assign_Group" runat="server" AutoPostBack="True"
                                        DataSourceID="SqlDataSource_MG_Name" DataTextField="TGName" DataValueField="TGID"
                                        OnSelectedIndexChanged="DropDownList_Assign_Group_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:TextBox ID="TextBox_TestNames" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br />
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div align="left">
                                <asp:CheckBoxList ID="CheckBoxList_Test" runat="server" DataSourceID="SqlDataSource_Test"
                                    DataTextField="TestName" CssClass="small_f" DataValueField="TID" RepeatColumns="2"
                                    RepeatDirection="Horizontal" Width="100%">
                                </asp:CheckBoxList>
                            </div>
                            <br />
                            <div align="center">
                                <asp:Button ID="Button1" runat="server" Text="Assign Test" /></div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <br />
                </td>
                <td valign="top" width="20%" style="height: 200px">
                    <div class="bxmain">
                        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                            <tr>
                                <td align="right" width="25%" style="height: 10px">
                                    Name :
                                </td>
                                <td width="25%" style="height: 10px">
                                    <asp:DropDownList ID="DropDownList_BName" runat="server" DataSourceID="SqlDataSource_BName"
                                        Width="280px" DataTextField="TB_Name" DataValueField="TB_ID" AutoPostBack="True">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    &nbsp;
                                </td>
                                <td>
                                    <asp:Button ID="Button_Refresh" runat="server" Text="Refresh" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br />
                    <asp:GridView ID="GridView_ServicesTest" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="Test_id,TB_ID" DataSourceID="SqlDataSource_TestServices" Width="98%">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr No.">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1%>
                                </ItemTemplate>
                                <ItemStyle Width="8%" />
                            </asp:TemplateField>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:BoundField DataField="Test_ID" HeaderText="Test_ID" SortExpression="Test_ID" />
                            <asp:BoundField DataField="TestName" HeaderText="TestName" SortExpression="TestName" />
                            <asp:BoundField DataField="ComponentName" HeaderText="ComponentName" SortExpression="ComponentName" />
                            <asp:BoundField DataField="TB_ID" HeaderText="TB_ID" SortExpression="TB_ID" />
                            <asp:TemplateField HeaderText="TCID" InsertVisible="False" SortExpression="TCID">
                                <EditItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("TCID") %>'></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("TCID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ranges">
                                <ItemTemplate>
                                    <asp:GridView ID="GridView_Ranges" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_ComponentGrid"
                                        DataKeyNames="Refid">
                                        <Columns>
                                            <asp:CommandField ShowDeleteButton="True" />
                                            <asp:BoundField DataField="StartValue" HeaderText="StartValue" SortExpression="StartValue" />
                                            <asp:BoundField DataField="EndValue" HeaderText="EndValue" SortExpression="EndValue" />
                                            <asp:BoundField DataField="Gender" HeaderText="Gender" ReadOnly="True" SortExpression="Gender" />
                                            <asp:BoundField DataField="MinAge" HeaderText="MinAge" ReadOnly="True" SortExpression="MinAge" />
                                            <asp:BoundField DataField="MaxAge" HeaderText="MaxAge" ReadOnly="True" SortExpression="MaxAge" />
                                            <asp:BoundField DataField="Report_Values" HeaderText="Report_Values" SortExpression="Report_Values" />
                                            <asp:BoundField DataField="Refid" HeaderText="Refid" InsertVisible="False" SortExpression="Refid" />
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="SqlDataSource_ComponentGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                                        DeleteCommand="DELETE FROM Test_RangeValues WHERE (Refid = @refid)" SelectCommand="SELECT StartValue, EndValue, CASE WHEN [Gender_Id] = 1 THEN 'Male' ELSE (CASE WHEN [Gender_Id] = 2 THEN 'Female' ELSE 'Both' END) END AS Gender, CASE WHEN [Min_Age] < 31 THEN CONVERT (varchar , [Min_Age]) + ' Day' ELSE (CASE WHEN [Min_Age] > 30 AND [Min_Age] < 365 THEN CONVERT (varchar , [Min_Age] / 30) + ' Month' ELSE CONVERT (varchar , [Min_Age] / 365) + ' Year' END) END AS MinAge, CASE WHEN [Max_Age] < 31 THEN CONVERT (varchar , [Max_Age]) + ' Day' ELSE (CASE WHEN [Max_Age] > 30 AND [Max_Age] < 365 THEN CONVERT (varchar , [Max_Age] / 30) + ' Month' ELSE CONVERT (varchar , [Max_Age] / 365) + ' Year' END) END AS MaxAge, Report_Values, Refid FROM Test_RangeValues WHERE (TCId = @TCID) ORDER BY Min_Age,[Gender_Id]  ">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="LabelComponentId" Name="TCID" PropertyName="Text" />
                                        </SelectParameters>
                                        <DeleteParameters>
                                            <asp:ControlParameter ControlID="GridView_Ranges" Name="refid" PropertyName="SelectedValue" />
                                        </DeleteParameters>
                                    </asp:SqlDataSource>
                                    <asp:Label ID="LabelComponentId" runat="server" Text='<%# Bind("TCID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <br />
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="HiddenField_TID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_BName" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT Test_Booking.TB_ID, Test_Booking.TB_Name FROM Test_Booking LEFT OUTER JOIN Admin_Services ON Test_Booking.S_Id = Admin_Services.S_ID WHERE (Test_Booking.MG_ID = @MG_ID) ORDER BY TB_Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Assign_Group" Name="MG_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_TestServices" runat="server" ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>"
        DeleteCommand="delete from Test_Services where Test_Services.Test_ID=@Test_Id and  Test_Services.TB_ID=@TB_Id"
        SelectCommand="SELECT     Test.TestName, Test_Services.Test_ID, Test_Services.TB_ID, TestComponent.ComponentName, TestComponent.TCID&#13;&#10;FROM         Test_Services INNER JOIN&#13;&#10;                      Test ON Test_Services.Test_ID = Test.TID INNER JOIN&#13;&#10;                      TestComponent ON Test.TID = TestComponent.TID&#13;&#10;WHERE     (Test_Services.TB_ID = @TB_Id)&#13;&#10;order by Test.TestName, TestComponent.ComponentName asc"
        UpdateCommand="update TestComponent set ComponentName=@ComponentName where TCID=@TCID">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_BName" Name="TB_Id" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView_ServicesTest" Name="Test_Id" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_Service" Name="TB_Id" PropertyName="SelectedValue" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ComponentName" />
            <asp:Parameter Name="TCID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_TName" runat="server" />
    <asp:HiddenField ID="HiddenField_TestName" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Test" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        InsertCommand="Insert_Test_Services" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>"
        SelectCommand="SELECT TestName, TID, TGID FROM Test WHERE (TGID = @TGID) and TestName like @TestName order by TestName"
        DeleteCommand="DELETE FROM Test_Services WHERE (Test_ID = @Test_ID) AND (TB_ID = @TB_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Assign_Group" Name="TGID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenField_TestName" Name="TestName" PropertyName="Value" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_TID" Name="Test_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_BName" Name="TB_ID" PropertyName="SelectedValue"
                Type="Int32" />
        </InsertParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_TID" Name="Test_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList_BName" Name="TB_ID" PropertyName="SelectedValue" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_MG_Name" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        InsertCommand="INSERT INTO Test_Booking(TB_Name, Private_Price, Public_Price, MG_ID,S_Id) VALUES (@TB_Name, @Private_Price, @Public_Price, @MG_ID,@S_Id)"
        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" SelectCommand="SELECT TGName, TGID FROM TestGroup">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_TBNAme" Name="TB_Name" PropertyName="Text" />
            <asp:Parameter DefaultValue="0" Name="Private_Price" />
            <asp:Parameter DefaultValue="0" Name="Public_Price" />
            <asp:ControlParameter ControlID="DropDownList_MGName" Name="MG_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_Service" Name="S_Id" PropertyName="SelectedValue" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_For_Grid" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" DeleteCommand="DELETE FROM Test_Booking WHERE (TB_ID = @TB_ID)"
        SelectCommand="SELECT Test_Booking.TB_Name, Test_Booking.TB_ID, Test_Booking.TB_Code, Test_Booking.Specimen_Required_By_Test, Test_Booking.Test_Day, Test_Booking.Test_Time, Test_Booking.Collection_Time, Gender.Gender, Test_Booking.Gender_Id FROM Test_Booking LEFT OUTER JOIN Gender ON Test_Booking.Gender_Id = Gender.Gender_ID WHERE (Test_Booking.MG_ID = @MG_ID) ORDER BY Test_Booking.TB_Name"
        UpdateCommand="UPDATE Test_Booking SET TB_Name = @TB_Name, Specimen_Required_By_Test =@Specimen_Required_By_Test ,Collection_Time =@Collection_Time   WHERE (TB_ID = @TB_ID)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView1" Name="TB_ID" PropertyName="SelectedValue" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="GridView1" Name="TB_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="GridView1" Name="TB_Name" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="GridView1" Name="Specimen_Required_By_Test" PropertyName="SelectedValue" />
             <asp:ControlParameter ControlID="GridView1" Name="Collection_Time" PropertyName="SelectedValue" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_MGName" Name="MG_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Private_fee" runat="server" />
    <asp:HiddenField ID="HiddenField_Public_Fee" runat="server" />
</asp:Content>
