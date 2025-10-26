<%--<%@ page title="" language="vb" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="ServiceCategoryWiseCashDetail, App_Web_dtynhger" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>--%>
<%@ Page Title="" Language="vb" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="ServiceCategoryWiseCashDetail.aspx.vb" Inherits="ServiceCategoryWiseCashDetail" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

 

     <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
     function ClientItemSelected(sender, e) {
         $get("<%=hfNameId.ClientID %>").value = e.get_value();
     } 
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="scrptManager" runat="server"></asp:ScriptManager>
    <asp:Label CssClass="err" ID="Label1" runat="server"></asp:Label>
    <div align="right" style="height: 30px; border-top: #CCC dotted 1px; width: 100%;
        display: none; line-height: 28px; font-weight: bold; color: #000000; font-size: 13px;">
        <asp:Button ID="btn_export" runat="server" Text="Export To Excel" />
    </div>
    <div style="padding-bottom:5px;">
    <tr>
                <asp:Button ID="btnEToExcel" runat="server" Text="Export To Excel"  Visible="true" />
            <span style="padding-left:300px;"> <asp:TextBox AutoPostBack="true" Width="300px" ID="txtboxServiceName"  Visible="true" runat="server"></asp:TextBox></span>
              <asp:AutoCompleteExtender ID="Auto_Names_Extender" runat="server" ServiceMethod="SearchNames"
                        MinimumPrefixLength="3" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" 
                        TargetControlID="txtboxServiceName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected">
                    </asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfNameId" runat="server" />
        <span style="padding-left: 20px">
            <asp:Button ID="btnSearch" runat="server" Text="Show Report" Visible="true" /></span>
    </tr>
    </div>
   <div style="padding-top:20px">
     <asp:GridView ID="GridView_Counter_Close" runat="server" AutoGenerateColumns="False"
        Width="100%" ShowFooter="True" DataSourceID="SqlDataSourceForGrid">
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <FooterStyle CssClass="myfooter" />
        <Columns>       <asp:TemplateField HeaderText="SrNo."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="8%" /> 
