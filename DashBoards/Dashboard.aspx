<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="false" CodeFile="Dashboard.aspx.vb" Inherits="DashBoards_Dashboard" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .bxmain2 {
            /* background: url("../images_mega/bxbg4.png") repeat-y scroll right bottom #E7E5F4;*/
            border: 1px solid #D2BFEA;
            border-radius: 4px;
            margin: 0;
            padding-top: 0;
            border-top: 0;
            overflow: hidden;
            height: 300px;
        }

        .margin_right10 {
            margin-right: 10px;
        }

        .txtright span {
            text-align: right;
            display: block;
            margin-right: 5px;
        }

        .boldt {
            font-weight: bold;
            text-align: right;
            display: block;
            margin-right: 5px;
        }

        .sel_pos {
            position: relative;
            margin-top: -36px;
            float: right;
            margin-right: 10px;
        }

        .splt {
            padding-left: 5px;
            padding-right: 5px;
        }


        .bxmain {
            min-height: 175px;
        }

        .bxmain2 {
            min-height: 175px;
        }

        .bxmain3 {
            min-height: 175px;
        }

        .bxmain4 {
            min-height: 175px;
        }

        .data_scroll {
            height: 225px;
            overflow-x: hidden;
            overflow-y: auto;
            width: 99%;
            padding-left: 5px;
        }


        .color_b {
            color: #000000;
        }

        #forms_items {
            margin: 15px;
        }

        .ssearch_panell {
            margin-bottom: 20px;
            overflow: hidden;
            border: #d6d6d6 solid 1px;
            background: #f7f7f7;
            padding: 10px;
            webkit-border-radius: 4px;
            azimuth -moz-border-radius: 4px;
        }

        .ssearch_div1 {
            margin-right: 20px;
            float: left;
        }

        .ssearch_div2 {
            float: left;
            margin-right: 15px;
        }

        .ssreach_label {
            margin-right: 15px;
            width: 70px;
            line-height: 22px;
            text-align: right;
            float: left;
            display: block;
            font-weight: bold;
        }

        .ssearch_panell input[type="text"], .ssearch_panell select {
            border: 1px solid #ccc;
            background: #ffffff;
        }

        .ssearch_panell input[type="submit"] {
            background: url(../images_hacims/img_btn_bg.png) left top repeat-x;
            height: 22px !important;
            line-height: 19px !important;
            cursor: pointer;
            font-size: 12px;
            color: #000000;
            azimuth font-weight:normal !important;
            border: #e1e1e1 solid 1px !important;
            -webkit-border-radius: 4px;
            azimuth -moz-border-radius: 4px;
            border-radius: 4px;
            behavior: url(PIEq.htc);
        }

        .chart_panel {
            margin-bottom: 15px;
            clear: both;
        }

        .row {
            margin-right: -15px;
            margin-left: -15px;
        }

        .col-6_r {
            float: right;
            width: 49%;
            position: relative;
            padding-right: 15px;
        }

        .col-6 {
            width: 49%;
            float: left;
            position: relative;
            padding-left: 15px;
        }

        .chart_panel h2 {
            height: 38px;
            line-height: 38px;
            background: url(../images_hacims/bhead.gif) 0 0 repeat-x;
            overflow: hidden;
            padding: 0 0 0 15px;
            width: auto;
            font-size: 13px;
        }

        .chart_panel .Grid_1 th {
            background: #E6ECEF;
            font-weight: bold !important;
            color: #4F4F4F;
            padding: 3px;
            text-align: center;
            font-size: 12px;
            color: #333;
            text-shadow: 0 1px 0 #FFFFFF;
            position: relative;
            font-weight: normal;
            border-bottom: 1px solid #AAAAAA;
        }

        .chart_panel .Grid_1 td {
            padding: 6px;
            text-transform: capitalize !important;
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

    <h1 class="title">Dashboard </h1>
    <div class="div-filter">
        <table style="width: 100%;">
            <tr>
                <td align="right">Hospital:</td>
                <td style="width: 20%;">
                    <asp:DropDownList ID="ddlHospital" runat="server" DataSourceID="SqlDataSource_Hospital"
                        DataTextField="Hospital_Name" DataValueField="Hospital_ID" Width="290px" Style="text-transform: uppercase;">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
                </td>

                <td align="right" style="width: 10%">From Date:</td>
                <td style="width: 10%">
                    <igsch:WebDateChooser ID="WebDateChooser_date_From" runat="server" Width="180px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
                <td align="right" style="width: 10%">To Date:
                </td>
                <td style="width: 10%">
                    <igsch:WebDateChooser ID="WebDateChooser_Date_To" runat="server" Width="180px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>

                <td align="center">
                    <asp:Button ID="Button1" runat="server" Text="Search" Font-Bold="True" Font-Size="Medium" Width="90px" OnClick="Button1_Click" /></td>
            </tr>
        </table>

    </div>
    <div class="chart_panel">
        <div class="row">
            <div class="col-6">
                <div class="bxmain2 inner_content">
                    <h2>OPD Patients (Department Wise)</h2>

                    <asp:Chart ID="Chart1" runat="server" Height="250px" Width="580px">
                        <Series>
                            <asp:Series ChartType="Pie" CustomProperties="BarLabelStyle=Center, PieLabelStyle=Outside"
                                Font="Microsoft Sans Serif, 8.25pt, style=Bold" IsValueShownAsLabel="True" XValueMember="Dept_Name"
                                YValueMembers="Total_Count" IsXValueIndexed="True" Name="Series1" Palette="BrightPastel"
                                PostBackValue="#INDEX" Legend="Legend1">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="True" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1">
                            </asp:Legend>
                        </Legends>
                    </asp:Chart>

                </div>

            </div>
            <div class="col-6_r">
                <div class="bxmain2 inner_content">
                    <h2>IPD Patients (Department Wise)</h2>
                    <asp:Chart ID="Chart2" runat="server" Height="250px" Width="580px">
                        <Series>
                            <asp:Series Name="Series1" XValueMember="SubDept_Name" YValueMembers="Total_Count"
                                CustomProperties="BarLabelStyle=Center" Font="Microsoft Sans Serif, 8.25pt, style=Bold"
                                IsValueShownAsLabel="True" LabelForeColor="White" Palette="BrightPastel">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="True" />
                            </asp:ChartArea>

                        </ChartAreas>
                    </asp:Chart>
                </div>
            </div>
        </div>
        <!-- block -->

        <div style="height: 0; line-height: 0; font-size: 0; clear: both; margin-bottom: 15px;"></div>
        <div class="row">
            <div class="col-6">
                <div class="bxmain2 inner_content">
                    <h2>OPD Patients (Patient Type Wise)</h2>
                    <asp:Chart ID="OPdTypeChart" runat="server" Height="250px" Width="580px">
                        <Series>
                            <asp:Series ChartType="Pie" CustomProperties="BarLabelStyle=Center, PieLabelStyle=Outside"
                                Font="Microsoft Sans Serif, 8.25pt, style=Bold" IsValueShownAsLabel="True" IsXValueIndexed="True"
                                Name="Series1" Palette="BrightPastel" Legend="Legend1">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="True" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1">
                            </asp:Legend>
                        </Legends>
                    </asp:Chart>

                </div>
            </div>
            <div class="col-6_r">
                <div class="bxmain2 inner_content">
                    <h2>IPD Patients (Patient Type Wise)</h2>
                    <asp:Chart ID="IPD_PtypewiseChart" runat="server" Height="250px" Width="580px">
                        <Series>
                            <asp:Series Name="Series1" XValueMember="GroupName" YValueMembers="Total"
                                CustomProperties="BarLabelStyle=Center" Font="Microsoft Sans Serif, 8.25pt, style=Bold"
                                IsValueShownAsLabel="True" LabelForeColor="White" Palette="BrightPastel">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">

                                <Area3DStyle Enable3D="True" />
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </div>
            </div>
        </div>
        <!-- block -->
        <div style="height: 0; line-height: 0; font-size: 0; clear: both; margin-bottom: 15px;"></div>

        <div class="row">
            <div class="col-6">
                <div class="bxmain2 inner_content" style="height: 310px;">
                    <h2>Lab Tests (Group Wise)</h2>

                    <asp:Chart ID="ChartLabTests" runat="server" Height="280px"
                        Width="580px">
                        <Series>
                            <asp:Series Name="Series1" ChartType="Bar" XValueMember="GroupName" YValueMembers="Total"
                                CustomProperties="BarLabelStyle=Center" Font="Microsoft Sans Serif, 8.25pt, style=Bold"
                                IsValueShownAsLabel="True" LabelForeColor="White" Palette="BrightPastel">
                            </asp:Series>
                        </Series>


                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="True" />
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>

                </div>
            </div>
            <div class="col-6_r">
                <div class="bxmain2 inner_content" style="height: 310px;">
                    <h2>Lab Collections  (Group Wise)</h2>

                    <asp:Chart ID="ChartTestGroupsAmount" runat="server" Height="280px"
                        Width="580px">
                        <Series>
                            <asp:Series Name="Series1" ChartType="Bar" XValueMember="GroupName" YValueMembers="Total_Amount"
                                CustomProperties="BarLabelStyle=Center" Font="Microsoft Sans Serif, 8.25pt, style=Bold"
                                IsValueShownAsLabel="True" LabelForeColor="White" Palette="BrightPastel">
                            </asp:Series>
                        </Series>

                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="True" />
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </div>
            </div>
        </div>
        <div style="height: 0; line-height: 0; font-size: 0; clear: both; margin-bottom: 15px;"></div>

        <div class="row">
            <div class="col-6">
                <div class="bxmain2 inner_content">
                    <h2>Radiology Tests (Group Wise)</h2>
                    <asp:Chart ID="ChartRadiologyTests" runat="server" Height="250px"
                        Width="580px">
                        <Series>
                            <asp:Series Name="Series1" XValueMember="GroupName" YValueMembers="Total"
                                CustomProperties="BarLabelStyle=Center" Font="Microsoft Sans Serif, 8.25pt, style=Bold"
                                IsValueShownAsLabel="True" LabelForeColor="White" Palette="BrightPastel">
                            </asp:Series>
                        </Series>


                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="True" />
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>


                </div>
            </div>
            <div class="col-6_r">
                <div class="bxmain2 inner_content">
                    <h2>Radiology Collections (Group Wise)</h2>

                    <asp:Chart ID="ChartRadiologyCollections" runat="server" Height="250px"
                        Width="580px">
                        <Series>
                            <asp:Series Name="Series1" XValueMember="GroupName" YValueMembers="Total_Amount"
                                CustomProperties="BarLabelStyle=Center" Font="Microsoft Sans Serif, 8.25pt, style=Bold"
                                IsValueShownAsLabel="True" LabelForeColor="White" Palette="BrightPastel">
                            </asp:Series>
                        </Series>


                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="True" />
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
