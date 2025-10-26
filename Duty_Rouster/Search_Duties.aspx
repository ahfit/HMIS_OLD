<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="Search_Duties.aspx.cs" Inherits="Administrator_Search_Duties" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .duty_panel {
            margin: 20px 0;
            width: 99%;
            overflow: auto;
        }
        .duty_panel .btn_hacims {
               margin:-15px 0 10px 0;
        }
            .duty_panel table.ShiftDutyTable {
                width: 100%;
                border: 1px solid #CCCACA;
            }

            .duty_panel table tr.RowStyle {
                height: 200px;
            }

        .HeaderRowStyle {
            background-color: #E7E7E7;
            height: 50px;
            font-size: 11px;
            text-align: center;
            font-weight: bold;
        }


        .TdStyle {
            height: 120px;
            overflow-x: hidden;
            overflow-y: auto;
            
        }

        .TableDataStyle {
            border: 1px solid #DADADA;
            padding: 0 0 0 10px;
        }

        .btnStyle {
            position: relative;
            float: right;
            margin-right: 10px;
        }

       .TdStyle input[type="image"] {
            width: 12px;
            height: 12px;
            float: left;
            margin-right:7px;
            
        }
       .inner_content {
    
    border-style: none;
    border-color: inherit;
    border-width: 0;
    margin: 0 0 0 0px;
    font-style: inherit;
    list-style: none;
    padding: 0;
    font-size: 11px;

}
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>--%>
    <%--<asp:UpdatePanel ID="upnlUpdatePanel" runat="server">--%>
    <contenttemplate>
<DIV class="bxmain inner_content" style="width:100%;" >
   <div><h2><span>Search Duties</span></h2></div>
     <TABLE id="TABLE1" class="tbl_form" cellSpacing=0 cellPadding=0 width="100%" border=0>
           <TBODY>
           <TR>
               <TD align=right width="40%">
                Start From : 
                </TD>
                <TD width="60%"><igsch:WebDateChooser id="WebDateChooser_start_From" runat="server" CssClass="drop_date" Width="202px" OnValueChanged="WebDateChooser_start_From_ValueChanged">
                                <AutoPostBack ValueChanged="True" />
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser> </TD></TR><TR><TD align=right>End Date : </TD><TD><igsch:WebDateChooser id="WebDateChooser_end_to" runat="server" CssClass="drop_date" Width="202px" EnableViewState="False">
                                <AutoPostBack ValueChanged="True" />
                                <CalendarLayout Culture="English (United Kingdom)">
                                </CalendarLayout>
                            </igsch:WebDateChooser> </TD></TR><TR><TD align=right>Department Name : </TD>
                            <TD>
                            <asp:DropDownList id="DropDownListDepartment" runat="server" Width="200px" AutoPostBack="True" Css DataSourceID="SqlDataSourceDepartmentName" DataTextField="Dept_Name" DataValueField="Dept_ID">

                            </asp:DropDownList> </TD></TR><TR><TD align=right>Sub Department Name : </TD><TD><asp:DropDownList id="DropDownListSubDepartment" runat="server" Width="200px" AutoPostBack="True" Css DataSourceID="SqlDataSourceSubDepartment" DataTextField="SubDept_Name" DataValueField="SubDept_Id" OnSelectedIndexChanged="DropDownListSubDepartment_SelectedIndexChanged">
                            </asp:DropDownList> </TD></TR>
               
               <TR><TD align=right>Employee Name : </TD>
                            <TD>
                            <asp:DropDownList id="DDLEMployee" runat="server" Width="200px" AutoPostBack="True"  DataSourceID="SDS_Employee" DataTextField="Name" 
                  DataValueField="EmpID" >

                            </asp:DropDownList> </TD></TR>
                  <asp:SqlDataSource ID="SDS_Employee" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>" 
        SelectCommand="SELECT 0 AS EmpID, ' ---ALL---' AS Name UNION 
