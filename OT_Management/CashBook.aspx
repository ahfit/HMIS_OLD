<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CashBook.aspx.vb"  MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Pathology_CashBook" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

 

       <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

           <asp:GridView ID="GridView2" runat="server" CssClass="Grid_1"
                        EmptyDataText="No data" Width="100%" PageSize="25" AutoGenerateColumns="False" DataSourceID="SqlDataSourcePatient" ShowFooter="True">
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />              
                <AlternatingRowStyle CssClass="GridAltItem" />
                  <Columns>
                      <asp:TemplateField HeaderText="Sr. No.">
                          <ItemTemplate>
                              <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                              <asp:HiddenField ID="HiddenField_Payment" runat="server" Value='<%# Eval("Total_Paid", "{0}") %>' />
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:BoundField DataField="Reg_no" HeaderText="Registration No." SortExpression="Reg_no" />
                      <asp:BoundField DataField="Yearly_No" HeaderText="Visit No." SortExpression="Yearly_No" />
                      <asp:BoundField DataField="Prefix" HeaderText="Patient Name" SortExpression="Prefix" />
                      <asp:BoundField DataField="PFName" HeaderText="PFName" SortExpression="PFName" />
                      <asp:BoundField DataField="PMName" HeaderText="PMName" SortExpression="PMName" />
                      <asp:BoundField DataField="PLName" HeaderText="PLName" SortExpression="PLName" />
                      <asp:BoundField DataField="PatientType" HeaderText="Patient Type" SortExpression="PatientType" />
                      <asp:BoundField DataField="Total_Paid" HeaderText="Amount" SortExpression="Total_Paid" />
                  </Columns>
                      <FooterStyle CssClass="myfooter" />
                  </asp:GridView>
    <br />
   <div class="bxmain">   
     <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
        <tr>
            <td width="40%" align="right">
                Date :
          </td>
            <td width="60%" >
                <igsch:webdatechooser id="WebDateChooser1" runat="server" cssClass="drop_date" Width="202px"></igsch:webdatechooser>
            </td>
        </tr>
        <tr>
            <td align="right" >
                Shift :
          </td>
            <td >
                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem Value="1">Morning</asp:ListItem>
                    <asp:ListItem Value="2">Evening</asp:ListItem>
                    <asp:ListItem Value="3">Night</asp:ListItem>
                </asp:DropDownList>            </td>
        </tr>
        <tr>
            <td >
            </td>
            <td ><asp:Button ID="Button1" runat="server" CssClass="btn1" Text="Save" />            </td>
        </tr>
    </table></div>
                <asp:SqlDataSource ID="SqlDataSourcePatient" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>" SelectCommand="SELECT   distinct  Path_Result_Delivery.Reg_no, Path_Result_Delivery.Yearly_No, Pathology_Test_Total_Amount.Total_Paid, Patient.Prefix, Patient.PFName, &#13;&#10;                      Patient.PMName, Patient.PLName, Payment.PatientType&#13;&#10;FROM         Pathology_Test_Total_Amount INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Pathology_Test_Total_Amount.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN&#13;&#10;                      Test_Booking_Services ON Path_Result_Delivery.Main_ID = Test_Booking_Services.Main_ID INNER JOIN&#13;&#10;                      Payment ON Path_Result_Delivery.Yearly_No = Payment.PayID AND Path_Result_Delivery.Reg_no = Payment.RegNo INNER JOIN&#13;&#10;                      Patient ON Payment.RegNo = Patient.RegNo&#13;&#10;WHERE     (Path_Result_Delivery.Yearly_No NOT IN&#13;&#10;                          (SELECT     Yearly_No&#13;&#10;                            FROM          Counter_Close)) AND (Path_Result_Delivery.Reg_no NOT IN&#13;&#10;                          (SELECT     Reg_No&#13;&#10;                            FROM          Counter_Close AS Counter_Close_1))&#13;&#10;order by Path_Result_Delivery.Yearly_No">
</asp:SqlDataSource>
 
    <asp:HiddenField ID="HiddenFieldDate" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:FinanceConnectionString %>"
        InsertCommand="MRI_Counter_Close" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:FinanceConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:SessionParameter Name="Emp_ID" SessionField="Emp_ID" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_Pay" Name="Receive_Amount" PropertyName="Value"
                Type="Int32" />
            <asp:SessionParameter Name="Dept_ID" SessionField="Dept_ID" Type="Int32" />
            <asp:SessionParameter Name="SubDept_ID" SessionField="SubDeptID" Type="Int32" />
            <asp:Parameter Direction="Output" Name="Identity" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Save_SUb" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
        InsertCommand="INSERT INTO Counter_Close(Reg_No, Yearly_No, Receiving_Amount_ID, PS_ID, Shift, Datetime, Dept_ID, SubDept_ID, Amount) VALUES (@Reg_No, @Yearly_No, @Receiving_Amount_ID, @PS_ID, @Shift, @Datetime, @Dept_ID, @SubDept_ID, @Amount)" ProviderName="<%$ ConnectionStrings:Radiology_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_Reg_No" Name="Reg_No" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_YearlyNo" Name="Yearly_No" PropertyName="Value"
                Type="Decimal" />
            <asp:ControlParameter ControlID="HiddenField_Recieve_Amount_ID" Name="Receiving_Amount_ID"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_PS_ID" Name="PS_ID" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Shift" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenFieldDate" Name="Datetime" PropertyName="Value" />
            <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" />
            <asp:SessionParameter Name="SubDept_ID" SessionField="SubDeptID" />
            <asp:ControlParameter ControlID="HiddenFieldAmount" Name="Amount" PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>


<asp:HiddenField ID="HiddenField_Recieve_Amount_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_PS_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Pay" runat="server" />
    <asp:HiddenField ID="HiddenField_Reg_No" runat="server" />
    <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
    <asp:HiddenField ID="HiddenField_Check" runat="server" Value="0" />
    <asp:HiddenField ID="HiddenFieldAmount" runat="server" />
<br />
<br />

  </asp:Content>