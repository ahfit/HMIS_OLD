<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage.master" inherits="BloodWaitingList, App_Web_k10uyj0r" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="bxmain inner_content" style="width: 100%">
        <h2><span style="font-size: 20px !important">Pending Blood Request</span></h2>
    </div>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        DataKeyNames="Blood_Request_Id,Registration_No,Yearly_No,Request_ID" DataSourceID="SqlDataSource_blood_waiting_List"
        PageSize="15" Width="100%" OnPreRender="GridView1_PreRender" OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
        <Columns>
            <asp:BoundField DataField="Blood_Request_Id" HeaderText="Blood_Request_Id" InsertVisible="False"
                ReadOnly="True" SortExpression="Blood_Request_Id" Visible="False" />
            <asp:BoundField DataField="Registration_No" HeaderText="Registration" SortExpression="Registration_No" />
            <asp:BoundField DataField="Yearly_No" HeaderText="Visit Number" SortExpression="Yearly_No"
                Visible="False" />
            <asp:BoundField DataField="Prefix" HeaderText="Patient" SortExpression="Prefix" />
            <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation" />
            <asp:BoundField DataField="Relation1" HeaderText="Relation Name" ReadOnly="True"
                SortExpression="Relation1" />
            <asp:BoundField DataField="Data_Time" HeaderText="When Need" ReadOnly="True"
                SortExpression="Relation1" />
            <asp:BoundField DataField="Sample_No" HeaderText="Sample No" ReadOnly="True"
                SortExpression="Relation1" />
            <asp:BoundField DataField="BloodGroup" HeaderText="Blood Group" ReadOnly="True"
                SortExpression="Relation1" />
            <asp:HyperLinkField DataNavigateUrlFields="Blood_Request_Id,Registration_No,Yearly_No" DataNavigateUrlFormatString="BloodGroup.aspx?bloodrequestid={0}&amp;Registration={1}&amp;YearlyNo={2}"
                Text="Blood Group" />
            <asp:HyperLinkField DataNavigateUrlFields="Registration_No,Blood_Request_Id,Yearly_No" DataNavigateUrlFormatString="BloodDonorRegistration.aspx?Reg_No={0}&amp;Request_Id={1}&amp;Yealry_No={2}"
                Text="New Donor" />
            <asp:HyperLinkField DataNavigateUrlFields="Blood_Request_Id,Registration_No,Yearly_No,Request_ID" DataNavigateUrlFormatString="Issue_Blood.aspx?BloodRequestId={0}&amp;Registration={1}&amp;YearlyNo={2}&amp;forId={3}"
                Text="Reserve Blood" />
            <asp:BoundField DataField="Request_ID" HeaderText="Id" SortExpression="Request_ID" />
            <asp:BoundField DataField="PFName" HeaderText="PFName" SortExpression="PFName" />
            <asp:BoundField DataField="PMName" HeaderText="PMName" SortExpression="PMName" />
            <asp:BoundField DataField="PLName" HeaderText="PLName" SortExpression="PLName" />
            <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <PagerStyle CssClass="GridPager" />

    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_blood_waiting_List" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
        SelectCommand="BloodBank_Waiting_List" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
        <SelectParameters>
            <asp:Parameter DefaultValue="17" Name="to_sub_Dept" Type="Int32" />
            <asp:Parameter DefaultValue="false" Name="status" Type="Boolean" />
            <asp:Parameter DefaultValue="10" Name="request_type_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <br />
</asp:Content>
