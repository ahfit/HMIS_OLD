<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="CallForInterview.aspx.cs" Inherits="HR_CallForInterview" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain inner_content"  style="width:100%;">
<span  ><h2>Call For Interview</h2></span>
<div>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                    <td style="width:40%;" align="right">
                        Advertisement :&nbsp;
                    </td>
                    <td>
                        <asp:DropDownList ID="DDL_Advertisement" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDL_Advertisement_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Post :&nbsp;
                    </td>
                    <td>
                        <asp:DropDownList ID="GridViewPosts" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        InteInterview Date :&nbsp;
                    </td>
                    <td>
                        <igsch:WebDateChooser Width="180px" runat="server" ID="InterviewDate">
                                    </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                <td colspan="2"  align="center">
                <asp:Button ID="btnAdd" runat="server" Text="Search" onclick="btnAdd_Click" />
                <asp:Button ID="btnReportforSelectedInterview" runat="server" 
                        Text="Report for Interviewer's" 
                        onclick="btnReportforSelectedInterview_Click"   />
                <asp:Button ID="btnReport" Visible="true" Text="Report" runat="server" OnClick="btnReport_Click"
                        CausesValidation="false" />
                <asp:Button ID="btnReport1" Visible="true" Text="Pre Interview Report" runat="server" 
                CausesValidation="false" onclick="btnReport1_Click" />
                </td>
                </tr>
                </table>
</div>

</div>
 <div runat="server" id="appDetails" style="width:100%" class="bxmain inner_content">
            <h2><span style="font-size:20px;">Candidates</span>
                </h2>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                <%--OnDataBound="OnDataBound"--%>
                    <td>
                        <asp:GridView AutoGenerateColumns="false"   ID="gvdAApplicants" runat="server" 
                            Width="100%" onrowdatabound="gvdAApplicants_RowDataBound">
                            <Columns>
                                <asp:BoundField HeaderText="Name" DataField="Name" />
                                <asp:BoundField HeaderText="CNIC" DataField="CNIC" />
                                <asp:BoundField HeaderText="Present address" DataField="Present_address"   />
                                <asp:BoundField HeaderText="Home Address" DataField="HomeAdd"   />
                                <asp:BoundField HeaderText="Mobile_Number" DataField="Mobile_Number" />
                                <asp:BoundField HeaderText="District Name" DataField="DistrictName" /> 
                                <asp:TemplateField HeaderText="Qualification">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnQualification" runat="server" CommandArgument='<%# Eval("AppID") %>' OnClick="lnkbtnQualification_Click"
                                            Text="Qualification"></asp:LinkButton>
                                            <asp:Label ID="lblAppID" runat="server" Visible="false" Text='<%# Eval("AppID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Report">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnReport" runat="server" CommandArgument='<%# Eval("AppID") %>' OnClick="lnkbtnReport_Click"
                                            Text="Report"></asp:LinkButton>
                                            
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Experience">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkbtnExperience" CommandArgument='<%# Eval("AppID") %>'  OnClick="lnkbtnExperience_Click" runat="server" Text="Experience"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 
                                <asp:TemplateField HeaderText="Select">
                                    <ItemTemplate>
                                         <asp:CheckBox ID="chkboxCall" runat="server" ToolTip='<%# Eval("ID") %>' />
                                         <asp:Label ID="lblIsCalled" runat="server" Visible="false" Text='<%# Eval("IsCalled") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit Interview Marks" >
                                <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnInterviewMarks" runat="server" CommandArgument='<%# Eval("AppID") %>' OnClick="lnkbtnInterviewMarks_Click"
                                            Text="Edit Interview Marks"></asp:LinkButton>
                                </asp:HyperLink >
                                </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr><td align="center">
                <asp:Button ID="btnCallForInterview" runat="server" Text="Call For Interview" 
                        onclick="btnCallForInterview_Click"   />
                </td></tr>
            </table>
        </div>
         <asp:Panel ID="panel" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                <h2>
                    <span>Qualification</span></h2>
                <table width="100%">                    
                        <tr>
                            <td colspan="10">
                                <asp:GridView ID="gvdQualification" runat="server" AutoGenerateColumns="true" Width="100%">
                                    <Columns>
                                        <%--<asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imagebtn" runat="server" CommandArgument='<%# Eval("ID") %>'
                                                    ImageUrl="~/Images/delete.png" OnClick="imagebtn_Click" OnClientClick="return Confirm('Do you want to delete this record?');"
                                                    Width="16" />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                    </Columns>
                                </asp:GridView>
                                <br />
                            </td>
                        </tr>
                    <tr style="line-height: 3;">
                       
                        <td style="padding-left: 20px; text-align: center" colspan="2">                            
                            <asp:Button ID="btnQulaifictionClose" runat="server" Text="Close" OnClick="btnQulaifictionClose_Click" />                            
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="panelExperience" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                <h2>
                    <span>Experience</span></h2>
                <table width="100%">                   
                    <tr>
                        <td colspan="10">
                            <asp:GridView ID="gvdForExperience" runat="server" AutoGenerateColumns="true" Width="100%">
                                <Columns>
                                    <%--<asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imagebtn" runat="server" CommandArgument='<%# Eval("ID") %>'
                                                ImageUrl="~/Images/delete.png" OnClick="imagebtnExperience_Click" OnClientClick="return Confirm('Do you want to delete this record?');"
                                                Width="16" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                </Columns>
                            </asp:GridView>
                            <br />
                        </td>
                    </tr>
                     <tr style="line-height: 3;">
                       
                        <td style="padding-left: 20px; text-align: center" colspan="2">                            
                            <asp:Button ID="btnCloseExperience" runat="server" Text="Close" OnClick="btnCloseExperience_Click" />                            
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </asp:Panel>
    
    <div style=" Width:100%;margin:10px 20px 0 20px">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
        </rsweb:ReportViewer>
    </div>
</asp:Content>

