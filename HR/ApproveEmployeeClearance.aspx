<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="ApproveEmployeeClearance.aspx.cs" Inherits="HR_ApproveEmployeeClearance" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <asp:SqlDataSource ID="dsEmployeeInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HfEmpId" Name="EmpID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:HiddenField ID="HiddenField_EmpId" runat="server" />
    <div class="bxmain" style="width: 100%;padding:10px">
        <div class="inner_content bxmain" style="width: 100%">
            <h2>Employee Clearance Approval</h2>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td colspan="3">

                        <asp:FormView ID="FormView1" runat="server" DataKeyNames="EmpID" DataSourceID="dsEmployeeInfo"
                            HorizontalAlign="Left" Width="100%">
                            <ItemTemplate>
                                <div class="bxinset radius4">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td valign="top" width="100" align="center">
                                                <asp:Image ID="Image2" runat="server" ImageUrl="~/images_hacims/picplace.jpg"
                                                    Width="77px" Height="90px" />
                                            </td>
                                            <td valign="top">
                                                <ul class="empinfo">
                                                    <li class="name">
                                                        <asp:Label ID="Label_EmpName" runat="server" Text='<%# Eval("[Employee Name]") %>'
                                                            ToolTip="Employee Name"></asp:Label></li>
                                                    <li>
                                                        <asp:Label ID="Designation_NameLabel" runat="server" Style="color: #c60c0c; font-weight: bold;"
                                                            Text='<%# Bind("Designation_Name") %>'></asp:Label>
                                                        <asp:Label ID="Designation_NameLabel0" runat="server" Text='<%# Convert.ToString("( ")+ Convert.ToString(Eval("SubDept_Name"))+Convert.ToString(" )") %>'></asp:Label></li>
                                                    <li class="div">
                                                        <asp:Label ID="Designation_NameLabel1" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label></li>
                                                    <li>Emp # <strong>
                                                        <asp:Label ID="RegistrationNo" runat="server" Text='<%# Eval("EmpID") %>'
                                                            ToolTip="Patient Registration Number"></asp:Label></strong>
                                                        <span class="spl">|</span> Join Date : <strong>
                                                            <asp:Label ID="Label_JoinDate" runat="server" Text='<%# Bind("JoinDate") %>' ToolTip="Patient Age"></asp:Label></strong>
                                                        <span class="spl">|</span> CNIC : <strong>
                                                            <asp:Label ID="Label_CNIC" runat="server" Text='<%# Eval("CNIC") %>' ToolTip="Identity Card #"></asp:Label></strong>
                                                        <span class="spl">|</span> <strong>
                                                            <asp:Label ID="LabelGender" runat="server" Text='<%# Eval("Gender") %>' ToolTip="Patient Gender"></asp:Label></strong>
                                                    </li>
                                                </ul>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </ItemTemplate>
                        </asp:FormView>

                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td valign="top" width="25%">&nbsp;</td>
                    <td valign="top">&nbsp;</td>
                    <td valign="top" width="25%">&nbsp;</td>
                </tr>
                <tr>
                    <td valign="top" width="30%">
                        <div class="inner_content bxmain" style="width: 99%;">
                            <h2>
                                <span>Clearance Departments</span></h2>
                            <div style="border-style: solid; border-width: 0px; height: 222px; overflow-x: hidden; overflow-y: auto;">
                                <asp:GridView ID="GridView6" runat="server" Width="98%" CssClass="Grid_1" AutoGenerateColumns="False"
                                    DataSourceID="SqlDataSource_Departments" EnableModelValidation="True" OnRowDataBound="GridView6_RowDataBound">
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                    <Columns>


                                        <asp:BoundField DataField="SubDept_Name" HeaderText="Department" SortExpression="SubDept_Name" />
                                        <asp:BoundField DataField="Remarks" HeaderText="Final Remarks" SortExpression="Remarks" />

                                        <asp:TemplateField HeaderText="Status" SortExpression="IsCleared">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("IsCleared") %>' ></asp:Label>
                                             <%--   <asp:HiddenField ID="hfcolor" runat="server" Value='<%# Bind("Color") %>' />--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </td>
                    <td valign="top">
                        <div class="inner_content bxmain" style="width: 99%;">
                            <h2>Add Remarks</h2>
                            <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">

                                <tr>
                                    <td align="right">Remarks :
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRemarks" runat="server" Height="63px" TextMode="MultiLine"
                                            Width="300px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"></td>
                                    <td>
                                        <asp:Button ID="btnAddRemarks" runat="server" Text="Add Remarks" OnClick="btnAddRemarks_Click" />
                                        <asp:Label ID="lblMsg" runat="server" Style="font-size: 13px; font-weight: bold;" ForeColor="Red"></asp:Label>
                                        <asp:Button ID="btnApprove" runat="server" Text="Approve" OnClick="btnApprove_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td valign="top" width="30%">
                        <div class="inner_content bxmain" style="width: 99%;">
                            <h2>Clearance Remarks</h2>
                            <div style="border-style: solid; border-width: 1px; height: 222px; overflow-x: hidden; overflow-y: auto;">
                                <asp:DataList ID="dlRemarks" runat="server" DataSourceID="SqlDataSourceRemarks">
                                    <ItemTemplate>
                                        <div class="bx_oplist" style="width: 98%; margin: auto;">
                                            <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("SubDept_Name") + " :" %>' Font-Bold="true"></asp:Label>
                                            <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks") %>' Font-Size="Small" ForeColor="Blue" Font-Bold="true"></asp:Label>
                                            <div  class="bx_oplist" style="width: 100%; text-align:right">
                                                <asp:Label ID="lblDate" runat="server" Text='<%# "(" + Eval("RemarksDate") + ")" %>' Font-Size="Small" ></asp:Label>
                                            </div>
                                        </div>
                                    </ItemTemplate>

                                </asp:DataList>
                                <br />
                                <asp:SqlDataSource ID="SqlDataSourceRemarks" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                                    SelectCommand="select isnull(Remarks,'') AS Remarks,SD.SubDept_Name,Convert(varchar,RemarksDate,103) + ' ' + FORMAT(RemarksDate,'hh:mm tt') AS RemarksDate,
