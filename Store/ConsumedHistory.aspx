<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Store_ConsumedHistory, App_Web_tnnmgguv" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
     <div class="bxmain inner_content" style="width:100%;">
        <div><h2><span>Consumed History</span></h2></div>
         <div style="width:100%; height:30px"></div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" id="TABLE1">

             <tr>
                <td align="right">
                    Department :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListDepartment" runat="server" Width="200px" AutoPostBack="True"
                        Css OnSelectedIndexChanged="DropDownListDepartment_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Sub Department :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListSubDepartment" runat="server" Width="200px" AutoPostBack="True"
                        Css  OnSelectedIndexChanged="DropDownListSubDepartment_SelectedIndexChanged" >
                    </asp:DropDownList>
                </td>
            </tr>
            
            
            
            
            <tr>
                <td align="right">
                    Employee :
                </td>
                <td>
                    <asp:DropDownList ID="DDLEMployee" runat="server" Width="200px" AutoPostBack="True"
                        Css >
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">
                    Start From :
                </td>
                <td width="60%" >
                    <igsch:WebDateChooser ID="WebStartDate" runat="server" CssClass="drop_date" Width="202px">
                        <AutoPostBack ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="right">
                    End Date :
                </td>
                <td width="60%" >
                    <igsch:WebDateChooser ID="WebEndDate" runat="server" CssClass="drop_date" Width="202px">
                        <AutoPostBack ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
           
            
            
            
            <tr>
                <td align="right">
                    &nbsp;
                </td>
                <td>
                    <asp:Button ID="ButtonSave" runat="server" Text="Save" OnClick="ButtonSave_Click" />
                    <asp:LinkButton CssClass="login_link" ID="LinkButton1" runat="server" Visible="False">Show All Shift</asp:LinkButton>
                    <asp:Label ID="lblMsg" runat="server" Font-Bold="False" ForeColor="Red"></asp:Label></td>
            </tr>
        </table>
    </div>
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="90%">
        </rsweb:ReportViewer>
    </div>
</asp:Content>

