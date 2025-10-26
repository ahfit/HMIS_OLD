<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="DashBoards_DB_Hr_One, App_Web_0myvw0cp" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
            <td width="50%" valign="top" rowspan="2">
                <div class="bxmain3 margin_right10 inner_content" style="height: 545px;">
                    <h2>
                        <span> Patient Visits </span>
                    </h2>
                    <div class="data_scroll" style="height:535px; text-align:center;">
                        <asp:Chart ID="Chart1" runat="server" Height="530px" Width="540px" DataSourceID="SqlDataSource1">
                            <Series>
                                <asp:Series ChartType="Bar" Name="Series1" XValueMember="Employee_Name" 
                                    YValueMembers="Visit_Count" CustomProperties="BarLabelStyle=Center" 
                                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
                                    IsXValueIndexed="True" LabelForeColor="White" Palette="BrightPastel">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <Area3DStyle Enable3D="true" LightStyle="Realistic" />
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>

                       
                        


                    </div>
                </div>
                <br />
            </td>
            <td width="50%" valign="top">
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px;">
                    <h2>
                        <span>Patient Visits</span>
                    </h2>
                    <div class="data_scroll" style="height: 240px;">

                        <asp:GridView ID="GridView1" runat="server" Width="100%" DataSourceID="SqlDataSource1" AutoGenerateColumns="false">
                            
                            <Columns>
                               <asp:BoundField DataField="Employee_Name" HeaderText="Dr. / Consultant" />
                                <asp:BoundField DataField="Visit_Count" HeaderText="Visits"  />
                                
                            </Columns>
                            
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                        SelectCommand="SELECT IsNull(Employee.EFName,'') + ' ' + IsNull(Employee.EMName,'') + ' ' + IsNull(Employee.ELName,'') Employee_Name, 
	COUNT(Payment.DoctorID) Visit_Count
FROM Payment 
INNER JOIN Employee ON Payment.DoctorID = Employee.EmpID
GROUP BY Employee.EFName, Employee.EMName, Employee.ELName
UNION ALL
SELECT 'Other' , COUNT(PayId)
From Payment 
Where IsNull(DoctorID,0) = 0 OR
	DoctorID NOT in (SELECT Employee.EmpID From Employee)">
                        
                        </asp:SqlDataSource>

                    </div>
                </div>
                <br />
            </td>
        </tr>
        <tr>
            <td width="50%" valign="top">
                <div class="bxmain2 margin_right10 inner_content" style="height: 250px;">
                    <h2>
                        <span>Details</span>
                    </h2>
                    <div class="data_scroll" style="height:240px;">
                    <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSource2" Width="100%" ShowHeader="false">
                       </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            SelectCommand="SELECT 'Total Departments' TotalCategory, COUNT(Department.Dept_ID) TotalCount From Department
Union ALL
SELECT 'Total Employees',COUNT(Employee.EmpID) From Employee
Union ALL
SELECT 'Total Wards' , COUNT(admin_Hospital_Wards.Ward_id) From admin_Hospital_Wards
union ALL
SELECT 'Total Beds',COUNT(Ward_Beds.Bed_id) From Ward_Beds
Union ALL 
SELECT 'Total Patients',COUNT(id) From Patient
Union ALL
SELECT 'Total Patient Visits',COUNT(PayID) From Payment
Union ALL
SELECT 'Total Indoor Visits',COUNT(PayId) From Payment 
Where Patient_Type = 'IPD'
Union ALL
SELECT 'Total OutDoor Visits',COUNT(PayId) From Payment 
Where Patient_Type = 'OPD'"></asp:SqlDataSource>

                    </div>
                </div>
                <br />
            </td>
        </tr>
    </table>



</asp:Content>

