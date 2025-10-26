<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_Payroll, App_Web_0myvw0cp" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
        
        <tr>
            <td width="50%" valign="top">
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px;">
                    <h2>
                        <span>Payroll</span>
                    </h2>
                    <div class="data_scroll">
                        
                        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" 
                            Width="100%" AutoGenerateColumns="False">
                            
                            <Columns>
                                <asp:BoundField DataField="Dept_Name" HeaderText="Dept_Name" 
                                    SortExpression="Dept_Name" />
                                <asp:BoundField DataField="E_Name" HeaderText="E_Name" 
                                    SortExpression="E_Name" />
                                <asp:BoundField DataField="Total_Amount" HeaderText="Total_Amount" 
                                    ReadOnly="True" SortExpression="Total_Amount" />
                            </Columns>

                        </asp:GridView>
                        
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                         SelectCommand="usp_GetAllEmpSalarySummary" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        
                    </div>
                </div>
                <br />
            </td>
            <td width="50%">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px;">
                    <h2>
                        <span>Payroll</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center; ">
                        <asp:Chart ID="Chart1" runat="server" Height="220px" Width="550px" DataSourceID="SqlDataSource1">
                            <Series>
                                <asp:Series Name="Series1" ChartType="Pie" XValueMember="Dept_Name" 
                                    YValueMembers="Total_Amount" CustomProperties="DrawingStyle=Emboss" 
                                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                    IsXValueIndexed="True" LabelForeColor="White" Palette="Bright" 
                                    Legend="Legend1">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="true" />
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                        
                    </div>
                </div>
                <br />
            </td>
        </tr>
        <tr>
            <td width="50%" valign="top">
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px;">
                    <h2>
                        <span>Monthly Summary</span>
                    </h2>
                    <div class="data_scroll" style="height:240px;">
                        
                        <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource2" 
                            Width="100%" AutoGenerateColumns="False" EmptyDataText="No Record(s) Found">

                            <Columns>
                                <asp:BoundField DataField="Dept_Name" HeaderText="Dept_Name" 
                                    SortExpression="Dept_Name" />
                                <asp:BoundField DataField="E_Name" HeaderText="E_Name" 
                                    SortExpression="E_Name" />
                                <asp:BoundField DataField="Total_Amount" HeaderText="Total_Amount" 
                                    ReadOnly="True" SortExpression="Total_Amount" ItemStyle-CssClass="AmountAlign" />
                            </Columns>


                        </asp:GridView>
                        
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                         SelectCommand="usp_GetAllEmpSalarySummaryMonthYear" SelectCommandType="StoredProcedure">
                         <SelectParameters>
                                <asp:Parameter Name="Month" Type="Int32" />
                               <asp:Parameter Name="Year" Type="Int32" />
                            </SelectParameters>
                         </asp:SqlDataSource>
                        
                    </div>
                </div>
                <br />
            </td>
            <td width="50%">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px;">
                    <h2>
                        <span>Monthly Summary</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center; height:230px; ">
                        
                        <asp:Chart ID="Chart2" runat="server" Height="220px" Width="550px" DataSourceID="SqlDataSource2" AlternateText="No Record(s) Found">
                            <Series>
                                <asp:Series Name="Series1" ChartType="Pie" XValueMember="Dept_Name" 
                                    YValueMembers="Total_Amount" CustomProperties="BarLabelStyle=Outside" 
                                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                    IsXValueIndexed="True" Palette="Excel">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="true" />
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                        
                    </div>
                </div>
                <br />
            </td>
        </tr>

    </table>

</asp:Content>

