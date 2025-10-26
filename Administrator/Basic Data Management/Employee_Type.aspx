<%@ page language="C#" autoeventwireup="true" inherits="HR_Employee_Type, App_Web_olgkf540" masterpagefile="~/hacims_masterpage_admin.master" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">




    <script language="javascript" type="text/javascript">




    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width:100%">
      <span>
            <h2>Add Employee Type</h2>
        </span>
          <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
            <tr>
                <td align="right">Employee Type :
                </td>
                <td width="60%">
                    <asp:TextBox CssClass="input_txt" runat="server" ID="txtboxDeptType"></asp:TextBox>
                    <asp:Button CssClass="btn_hacims" runat="server" ID="btnSave" Text="Save" OnClick="btnSave_Click" />
                    <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:GridView ID="GridView1" CssClass="Grid_1" runat="server" AutoGenerateColumns="False" AllowPaging="True" Width="100%" PageSize="25">
        <Columns>
            <asp:BoundField DataField="Employee_type_Id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="Employee_type_Id" />
            <asp:BoundField DataField="Type" HeaderText="Employee Type Name"  ReadOnly="True" SortExpression="Type" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton runat="server" ID="lbtnDelete" ToolTip='<%# Bind("Employee_type_Id") %>' Text="Delete" OnClick="lbtnDelete_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>