</asp:TemplateField>   
          <%--  <asp:BoundField DataField="reciept_No" HeaderText="Reciept No." SortExpression="reciept_No" />--%>
           <asp:TemplateField HeaderText="Registration No." SortExpression="Registration #">               
                <ItemTemplate>
                    <asp:Label ID="lbl_reg" runat="server" Text='<%# Bind("Reg_No") %>'></asp:Label>
                </ItemTemplate>
                 <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField DataField="YearlyNo" HeaderText="Visit No" SortExpression="YearlyNo" ItemStyle-HorizontalAlign="Center" /> 
            <asp:TemplateField HeaderText="Patient Name" SortExpression="PFName">
                <ItemTemplate>
                    <asp:Label ID="LBL_Patient_Name" runat="server"></asp:Label>
                    <asp:HiddenField ID="HF_F_Name" runat="server" Value='<%# Eval("PFName") %>' />
                    <asp:HiddenField ID="HF_M_Name" runat="server" Value='<%# Eval("PMName") %>' />
                    <asp:HiddenField ID="HF_L_Name" runat="server" Value='<%# Eval("PLName") %>' />                    
                </ItemTemplate>               
            </asp:TemplateField>
                 <asp:BoundField DataField="Party_Name" HeaderText="Company" SortExpression="Party_Name" /> 
            <asp:BoundField DataField="ServiceDate" HeaderText="Service Date" SortExpression="ServiceDate" />                      
            <asp:BoundField DataField="S_Name" HeaderText="Service Name" SortExpression="S_Name" />
            <asp:BoundField DataField="Dept_Name" HeaderText="Department" SortExpression="Dept_Name" />
            <asp:BoundField DataField="EntryBy" HeaderText="Entry By" SortExpression="EntryBy" />
            <asp:BoundField DataField="DoctorName" HeaderText="Doctor Name" SortExpression="DoctorName" />
             <asp:BoundField DataField="IPDOPD" HeaderText="IPD/OPD" SortExpression="IPDOPD" />
              <asp:BoundField DataField="PType" HeaderText="Patient Type" SortExpression="PType" />
            <asp:TemplateField HeaderText="Amount" SortExpression="Amount">


                <FooterTemplate>
                    <strong>Total Balance :</strong>
                </FooterTemplate>

                <ItemTemplate>
                    <asp:Label ID="LBL_Amount" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                    <asp:HiddenField ID="hf_amount" runat="server" Value='<%# Bind("Amount") %>' />
                </ItemTemplate>
              <ItemStyle HorizontalAlign="Right" />
              <FooterTemplate>
                    <asp:Label ID="total_Remain" runat="server" Text="0" ForeColor="RED" Font-Size="Larger"
                        Font-Bold="true"></asp:Label>

                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right"  />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Discount" SortExpression="Discount">


                <ItemTemplate>
                    <asp:Label ID="LBL_Discount" runat="server" Text='<%# Bind("Discount")%>'></asp:Label>
                    <asp:HiddenField ID="hf_Discount" runat="server" Value='<%# Bind("Discount")%>' />
                </ItemTemplate>
              <ItemStyle HorizontalAlign="Right" />
              <FooterTemplate>
                    <asp:Label ID="total_Discount" runat="server" Text="0" ForeColor="RED" Font-Size="Larger"
                        Font-Bold="true"></asp:Label>

                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right"  />
            </asp:TemplateField>
             <asp:BoundField DataField="Discount_Type" HeaderText="Discount Type" SortExpression="Discount_Type" />

            <asp:TemplateField HeaderText="Refund" SortExpression="RefundAmount">


                <ItemTemplate>
                    <asp:Label ID="LBL_RefundAmount" runat="server" Text='<%# Bind("RefundAmount")%>'></asp:Label>
                    <asp:HiddenField ID="hf_RefundAmount" runat="server" Value='<%# Bind("RefundAmount")%>' />
                </ItemTemplate>
              <ItemStyle HorizontalAlign="Right" />
              <FooterTemplate>
                    <asp:Label ID="total_RefundAmount" runat="server" Text="0" ForeColor="RED" Font-Size="Larger"
                        Font-Bold="true"></asp:Label>

                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right"  />
            </asp:TemplateField>
             
            <asp:TemplateField HeaderText="Amount" SortExpression="Amount">


                <FooterTemplate>
                    <strong>Total Paid :</strong>
                </FooterTemplate>

                <ItemTemplate >
                    <asp:Label ID="LBL_Paid" runat="server" Text='<%# Bind("Paid") %>' ></asp:Label>
                    <asp:HiddenField ID="hf_Paid" runat="server" Value='<%# Bind("Paid") %>' />
                </ItemTemplate>
              <ItemStyle HorizontalAlign="Right" />
              <FooterTemplate>
                    <asp:Label ID="total_Paid" runat="server" Text="0" ForeColor="RED" Font-Size="Larger"
                        Font-Bold="true"></asp:Label>
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>

            <asp:BoundField DataField="EntryBy" HeaderText="Entry by" SortExpression="EntryBy" Visible="false" />
         
        </Columns>
    </asp:GridView>
    </div>
    <br />
    <br />
   

    <div style="width:100px; text-align:center;margin: 0 auto;">
    <asp:Button ID="btnBack" Text="Back" runat="server" CssClass="btn_hacims" OnClientClick="javascript:history.back(-1)" />
    </div>
    <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Cash_Submitted_Details_BySericeName" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
        <SelectParameters>
         <asp:QueryStringParameter Name="ServiceCategoryId" QueryStringField="CId" Type="Int32" />
            <asp:QueryStringParameter Name="DateFrom" QueryStringField="DateFrom" Type="String" />
           
            <asp:QueryStringParameter Name="DateTo" QueryStringField="DateTo" Type="String" /> 
              <asp:Parameter DefaultValue="%" Name="ServiceName"  Type="String" />                           
            <asp:QueryStringParameter Name="Type" QueryStringField="Type" Type="String" />
            <asp:QueryStringParameter Name="HospitalID" QueryStringField="HospitalID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

            
          <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" 
        Height="500px">
    </rsweb:ReportViewer>

           
</asp:Content>
