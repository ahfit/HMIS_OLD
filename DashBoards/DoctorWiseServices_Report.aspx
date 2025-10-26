<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="DoctorWiseServices_Report.aspx.cs" Inherits="DashBoards_DoctorWiseServices_Report" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            text-align: right;
            width: 50%;
        }

        .style2 {
            text-align: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span>Department Wise Patients</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
           
              <tr>
                <td align="right" style="width: 10%;">
                    <strong>Hospital :</td>
                <td style="width: 10%;">
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="202px" >
                    
                </asp:DropDownList> 
                </td>
                <td align="right" style="width: 10%;">
                    <b>Service Category:</b>
                </td>
                <td style="width: 10%;">
                    <asp:DropDownList ID="ddlCategory" AutoPostBack="true" runat="server" DataTextField="Asc_Name"
                        DataValueField="Asc_id"
                        OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                <td>
                    &nbsp;</td>
            </tr>

            <tr>
                <td align="right" style="width: 10%;">
                    <b>Duty Department:</b>
                </td>
                <td style="width: 10%;">
                    <asp:DropDownList ID="ddlDepartment" runat="server" AutoPostBack="false">
                    </asp:DropDownList>
                </td>
                <td align="right" style="width: 10%;">
                    <b>Services : </b>
                </td>
                <td style="width: 10%;">
                    <asp:TextBox ID="txtboxServices" placeholder="Search Services" runat="server" AutoPostBack="true"
                        OnTextChanged="txtboxServices_TextChanged"></asp:TextBox>
                    <br />
                    <asp:DropDownList ID="ddlServcies" runat="server" ></asp:DropDownList>

                </td>
                <td align="right" style="width: 10%;">
                    <b>
                    <asp:Button ID="btnSearchServices" Text="Search Services" Visible="false" runat="server" OnClick="btnSearchServices_Click" />
                    </b>
                </td>
                <td style="width: 10%;"></td>
            </tr>
            <tr>
                <td align="right" style="width: 10%;">
                    <b>From Date : </b>
                </td>
                <td style="width: 10%;">
                    <igsch:WebDateChooser ID="wdcStartDate" runat="server" Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
                 <td align="right" style="width: 10%;">
                    <b>Doctor Department : </b>
                </td>
                <td style="width: 10%;">
                    <asp:DropDownList ID="DDL_DoctorDepartment" runat="server" OnSelectedIndexChanged="DDL_DoctorDepartment_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>

                </td>
                <td align="right" style="width: 10%;">
                    <b></b>
                </td>
                <td style="width: 10%;"></td>
            </tr>
            <tr>
                <td align="right" style="width: 10%;">
                    <b>To Date : </b>
                </td>
                <td style="width: 10%;">
                    <igsch:WebDateChooser ID="wdcEndDate" runat="server" Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
                 <td align="right" style="width: 10%;">
                    <b>Doctor : </b>
                </td>
                <td style="width: 10%;">
                    <asp:DropDownList ID="ddlDoctor" runat="server"></asp:DropDownList>
                </td>
                <td align="right" style="width: 10%;">
                    &nbsp;</td>
                <td style="width: 10%;">&nbsp;</td>
            </tr>
            <tr>


                <td align="right" style="width: 10%;">
                    &nbsp;</td>
                <td style="width: 10%;">
                    &nbsp;</td>
               
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" Width="100px" OnClick="btnSearch_Click" />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px">
    </rsweb:ReportViewer>
    <asp:SqlDataSource ID="sdsPatientCount" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="PatientCount_Ultrasound_Report_DoctorWise" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Start_Date" Type="DateTime" />
            <asp:Parameter Name="End_Date" Type="DateTime" />
            <asp:Parameter Name="CategoryId" Type="Int16" />
            <asp:Parameter Name="serviceID" Type="Int16" />
            <asp:Parameter Name="DepatmentID" Type="Int16" />
            <asp:Parameter Name="DoctorID" Type="Int16" />
            <asp:Parameter Name="HospitalID" Type="Int16" />

            <%--<asp:ControlParameter Name="CategoryId" ControlID="ddlCategory" Type="Int16" PropertyName="SelectedValue" />--%>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
