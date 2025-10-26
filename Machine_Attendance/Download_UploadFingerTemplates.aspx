<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Machine_Attendance_Download_UploadFingerTemplates, App_Web_aiw43tag" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Get All Finger Templates of Employees</span></h2>
        <table width="100%">
            <tr>
                <td align="right" class="style1">
                    <strong>Select Machine :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Machine" runat="server"
                        DataSourceID="SqlDataSource_Machines" DataTextField="Location" CssClass="drop_down"
                        DataValueField="IP_Machine" AutoPostBack="false">
                    </asp:DropDownList>
                    <asp:Label Text="" Font-Bold="true" ID="lbl_MachineMsg" runat="server" />
                    <asp:Button Text="Get All Templates" ID="btn_AllTemplates" OnClick="btn_AllTemplates_Click" CssClass="btn_hacims" runat="server" />

                    <asp:SqlDataSource ID="SqlDataSource_Machines" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand="select Location, IP_Machine from Attendence_Machines where Is_Active=1"></asp:SqlDataSource>

                    <asp:Button Text="enable" ID="enable" OnClick="enable_Click" Visible="false" runat="server" />
                </td>
                <td>
                    <div id="divMachines" runat="server">
                    <asp:CheckBoxList runat="server" ID="cbListMachines" RepeatDirection="Horizontal" RepeatColumns="3" Font-Bold="true" ForeColor="Green">
                    </asp:CheckBoxList>
                        </div>
                </td>
            </tr>
        </table>
    </div>
    </br>
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Upload Templates to All Active Machines</span></h2>
        <table style="width: 100%">
            <tr>
                <td>
                    Employee#
                    <asp:TextBox runat="server" ID="txtEmpID" />
                    <asp:Button Text="Search" OnClick="btnSearchEmp_Click" CssClass="btn_hacims" ID="btnSearchEmp" runat="server" />
                </td>
                <td align="right">
                    <asp:Button Text="Upload Templates" ID="btn_UploadTemplate" OnClick="btn_UploadTemplate_Click" CssClass="btn_hacims" runat="server" />
                    <asp:Button Text="Delete from Machine" ID="btn_Delete" OnClick="btn_Delete_Click" runat="server" CssClass="btn_hacims" />

                </td>
            </tr>
        </table>
        <asp:GridView runat="server" ID="GridViewFingerDetail" ShowHeaderWhenEmpty="true" AlternatingRowStyle-BackColor="#ffff99" AutoGenerateColumns="false" CssClass="Grid_1" OnRowDataBound="GridViewFingerDetail_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="Sr#">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Emp ID">
                    <ItemTemplate>
                        <asp:Label Text='<%#Bind("EmpID") %>' ID="lblID" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <asp:Label Text='<%#Bind("Emp_Name") %>' ID="lblName" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="0">
                    <ItemTemplate>
                        <asp:Image runat="server" ID="FigImgID0" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F0") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="1">
                    <ItemTemplate>
                        <asp:Image runat="server" ID="FigImgID1" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F1") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="2">
                    <ItemTemplate>
                        <asp:Image runat="server" ID="FigImgID2" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F2") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="3">
                    <ItemTemplate>
                        <asp:Image runat="server" ID="FigImgID3" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F3") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="4">
                    <ItemTemplate>
                        <asp:Image runat="server" ID="FigImgID4" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F4") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="5">
                    <ItemTemplate>
                        <asp:Image runat="server" ID="FigImgID5" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F5") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="6">
                    <ItemTemplate>
                        <asp:Image runat="server" ID="FigImgID6" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F6") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="7">
                    <ItemTemplate>
                        <asp:Image runat="server" ID="FigImgID7" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F7") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="8">
                    <ItemTemplate>
                        <asp:Image runat="server" ID="FigImgID8" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F8") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="9">
                    <ItemTemplate>
                        <asp:Image runat="server" ID="FigImgID9" ImageUrl="~/Images/icon_ok.png" ToolTip='<%#Bind("F9") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chkBoxSelect" ToolTip='<%#Bind("EmpID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <asp:Panel runat="server" ID="panelProgress" CssClass="lightbox_bg" Visible="false">
        <div class="lightbox">
            <div id="progressbar"></div>
           
        </div>
    </asp:Panel>

</asp:Content>

