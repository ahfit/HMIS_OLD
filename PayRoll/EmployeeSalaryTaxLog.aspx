<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="EmployeeSalaryTaxLog.aspx.cs" Inherits="PayRoll_EmployeeSalaryTaxLog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<script type="text/javascript">
   
</script>
    <style  type="text/css">
        .nodisplay
        {
            display:none;
        }
    </style>

    <script type="text/javascript">
        function confirmationDelete() {
            if (confirm('Are you sure you want to delete Record ?')) {
                return true;
            } else {
                return false;
            }
        }
   </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
    <div class="bxmain" style="padding: 17px; width: 65%;">

        <div>

            <asp:FormView ID="FormView2" runat="server" DataKeyNames="EmpID" DataSourceID="dsEmployeeInfo"
                HorizontalAlign="Left" Width="100%">
                <ItemTemplate>

                    <asp:Image ID="Image2" Visible="false" runat="server" Style="position: absolute; margin-left: 25px; margin-top: 60px;"
                        ImageUrl=' <%# Convert.ToString("~/DisplayPic.ashx?Emp_Id=") + Convert.ToString(Eval("EmpID")) %>'
                        Width="77px" Height="90px" />

                    <div class="bxinset radius4">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>

                                <td valign="top">

                                    <ul class="empinfo">
                                        <li class="name" style="display: inline;">
                                            <asp:Label ID="Label_EmpName" runat="server" Text='<%# Eval("[Employee Name]") %>' ToolTip="Employee Name"></asp:Label></li>
                                        <span class="splt">|</span>
                                        <li style="display: inline;">
                                            <asp:Label ID="Designation_NameLabel" runat="server" Style="color: #c60c0c; font-weight: bold;" Text='<%# Bind("Designation_Name") %>'></asp:Label>
                                            <asp:Label ID="Designation_NameLabel0" Visible="false" runat="server" Text='<%# Convert.ToString("( ") + Convert.ToString(Eval("SubDept_Name")) + Convert.ToString(" )") %>'></asp:Label></li>
                                        <span class="splt">|</span>
                                        <li class="div" style="display: inline;">
                                            <asp:Label ID="Designation_NameLabel1" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label></li>
                                        <span class="splt">|</span>
                                        <li style="display: inline;">Emp #  <strong>
                                            <asp:Label ID="RegistrationNo" runat="server" Text='<%# Eval("EmpNo") %>' ToolTip="Patient Registration Number"></asp:Label></strong>
                                            <span class="spl">|</span>
                                            Join Date : <strong>
                                                <asp:Label ID="Label_JoinDate" runat="server" Text='<%# Bind("JoinDate") %>' ToolTip="Patient Age"></asp:Label></strong>
                                            <span class="spl">|</span>
                                            <strong>
                                                <asp:Label ID="Label_CNIC" runat="server" Visible="false" Text='<%# Eval("CNIC") %>' ToolTip="Identity Card #"></asp:Label></strong>

                                            <strong>
                                                <asp:Label ID="LabelGender" Visible="false" runat="server" Text='<%# Eval("Gender") %>' ToolTip="Patient Gender"></asp:Label></strong>
                                        </li>
                                    </ul>


                                </td>
                            </tr>
                        </table>
                    </div>

                </ItemTemplate>
            </asp:FormView>


            <asp:SqlDataSource ID="dsEmployeeInfo" runat="server"
                ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <%--<asp:ControlParameter ControlID="HiddenField_Emp_ID" DefaultValue="0" 
                    Name="EmpID" PropertyName="Value" />--%>
                    <asp:QueryStringParameter Name="EmpID" DefaultValue="0" QueryStringField="EmpId" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>


    </div>
    <br />



    <div class="inner_content bxmain" >
        <h2>Add Employee Salary Tax History</h2>
     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
           <tr>
                <td align="right" class="style1">
                    <strong>Financial Year :</strong> </td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlFinancialYear" runat="server"
                        CssClass="drop_down" DataSourceID="sdsFinancialyear" DataTextField="Financial_Year"
                        DataValueField="Financial_Year_Id"
                        AutoPostBack="True" OnSelectedIndexChanged="ddlFinancialYear_SelectedIndexChanged" Style="margin-left: 0px">
                    </asp:DropDownList>

                    <asp:SqlDataSource ID="sdsFinancialyear" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                        SelectCommand="select Financial_Year_Id,Financial_Year from Financial_Year order by isnull(CurrentFinancialYear,0) desc, Start_Date desc"></asp:SqlDataSource>

                </td>
            </tr>
         <tr>
                <td align="right" class="style1">
                    <strong>Month :</strong> </td>
                <td colspan="2">
                    <asp:DropDownList ID="DDLMonth" runat="server"  Width="100px">

                    <asp:ListItem Value="1">January</asp:ListItem>
                            <asp:ListItem Value="2">February</asp:ListItem>
                            <asp:ListItem Value="3">March</asp:ListItem>
                            <asp:ListItem Value="4">April</asp:ListItem>
                            <asp:ListItem Value="5">May</asp:ListItem>
                            <asp:ListItem Value="6">June</asp:ListItem>
                            <asp:ListItem Value="7">July</asp:ListItem>
                            <asp:ListItem Value="8">August</asp:ListItem>
                            <asp:ListItem Value="9">September</asp:ListItem>
                            <asp:ListItem Value="10">October</asp:ListItem>
                            <asp:ListItem Value="11">November</asp:ListItem>
                            <asp:ListItem Value="12">December</asp:ListItem>


                </asp:DropDownList>
                <asp:DropDownList ID="ddlYear" runat="server"  Width="100px">

                    <asp:ListItem Value="2017">2017</asp:ListItem>
                    <asp:ListItem Value="2018">2018</asp:ListItem>
                    <asp:ListItem Value="2019">2019</asp:ListItem>
                    <asp:ListItem Value="2020">2020</asp:ListItem>
                    <asp:ListItem Value="2021">2021</asp:ListItem>
                    <asp:ListItem Value="2022">2022</asp:ListItem>
                    <asp:ListItem Value="2023">2023</asp:ListItem>
                    <asp:ListItem Value="2024">2024</asp:ListItem>
                    <asp:ListItem Value="2025">2025</asp:ListItem>
                    <asp:ListItem Value="2026">2026</asp:ListItem>
                    <asp:ListItem Value="2027">2027</asp:ListItem>
                    <asp:ListItem Value="2028">2028</asp:ListItem>
                    <asp:ListItem Value="2029">2029</asp:ListItem>


                </asp:DropDownList>

                </td>
            </tr>
         <tr>
                <td align="right" class="style1">
                    <strong>Income :</strong> </td>
                <td colspan="2">
                    <asp:TextBox ID="txtSalary" runat="server" Text="0" SkinID="intdata"></asp:TextBox>
             

                </td>
            </tr>
         <tr>
                <td align="right" class="style1">
                    <strong>Tax :</strong> </td>
                <td colspan="2">
                    <asp:TextBox ID="txtTax" runat="server" Text="0" SkinID="intdata"></asp:TextBox>

                </td>
            </tr>
         <tr>
                <td align="right" class="style1">
                    <strong>Reason :</strong> </td>
                <td colspan="2">
                    <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" Height="70px"></asp:TextBox>

                </td>
            </tr>
          <tr>
            <td colspan="2" align="center">
                <div style="padding-top: 10px;">
                    <asp:Button runat="server" ID="btnSave" Text="Save" OnClick="btnSave_Click" />
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </div>
            </td>
        </tr>
    </table>
        </div>

    <asp:GridView ID="gvdSalaryHistory" AutoGenerateColumns="false" runat="server" ShowFooter="true" 
        OnRowDataBound="gvdSalaryHistory_RowDataBound" OnRowCancelingEdit="gvdSalaryHistory_RowCancelingEdit" OnRowEditing="gvdSalaryHistory_RowEditing"
         OnRowUpdating="gvdSalaryHistory_RowUpdating">
        <Columns>
             <asp:TemplateField HeaderText="ID">
                <ItemTemplate>
                    <%#Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Financial Year">
                <ItemTemplate>
                    <asp:Label ID="lblFinancialYear" runat="server"  Text='<%#Bind("Financial_Year")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  HeaderText="Month">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblSalaryMonth" Text='<%#Bind("SalaryMonth")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  HeaderText="Year">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblTaxYear" Text='<%#Bind("Tax_year")%>'></asp:Label>
                </ItemTemplate>
                 <FooterTemplate>
                    <asp:Label ID="Label2" runat="server" Text="Total : " Font-Bold="true"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Salary">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblSalary" Text='<%#Bind("Salary")%>'></asp:Label> 
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox runat="server" ID="txtSalary" Text='<%#Bind("Salary")%>' SkinID="intdata"></asp:TextBox> 
                </EditItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lblTotalSalary" runat="server" Font-Bold="true"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Tax">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblTax" Text='<%#Bind("Tax")%>'></asp:Label>
                    
                </ItemTemplate>
                 <EditItemTemplate>
                    <asp:TextBox runat="server" ID="txtTax" Text='<%#Bind("Tax")%>' SkinID="intdata"></asp:TextBox> 
                     <asp:HiddenField ID="HfLogId" runat="server" Value='<%#Bind("Id")%>'/>
                </EditItemTemplate>
                 <FooterTemplate>
                    <asp:Label ID="lblTotalTax" runat="server" Font-Bold="true"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Reason">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblReason" Text='<%#Bind("Reason")%>'></asp:Label> 
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>  
                    <ItemTemplate>  
                        <asp:LinkButton ID="lnk_Edit" runat="server" Text="Edit" CommandName="Edit"></asp:LinkButton> 
                    </ItemTemplate>  
                    <EditItemTemplate>  
                        <asp:LinkButton ID="lnk_Update" runat="server" Text="Update" CommandName="Update"></asp:LinkButton>
                        <asp:LinkButton ID="lnk_Cancel" runat="server" Text="Cancel" CommandName="Cancel"></asp:LinkButton>
                    </EditItemTemplate>  
                </asp:TemplateField> 
            <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                   <asp:LinkButton ID="lnk_Delete" runat="server" Text="Delete" CommandArgument='<%#Bind("Id")%>' OnClick="lnk_Delete_Click" OnClientClick="return confirmationDelete();"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>
