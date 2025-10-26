<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="HR_Employee_Contract, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 332px;
        }
        .style2
        {
            text-align:right;
            width: 109px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain">
        <h1 style="color: Maroon; font-size: medium">
            Employee Contract</h1>
    </div>
    <br />
    <div class="bxmain">
        <table class="diagnosis_list">
            <tr>
                <td class="style2">
                   Contract Date:
                </td>
                <td class="style1">
                    <igsch:WebDateChooser ID="cntrtdatewebchooser" Width="250px" runat="server" CssClass="drop_date"
                        Visible="true">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Expiry Date:
                </td>
                <td class="style1">
                    <igsch:WebDateChooser ID="expirydatewebchooser" Width="250px" runat="server" CssClass="drop_date"
                        Visible="true" Value="">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td class="style2">
                 Contract Document:
                </td>
                <td class="style1">
                    <asp:FileUpload ID="cntrctupload" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Signing Authority:
                </td>
                <td class="style1">
                    <asp:DropDownList ID="authoritylist" runat="server" DataSourceID="SqlDataSource1"
                        DataTextField="Name" DataValueField="EmpID">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Notes:
                </td>
                <td class="style1">
                    <asp:TextBox ID="Notesbox" runat="server" Height="50px" TextMode="MultiLine" Width="400px">
                    </asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                </td>
                <td class="style1">
                    <asp:Button ID="Savebttn" runat="server" OnClick="Savebttn_Click" Text="Save" />
                    <asp:Label ID="lblAttachfile" runat="server" Text=""></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" EmptyDataText="No Record Found"
        DataKeyNames="EmpContractID" DataSourceID="SqlDataSource2" Width="100%">
        <Columns>
             <asp:BoundField DataField="Name" HeaderText="Name" />
            <asp:BoundField DataField="EmpContractID" HeaderText="EmpContractID" Visible="False"
                ReadOnly="True" SortExpression="EmpContractID" />
            <asp:BoundField DataField="EmpID" HeaderText="EmpID" SortExpression="EmpID" Visible="false" />
            <asp:BoundField DataField="ContractDate" HeaderText="Contract Date" SortExpression="ContractDate"
                DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="ContractExpDate" HeaderText="Contract Expiry Date" SortExpression="ContractExpDate"
                DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="Name" HeaderText="Signing Authority" SortExpression="Name" />
            <asp:BoundField DataField="ContractNotes" HeaderText="Contract Notes" SortExpression="ContractNotes" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HyperLink runat="server" Target="_blank" NavigateUrl='<%# Eval("ContractDocPath") %>'
                        Text='<%#Eval("ContractDocPath") %>' />
                </ItemTemplate>
            </asp:TemplateField>
           
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
        InsertCommandType="StoredProcedure" SelectCommand="SELECT Contract.EmpContractID, Contract.EmpID, convert(varchar,Contract.ContractDate,106) as ContractDate, convert(varchar,Contract.ContractExpDate,106) as ContractExpDate , Contract.ContractNotes, Contract.ContractSigningAuthorityID, Contract.ContractDocPath, Employee.Name FROM Contract LEFT OUTER JOIN Employee ON Contract.ContractSigningAuthorityID = Employee.EmpID WHERE (Contract.EmpID = @empid)"
        InsertCommand="usp_contract" CancelSelectOnNullParameter="False">
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter Name="empid" Type="Int32" />
            <asp:Parameter Name="contractdate" Type="DateTime" />
            <asp:Parameter Name="contractexpdate" Type="DateTime" />
            <asp:Parameter Name="contractnotes" Type="String" />
            <asp:Parameter Name="signingauth" Type="Int32" />
            <asp:Parameter Name="cntrctdocpath" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="empid" QueryStringField="empid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="SELECT     EmpID, isnull(EFName,'')+' '+ISNULL(EMName,'')+' '+ISNULL(ELName,'') As Name
FROM Employee"></asp:SqlDataSource>
</asp:Content>
