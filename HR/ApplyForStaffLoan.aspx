<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ApplyForStaffLoan.aspx.cs" Inherits="HR_ApplyForStaffLoan" MasterPageFile="~/hacims_masterpage_admin.master" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">

    </script>
    <style type="text/css">
        .style1 {
            width: 410px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
    <iframe id="frmPrint" name="IframeName" width="500"
        height="200" runat="server"
        style="display: none"></iframe>
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Apply For Staff Loan</span></h2>

        <table class="tbl_form">
            <tr>
                <td align="right" class="style1">
                    <strong>Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="ddl_SubDepartment" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Branch" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AutoPostBack="True">
                    </asp:DropDownList>
                    </td>
            </tr>
            <tr>

                <td align="right" class="style1">
                    <strong>Employee For Loan:</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="drop_down" 
                        DataSourceID="SDS_Employee" DataTextField="Name" DataValueField="EmpID">
                    </asp:DropDownList>
                    <asp:HiddenField  runat="server" ID="hfempid"/>
                    <asp:SqlDataSource ID="SDS_Employee" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT     Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name
FROM         Employee
 
WHERE     (Employee.SubDeptId = @SubdeptId) and (Employee.ActiveStatus=1)   order by Name,EmpID"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddl_SubDepartment" Name="SubdeptId" PropertyName="SelectedValue"/>
                        </SelectParameters>
                    </asp:SqlDataSource>



                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Total Loan Amount :</strong></td>
                <td colspan="2">
                    <asp:TextBox ID="txtLoanAmount" runat="server" SkinID="intdata"  required></asp:TextBox>
                    <asp:RangeValidator id="Range1"
           ControlToValidate="txtLoanAmount"
           MinimumValue="3"
           MaximumValue="2147483647"
           Type="Integer"
           Text="The value must be integer and greater than 0"
           runat="server"/>
                </td>
            </tr>

            <tr>
                <td align="right" class="style1">
                    <strong>Installment Amount :</strong></td>
                <td colspan="2">
                    <asp:TextBox ID="txtInstallmentAmount" runat="server" SkinID="intdata" required></asp:TextBox>
                    <asp:RangeValidator id="RangeValidator2"
           ControlToValidate="txtInstallmentAmount"
           MinimumValue="0"
           MaximumValue="2147483647"
           Type="Integer"
           Text="The value must be integer and greater than 0"
           runat="server"/>

                </td>
            </tr>
              <tr>
                <td align="right" class="style1"><strong>Year :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlYear" runat="server">
                       </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1"><strong>Month :</strong></td>
                <td colspan="2">
                     <asp:DropDownList ID="ddlMonth" runat="server">
                       <asp:ListItem Text="1" Value="1"> Januarary</asp:ListItem>
                       <asp:ListItem Text="2" Value="2">Feburary</asp:ListItem>
                       <asp:ListItem Text="3" Value="3">March</asp:ListItem>
                       <asp:ListItem Text="4" Value="4">Aprail</asp:ListItem>
                       <asp:ListItem Text="5" Value="5">May</asp:ListItem>
                       <asp:ListItem Text="6" Value="6">June</asp:ListItem>
                       <asp:ListItem Text="7" Value="7">July</asp:ListItem>
                       <asp:ListItem Text="8" Value="8">August</asp:ListItem>
                       <asp:ListItem Text="9" Value="9">September</asp:ListItem>
                       <asp:ListItem Text="10" Value="10">October</asp:ListItem>
                       <asp:ListItem Text="11" Value="11">November</asp:ListItem>
                       <asp:ListItem Text="12" Value="12">December</asp:ListItem>
                   </asp:DropDownList>
                </td>
            </tr>
          
            <tr style="display:none;">
                <td align="right" class="style1">
                    <strong>Hospital :</strong> </td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Company" runat="server" CssClass="drop_down"
                        DataSourceID="SDS_Company" DataTextField="Hospital_Name"
                        DataValueField="Hospital_ID"
                        AutoPostBack="True" Style="margin-left: 0px">
                    </asp:DropDownList>

                    <asp:SqlDataSource ID="SDS_Company" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
                </td>
            </tr>

            <tr>
                <td colspan="3">                    
                    <h3 class="title">
                    Select Surity Employee</h3>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Branch" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Branch" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AutoPostBack="True">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Branch" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="Select SubDepartment.SubDept_Id,SubDept_Name from SubDepartment
 
ORDER BY SubDept_Name">
                        <SelectParameters>
                            <%--<asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />--%>
                            <%--     <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />--%>
                        </SelectParameters>
                    </asp:SqlDataSource>





                </td>
            </tr>
            <tr>

                <td align="right" class="style1">
                    <strong>Employee :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlSurityEmployee" runat="server"
                        CssClass="drop_down" DataSourceID="sdsEmployeeForSurity" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>

                    <asp:SqlDataSource ID="sdsEmployeeForSurity" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT     Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name FROM         Employee
 WHERE     (@SubDept_Id =0 or Employee.SubDeptId = @SubDept_Id) and (Employee.ActiveStatus=1)  order by Name,EmpID"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Branch" Name="SubDept_Id"
                                PropertyName="SelectedValue" />
                           
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <%-- SelectCommand="SELECT     Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name
FROM         Employee

inner join EmployeeReportingAuthority ER on er.ReportingAuthorityEmpID=Employee.EmpID
WHERE     (@SubDept_Id =0 or Employee.SubDeptId = @SubDept_Id) and ER.EmpID=@empid  order by Name,EmpID"--%>



                </td>
            </tr>


            <tr>
                <td align="right" class="style1">&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="btnSearch" runat="server" CssClass="btn_hacims" Text="Seacrh" OnClick="btnSearch_Click" formnovalidate/>
                    <asp:Button ID="btnSave" runat="server" CssClass="btn_hacims" Text="Save" OnClick="btnSave_Click" />
                    <asp:Label ID="lblFruitName" runat="server" />
                     <asp:Label ID="Label1" runat="server" />
                    <asp:Label ID="lblSaveMessage" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </div>

    <br />

    <asp:GridView ID="gvList" runat="server" AutoGenerateColumns="False"
        CssClass="Grid_1" Width="100%" AllowPaging="True" DataKeyNames="ID"
        PageSize="50" EnableModelValidation="True">
        <Columns>
            <asp:TemplateField HeaderText="#">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                    <asp:HiddenField ID="HiddenField_EmpId" runat="server"
                        Value='<%# Eval("LoanEmpId") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="LoanEmpId" HeaderText="Emp Id" SortExpression="Emp Id" />
            <asp:BoundField DataField="Employee" HeaderText="Employee" SortExpression="Employee" />
            <asp:BoundField DataField="ApplyDate" HeaderText="ApplyDate" SortExpression="ApplyDate" />
            <asp:BoundField DataField="LoanAmount" HeaderText="LoanAmount" SortExpression="LoanAmount" />
            <asp:BoundField DataField="SurityEmployee" HeaderText="SurityEmployee" SortExpression="SurityEmployee" />
            <asp:BoundField DataField="Installment" HeaderText="Installment" SortExpression="Installment" />
            <asp:BoundField DataField="RequestedMonth" HeaderText="Requested Month" SortExpression="RequestedMonth" />
            <asp:BoundField DataField="RequestedYear" HeaderText="Requested Year" SortExpression="RequestedYear" />
            <asp:BoundField DataField="IsApproved" HeaderText="Approve Status" SortExpression="IsApproved" />
            <%-- <asp:BoundField DataField="ApprovedByHR" HeaderText="Approved By HR" SortExpression="ApprovedByHR" />
            <asp:BoundField DataField="ApprovedByFinance" HeaderText="Approved By Finance" SortExpression="ApprovedByFinance" />--%>
            <asp:TemplateField HeaderText="Delete">
                <ItemStyle Width="10%" />
                <ItemTemplate>
                    <asp:LinkButton ID="lnkdelete" CausesValidation="false" Text="Delete" CommandName='<%# Bind("ID") %>' runat="server" OnClick="lnkdelete_Click"
                        OnClientClick="try { return confirm('Are you sure you want to delete this loan Request?'); } catch(e){alert(e.message);}"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>

