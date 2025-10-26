<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Doctors_call, App_Web_p0fljamz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

 
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:Label ID="Label_message" runat="server" ></asp:Label>
                 
 <asp:Label Font-Bold="True" ID="LabelMessage" runat="server" ></asp:Label>
                               
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                          DataSourceID="SqlDataSourceForGrid" Width="100%" ShowHeaderWhenEmpty="true">
                      <Columns>
                      <asp:TemplateField HeaderText="Call BY" SortExpression="Call_BY">
                        <EditItemTemplate>
                          <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Call_BY") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                          <asp:Label ID="Label1" runat="server" Text='<%# Bind("Call_BY") %>'></asp:Label>
                          <asp:HiddenField ID="HiddenFieldID" runat="server" Value='<%# Bind("CTD_ID", "{0}") %>' />
                        </ItemTemplate>
                      </asp:TemplateField>
                      <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject" />
                      <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                      <asp:BoundField DataField="Needed" HeaderText="Needed In Time" ReadOnly="True" SortExpression="Needed" />
                      <asp:BoundField DataField="Call_Date" HeaderText="Call Date" ReadOnly="True" SortExpression="Call_Date" />
                      <asp:BoundField DataField="Call_Time" HeaderText="Call Sent Time" ReadOnly="True" SortExpression="Call_Time" />
                      <asp:BoundField DataField="RegNo" HeaderText="RegNo" SortExpression="RegNo" />
                      <asp:BoundField DataField="YearlyNo" HeaderText="YearlyNo" SortExpression="YearlyNo" />
                      </Columns>
                      <RowStyle CssClass="GridItem" />
                      <HeaderStyle CssClass="GridHeader" />                  
                          <AlternatingRowStyle CssClass="GridAltItem" />
                   </asp:GridView>
 
<asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                      ProviderName="<%$ ConnectionStrings:TreatmentConnectionString.ProviderName %>" SelectCommand="Select_Doctors_Call"
                      SelectCommandType="StoredProcedure">
  <SelectParameters>
    <asp:SessionParameter Name="Emp_ID" SessionField="Emp_id" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

        <asp:HiddenField ID="HiddenFieldToolTIp" runat="server" Value="true" /><asp:HiddenField ID="HiddenField1" runat="server" Value="true" />
            
        

  </asp:Content>