SELECT     EmpID, ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name
FROM         Employee
WHERE     (@DeptID =0 or DeptID = @DeptID)" 
                    
                    
                    
                    ProviderName="<%$ ConnectionStrings:Machine_AttendanceConnectionString.ProviderName %>">
              <SelectParameters>
                  <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" 
                      PropertyName="SelectedValue" />
              </SelectParameters>
    </asp:SqlDataSource>
                    <TR><TD align=right> Search By Employee: </TD>
                            <TD>
                        <asp:RadioButtonList runat="server" ID="rdrbtn"  RepeatDirection="Horizontal" >
                            <asp:ListItem Value="0">By Department</asp:ListItem>
                             <asp:ListItem Value="1">By Duty Department</asp:ListItem>
                        </asp:RadioButtonList>
                                 </TD></TR>
               
               <TR><TD style="WIDTH: 375px; HEIGHT: 25px" align=right></TD><TD><asp:Button id="btnSearch" onclick="btnSearch_Click" visible="false" runat="server" Text="Search"></asp:Button>
        <asp:Button id="Button_Report"  runat="server" Text="Report" 
            onclick="Button_Report_Click"></asp:Button>
        <asp:HiddenField ID="HiddenField1" runat="server" />
        <asp:HiddenField ID="HiddenField_Sdate" runat="server">
        </asp:HiddenField><asp:HiddenField ID="HiddenField_EDate" runat="server">
        </asp:HiddenField>
        <asp:HiddenField ID="HiddenField_Dept" runat="server">
        </asp:HiddenField>
        <asp:HiddenField ID="HiddenField_Sub_Dept" runat="server">
        </asp:HiddenField>
                     <asp:HiddenField ID="hfdempdep" runat="server"> </asp:HiddenField>
                    
                    <asp:HiddenField ID="HiddenField_Employee" runat="server">
        </asp:HiddenField>
        <asp:Label id="lblMsg" runat="server" ForeColor="#C00000" __designer:wfdid="w1" Font-Bold="True"></asp:Label></TD></TR></TBODY></TABLE></div><asp:Panel id="PnlAddEmp" runat="server" CssClass="lightbox"><DIV class="bxmain" style="width:98.8% !important;" align="center">
                            
                            <TABLE id="TABLE2" class="tbl_form" cellSpacing=0 cellPadding=0 width="100%" border="0">                            
                            <TBODY>
                            <TR>
                                <TD style="WIDTH: 267px" align=right>Employees of Department : </TD>
                                <TD><asp:DropDownList id="DDLDeptForEmp" runat="server" Width="200px" AutoPostBack="True"  DataSourceID="SqlDataSource_EmpForDept" DataTextField="Dept_Name" DataValueField="Dept_ID" OnSelectedIndexChanged="DDLDeptForEmp_SelectedIndexChanged"></asp:DropDownList> <asp:SqlDataSource id="SqlDataSource_EmpForDept" runat="server" SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department]" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" __designer:wfdid="w2"></asp:SqlDataSource></TD></TR><TR><TD style="WIDTH: 267px" align=right>Employee of Sub Department : </TD><TD><asp:DropDownList id="DDLSubDeptForEmp" runat="server" Width="200px" AutoPostBack="True" Css DataSourceID="SqlDataSource_EmpForSubDept" DataTextField="SubDept_Name" DataValueField="SubDept_Id" OnSelectedIndexChanged="DDLSubDeptForEmp_SelectedIndexChanged"></asp:DropDownList> <asp:SqlDataSource id="SqlDataSource_EmpForSubDept" runat="server" SelectCommand="Select 'Select' SubDept_Name,0 SubDept_Id Union All SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Deptid)" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" __designer:wfdid="w3"><SelectParameters>
