<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AssignAdminServiceRate.aspx.cs" Inherits="Patient_Billing_AssignAdminServiceRate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div clase="bxmain inner-content" style="width: 100%">
        <h3><span>Assign OPD Services</span></h3>
    </div>
    <table class="style1">
        <tr>
            <td align="right">
                <b>Hospital :</b></td>
            <td>
                <asp:dropdownlist id="ddlhospital" Enabled="false" runat="server" width="202px">
                                </asp:dropdownlist>
            </td>
        </tr>
        <tr>
            <td align="right">
                <b>Patient Type :</b></td>
            <td>
                <asp:dropdownlist id="ddlPatientType" runat="server" width="202px"
                    autopostback="True"
                    onselectedindexchanged="ddlPatientType_SelectedIndexChanged">
                                </asp:dropdownlist>
            </td>
        </tr>
        <tr>
            <td align="right">
                <b>Service Category :</b></td>
            <td>
                <asp:dropdownlist id="ddlCategory" runat="server" width="202px"
                    autopostback="True" onselectedindexchanged="ddlCategory_SelectedIndexChanged">
                                </asp:dropdownlist>
            </td>
        </tr>
        <tr>
            <td align="right">
                <b>Service :</b></td>
            <td>
                <asp:dropdownlist id="ddlServices" AutoPostBack="true" onselectedindexchanged="ddlServices_SelectedIndexChanged" runat="server"
                    width="202px">
                                </asp:dropdownlist>
            </td>
        </tr>

        <tr >
            <td align="right">
                <b>Sub Department :</b></td>
            <td>
                <asp:dropdownlist id="DDL_SubDepartment"  AutoPostBack="true" onselectedindexchanged="DDL_SubDepartment_SelectedIndexChanged"  runat="server"
                    width="202px">
                                </asp:dropdownlist>
            </td>
        </tr>

        <tr>
            <td align="right">
                <b>Amount :</b></td>
            <td>
                <asp:textbox id="txtbox" runat="server" width="202px"></asp:textbox>

            </td>
        </tr>

        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:button id="btn_Update" runat="server" text="Save" onclick="btn_Update_Click" />
                <asp:label id="lblmsg" text="Save Successfully...." visible="false" runat="server"></asp:label>
            </td>

        </tr>
        <tr>
            <td colspan="20">
                <asp:gridview id="GridView1" runat="server" autogeneratecolumns="false">
                  <Columns>
    <asp:TemplateField HeaderText="Patient Type ">
            <ItemTemplate>
            <asp:Label ID="lblid" Text='<%# Bind("Patient_type") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>


    <asp:TemplateField HeaderText="Service Name">
            <ItemTemplate>
            <asp:Label ID="lblname" Text='<%# Bind("S_Name") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

     <asp:TemplateField HeaderText="Amount ">
            <ItemTemplate>
            <asp:Label ID="lblname" Text='<%# Bind("S_Amount") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

           
</Columns>

                </asp:gridview>
            </td>

        </tr>
    </table>
</asp:Content>

