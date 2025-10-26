<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="EvalutionFormSettingGeneric.aspx.cs" Inherits="HR_EvalutionFormSettingGeneric" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Employee Appraisal Setting</span></h2>

        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
            
             <tr >
                        <td class="tbl-col-1">Hospital : </td>
                        <td >
                             <asp:DropDownList ID="DDL_Company" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Company" DataTextField="Hospital_Name"
                         DataValueField="Hospital_ID"
                        AutoPostBack="True" Style="margin-left: 0px">
                    </asp:DropDownList> 

                    <asp:SqlDataSource ID="SDS_Company" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="select 0 As Hospital_ID, '---ALL---' as Hospital_Name union select [Hospital_ID], [Hospital_Name] FROM [Hospital]">

                    </asp:SqlDataSource>
                        </td>
                         <td  class="tbl-column-3">
                     Department :</td>
                <td >
                    <asp:DropDownList ID="DDL_Department" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Department" DataTextField="Dept_Name" 
                        DataValueField="Dept_ID" AutoPostBack="True">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Department" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="usp_GetDeprtmentsByHospitalWithALL" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />
                             <%--<asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />--%>
                
                        </SelectParameters>
                    </asp:SqlDataSource>

                    </td>
                    </tr>
                    <tr>
                        <td class="tbl-column-1">
                          Sub Department :
                        </td>
                        <td >
                            <asp:DropDownList ID="DDL_Branch" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Branch" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Branch" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="usp_GetSubDeprtmentsByHospitalWithALL" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="DDL_Department" Name="DeptID"
                                PropertyName="SelectedValue" />
                
                        </SelectParameters>
                    </asp:SqlDataSource>
                        </td>
                        <td class="tbl-column-3">
                           Employee :
                        </td>
                        <td >
                            <%--    <asp:DropDownList ID="DDL_Employee" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Employee" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>--%>
                             <div style=" position: absolute;overflow-x: auto; height: 130px;border: 1px solid #00000024;width: 350px; background: white;">
         Select/Deselect All :<asp:CheckBox ID="cbAll" AutoPostBack="true"  runat="server"  OnCheckedChanged="cbAll_CheckedChanged"   />
                        <asp:CheckBoxList ID="CheckBoxList_Emp" runat="server" DataSourceID="SqlDataSourceEmployeeName"
                            DataTextField="empolyeeName" DataValueField="EmpID" RepeatColumns="1" RepeatDirection="Vertical"
                            Width="100%" RepeatLayout="UnorderedList">
                        </asp:CheckBoxList>
                    </div>
   
       
                    <asp:SqlDataSource ID="SDS_Employee" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="usp_GetEmployeeWithAll" SelectCommandType="StoredProcedure"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="DDL_Department" Name="DeptID" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="DDL_Branch" Name="SubDeptId" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceEmployeeName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT     Employee.EmpID,  ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') &#13;&#10; 
        + ' ' + ISNULL(Employee.ELName, ' ')+' '+ cast(Employee.EmpID as varchar)   + ' (' + Designation.Designation_Name + ') '
       AS empolyeeName, Employee.DeptID, Employee.SubDeptId&#13;&#10;FROM         Employee INNER JOIN&#13;&#10; 
        Designation ON Employee.DesignationID = Designation.Designation_ID&#13;&#10;WHERE  (Employee.SubDeptId = @SubDeptId) 
        and Activestatus=1 order by empolyeeName">
                                <SelectParameters>
                                     <asp:ControlParameter ControlID="DDL_Branch" Name="SubDeptId" PropertyName="SelectedValue" />
                                </SelectParameters>
                                </asp:SqlDataSource>
                        </td>
                    
                        
                   </tr>
             <tr>
                <td width="20%" align="right">Financial Year :  </td>
                <td class="radio-Type" align="left">
                    <asp:DropDownList ID="ddlFinancialYear" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFinancialYear_SelectedIndexChanged"></asp:DropDownList>
                </td>
                 </tr>
             <tr>
                <td width="20%" align="right">Title  </td>
                <td class="radio-Type" align="left">
               <asp:TextBox runat="server" ID="txtboxtilte" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqvalidtr" runat="server" ControlToValidate="txtboxtilte" ForeColor="Red"
                        ErrorMessage="Please Enter Tilte" ></asp:RequiredFieldValidator>
                     </td>
                 </tr>
            <tr>
                <td width="20%" align="right">Type :  </td>
                <td class="radio-Type">
                    <asp:RadioButtonList runat="server" ID="rbType" AutoPostBack="true" RepeatDirection="Horizontal" OnSelectedIndexChanged="rbType_SelectedIndexChanged">
                        <asp:ListItem Text="Probation" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Appraisal" Value="4"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
                </tr>
            <tr>
             <td width="20%" align="right">Heading :  </td>
                <td>
                    <asp:DropDownList ID="ddlHeading" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlHeading_SelectedIndexChanged" > </asp:DropDownList>
                    <%--<asp:DropDownList ID="ddlHeading" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlHeading_SelectedIndexChanged"> </asp:DropDownList>--%>
                </td>
            </tr>
            
            <tr>
                <td align="center" colspan="3">
                    <asp:Button ID="btnsave" runat="server" Text="Save" OnClick="btnsave_Click" />
                    <asp:link
                    <asp:Label ID="lblmsg" runat="server" Visible="false" Font-Bold="true" Font-Size="Large" ForeColor="Green"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <asp:Label runat="server" ID="lblstatus"></asp:Label>
    <br />
    <asp:GridView ID="gridFatorsDetails" runat="server" AutoGenerateColumns="false" Width="100%" OnRowDataBound="gridFatorsDetails_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Mark" HeaderStyle-HorizontalAlign="Center" >
                               <HeaderTemplate>
                                   <asp:CheckBox runat="server" id="grdcheck"  Text="Mark" OnCheckedChanged="grdcheck_CheckedChanged"  AutoPostBack="true" />
                               </HeaderTemplate>
                                 <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chkSelect"  Enabled="true"/>
                                    <%-- <asp:CheckBoxList ID="checkOne" Enabled="true"   runat="server"></asp:CheckBoxList>--%>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name"  HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="name" Text='<%# Bind("Name") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Detail"  HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="detail" Text='<%# Bind("Detail") %>' runat="server" />
                              <asp:HiddenField ID="hfFactorId" runat="server" Value='<%# Bind("FactorId") %>' />
                                    <asp:HiddenField ID="hfFactorDetailId" runat="server" Value='<%# Bind("FactorDetailId") %>' />

                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Marks">
                                <ItemTemplate>
                                    <%--<asp:TextBox ID="lblWeightage" Visible="false"  runat="server" Text='<%# Bind("Weightage") %>'> </asp:TextBox>--%>
                                    <asp:TextBox ID="lblmarks" runat="server" Text='<%# Bind("marks") %>'> </asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>



                    </asp:GridView>
    
 </asp:Content>

