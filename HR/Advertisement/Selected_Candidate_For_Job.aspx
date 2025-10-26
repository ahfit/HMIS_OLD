<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_Advertisement_Selected_Candidate_For_Job, App_Web_sbolykjk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content"  style="width:100%;">
<span  ><h2>Search</h2></span>
<div>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                    <td style="width:40%;" align="right">
                        Advertisement :&nbsp;
                    </td>
                    <td>
                        <asp:DropDownList ID="DDL_Advertisement" runat="server" OnSelectedIndexChanged="DDL_Advertisement_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Post :&nbsp;
                    </td>
                    <td>
                        <asp:DropDownList ID="GridViewPosts" runat="server" OnSelectedIndexChanged="GridViewPosts_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Candidate Type
                    </td>
                    <td>
                        <asp:DropDownList ID="DDL_Candidate_Type" runat="server" AutoPostBack="true" OnSelectedIndexChanged="GridViewPosts_SelectedIndexChanged">
                            <asp:ListItem Value="0" Text="Not Selected" />
                            <asp:ListItem Value="1" Text="Selected" />
                        </asp:DropDownList>
                    </td>
                </tr>
 
                </table>
</div>

</div>
 <div runat="server" id="appDetails" style="width:100%" class="bxmain inner_content">
            <h2><span style="font-size:20px;">
               Selected Candidate's</span></h2>
            <br />
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                <%--OnDataBound="OnDataBound"--%>
                    <td>
                        <asp:GridView AutoGenerateColumns="false"   ID="gvdAApplicants" runat="server" OnRowDataBound="gvdAApplicants_RowDataBound"
                            Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="Sr.#">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Name" DataField="Name" />
                                <asp:BoundField HeaderText="CNIC" DataField="CNIC" />
                                <asp:BoundField HeaderText="Mobile_Number" DataField="Mobile_Number" />
                                <asp:BoundField HeaderText="email_address" DataField="email_address"   />
                                <asp:BoundField HeaderText="Address" DataField="HomeAdd" /> 
                                <asp:BoundField HeaderText="District" DataField="DistrictName" /> 
                                <asp:BoundField HeaderText="Status" DataField="Status" /> 
                                <asp:TemplateField HeaderText="Appointment Letter">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtnAppointLetter" runat="server" CommandArgument='<%# Eval("AppID") %>' OnClick="lbtnAppointLetter_Click"
                                            Text="Appointment Letter"></asp:LinkButton>
                                            <asp:Label ID="lblAppID" runat="server" Visible="false" Text='<%# Eval("AppID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Arrival Report">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtnArrivalReport" CommandArgument='<%# Eval("AppID") %>'  OnClick="lbtnArrivalReport_Click" runat="server" Text="Arrival Report"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            
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
                </table>
            </div>
        </div>
    </asp:Panel>
</asp:Content>

