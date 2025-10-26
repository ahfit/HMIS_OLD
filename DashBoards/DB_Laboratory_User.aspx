<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="DB_Laboratory_User.aspx.cs" Inherits="DashBoards_DB_Laboratory_User" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
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
        <tr>
            <td width="50%" valign="top">
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px; ">
                    <h2 style="padding-bottom:10px;">
                        <span>Tests</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvIPDOPDGroupSummary" runat="server" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSource1" Width="100%">
                            <Columns>
                                <asp:BoundField DataField="GroupName" HeaderText="Group Name"
                                    ItemStyle-CssClass="AmountAlign" SortExpression="GroupName" />
                                <asp:BoundField DataField="IPD_Count" HeaderText="IPD" ReadOnly="True"
                                    ItemStyle-CssClass="AmountAlign" SortExpression="IPD_Count" />
                                <asp:BoundField DataField="OPD_Count" HeaderText="OPD" ReadOnly="True"
                                    ItemStyle-CssClass="AmountAlign" SortExpression="OPD_Count" />
                                <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="True"
                                    ItemStyle-CssClass="AmountAlign" SortExpression="Total" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            SelectCommand="usp_GetLabServicesCountByGroup" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="Date_From" Type="DateTime" />
                                <asp:Parameter Name="Date_To" Type="DateTime" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
                <br>
            </td>
            <td width="50%" valign="top">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px;">
                    <h2 style="padding-bottom:10px;">
                        <span>Tests</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center; padding-right: 10px;">
                        <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" Height="224px"
                            Width="560px">
                            <Series>
                                <asp:Series Name="Series1" XValueMember="GroupName" YValueMembers="Total" 
                                    ChartType="Bar" CustomProperties="BarLabelStyle=Center" 
                                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                    IsXValueIndexed="True" LabelForeColor="White" Palette="BrightPastel">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </div>
                </div>
                <br>
            </td>
        </tr>
        <tr>
            <td width="50%">
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px;">
                    <h2 style="padding-bottom:10px;">
                        <span>Collections</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvIPDOPDGroupAmountSummary" runat="server" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSource2" Width="100%">
                            <Columns>
                                <asp:BoundField DataField="GroupName" HeaderText="Group Name"
                                    ItemStyle-CssClass="AmountAlign" SortExpression="GroupName" />
                                <asp:BoundField DataField="IPD_Total" HeaderText="IPD" ReadOnly="True"
                                    ItemStyle-CssClass="AmountAlign" SortExpression="IPD_Total" />
                                <asp:BoundField DataField="OPD_Total" HeaderText="OPD" ReadOnly="True"
                                    ItemStyle-CssClass="AmountAlign" SortExpression="OPD_Total" />
                                <asp:BoundField DataField="Total_Amount" HeaderText="Total Amount"
                                    ItemStyle-CssClass="AmountAlign" ReadOnly="True" SortExpression="Total_Amount" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            SelectCommand="usp_GetLabServicesAmountCountByGroup" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="Date_From" Type="DateTime" />
                                <asp:Parameter Name="Date_To" Type="DateTime" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
            </td>
            <td width="50%" valign="top">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px; ">
                    <h2 style="padding-bottom:10px;">
                        <span>Collections</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center; padding-right: 10px;">
                        <asp:Chart ID="Chart2" runat="server" DataSourceID="SqlDataSource2" Height="224px"
                            Width="560px">
                            <Series>
                                <asp:Series Name="Series1" XValueMember="GroupName" YValueMembers="Total_Amount"
                                    ChartType="Pie" Legend="Group Name" YValueType="Single" 
                                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                    IsXValueIndexed="True" CustomProperties="PieLabelStyle=Outside" 
                                    Palette="BrightPastel">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Name="Group Name">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
