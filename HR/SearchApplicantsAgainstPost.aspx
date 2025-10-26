<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="SearchApplicantsAgainstPost.aspx.cs" Inherits="HR_SearchApplicantsAgainstPost" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Interview / Entry Test Result</span></h2>
        <table width="100%" cellspacing="0" cellpadding="0" border="0px">
            <tr>
                <td>
                  <span style="margin-left:30%;">  <label   runat="server" class="spacing" id="Label1">
                        Advertisment
                    </label></span>
                    <asp:DropDownList ID="DDL_Advertisement" runat="server" autopostback="true" OnSelectedIndexChanged="DDL_Advertisement_SelectedIndexChanged">
                        </asp:DropDownList>
                    <label runat="server" class="spacing" id="Label2">
                        Post
                    </label>
                     <asp:DropDownList ID="ddlPosts" runat="server"  >
                        </asp:DropDownList>                   
                </td>
            </tr>
           <tr>
                <td align="center" style="padding-top: 10px;">
                    <asp:Button ID="btnSearch" Text="Search" runat="server" OnClick="btnSearch_Click"
                        CausesValidation="false" />
                        <asp:Button ID="btnReport" Text="All Applicant Report" runat="server" OnClick="btnReport_Click"
                        CausesValidation="false" />
                    <%--<asp:Button ID="btnBlankReport" runat="server" Text="Blank Merit Report" OnClick="btnBlankReport_Click"
                        CausesValidation="false" />--%>
                </td>
            </tr>
        </table>
    </div>


    <div style="width:100%;">
           <asp:GridView Width="100%" AutoGenerateColumns="false" ID="GridView_Applicants" runat="server"
            ShowHeaderWhenEmpty="true" >
            <Columns>
                <asp:TemplateField HeaderText="Sr.#">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Applicant Name" >
                    <ItemTemplate>
                        <asp:Label ID="lblAdd_App_ID" Text='<%# Eval("name") %>' 
                            runat="server"></asp:Label>
                            <asp:HiddenField ID="hfappid" runat="server" Value='<%# Eval("AppID") %>' />                            
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField HeaderText="DistrictName">
                    <ItemTemplate>
                        <asp:Label ID="lblDISTNAME" Text='<%# Eval("DistrictName") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Mobile Number">
                    <ItemTemplate>
                        <asp:Label ID="lblMNo" Text='<%# Eval("Mobile_Number") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="CNIC">
                    <ItemTemplate>
                        <asp:Label ID="lblcnic" Text='<%# Eval("CNIC") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>


                <%--<asp:TemplateField HeaderText="Advertisment Name">
                    <ItemTemplate>
                        <asp:Label ID="lblF_Name" Text='<%# Eval("Ad_Title") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Post Name">
                    <ItemTemplate>
                        <asp:Label ID="lblL_Name" Text='<%# Eval("Title") %>' runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>--%>


                <asp:HyperLinkField DataNavigateUrlFields="AppID" Target="_blank" DataNavigateUrlFormatString="./ApplicantFormWithOutPassword.aspx?appid={0}" Text="Update" HeaderText="Update"  />
                
                <asp:HyperLinkField DataNavigateUrlFields="AppID" Target="_blank" DataNavigateUrlFormatString="./Applicant_Form_Report.aspx?App_Id={0}" Text="Report" HeaderText="Report"  />
                <asp:HyperLinkField   Target="_blank" DataNavigateUrlFields="AppID" DataNavigateUrlFormatString="./EntryTest_InterviewMarks.aspx" Text="Update Marks" HeaderText="Update Marks"  />
            </Columns>
        </asp:GridView>
    </div>

 <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
           
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px"></rsweb:ReportViewer> 
</asp:Content>

