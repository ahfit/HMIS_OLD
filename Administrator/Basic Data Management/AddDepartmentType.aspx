<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="AddDepartmentType, App_Web_olgkf540" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h3 style="margin-left: 470px; font-family:'Times New Roman' ">Add Department Type</h3>
    <div style="text-align: center;width:50px; margin-left: 370px; margin-top: 10px; height: 10px">
        <table runat="server">
            <tr>
                <td style="text-align: right"><label style="font-size:medium">DeptType: </label></td>
                <td style="margin-left:10px">
                    <asp:TextBox ID="txtDeptType" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr colspan="2">
                <td></td>
                <td>
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top:70px;margin-left:300px;text-align:center;width:520px;height:150px;overflow-y:scroll">
        <asp:GridView ID="GridView1" Width="500px" runat="server" AutoGenerateColumns="false">
            <Columns >
                <asp:TemplateField HeaderStyle-Width="30px" HeaderText="ID">
                    <ItemTemplate >
                        <asp:Label ID="lblID" runat="server" Text='<% #Bind("Dept_Type_Id") %>' ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderStyle-Width="140px" HeaderText="Department Type Name">
                    <ItemTemplate>
                        <asp:Label ID="lblName" runat="server" Text='<% #Bind("Dept_Type_Name") %>' ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderStyle-Width="50px"  HeaderText="Is Active">
                    <ItemTemplate >
                        <asp:Label ID="lblActive" runat="server" Text='<% #Bind("is_Active") %>' ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Delete">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<% #Bind("Dept_Type_Id") %>' Text="Delete" onClick="btnDelete_Click"/>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Edit">
                    <ItemTemplate>  
                        <asp:LinkButton ID="btn_Edit" CommandArgument='<% #Bind("Dept_Type_Id") %>' runat="server" Text="Edit" onClick="btn_Edit_Click" />  
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
        
    </div>
</asp:Content> 

