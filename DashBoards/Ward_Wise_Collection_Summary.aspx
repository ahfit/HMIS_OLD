<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Doctor_Wise_Collection_Summary, App_Web_csihqmfb" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .bxmain2
        {
            background: url("../images_mega/bxbg4.png") repeat-y scroll right bottom #E7E5F4;
            border: 1px solid #D2BFEA;
            border-radius: 4px;
            margin: 0;
            padding-bottom: 15px;
            padding-top: 10px;
            height: 530px;
        }
        
        .margin_right10
        {
            margin-right: 10px;
        }
        .txtright span
        {
            text-align: right;
            display: block;
            margin-right: 5px;
        }
        .boldt
        {
            font-weight: bold;
            text-align: right;
            display: block;
            margin-right: 5px;
        }
        .sel_pos
        {
            position: relative;
            margin-top: -36px;
            float: right;
            margin-right: 10px;
        }
        .splt
        {
            padding-left: 5px;
            padding-right: 5px;
        }
        
        
        .bxmain
        {
            min-height: 175px;
        }
        .bxmain2
        {
            min-height: 175px;
        }
        .bxmain3
        {
            min-height: 175px;
        }
        .bxmain4
        {
            min-height: 175px;
        }
        
        .data_scroll
        {
            height: 225px;
            overflow-x: hidden;
            overflow-y: auto;
            width: 99%;
            padding-left: 5px;
        }
        
        
        .color_b
        {
            color: #000000;
        }
    </style>
    <script type="text/javascript">

        $(document).ready(function (e) {

            $.fn.commas = function () {
                return this.each(function () {
                    $(this).text($(this).text().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                })
            }


            $(".total_payable").html($("#ctl00_ContentPlaceHolder1_GridviewPayable .boldt").text());
            $(".total_receiveable").html($("#ctl00_ContentPlaceHolder1_GridviewReceiveable .boldt").text());

            $("span").commas();

        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr style="text-align: center; width: 100%;">
            <td style="padding-bottom: 10px; text-align: right;">
                <spna style="font-weight: bold;">From Date:&nbsp;&nbsp;</spna>
            </td>
            <td style="padding-bottom: 10px; text-align: left;">
                <igsch:WebDateChooser ID="WebDateChooser_date_From" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr style="text-align: center; width: 100%;">
            <td style="padding-bottom: 10px; text-align: right;">
                <spna style="font-weight: bold;">To Date:&nbsp;&nbsp;</spna>
            </td>
            <td style="padding-bottom: 10px; text-align: left;">
                <igsch:WebDateChooser ID="WebDateChooser_Date_To" runat="server" Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2" style="padding-bottom:10px; padding-left:200px;">
                <asp:Button ID="Button1" runat="server" Text="Search" Font-Bold="True" 
                    Font-Size="Medium" Width="205px" onclick="Button1_Click" />
            </td>
        </tr>
        <tr>
            <td width="50%" valign="top">
                &nbsp;</td>
            <td width="50%">
                <br />
            </td>
        </tr>
        <tr>
            <td width="50%">
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px;">
                    <h2>
                        <span>Ward Wise Collection</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvDepartmentCollection" runat="server" EmptyDataText="No Record(s) Found"
                            DataSourceID="SqlDataSource2" width="100%" AutoGenerateColumns="False" 
                            onprerender="gvDepartmentCollection_PreRender" ShowFooter="True">
                            <Columns>
                                <asp:BoundField DataField="Ward_Name" HeaderText="Ward Name" 
                                    SortExpression="Ward_Name" />
                                <asp:BoundField DataField="OPD" HeaderText="OPD" ReadOnly="True" 
                                    SortExpression="OPD" Visible="False" />
                                <asp:TemplateField HeaderText="IPD" SortExpression="IPD">
                                    <FooterTemplate>
                                        <asp:Label ID="TotalIPD" runat="server" Text="Label"></asp:Label>
                                    </FooterTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="IPD" runat="server" Text='<%# Bind("IPD") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="IPD" runat="server" Text='<%# Eval("IPD") %>'></asp:Label>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="true" SortExpression="Total" Visible="true" />
                               
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            SelectCommand="usp_get_ColSummary_By_Ward" 
                            SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                
                                    <asp:Parameter Name="startDate" Type="DateTime" />
                                    <asp:Parameter Name="endDate" Type="DateTime" />

                                </SelectParameters>
                            
                            </asp:SqlDataSource>
                        
                    </div>
                </div>
            </td>
            <td width="50%" valign="top">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px;">
                    <h2>
                        <span>Ward Wise Collection</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center;">
                        <asp:Chart ID="Chart2" runat="server" DataSourceID="SqlDataSource2" 
                            Height="225px" Width="550px" EnableViewState="True">
                            <Series>
                                <asp:Series ChartType="Pie" Name="Series1" XValueMember="Ward_Name" 
                                    YValueMembers="Total" CustomProperties="CollectedColor=ActiveBorder, PieLabelStyle=Outside" 
                                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                    IsXValueIndexed="True" Legend="Legend1" Palette="BrightPastel">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                
                                <asp:ChartArea Name="ChartArea1">
                                    <Area3DStyle Enable3D="true" PointGapDepth="1000" />
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
