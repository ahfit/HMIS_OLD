<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="ConsultantWisePkgsReport.aspx.cs" Inherits="Patient_Billing_ConsultantWisePkgsReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>




      <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            
            <span><asp:Label runat="server" ID="lblHeader" Text="Search DateWise GRN"></asp:Label> </span></h2>
        <table style="width: 100%;">
            <tr>
                 <td align="right" style="width: 10%;">
                    <b>Department : </b>
                        </td>
                <td style="width: 10%;">
                    <asp:DropDownList ID="DDL_DoctorDepartment" runat="server" OnSelectedIndexChanged="DDL_DoctorDepartment_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>

                </td>
                   <td align="right" style="width: 10%;">
                    <b>From Date : </b>
                </td>
                <td style="width: 10%;">
                    <asp:TextBox runat="server" ID="wdcStartDate" TextMode="Date" />
                </td>
            
            </tr>

            <tr>
                                   <td align="right" style="width: 10%;">
                    <b>Doctor : </b>
                </td>
                <td style="width: 10%;">
                    <asp:DropDownList ID="ddlDoctor" runat="server"></asp:DropDownList>

                </td>

                   <td align="right" style="width: 10%;">
                    <strong>To Date :</strong>
                        </td>
                <td style="width: 10%;">
                   <asp:TextBox runat="server" ID="wdcEndDate" TextMode="Date" />
                </td>
            </tr>

            
            <tr>
               

                  <td align="right" style="width: 10%;">
                    <strong>Packages :</strong>
                </td>
                <td style="width: 10%;">
                  <asp:DropDownList ID="DropDownPackages" runat="server" Width="202px" >
                    
                </asp:DropDownList> 
                </td>
                  
                   <td align="right" style="width: 10%;">
                       &nbsp;</td>
                <td style="width: 10%;">
                    &nbsp;</td>
            </tr>
       
       
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td>
                     <asp:Button ID="Button1" runat="server" Text="View Report" OnClick="Button1_Click" />
                </td>
                <td>
                </td>
            </tr>
        </table>
    </div>
    <br />
       <div>
         <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px">
    </rsweb:ReportViewer>
    </div>
</asp:Content>
