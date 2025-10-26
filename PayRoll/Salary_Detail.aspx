<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="PayRoll_Salary_Detail, App_Web_tchaehmk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 258px;
        }

        .auto-style3 {
            width: 10px;
        }
        .auto-style4 {
            width: 121px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span style="font-size: 20px ! important">Salary Detail Report</span></h2>
        <hr />
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%" style="margin-top:20px">
            <tr>
                <td align="right"><b>Name :&nbsp;</b></td>
                <td class="auto-style1">
                    <asp:TextBox ID="txtName" runat="server" Text="" Width="252px"></asp:TextBox>
                </td>
                <td class="auto-style3"></td>
               <td align="right"><b>Year :&nbsp; </b> </td>
                <td>
                    <asp:DropDownList ID="ddl_Year" runat="server" Width="126px">
                        
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" class="auto-style4"><b>Desiganition :&nbsp;</b></td>
                <td>
                    <asp:DropDownList ID="ddl_desg" runat="server" AutoPostBack="true" Width="252px" OnLoad="Page_Load">
                        <asp:ListItem Value="0" Text="All"></asp:ListItem>
                    </asp:DropDownList>
                    
                </td>
                <td></td>
                <td align="right" class="auto-style4" ><b>Month :&nbsp;</b></td>
                <td>
                    <asp:DropDownList ID="ddl_Month" runat="server" Width="126px">
                        
                        <asp:ListItem Value="1">Jan</asp:ListItem>
                        <asp:ListItem Value="2">Feb</asp:ListItem>
                        <asp:ListItem Value="3">Mar</asp:ListItem>
                        <asp:ListItem Value="4">Apr</asp:ListItem>
                        <asp:ListItem Value="5">May</asp:ListItem>
                        <asp:ListItem Value="6">June</asp:ListItem>
                        <asp:ListItem Value="7">July</asp:ListItem>
                        <asp:ListItem Value="8">Aug</asp:ListItem>
                        <asp:ListItem Value="9">Sep</asp:ListItem>
                        <asp:ListItem Value="10">Oct</asp:ListItem>
                        <asp:ListItem Value="11">Nov</asp:ListItem>
                        <asp:ListItem Value="12">Dec</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
              <td align="right" class="auto-style4"><b>Deptarment :&nbsp; </b></td>
                <td>
                    <asp:DropDownList ID="ddl_department" AutoPostBack="true" runat="server" Width="252px" OnLoad="Page_Load">
                        <asp:ListItem Value="0" Text="All"></asp:ListItem>
                    </asp:DropDownList>
                </td>
               
                <td></td>
               
                <td align="right"><b>Payment Type :&nbsp;</b></td>
                <td>
                    <asp:DropDownList ID="salary_TeleMode" runat="server" Width="126px">
                        <asp:ListItem Value="0" Text="All"></asp:ListItem>
                        <asp:ListItem Value="1">Cash</asp:ListItem>
                        <asp:ListItem  Value="2">Bank</asp:ListItem>
                        <asp:ListItem  Value="3">Check</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                
                <td class="auto-style3"></td>
                <td align="right" class="auto-style4"></td>
                <td></td>
            </tr>
            <tr><td></td><td></td><td></td><td></td><td></td></tr>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td class="auto-style4">
                    <asp:Button ID="btn_Report" Text="Salary Report" runat="server"  OnClick="btn_Report_Click"/>
                </td>
                <td></td>
            </tr>
        </table><hr />
      
    </div>
      
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%"></rsweb:ReportViewer>
        
</asp:Content>

