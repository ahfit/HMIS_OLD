<%@ Page Title="" Language="VB"  MasterPageFile="~/hacims_masterpage_admin.master"  AutoEventWireup="false"  CodeFile="EmpoyeeDayWiseLeave.aspx.vb"  Inherits="HR_EmpoyeeDayWiseLeave" %>

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
    
    <div class="bxmain inner_content" style="width:100%"><h2><span>Employee Leave Summary</span></h2>

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
                                    <asp:TemplateField HeaderText="For Date">
                                       <%-- <FooterTemplate>
                                            <asp:Label ID="Amount_Label" runat="server" Text="For Date"></asp:Label>
                                        </FooterTemplate>--%>
                                        <ItemTemplate>
                                            <asp:Label ID="lbAmount" runat="server" Text='<%# Bind("For_date")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Leave Type">
                                       <%-- <FooterTemplate>
                                            <asp:Label ID="Amount_Label" runat="server" Text="For Date"></asp:Label>
                                        </FooterTemplate>--%>
                                        <ItemTemplate>
                                            <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("OverTime")%>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtAmount" runat="server" Text='<%# Bind("OverTime")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                 
                                    
                                    <asp:TemplateField ShowHeader="False" Visible="false">
                                        <EditItemTemplate>
                                            <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="True" CommandName="Update" ImageUrl="~/images/updatebtn.png"  Text="Update" />
                                            &nbsp;<asp:ImageButton ID="ImageButto" runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/images_hacims/icon_delete.gif" Text="Cancel" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ImageButto1" runat="server" CausesValidation="False" CommandName="Edit" ImageUrl="~/images_hacims/icon_edit.gif" Text="Edit" />
                                            &nbsp;
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
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
        SelectCommand="sELECT id ,emp_id as Emp_Id,'1' as Att_id,LeaveType as OverTime,'false' as Is_Double ,for_date as For_date FROM PendingLeaves where emp_Id=@Empid and for_date>=@month and for_date<=@year" ProviderName="<%$ ConnectionStrings:Machine_AttendanceConnectionString.ProviderName %>" UpdateCommand="Update  [Machine_Attendance].[dbo].[PendingLeaves] set LeaveDeduction=@OverTime where id=@id" DeleteCommand="Delete from 
   [Machine_Attendance].[dbo].[PendingLeaves] where id=@id">
              <DeleteParameters>
                  <asp:Parameter Name="id" />
              </DeleteParameters>
              <SelectParameters>
                  <asp:ControlParameter ControlID="HFEmpid" Name="Empid" PropertyName="Value" Type="int32"  />
                  <asp:ControlParameter ControlID="HFmonth" Name="month" PropertyName="Value" Type="DateTime"  />
                  <asp:ControlParameter ControlID="HFyear" Name="year" PropertyName="Value" Type="DateTime"  />
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

