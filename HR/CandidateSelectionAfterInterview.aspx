<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="CandidateSelectionAfterInterview.aspx.cs" Inherits="HR_CandidateSelectionAfterInterview" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content"  style="width:100%;">
<span  ><h2>Candidate Select After Interview</h2></span>
<div>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                    <td style="width:40%;" align="right">
                        Advertisement :&nbsp;
                    </td>
                    <td>
                        <asp:DropDownList ID="DDL_Advertisement" autopostback="true" runat="server" OnSelectedIndexChanged="DDL_Advertisement_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Post :&nbsp;
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlPosts" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr style="display:none">
                    <td align="right">
                        Interview Date :&nbsp;
                    </td>
                    <td>
                        <igsch:WebDateChooser Width="180px" runat="server" ID="InterviewDate">
                                    </igsch:WebDateChooser>
                    </td>
                </tr>
                <tr>
                <td colspan="2"  align="center">
                <asp:Button ID="btnAdd" runat="server" Text="Search" onclick="btnAdd_Click" />
                
                </td>
                </tr>
                </table>
</div>

</div>
<div runat="server" id="appDetails" style="width:100%" class="bxmain inner_content">
            <h2><span style="font-size:20px;">
                Candidate's</span></h2>
            <br />
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
               
                    <td>
                        <asp:GridView  AutoGenerateColumns="true"    ID="gvdAApplicants" runat="server" 
                            Width="100%" onrowdatabound="gvdAApplicants_RowDataBound" 
                            onprerender="gvdAApplicants_PreRender"  >
                            <Columns>
                                 <asp:TemplateField HeaderText="Select">
                                    <ItemTemplate>
                                         <asp:CheckBox ID="chkboxCall" runat="server" ToolTip='<%# Eval("ID") %>'  />
                                         <asp:Label ID="lblIsCalled" runat="server" Visible="false" Text='<%# Eval("Is_Selected") %>' ></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>                                                   
                                <%--<asp:TemplateField HeaderText="Box">
                                    <ItemTemplate>
                                         <asp:TextBox ID="txtbox" Text='<%# Eval("Advrertisment") %>' runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>                                                   

                                <asp:TemplateField HeaderText="Box">
                                    <ItemTemplate>
                                         <asp:TextBox ID="txtbox" Text='<%# Eval("Title") %>' runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>                                                   

                                 <asp:TemplateField HeaderText="Box">
                                    <ItemTemplate>
                                         <asp:TextBox ID="txtbox" Text='<%# Eval("Name") %>' runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField> 
--%>
                                
                                 <%--<asp:TemplateField HeaderText="Box">
                                    <ItemTemplate>
                                         <asp:TextBox ID="txtbox" Text='<%# Eval("Qualification_Name") %>' runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField> --%>
                                
                                
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr><td align="center">
                <asp:Button ID="btnSelection" runat="server" Text="Select" 
                        onclick="btnSelection_Click"   />
                </td></tr>
            </table>
        </div>
</asp:Content>

