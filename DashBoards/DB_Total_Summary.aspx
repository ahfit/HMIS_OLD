<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="DashBoards_DB_Total_Summary, App_Web_442qjtxu" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
        
        .style1
        {
            font-size: 11px;
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
                    <h2 style="padding-bottom: 10px;">
                        <span>Out Door Patient Collections</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvOPDMonthlySummary" runat="server" AutoGenerateColumns="false"
                            Width="100%">
                            <Columns>
                                <asp:BoundField DataField="SubDept_Name" HeaderText="Department" />
                                <asp:BoundField DataField="Patient_Count" HeaderText="Patients" />
                                <asp:BoundField DataField="Collected_Amount" HeaderText="Collections" />
                                <asp:BoundField DataField="Counter_Date" HeaderText="Date" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
                <br />
            </td>
            <td width="50%" valign="top">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px;">
                    <h2 style="padding-bottom: 10px;">
                        <span>Out Door Patient Collections</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center;">
                        <asp:Chart ID="Chart1" runat="server" Height="750px" Width="550px">
                            <Series>
                                <asp:Series ChartType="bar" CustomProperties="BarLabelStyle=Center" Font="Microsoft Sans Serif, 8.25pt, style=Bold"
                                    IsValueShownAsLabel="True" XValueMember="SubDept_Name" YValueMembers="Collected_Amount"
                                    IsXValueIndexed="false" Name="Series1" Palette="BrightPastel" LabelForeColor="White">
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
            </td>
        </tr>
        <tr>
            <td width="50%" valign="top">
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px;">
                    <h2 style="padding-bottom: 10px;">
                        <span>In Door Patient Collections</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvIPDMonthlySummary" runat="server" AutoGenerateColumns="false"
                            Width="100%">
                            <Columns>
                                <asp:BoundField DataField="SubDept_Name" HeaderText="Department" />
                                <asp:BoundField DataField="Patient_Count" HeaderText="Patients" />
                                <asp:BoundField DataField="Collected_Amount" HeaderText="Collections" />
                                <asp:BoundField DataField="Counter_Date" HeaderText="Date" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </td>
            <td width="50%" valign="top">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px; ">
                    <h2 style="padding-bottom: 10px;">
                        <span>In Door Patient Collections</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center;">
                        <asp:Chart ID="Chart2" runat="server" Height="350px" Width="550px">
                            <Series>
                                <asp:Series ChartType="Bar" CustomProperties="BarLabelStyle=Center" Font="Microsoft Sans Serif, 8.25pt, style=Bold"
                                    IsValueShownAsLabel="True" XValueMember="SubDept_Name" YValueMembers="Collected_Amount"
                                    IsXValueIndexed="True" LabelForeColor="White" Name="Series1" Palette="SeaGreen">
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
            </td>
        </tr>
    </table>
    <br />
    <br />
</asp:Content>
