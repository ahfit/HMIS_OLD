<%@ Page  Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AddEditDialysisMachine.aspx.cs" Inherits="Pt_EMR_AddEditDialysisMachine" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span>Add Dialysis Machine</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td align="right" style="width: 10%;">
                    <b>Department:</b>  </td>
                <td style="width: 10%;">
                    <asp:DropDownList ID="ddlsubdepartment" AutoPostBack="true" OnSelectedIndexChanged="ddlsubdepartment_SelectedIndexChanged" runat="server" DataValueField="SubDept_Id" DataTextField="SubDept_Name">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" style="width: 10%;">
                    <b>Session:</b>
                </td>
                <td style="width: 10%;">
                    <asp:DropDownList ID="ddlSession" runat="server" DataTextField="Session_Name" DataValueField="Session_ID">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td align="right" style="width: 10%;">
                    <b>Machine Name :</b>
                </td>
                <td style="width: 10%;">
                    <asp:TextBox ID="textMachine" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="btn_save" runat="server" Text="Save" OnClick="btn_save_Click" />
                    <asp:Label ID="lblmsg" Text="Save Successfully...." Visible="false" runat="server"></asp:Label>
                </td>

            </tr>

        </table>
    </div>


    <div style="margin-top: 10px; padding-top: 10px;" class="bxmain inner_content">
     
        <asp:GridView ID="gridview" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:TemplateField HeaderText="Department">

                    <ItemTemplate>
                        <asp:Label ID="label1" Text='<%# Bind("SubDept_Name") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Session">
                    <ItemTemplate>
                        <asp:Label ID="labelSession" Text='<%# Bind("Session_Name") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Machine Name">
                    <ItemTemplate>
                        <asp:Label ID="labelMachine" Text='<%# Bind("MachineName") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date">
                    <ItemTemplate>
                        <asp:Label ID="labelDate" Text='<%# Bind("Datetime") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Created by">
                    <ItemTemplate>
                        <asp:Label ID="labelDate" Text='<%# Bind("Name") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="del" Text="Delete" CommandName='<%# Bind("id") %>' runat="server" OnClick="deleteRecord"> </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>













</asp:Content>

