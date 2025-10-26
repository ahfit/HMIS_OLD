<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_Hr, App_Web_0myvw0cp" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px;">
                    <h2>
                        <span>Hospital Wise Employees</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvSubDeptData" runat="server" DataSourceID="SqlDataSource1" Width="100%" AutoGenerateColumns="false">
                        <Columns>
                                <asp:BoundField DataField="Hospital_Name" HeaderText="Hospitals"  />
                                <asp:BoundField DataField="Employee_Count" HeaderText="Employees" ItemStyle-CssClass="AmountAlign" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            SelectCommand="SELECT     Hospital.Hospital_Name, COUNT(Employee.EmpID) AS Employee_Count
FROM         Employee INNER JOIN
                      SubDepartment ON Employee.SubDeptId = SubDepartment.SubDept_Id
                      Inner JOIN Department On SubDepartment.Dept_Id = Department.Dept_ID
                      INNER JOIN Hospital On Department.Hospital_ID = Hospital.Hospital_ID
GROUP BY Hospital.Hospital_Name
ORDER BY Hospital.Hospital_Name"></asp:SqlDataSource>
                    </div>
                </div>
                <br />
            </td>
            <td width="50%">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px;">
                    <h2>
                        <span>Hospital Wise Employees</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center;">
                        <asp:Chart ID="Chart1" runat="server" Height="225px" Width="540px" DataSourceID="SqlDataSource1">
                            <Series>
                                <asp:Series ChartType="Bar" Name="Series1" XValueMember="Hospital_Name" 
                                    YValueMembers="Employee_Count" CustomProperties="BarLabelStyle=Center" 
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
                <br />
            </td>
        </tr>
        
        <tr>
            <td width="50%">
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px;">
                    <h2>
                        <span>Designation Wise Employees</span>
                    </h2>
                    <div class="data_scroll">
                        <asp:GridView ID="gvDesignationsData" runat="server" DataSourceID="SqlDataSource3" Width="100%" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField DataField="Designation_Name" HeaderText="Designation Name" ItemStyle-CssClass="AmountAlign" />
                                <asp:BoundField DataField="Employee_Count" HeaderText="Employees" ItemStyle-CssClass="AmountAlign" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            SelectCommand="SELECT Designation_Name, COUNT(Employee.EmpID) AS Employee_Count
FROM Employee 
INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID
GROUP BY Designation_Name
ORDER BY Designation_Name"></asp:SqlDataSource>
                    </div>
                </div>
            </td>
            <td width="50%" valign="top">
                <div class="bxmain3 margin_right10 inner_content" style="height: 255px;">
                    <h2>
                        <span>Designation Wise Employees</span>
                    </h2>
                    <div class="data_scroll" style="text-align: center;">
                        <asp:Chart ID="Chart3" runat="server" Height="750px" Width="550px" DataSourceID="SqlDataSource3">
                            <Series>
                                <asp:Series ChartType="Bar" Name="Series1" XValueMember="Designation_Name" 
                                    YValueMembers="Employee_Count" CustomProperties="BarLabelStyle=Center" 
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
