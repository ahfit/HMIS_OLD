<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_Budget_Report, App_Web_csihqmfb" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
                        <span>Budget Current Year</span>
                    </h2>
                    <div class="data_scroll">
                        
                        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" Width="100%" AutoGenerateColumns="false">
                            
                            <Columns>
                                <asp:BoundField DataField="Expenditures" HeaderText="Expenditures"  />
                                <asp:BoundField DataField="Revise_Amount" HeaderText="Revise Amount"  />
                                <asp:BoundField DataField="Estimated_Amount" HeaderText="Estimated Amount"  />
                                <asp:BoundField DataField="Excess" HeaderText="Excess"  />
                                <asp:BoundField DataField="Budget_Year" HeaderText="Year"  />

                            </Columns>

                        </asp:GridView>
                        
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                         SelectCommand="Select_Budget_Current" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        
                    </div>
                </div>
                <br />
            </td>
            <td width="50%">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px;">
                    <h2>
                        <span>Budget Current Year</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center; ">
                        
                        <asp:Chart ID="Chart1" runat="server" Height="220px" Width="550px" DataSourceID="SqlDataSource1">
                            <Series>
                                <asp:Series Name="Series1" ChartType="StackedBar" XValueMember="Expenditures" 
                                    YValueMembers="Revise_Amount" CustomProperties="DrawingStyle=Emboss" 
                                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                    IsXValueIndexed="True" LabelForeColor="White" Palette="Bright">
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
        <tr>
            <td width="50%" valign="top">
                <div class="bxmain2 margin_right10 inner_content" style="height: 550px;">
                    <h2>
                        <span>Budget</span>
                    </h2>
                    <div class="data_scroll" style="height:540px;">
                        
                        <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource2" Width="100%" AutoGenerateColumns="false">

                            <Columns>
                                <asp:BoundField DataField="Expenditures" HeaderText="Expenditures" ItemStyle-Width="38%"   />
                                <asp:BoundField DataField="Revise_Amount" HeaderText="Revise Amount"   ItemStyle-Width="17%" />
                                <asp:BoundField DataField="Estimated_Amount" HeaderText="Estimated Amount"  ItemStyle-Width="20%"  />
                                <asp:BoundField DataField="Excess" HeaderText="Excess"  ItemStyle-Width="10%"  />
                                <asp:BoundField DataField="Budget_Year" HeaderText="Year" ItemStyle-Width="15%"  />

                            </Columns>


                        </asp:GridView>
                        
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                         SelectCommand="Select_Budget" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                        
                    </div>
                </div>
                <br />
            </td>
            <td width="50%">
                <div class="bxmain3 margin_right10 inner_content" style="height: 555px;">
                    <h2>
                        <span>Budget</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center; height:530px; ">
                        
                        <asp:Chart ID="Chart2" runat="server" Height="920px" Width="550px" DataSourceID="SqlDataSource2">
                            <Series>
                                <asp:Series Name="Series1" ChartType="StackedBar" XValueMember="Expenditures" 
                                    YValueMembers="Revise_Amount" CustomProperties="BarLabelStyle=Outside" 
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