ISNULL(E.EFName+' ','') + ISNULL(E.EMName+' ','') + ISNULL(E.ELName+' ','') As Employee 
from EmployeeClearanceRemarks ECR
inner join SubDepartment SD on ECR.SubDeptId = SD.SubDept_Id
inner join Employee E on ECR.RemarksBy = E.EmpID
where  ClearanceId = @ClearanceId order by ECR.Id Desc">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HfClearanceId" Name="ClearanceId" PropertyName="Value"
                                            Type="Int32" />                                        
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <br />
                                <asp:HiddenField ID="HiddenField_StartDate" runat="server" />
                                <asp:HiddenField ID="HiddenField_EndDate" runat="server" />
                                <asp:HiddenField ID="HiddenField_LeaveDate" runat="server" />
                                <asp:HiddenField ID="HiddenField_LeaveID" runat="server" />
                                <asp:HiddenField ID="HiddenField_HasOpening" runat="server" />

                            </div>
                        </div>
                    </td>
                </tr>
            </table>

            <asp:SqlDataSource ID="SqlDataSource_Departments" runat="server" ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                SelectCommand="select SD.SubDept_Name,SD.SubDept_Id, Case when isnull(ECS.IsApproved,0) = 0 then 'Pending' else 'Cleared' end AS IsCleared,
isnull(Remarks,'') AS Remarks
from EmployeeClearanceMain ECM
inner join EmployeeClearanceSub ECS on ECM.ClearanceId = ECS.ClearanceId
inner join SubDepartment SD on ECS.SubDeptId = SD.SubDept_Id
where ECM.ClearanceId = @ClearanceId">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HfClearanceId" Name="ClearanceId" PropertyName="Value"
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

        </div>
    </div>
   <asp:HiddenField runat="server" ID="HfEmpId" />
    <asp:HiddenField runat="server" ID="HfClearanceId" />
    <br />
</asp:Content>
