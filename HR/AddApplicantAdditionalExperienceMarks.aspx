<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="AddApplicantAdditionalExperienceMarks.aspx.cs"
    Inherits="HR_AddApplicantAdditionalExperienceMarks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            text-align: right;
            width: 50%;
        }
        .style2
        {
            text-align: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Add Additional Qualification and Experience Marks</span></h2>
        <table width="100%">
            <tr>
                <td class="style1">
                    Advertisment :
                </td>
                <td class="style2">
                    <asp:DropDownList ID="DDL_Advertisement" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDL_Advertisement_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    Post :
                </td>
                <td class="style2">
                    <asp:DropDownList ID="ddlPosts" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPosts_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
             <tr>
                <td class="style1">
                    Qualifucation :
                </td>
                <td class="style2">
                    <asp:DropDownList ID="ddlQualification" runat="server" AutoPostBack="true" >
                    </asp:DropDownList>
                </td>
            </tr>


            <tr>
                <td>
                    <div style="width: 100%">
                        <table id="idExperience" runat="server" visible="false" width="100">
                            <tr>
                                <td style="width: 50%;">
                                    Experience
                                </td>
                                <td style="width: 50%;">
                                    <asp:Label ID="lblExperience" ForeColor="Red" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
                <td class="style2">
                    <div>
                        <table id="idAdditionalMarks" runat="server" visible="false" width="100%">
                            <tr>
                                <td>
                                    Addidtional Marks
                                </td>
                                <td>
                                    <asp:Label ID="lblAdditionalMarks" ForeColor="Red" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button Text="Search" ID="btnSarch" runat="server" 
                        onclick="btnSarch_Click" />
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td style="width: 30%">
                    <asp:GridView ID="gvd" runat="server" AutoGenerateColumns="false" 
                        onrowdatabound="gvd_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Qualification Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblQualifincationName" runat="server" Text='<%# Eval("Qualification_Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Percentage">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hfQid" runat="server" Value='<%# Eval("Qualification_Id") %>' />
                                    <asp:HiddenField ID="hfMeritID" runat="server" Value='<%# Eval("MeritCriteriaID") %>' />
                                    <asp:Label ID="lblQualifincationPercentage" runat="server" Text='<%# Eval("Percentage") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
                <td>
                
                </td>
                 <td style="width: 65%">
                    <asp:GridView ID="gvdAddMarks" runat="server" AutoGenerateColumns="false">
                        <Columns>
                            <asp:TemplateField HeaderText="Applicant Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblAppName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                    <asp:Label ID="lblAppID" runat="server" Visible="false" Text='<%# Eval("AppId") %>'></asp:Label>
                                    <%--<asp:Label ID="lblAppPercentageID" runat="server" Visible="false" Text='<%# Eval("AppPercentageID") %>'></asp:Label>--%>
                                    
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="false" HeaderText="Additional Marks">
                                <ItemTemplate>                                
                                    <asp:Label ID="lblAdditionalMarks" runat="server" Text='<%# Eval("AdditionalMarks") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Experience">
                                <ItemTemplate>
                                    <asp:Label ID="lblPercentage" runat="server" Text='<%# Eval("Appexperience") %>'></asp:Label>
                                    <asp:Label ID="lblMerit" Visible="false" runat="server" Text='<%# Eval("MeritCriteriaID") %>'></asp:Label>
                                    
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="Add Marks">
                                <ItemTemplate>
                                    <asp:TextBox AutoPostBack="true"  ID="txtAddAddMarks" runat="server" SkinID="intdata" 
                                        ontextchanged="txtAddAddMarks_TextChanged" ></asp:TextBox>
                                        <asp:Label ID="lblMarks" Visible="false" runat="server" Text="Enter Correct Marks"></asp:Label>
                                        
                                        
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--  <asp:TemplateField HeaderText="Add Experience">
                                <ItemTemplate>
                                    <asp:TextBox AutoPostBack="true" SkinID="intdata"  ontextchanged="txtAddExperience_TextChanged" ID="txtAddExperience" runat="server" ></asp:TextBox>
                                    <asp:Label ID="lblexperience" Visible="false" runat="server" Text="Enter Correct Marks"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                              <asp:TemplateField HeaderText="Update">
                                <ItemTemplate>
                                    <asp:Button ID="btn" runat="server" Text="Update" OnClick="btn_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
                <td>
                
                </td>

            </tr>
        </table>
    </div>
</asp:Content>
