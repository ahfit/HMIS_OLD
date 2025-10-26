<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="DischargedPatient.aspx.cs" Inherits="Patient_Billing_DischargedPatient" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            width: 100%;
        }

        .style2 {
            width: 386px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager runat="server" id="ScriptManager1"/>
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Discharge Patients</span></h2>

        <table class="style1">
            <tr>
                <td width="40%" align="right">Start Date
                </td>
                <td width="60%" align="left">
                    <asp:TextBox runat="server" ID="txtSDate" TextMode="Date" />
                </td>
            </tr>
            <tr>
                <td width="40%" align="right">End Date
                </td>
                <td width="60%" align="left">
                    <asp:TextBox runat="server" ID="txtEDate" TextMode="Date" />
                </td>
            </tr>
            <tr>
                <td width="40%" align="right">Reg #</td>
                <td width="60%" align="left">
                    <asp:TextBox ID="txtRegNo" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td width="40%" align="right">Visit #</td>
                <td width="60%" align="left">
                    <asp:TextBox ID="txtVisitNo" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>

                <td colspan="2" align="center">
                    <asp:Button ID="btnReport"  runat="server" Text="View" 
                        OnClick="btnReport_Click" />

                </td>
            </tr>

        </table>
        <asp:GridView runat="server" ID="GridView1" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false">
            <Columns>
                <asp:TemplateField HeaderText="Sr#">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
            
             <asp:TemplateField HeaderText="RegNo">
                    <ItemTemplate>
                        <asp:Label Text='<%#Bind("RegNo") %>' ID="lblRegNo" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Visit#">
                    <ItemTemplate>
                        <asp:Label Text='<%#Bind("payid") %>' ID="lblpayid" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <asp:Label Text='<%#Bind("Name") %>' ID="lblName" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Reg Date">
                    <ItemTemplate>
                        <asp:Label Text='<%#Bind("RegDate") %>' ID="lblRegDate" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <%-- <asp:TemplateField HeaderText="Discharge Date">
                    <ItemTemplate>
                        <asp:Label Text='<%#Bind("") %>' ID="lbl" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>--%>
                 <asp:TemplateField >
                    <ItemTemplate>
                        <asp:LinkButton ID="lbtnChange" Text="Change Status" CommandArgument='<%#Bind("payid") %>' OnClick="lbtnChange_Click" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    
</asp:Content>
