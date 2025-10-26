<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="SampleCollectedTestReport.aspx.cs" Inherits="Pathology_PatientTestsReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="width: 100%" class="bxmain inner_content">
        <h2><span>Sample Collected Test Report</span></h2>
        <table style="width: 99%">
        
            <tr>
                        <td style="width: 20%; text-align: right">
                            From Date :</td>
                        <td >
                            &nbsp;<asp:TextBox ID="txtfromdate" runat="server" TextMode="Date">
                    </asp:TextBox>
                            <asp:textbox id="txtTimeFrom" runat="server" textmode="Time"></asp:textbox>
                            <asp:TextBox ID="hffromdate" runat="server" Visible="false" />
                        </td>
                    
                        <td style="width: 20%; text-align: right">
                            To Date :</td>
                        <td>
                            &nbsp;<asp:TextBox ID="txttodate" runat="server" TextMode="Date">
                    </asp:TextBox>
                            <asp:textbox id="txtTimeTo" runat="server" textmode="Time"></asp:textbox>
                            <asp:TextBox ID="hftodate" runat="server" Visible="false" />
                        </td>
               

            </tr>
            <tr>

                <td style="width: 20%; text-align: right">Collection Center :</td>
                <td>&nbsp
                    <asp:DropDownList ID="DropDownList1" runat="server" TabIndex="14" DataSourceID="SqlDataSource_SubDept"
                        Width="140px" DataTextField="SubDept_Name" DataValueField="SubDept_Id"
                        AutoPostBack="True">
                    </asp:DropDownList>

                </td>

                <td style="width: 20%; text-align: right">Test Group :</td>
                <td>&nbsp
                    <asp:DropDownList ID="DropDownList2" runat="server" TabIndex="14" DataSourceID="SqlDataSource_TestGroup"
                        Width="140px" DataTextField="TGName" DataValueField="TGID"
                        AutoPostBack="True">
                    </asp:DropDownList>

                </td>
            </tr>
            <tr>
                <td style="width: 20%; text-align: right">Status :</td>
                <td>&nbsp
                <asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource_Status" DataTextField="Status" 
                    DataValueField="Status_ID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_Status" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Pathology2ConnectionString %>" 
                    SelectCommand="select 0 as Status_ID, '--ALL--' as Status union SELECT Status_ID, Status FROM Test_Status where  Priority is not null" ></asp:SqlDataSource>
                </td>

                <td style="width: 20%; text-align: right">MRNo :</td>
                <td>&nbsp
                    <asp:textbox id="txtMRNo" runat="server" ></asp:textbox>
                 </td>
            </tr>
            <tr>
               

                <td style="width: 20%; text-align: right">Lab No :</td>
                <td>&nbsp
                    <asp:textbox id="txtLabNo" runat="server" ></asp:textbox>
                 </td>
            </tr>
            <tr>
                <td colspan="4" align="center">
                    <asp:button id="btnSearch" runat="server" text="Search" OnClick="btnSearch_Click" />
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlDataSource_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
            SelectCommand="select '--ALL--' as SubDept_Name, 0 as SubDept_Id union select SubDepartment.SubDept_Name,SubDepartment.SubDept_Id FROM SubDepartment where SubDept_Type=1   ORDER BY SubDept_Name ">
            <%--  <SelectParameters>
            <asp:ControlParameter ControlID="DDLDepartment" Name="Dept_Id" PropertyName="SelectedValue" />
        </SelectParameters>--%>
        </asp:SqlDataSource>

         <asp:SqlDataSource ID="SqlDataSource_TestGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
            ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>"
            SelectCommand="select '--ALL--' as TGName, 0 as TGID union select TestGroup.TGName,TestGroup.TGID FROM TestGroup ORDER BY TGName ">
        </asp:SqlDataSource>
        
    </div>
    <div style="width: 100%">
            <asp:scriptmanager id="ScriptManager1" runat="server"></asp:scriptmanager>
            <rsweb:reportviewer id="ReportViewer1" runat="server" width="100%">
        </rsweb:reportviewer>
        </div>
</asp:Content>

