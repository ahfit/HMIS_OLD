<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Patient_Registration_EmployeeDuty_Department, App_Web_5tqtaelx" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%">
        <h2>
            <span>Assign Duties To Doctors </span>
        </h2>
        <%--<table class="diagnosis_list">--%>
        <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="right" style="width: 30px;">
                    <b>Department:</b> &nbsp;
                </td>
                <td>
                    <asp:DropDownList ID="ddldept"  
                        runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <b>Sub Department:&nbsp;</b>
                </td>
                <td>
                    <asp:DropDownList ID="ddlsubdept" runat="server">
                    </asp:DropDownList>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">
                    <b>Doctors&nbsp;</b>
                </td>
                <td>
                    <asp:DropDownList ID="ddldoctors" runat="server">
                    </asp:DropDownList>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <br />
                    <asp:Button ID="savebtn" Text="Save" OnClick="savebtn_Click" runat="server" />
                    <asp:Label Text="Saved Successfully.." Visible="false" ID="lblMsg" runat="server" />
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                </td>
            </tr>
            <tr>
                <td colspan="2" width="100%">
                    <asp:GridView ID="gride2" AutoGenerateColumns="false" runat="server">
                        <Columns>
                            <asp:BoundField DataField="Dept_Name" HeaderText="Department" />
                            <asp:BoundField DataField="SubDept_Name" HeaderText="Duty SubDepartment" />
                            <asp:BoundField DataField="EFName" HeaderText="Doctor" />
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:LinkButton Text="Delete" ID="btnDelete" autopostBack="true" OnClick="btnDelete_Click"
                                        CommandArgument='<%# Bind("ID") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
