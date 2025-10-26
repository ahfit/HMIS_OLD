<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_EmpoyeeDayWiseOverTime, App_Web_mrdzezyb" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
<script type ="text/javascript">


</script>
    <style type="text/css">
        .style1
        {
            width: 410px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

   
    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
    
    <div class="bxmain inner_content" style="width:100%"><h2><span>Employee OverTime Summary</span></h2>

    <table class="tbl_form">
        
        <tr>
            <td align="right" class="style1">
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                <asp:Button ID="btn_Report" runat="server" Text="Save"  CssClass="btn_hacims"
                    onclick="btn_Report_Click" />
            </td>
            <asp:HiddenField ID="HFEmpid" runat="server" />
             <asp:HiddenField ID="HFmonth" runat="server" />
             <asp:HiddenField ID="HFyear" runat="server" />
        </tr>
</table>
    </div>
    <div>

        

        <asp:GridView Style="margin-left: 10px" ID="GridView_Date_Wise" runat="server" CssClass="Grid_1"
                                Width="92%"  AutoGenerateColumns="False" ShowFooter="True" DataSourceID="SDS_OverTime"
                                DataKeyNames="id">
                                <RowStyle CssClass="GridItem"></RowStyle>
                                <Columns> 
                                    <asp:TemplateField HeaderText="Employee ID">
                                        <%--<FooterTemplate>
                                            <asp:Label ID="Discount_Label" runat="server" Text="Discount_Label"></asp:Label>
                                        </FooterTemplate>--%>
                                        <ItemTemplate>
                                            <asp:Label ID="lblDiscount" runat="server" Text='<%# Bind("Emp_Id") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" SortExpression="EmployeeName" ReadOnly="true"/>
                                    <asp:TemplateField HeaderText="For Date">
                                       <%-- <FooterTemplate>
                                            <asp:Label ID="Amount_Label" runat="server" Text="For Date"></asp:Label>
                                        </FooterTemplate>--%>
                                        <ItemTemplate>
                                            <asp:Label ID="lbAmount" runat="server" Text='<%# Bind("For_date")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Over Time (Minutes)">
                                       <%-- <FooterTemplate>
                                            <asp:Label ID="Amount_Label" runat="server" Text="For Date"></asp:Label>
                                        </FooterTemplate>--%>
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("OverTime")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtAmount" runat="server" Text='<%# Bind("OverTime")%>' SkinID="intdata"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                 
                                    
                                    <asp:TemplateField ShowHeader="False" HeaderText="Edit">
                                        <EditItemTemplate>
                                            <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="True" CommandName="Update" ImageUrl="~/images/updatebtn.png"  Text="Update" />
                                            &nbsp;<asp:ImageButton ID="ImageButto" runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/images_hacims/icon_delete.gif" Text="Cancel" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ImageButto1" runat="server" CausesValidation="False" CommandName="Edit" ImageUrl="~/images_hacims/icon_edit.gif" Text="Edit" />
                                            &nbsp;
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delete">
                                        <ItemTemplate>

                                            <asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif" Text="Delete" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                </Columns>
                                <FooterStyle CssClass="myfooter"></FooterStyle>
                                <HeaderStyle CssClass="GridHeader"></HeaderStyle>
                                <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
                            </asp:GridView>

    </div>
     <asp:SqlDataSource ID="SDS_OverTime" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>" 
        SelectCommand="SELECT [id],[Emp_Id] ,[Att_Id],[OverTime],[Is_Double],Convert(varchar,[For_date],103) AS For_date,
ISNULL(Employee.EFName+' ','') + ISNULL(Employee.EMName+' ','') + ISNULL(Employee.ELName+' ','') AS EmployeeName FROM [EmpPendingOverTime]
inner join Employee on EmpPendingOverTime.Emp_Id = Employee.EmpID where Emp_Id=@Empid and Mnth=@month and Yer=@year" ProviderName="<%$ ConnectionStrings:Machine_AttendanceConnectionString.ProviderName %>" 
         UpdateCommand="Update  [Machine_Attendance].[dbo].[EmpPendingOverTime] set OverTime=@OverTime, HourlyOverTime = (@OverTime/60)*60 where id=@id" DeleteCommand="Delete from 
   [Machine_Attendance].[dbo].[EmpPendingOverTime] where id=@id">
              <DeleteParameters>
                  <asp:Parameter Name="id" />
              </DeleteParameters>
              <SelectParameters>
                  <asp:ControlParameter ControlID="HFEmpid" Name="Empid" PropertyName="Value" Type="Int32"  />
                  <asp:ControlParameter ControlID="HFmonth" Name="month" PropertyName="Value" Type="string"  />
                  <asp:ControlParameter ControlID="HFyear" Name="year" PropertyName="Value" Type="string"  />
              </SelectParameters>
              <UpdateParameters>
                  <asp:Parameter Name="OverTime" />
                  <asp:Parameter Name="id" />
              </UpdateParameters>
    </asp:SqlDataSource>
    <input style="visibility:hidden" type="button" value="print" onclick="printSpecial()" id = "btn_print" autofocus="autofocus" onload ="Set_focus()"><br />
    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
    </rsweb:ReportViewer>

</asp:Content>

