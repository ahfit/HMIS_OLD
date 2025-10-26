<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Admin_Holiday.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master"
    Inherits="Admin_Holiday" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .lightbox {
            background-color: #FFFFFF;
            border: 8px solid #000000;
            border-radius: 10px;
            display: block;
            height: 420px;
            left: 36%;
            margin: -220px 0 0 -250px;
            padding: 10px;
            position: absolute;
            top: 42%;
            width: 800px;
            z-index: 9999;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%">
        <div>
            <h2><span>Register Holiday </span></h2>
        </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="40%" align="right">Holiday Type :
                </td>
                <td>
                    <asp:RadioButtonList ID="RadioButton_RBL" runat="server" RepeatDirection="Horizontal"
                        AutoPostBack="True" RepeatLayout="Flow">
                        <asp:ListItem Value="WeekHoliday">Week Holiday</asp:ListItem>
                        <asp:ListItem Selected="True" Value="OtherHoliday">Other Holiday</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
                <td><strong> Select Year</strong> </td>
                <td>
                    <asp:DropDownList ID="ddlYear" runat="server" ></asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:Panel ID="pnl_WeekHoliday" runat="server" Visible="False" Width="100%">
        <div class="bxmain" style="width: 100%">
            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                <tr>
                    <td align="right">Select Week Days :
                    </td>
                    <td>
                        <asp:CheckBoxList ID="CBL_DaysOFWeek" runat="server" DataSourceID="SDC_WeekDays"
                            DataTextField="Day_Name" DataValueField="Day_Abbr" RepeatDirection="Horizontal">
                        </asp:CheckBoxList>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="40%">From :
                    </td>
                    <td>
                        <igsch:WebDateChooser ID="WDC_From" runat="server">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">To :
                    </td>
                    <td>
                        <igsch:WebDateChooser ID="WDC_TO" runat="server">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="4">
                        
            <asp:Button ID="btn_Save_WeekHolidays" runat="server" Text="Save" />
        
                    </td>
                </tr>
            </table>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="Grd_WeekHolidays" runat="server" AutoGenerateColumns="False" AllowSorting="true" DataKeyNames="Holiday_ID" CssClass="Grid_1"
                    Width="100%" DataSourceID="SDS_WeekHoliday">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="Holiday_Type_Name" HeaderText="Holidat Type" SortExpression="Holiday_Type_Name" />
                        <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                        <asp:BoundField DataField="HolidayDate" HeaderText="HolidayDate" ReadOnly="True"
                            SortExpression="HolidayDate" />
                        <asp:BoundField DataField="Day" HeaderText="Day" SortExpression="Day" />
                        <asp:BoundField DataField="Holiday_ID" HeaderText="Holiday_ID" InsertVisible="False"
                            ReadOnly="True" SortExpression="Holiday_ID" Visible="False" />
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <PagerStyle CssClass="GridPager" />
                </asp:GridView>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                            <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                            </span>
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:SqlDataSource ID="SDS_WeekHoliday" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            DeleteCommand="DELETE FROM Holiday&#13;&#10;WHERE     (Holiday_ID = @Holiday_ID)"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT     Holiday_Type.Holiday_Type_Name, Holiday.Description, CONVERT(varchar, Holiday.Holiday_Date, 103) AS HolidayDate, datename(weekday,Holiday.Holiday_Date) Day , Holiday.Holiday_ID&#13;&#10;FROM         Holiday INNER JOIN&#13;&#10;                      Holiday_Type ON Holiday.Holiday_Type_ID = Holiday_Type.Holiday_Type_Id&#13;&#10;WHERE     (Holiday_Type.Holiday_Type_Id = 2)&#13;&#10;ORDER BY Holiday.Holiday_Date&#13;&#10;&#13;&#10;">
            <DeleteParameters>
                <asp:Parameter Name="Holiday_ID" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDC_WeekDays" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT Day_Name, Day_Abbr FROM Week_Day"></asp:SqlDataSource>
        
    </asp:Panel>
    <asp:Panel ID="Pnl_Other_Holiday" runat="server" Width="100%">
        <div class="bxmain" style="width: 100%">
            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                <tr>
                    <td width="40%" align="right">Select Holiday :
                    </td>
                    <td>
                        <asp:DropDownList ID="DDL_Holiday" runat="server" DataSourceID="SDS_Holiday_Type"
                            DataTextField="Holiday_Type_Name" DataValueField="Holiday_Type_Id">
                        </asp:DropDownList>
                        &nbsp;<asp:LinkButton ID="LB_ADD" runat="server">Add Holiday</asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td align="right">Date :
                    </td>
                    <td>
                        <igsch:WebDateChooser ID="WDC_Date" runat="server">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                    <td align="right">Over Time :
                    </td>
                    <td>
                        <asp:CheckBox runat="server" ID="chkBoxDoubleOverTime" Checked="false" Text="Is Double OverTime"/>
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <asp:Button ID="btn_Save_OtherHolidays" CssClass="btn_hacims" runat="server" Text="Save" />
                    </td>
                </tr>
            </table>
        </div>
        <br />

        <br />
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
        <asp:GridView ID="GRD_Other_Holiday" runat="server" AutoGenerateColumns="False" AllowSorting="true" DataKeyNames="Holiday_ID" CssClass="Grid_1"
            Width="100%" DataSourceID="SDS_Other_Holiday">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" />
                <asp:BoundField DataField="Holiday_Type_Name" HeaderText="Holiday Name" SortExpression="Holiday_Type_Name" />
                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                <asp:BoundField DataField="HolidayDate" HeaderText="HolidayDate" ReadOnly="True"
                    SortExpression="HolidayDate" />
                <asp:BoundField DataField="Day" HeaderText="Day" ReadOnly="True" SortExpression="Day" />
                <asp:BoundField DataField="Holiday_ID" HeaderText="Holiday_ID" InsertVisible="False"
                    ReadOnly="True" SortExpression="Holiday_ID" Visible="False" />
                <%--<asp:TemplateField HeaderText="IsDoubleOverTime">
                    <ItemTemplate>
                         <asp:CheckBox runat="server" ID="chkBoxDoubleOverTime" Checked="false" />

                    </ItemTemplate>
                </asp:TemplateField>--%>
            </Columns>
            <RowStyle CssClass="GridItem" />
            <AlternatingRowStyle CssClass="GridAltItem" />
            <PagerStyle CssClass="GridPager" />
        </asp:GridView>
                    <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                        <ProgressTemplate>
                            <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                    <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                </span>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </ContentTemplate>
            </asp:UpdatePanel>
        <asp:SqlDataSource ID="SDS_Other_Holiday" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            DeleteCommand="DELETE FROM Holiday&#13;&#10;WHERE     (Holiday_ID = @Holiday_ID)"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT     Holiday_Type.Holiday_Type_Name, Holiday.Description, CONVERT(varchar, Holiday.Holiday_Date, 103) AS HolidayDate, datename(weekday,Holiday.Holiday_Date) Day , Holiday.Holiday_ID&#13;&#10;FROM         Holiday INNER JOIN&#13;&#10;                      Holiday_Type ON Holiday.Holiday_Type_ID = Holiday_Type.Holiday_Type_Id&#13;&#10;WHERE     (Holiday_Type.Holiday_Type_Id <> 2)">
            <DeleteParameters>
                <asp:Parameter Name="Holiday_ID" />
            </DeleteParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SDS_Holiday_Type" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="SELECT     Holiday_Type_Id, Holiday_Type_Name&#13;&#10;FROM         Holiday_Type&#13;&#10;where (Holiday_Type_Id <> 2)&#13;&#10;order by Holiday_Type_Name&#13;&#10;"
            DeleteCommand="DELETE FROM Holiday_Type WHERE (Holiday_Type_Id = @Holiday_Type_Id)">
            <DeleteParameters>
                <asp:Parameter Name="Holiday_Type_Id" />
            </DeleteParameters>
        </asp:SqlDataSource>
    </asp:Panel>
    <asp:Panel ID="pnl_Add_HolidayType" runat="server" Visible="false" Width="100%" CssClass="lightbox_bg">
        <div class="lightbox">
            <div class="bxmain">
                <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                    <tr>
                        <td width="40%"></td>
                        <td align="right">
                            <asp:ImageButton ID="IMG_Btn_Close" ImageUrl="~/images/icon_delete.gif" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Holiday Type :
                        </td>
                        <td>
                            <asp:TextBox ID="txt_Holiday_Type" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Abbreviation :
                        </td>
                        <td>
                            <asp:TextBox ID="Holiday_Add" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:Button ID="btn_SaveType" runat="server" Text="Save" />
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
            <asp:GridView ID="Grd_Holiday_Type" runat="server" AutoGenerateColumns="False" AllowSorting="true" Width="100%"
                DataSourceID="SDS_HolidayType_ForGrid" DataKeyNames="Holiday_Type_Id">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" />
                    <asp:TemplateField HeaderText="SrNo.">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1%>
                        </ItemTemplate>
                        <ItemStyle Width="8%" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="Holiday_Type_Id" HeaderText="Holiday_Type_Id" InsertVisible="False"
                        ReadOnly="True" SortExpression="Holiday_Type_Id" Visible="False" />
                    <asp:BoundField DataField="Holiday_Type_Name" HeaderText="Holiday_Type_Name" SortExpression="Holiday_Type_Name" />
                </Columns>
                <RowStyle CssClass="GridItem" />
                <AlternatingRowStyle CssClass="GridAltItem" />
                <PagerStyle CssClass="GridPager" />
            </asp:GridView>
            <asp:UpdateProgress ID="UpdateProgress3" runat="server">
                        <ProgressTemplate>
                            <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                    <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                </span>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:SqlDataSource ID="SDS_HolidayType_ForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                InsertCommand="INSERT INTO Holiday_Type&#13;&#10;                      (Holiday_Type_Name, Repeat_Every_Year,Holiday_Add)&#13;&#10;VALUES     (@Holiday_Type_Name, 1,@Holiday_Add)"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="SELECT     Holiday_Type_Id, Holiday_Type_Name&#13;&#10;FROM         Holiday_Type"
                DeleteCommand="DELETE FROM Holiday_Type WHERE (Holiday_Type_Id = @Holiday_Type_Id)">
                <InsertParameters>
                    <asp:ControlParameter ControlID="txt_Holiday_Type" Name="Holiday_Type_Name" PropertyName="Text" />
                    <asp:ControlParameter ControlID="Holiday_Add" Name="Holiday_Add" PropertyName="Text" />
                </InsertParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Holiday_Type_Id" />
                </DeleteParameters>
            </asp:SqlDataSource>
        </div>
    </asp:Panel>
    <%--       </td>
        </tr>
    </table>--%>
</asp:Content>
