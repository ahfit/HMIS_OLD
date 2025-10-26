<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="UpdateServicesAgainstDoctor.aspx.cs" Inherits="Patient_Billing_UpdateServicesAgainstDoctor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%">
        <h2>
            <span>Update Services Against Doctor </span>
        </h2>
        <table width="100%" style="margin-top=20px">
            <tr >
                <td align="right" width="40%" >
                    From Date :</td>
                <td align="left">
                    <asp:textbox id="txtDateFrom" runat="server" textmode="Date"></asp:textbox>
                </td>
            </tr>
            <tr >
                <td align="right" width="40%" >
                    To Date :</td>
                <td align="left">

                    <asp:textbox id="txtDateTo" runat="server" textmode="Date"></asp:textbox>
                </td>
            </tr>
            <tr >
                <td align="right" width="40%" >
                    <asp:Label runat="server" Text="Visit #"></asp:Label>
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtRegno"></asp:TextBox>
                    <asp:Button Text="Search" runat="server" ID="btnSearch" OnClick="btnReport_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:GridView ID="gvd" runat="server" AutoGenerateColumns="false" OnRowDataBound="gvd_RowDataBound">
            <Columns>
                <asp:BoundField  DataField="RegNo" HeaderText="Reg #"/>
                <asp:BoundField  DataField="PayId" HeaderText="Visit #"/>
                <asp:BoundField  DataField="PatientName" HeaderText="Patient Name"/>
                <asp:BoundField  DataField="S_Name" HeaderText="Service"/>
                <asp:BoundField  DataField="Patient_type" HeaderText="Type"/>
                <asp:BoundField  DataField="DateTime" HeaderText="Date"/>
                <asp:BoundField  DataField="Amount" HeaderText="Amount"/>
                <asp:BoundField  DataField="Discount" HeaderText="Discount"/>
                <asp:BoundField  DataField="Paid" HeaderText="Paid"/>
                                
                <asp:TemplateField>
                    <ItemTemplate>
                    <%--<asp:Label ID="Label2" runat="server" Text='<%# Bind("Doctor_Name", "{0}") %>' Width="199px"></asp:Label>--%>
                    <asp:DropDownList ID="ddl_Doctor" DataTextField="Name" DataValueField="EmpID" runat="server">

                    </asp:DropDownList>
                        <asp:HiddenField ID="hfDctrID" runat="server" Value='<%# Eval("Doctor_ID") %>' />
                        <asp:HiddenField ID="hdfS_ID" runat="server" Value='<%# Eval("S_ID") %>' />
                        
                </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                   <ItemTemplate>
                       <asp:Button ID="btnUpdate" OnClick="btnUpdate_Click" runat="server" Text="Update" CommandArgument='<%# Eval("ID") %>' />
                   </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
