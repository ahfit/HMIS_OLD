<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AdminManualAttendance.aspx.cs" Inherits="Leave_Management_AdminManualAttendance" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
    </script>
    <style type="text/css">
        .style1 {
            width: 40%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>

    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Mark Attendance Manually</span></h2>

        <table class="tbl_form">
            <tr>
                <td align="right" class="style1">
                    <strong>Select Hospital :</strong> </td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Company" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Company" DataTextField="Hospital_Name"
                        DataValueField="Hospital_ID"
                        AutoPostBack="True" Style="margin-left: 0px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Company" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital] order by Hospital_Name"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Select Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Branch" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Branch" DataTextField="Dept_Name"
                        DataValueField="Dept_ID" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Branch" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="select 0 as Dept_ID ,'---ALL---' as Dept_Name union SELECT     Dept_ID, Dept_Name
FROM         Department
where Hospital_ID = @HospitalID order by Dept_Name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Select Sub Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_SubDepartment" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_SubDept" DataTextField="SubDept_Name"
                        DataValueField="SubDept_ID" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_SubDept" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="select 0 as SubDept_Id,'---ALL---' as SubDept_Name union select SubDept_Id,SubDept_Name from SubDepartment where (@DeptID=0 or Dept_Id=@DeptID) order by SubDept_Name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Branch" Name="DeptID"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1"><strong>Select Date:</strong></td>
                <td colspan="2">
                    <asp:TextBox runat="server" ID="txtDate" TextMode="Date" visible ="false"/>
                    <igsch:WebDateChooser ID="WebDateChooser_Date" runat="server" Width="200px" >
                         <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button Text="Search" ID="btnSearch" OnClick="btnSearch_Click" runat="server" />
                    <asp:Button Text="Update" ID="btnUpdate" OnClick="btnUpdate_Click" runat="server" />
                    <asp:Label ID="lblMsg" Text="Marked Successfully" ForeColor="Green" Visible="false" Font-Bold="true" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <asp:GridView runat="server" ID="GridView1" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField HeaderText="Sr.#">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Name">
                <ItemTemplate>
                    <asp:Label ID="lblName" Text='<%# Bind("Name") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Department">
                <ItemTemplate>
                    <asp:Label ID="lblDeptName" Text='<%# Bind("Dept_Name") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Designation">
                <ItemTemplate>
                    <asp:Label ID="lblDesignation" Text='<%# Bind("Designation_Name") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date" Visible="false">
                <ItemTemplate>
                    <asp:Label ID="lblDate" Text='<%# Bind("attDate") %>' runat="server" ToolTip='<%# Bind("EmpID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date">
                <ItemTemplate>
                    <asp:Label ID="lblConvertDate" Text='<%# Bind("ConvertDate") %>' runat="server" ToolTip='<%# Bind("EmpID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Time In">
                <ItemTemplate>
                    <asp:TextBox ID="txtTimeIn" TextMode="time" runat="server" Text='<%# Bind("Time_In") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Time Out">
                <ItemTemplate>
                    <asp:TextBox ID="txtTimeOut" TextMode="time" runat="server" Text='<%# Bind("Time_out") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Comments">
                <ItemTemplate>
                    <asp:TextBox ID="txtComment" TextMode="MultiLine" Width="150px" Height="50px" runat="server" Text='<%# Bind("admin_comment") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="chkatt" runat="server" ToolTip='<%# Bind("att_id") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

