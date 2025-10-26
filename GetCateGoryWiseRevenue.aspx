<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="GetCateGoryWiseRevenue.aspx.cs" Inherits="GetCateGoryWiseRevenue" %>
 <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span>Category Wise Revenue Report</span></h2>


        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
              <tr>
            <td align="right"><strong>Hospital :</td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="202px" >
                    
                </asp:DropDownList> 
            </td>
       
            <td align="right">From Date :</td>
            <td>
                  <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
            </td>
        
            <td align="right">To Date :</td>
            <td>
                  <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
            </td>
       
           
                <td class="style1">
                    Counter Type :</td>
                <td class="style2">
                   <asp:DropDownList ID="DDL_CounterType" runat="server" >
                    </asp:DropDownList>
                </td>
            
           
                <td align="Left" >
                    <asp:Button ID="btnSearch" runat="server" Text="Search" Width="100px" 
                        onclick="btnSearch_Click" />
                </td>
            </tr>
        </table>
        
    </div>
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
           
             <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px" >
    </rsweb:ReportViewer>
    

</asp:Content>

