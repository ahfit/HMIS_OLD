

<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="PatientHistory1, App_Web_3d5bytc0" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource_Visits" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
        SelectCommand="SELECT [PayID], [DateTime] FROM [Payment] WHERE ([RegNo] = @RegNo)">
        <SelectParameters>
            <asp:QueryStringParameter Name="RegNo" QueryStringField="regno" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView_Visits" runat="server" AutoGenerateColumns="False" DataKeyNames="PayId"
        DataSourceID="SqlDataSource_Visits">
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="PayID" HeaderText="PayID" SortExpression="PayID" />
            <asp:BoundField DataField="DateTime" HeaderText="DateTime" SortExpression="DateTime" />
        </Columns>
    </asp:GridView>



<asp:GridView ID="GridViewhistory" runat="server"  AutoGenerateColumns="False" DataSourceID="SqlDataSourcePatientHistory" CssClass="Grid_1" Width="100%">
                  <FooterStyle CssClass="GridPager" />            
                  <RowStyle CssClass="GridItem" />
                  <HeaderStyle CssClass="GridHeader2" />            
                  <AlternatingRowStyle CssClass="GridAltItem" />
                  <Columns>
                  <asp:BoundField DataField="PayID" HeaderText="COD" SortExpression="PayID" />
                  <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" />
                      <asp:BoundField DataField="prefix" HeaderText="prefix" SortExpression="prefix" />
                      <asp:BoundField DataField="pfname" HeaderText="pfname" SortExpression="pfname" />
                      <asp:BoundField DataField="pmname" HeaderText="pmname" SortExpression="pmname" />
                      <asp:BoundField DataField="PLNAME" HeaderText="PLNAME" SortExpression="PLNAME" />
                  <asp:BoundField DataField="Relation" SortExpression="Relation" />
                  <asp:BoundField DataField="RELATIONNAME" ReadOnly="True" SortExpression="RELATIONNAME" />
                  <asp:BoundField DataField="Age" HeaderText="Age" SortExpression="Age" Visible="False" />
                  <asp:BoundField DataField="SexDescription" HeaderText="Gender" SortExpression="SexDescription" Visible="False" />
                  <asp:BoundField DataField="Sending" HeaderText="Sent by" ReadOnly="True" SortExpression="Sending" />
                  <asp:BoundField DataField="forward_date" HeaderText="Date" SortExpression="forward_date" />
                  <asp:BoundField DataField="Request_Name" HeaderText="Purpose" SortExpression="Request_Name" />
                  <asp:BoundField DataField="EmployeeName" HeaderText="Sender Name" ReadOnly="True"
                        SortExpression="EmployeeName" />
                  <asp:BoundField DataField="EFName" HeaderText="EFName" SortExpression="EFName" Visible="False" />
                  <asp:BoundField DataField="RequestComplete" HeaderText="Request Completed" SortExpression="RequestComplete" />
                  </Columns>
                  <PagerStyle CssClass="GridPager" />            
</asp:GridView>
              <asp:SqlDataSource ID="SqlDataSourcePatientHistory" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                SelectCommand="PatientMovement" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField_Payid" DefaultValue="" Name="YearlyNo"
                            PropertyName="Value" Type="Decimal" />
                        <asp:ControlParameter ControlID="HiddenField_RegNo" DefaultValue="" Name="RegNo"
                            PropertyName="Value" Type="String" />
                    </SelectParameters>
                                          </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_RegNo" runat="server" />
                <asp:HiddenField ID="HiddenField_Payid" runat="server" /><br />

  </asp:Content>