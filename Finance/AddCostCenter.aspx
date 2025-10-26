<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AddCostCenter.aspx.cs" Inherits="Finance_AddCostCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Add Cost Center</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
              <tr>
                <td align="right">Hospital:</td>

                <td>
                    <asp:DropDownList ID="ddlHospital" Enabled="false" runat="server" CssClass="dropbox"
                        Width="262px" DataSourceID="sdsHospital" DataTextField="Hospital_Name"
                        DataValueField="Hospital_ID" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsHospital" runat="server"
                        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        SelectCommand=" SELECT distinct    Hospital.Hospital_ID, Hospital.Hospital_Name FROM  Hospital">
                    </asp:SqlDataSource>

                </td>
            </tr>
              <tr>
                <td align="right">Main Cost Center :</td>

                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" Width="262px" AutoPostBack="true" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged"></asp:DropDownList>&nbsp;</td>
            </tr>
            <tr>
                <td align="right">Cost Center Name : </td>
                <td align="left">
                    <asp:TextBox ID="txtName" runat="server" style="width: 22em;"></asp:TextBox>
                </td>
               
            </tr>
            <tr>
                 <td colspan="2"  align="center" >
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click1"/>
                </td>
            </tr>
          
        </table>
    </div>
    <br />
    <asp:GridView ID="gvCostCenter" runat="server" AutoGenerateColumns="false"
        Width="100%">
        <Columns>
            <asp:TemplateField HeaderText="Sr. #">
                <ItemTemplate>
                    <%# Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CostCenterName" HeaderText="Cost Center Name" />
            <asp:BoundField DataField="Hospital_Name" HeaderText="Hospital Name" />

        </Columns>
    </asp:GridView>
</asp:Content>

