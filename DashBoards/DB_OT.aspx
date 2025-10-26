<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_OT, App_Web_0myvw0cp" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="50%" valign="top">
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px;">
                    <h2>
                        <span>Operation Theathers</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvSubDeptData" runat="server" DataSourceID="SqlDataSource1" Width="100%" AutoGenerateColumns="false">
                        <Columns>
                                <asp:BoundField DataField="OperationTheatre" HeaderText="Operation Theatre"  />
                                <asp:BoundField DataField="Total" HeaderText="Total" ItemStyle-CssClass="AmountAlign" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
                            SelectCommand="SELECT OT.SubDept_Name OperationTheatre,COUNT(Pt_Operation_Admitted_ID) - COUNT(Final_Operation_Date) Pending,
COUNT(Pt_Operation_Admitted_ID) Total
From Pt_Operation_Admitted A 
INNER JOIN SubDepartment OT ON A.OT_Room = OT.SubDept_Id
GROUP BY OT.SubDept_Name
"></asp:SqlDataSource>
                    </div>
                </div>
                <br />
            </td>
            <td width="50%">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px;">
                    <h2>
                        <span>Operation Theathers</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center;">
                        <asp:Chart ID="Chart1" runat="server" Height="225px" Width="540px" DataSourceID="SqlDataSource1">
                            <Series>
                                <asp:Series ChartType="Bar" Name="Series1" XValueMember="OperationTheatre" 
                                    YValueMembers="Total" CustomProperties="BarLabelStyle=Center" 
                                    IsValueShownAsLabel="True" IsXValueIndexed="True" LabelForeColor="White" 
                                    Palette="BrightPastel">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </div>
                </div>
                <br />
            </td>
        </tr>
        <tr>
            <td width="50%">
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px;">
                    <h2>
                        <span>Anaesthesia</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvWardsData" runat="server" DataSourceID="SqlDataSource2" Width="100%" AutoGenerateColumns="false">
                        <Columns>
                                <asp:BoundField DataField="AnaesthesiaType" HeaderText="Anaesthesia Type"  />
                                <asp:BoundField DataField="Patient_Count" HeaderText="Patient Count" ItemStyle-CssClass="AmountAlign" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
                            SelectCommand="SELECT A.AnaesthesiaType,COUNT(A.Pt_Operation_Admitted_ID) Patient_Count
From Pt_Operation_Admitted A 
Where A.Final_Operation_Date Is Not Null
GROUP BY A.AnaesthesiaType
"></asp:SqlDataSource>
                    </div>
                </div>
                <br />
            </td>
            <td width="50%" valign="top">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px;">
                    <h2>
                        <span>Anaesthesia</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center;">
                        <asp:Chart ID="Chart2" runat="server" Height="225px" Width="550px" DataSourceID="SqlDataSource2"
                            CustomProperties="BarLabelStyle=Center" 
                                    IsValueShownAsLabel="True" IsXValueIndexed="True" LabelForeColor="White" 
                                    Palette="BrightPastel"
                        >
                            <Series>
                                <asp:Series ChartType="Bar" Name="Series1" XValueMember="AnaesthesiaType" 
                                    YValueMembers="Patient_Count" CustomProperties="BarLabelStyle=Center" 
                                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                    IsXValueIndexed="True" LabelForeColor="White" Palette="SeaGreen">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </div>
                </div>
                <br />
            </td>
        </tr>
        <tr>
            <td width="50%">
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px;">
                    <h2>
                        <span>Operated By</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvDesignationsData" runat="server" DataSourceID="SqlDataSource3" Width="100%" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="Employee_Name" HeaderText="Employee Name"  />
                                <asp:BoundField DataField="Pending" HeaderText="Pending" ItemStyle-CssClass="AmountAlign" />
                                <asp:BoundField DataField="Total" HeaderText="Total" ItemStyle-CssClass="AmountAlign" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:OperationTheaterConnectionString %>"
                            SelectCommand="SELECT IsNull(Emp.Prefix,'') + ' ' + IsNull(Emp.EFName,'') + ' ' + IsNull(Emp.ELName,'') Employee_Name,
		COUNT(Pt_Operation_Admitted_ID) - COUNT(Final_Operation_Date) Pending,
COUNT(Pt_Operation_Admitted_ID) Total
From Pt_Operation_Admitted A 
INNER JOIN Employee Emp ON A.Incharge_Surgeon_Id = Emp.EmpID
GROUP BY IsNull(Emp.Prefix,'') + ' ' + IsNull(Emp.EFName,'') + ' ' + IsNull(Emp.ELName,'')
"></asp:SqlDataSource>
                    </div>
                </div>
            </td>
            <td width="50%" valign="top">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px;">
                    <h2>
                        <span>Operated By</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center;">
                        <asp:Chart ID="Chart3" runat="server" Height="225px" Width="550px" DataSourceID="SqlDataSource3"
                            CustomProperties="BarLabelStyle=Center" 
                                    IsValueShownAsLabel="True" IsXValueIndexed="True" LabelForeColor="White" 
                                    Palette="BrightPastel"
                        >
                            <Series>
                                <asp:Series ChartType="Bar" Name="Series1" XValueMember="Employee_Name" 
                                    YValueMembers="Total" CustomProperties="BarLabelStyle=Center" 
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
            </td>
        </tr>
    </table>
</asp:Content>