<asp:ControlParameter ControlID="DDLDeptForEmp" PropertyName="SelectedValue" Name="Deptid"></asp:ControlParameter>
</SelectParameters>
</asp:SqlDataSource> <asp:HiddenField id="HiddenField_WardId" runat="server" __designer:wfdid="w1"></asp:HiddenField></TD></TR><TR><TD style="WIDTH: 267px" align=right>Employee Name : </TD><TD vAlign=top><DIV style="OVERFLOW: scroll; WIDTH: 600px; HEIGHT: 250px">
                                    <asp:CheckBoxList id="CheckBoxList_Emp" runat="server" Width="82%" 
                                        AutoPostBack="True" DataSourceID="SqlDataSourceEmployeeName" 
                                        DataTextField="empolyeeName" DataValueField="EmpID" Height="33px" 
                                        RepeatColumns="2" RepeatDirection="Horizontal" 
                                        ></asp:CheckBoxList> </DIV></TD></TR><TR><TD style="WIDTH: 267px" align=right>&nbsp; </TD><TD><asp:Button id="ButtonSave" onclick="ButtonSave_Click" runat="server" Text="Save"></asp:Button> <asp:Button id="btnClose" onclick="btnClose_Click" runat="server" Text="Close" __designer:wfdid="w1"></asp:Button></TD></TR></TBODY></TABLE></DIV></asp:Panel>    
            <div class="duty_panel">
                <asp:Panel id="pnlWeekView" runat="server"></asp:Panel>
            </div>
            
             <asp:SqlDataSource id="SqlDataSource_Saveinfo" runat="server" SelectCommand="select * from Admin_Employee_Duty_Roster" 
                 ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                 InsertCommand="sp_InsertDutyRoster" InsertCommandType="StoredProcedure"><InsertParameters>
<asp:ControlParameter ControlID="HiddenField_dutyRosterID" PropertyName="Value" Name="Duty_Roster_ID" Type="Int32"></asp:ControlParameter>
<asp:ControlParameter ControlID="HiddenField_EmpID" PropertyName="Value" Name="Emp_ID" Type="Int32"></asp:ControlParameter>
<asp:ControlParameter ControlID="HiddenField_Date_Start" PropertyName="Value" DbType="DateTime" Name="Start_Duty_Date"></asp:ControlParameter>
<asp:ControlParameter ControlID="HiddenField_Date_Start" PropertyName="Value" DbType="DateTime" Name="Duty_End_Date"></asp:ControlParameter>
<asp:ControlParameter ControlID="HiddenField_WardId" PropertyName="Value" Name="Ward_Id" Type="String"></asp:ControlParameter>
</InsertParameters>
</asp:SqlDataSource> <asp:HiddenField id="HiddenField_EmpID" runat="server"></asp:HiddenField>&nbsp; <asp:HiddenField id="HiddenField_Date_Start" runat="server"></asp:HiddenField> <asp:HiddenField id="HiddenField_ShiftName" runat="server"></asp:HiddenField> <asp:HiddenField id="HiddenField_dutyRosterID" runat="server"></asp:HiddenField> 
</contenttemplate>
    </asp:UpdatePanel>
    
    <asp:SqlDataSource ID="SqlDataSourceDepartmentName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT     Department.Dept_Name  as Dept_Name, Department.Dept_ID, Hospital.Hospital_Abb
FROM         Department INNER JOIN
                      Hospital ON Department.Hospital_ID = Hospital.Hospital_ID"></asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_fromDate" runat="server" />
    <asp:HiddenField ID="HiddenField_Todate" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT  SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Deptid)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListDepartment" Name="Deptid"
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployeeName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="sp_SelectEmployees" CancelSelectOnNullParameter="False" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLDeptForEmp" Name="DeptID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DDLSubDeptForEmp" Name="SubDeptID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenField_Date_Start" Name="OnDate" PropertyName="Value" Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenField_ShiftName" Name="Shift_Name" PropertyName="Value" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    &nbsp;
    
    
</asp:Content>
