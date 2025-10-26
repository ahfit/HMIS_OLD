<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Advertisement_Status.aspx.cs" Inherits="HR_Advertisement_Advertisement_Status" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7DD5C3163F2CD0CB"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            width: 40%;
            text-align: right;
        }

        .style2 {
            width: 60%;
            text-align: left;
        }

        .Panelstyle1 {
            width: 22%;
            text-align: right;
        }

        .Panelstyle2 {
            width: 22%;
            text-align: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>All Advertisement </span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td class="style1">Advertisement Type</td>
                <td class="style2">
                    <asp:DropDownList runat="server" ID="DDL_AD_Status" AutoPostBack="true" OnSelectedIndexChanged="DDL_AD_Status_SelectedIndexChanged">
                        <asp:ListItem Value="-1" Text="--ALL--" />
                        <asp:ListItem Value="1" Text="Active" />
                        <asp:ListItem Value="0" Text="Deactive" />
                    </asp:DropDownList>
                </td>
            </tr>

        </table>
        <asp:GridView ID="GridView1" runat="server" Width="100%" AutoGenerateColumns="False"
            AllowPaging="True" PageSize="50" EmptyDataText="No Record(s) Found">
            <Columns>
                <asp:TemplateField HeaderText="Sr.#">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Title">
                    <ItemTemplate>
                        <asp:Label ID="lblTitle" ToolTip='<%# Bind("Ad_Id") %>' Text='<%# Bind("Ad_Title") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description">
                    <ItemTemplate>
                        <asp:TextBox ID="txtDescription" Width="350px" Height="70px" Enabled="false" Text='<%# Bind("Description") %>' TextMode="MultiLine" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Start Date">
                    <ItemTemplate>
                        <asp:Label ID="lblStartDate" Text='<%# Bind("Start_Date") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="End Date">
                    <ItemTemplate>
                        <asp:Label ID="lblEndDate" Text='<%# Bind("End_Date") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Current Status">
                    <ItemTemplate>
                        <asp:Label ID="lblCurrent_Status" Text='<%# Bind("Advertisement_Status") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton Text="Active/Deactive" ToolTip='<%# Bind("Is_Active") %>' CommandArgument='<%# Bind("Ad_Id") %>' runat="server" ID="lbtnChangeStatus" OnClick="lbtnChangeStatus_Click" />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>

    </div>
</asp:Content>
