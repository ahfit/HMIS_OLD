<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EmployeeReportingAuthoritiesSetting.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="HR_EmployeeReportingAuthoritiesSetting" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
        .input_txt {
            width: 400px !important;
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
  <%--  <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>

      <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Employee Approval Authorities</span></h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">

           <tr>
                <td align="right" class="style1">
                    <strong>Category :</strong> </td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlCategory" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Category" DataTextField="Category"
                        DataValueField="CategoryId"
                        AutoPostBack="True" Style="margin-left: 0px">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Category" runat="server"
                        ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                        SelectCommand="select Category,CategoryId from HROperationCategory"></asp:SqlDataSource>




                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Reporting Level :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlLevels" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Levels" DataTextField="Level"
                        DataValueField="LevelNum" AutoPostBack="True" OnSelectedIndexChanged="ddlLevels_SelectedIndexChanged">
                    </asp:DropDownList>


                    <asp:SqlDataSource ID="SDS_Levels" runat="server"
                         ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                        SelectCommand="select LevelNum,Level from HRAuthorityLevel">
                        <SelectParameters>
                
                        </SelectParameters>


                    </asp:SqlDataSource>


                </td>
            </tr>
             <tr>
                <td align="right" class="style1">
                    <strong> Authority Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Branch" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Branch" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AutoPostBack="True">
                    </asp:DropDownList>


                    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                         ConnectionString="<%$ ConnectionStrings:Machine_AttendanceConnectionString %>"
                        SelectCommand="select 0 AS SubDept_Id, ' ---ALL--- ' AS SubDept_Name union
Select sd.SubDept_Id,SubDept_Name from SubDepartment sd
                        inner join Department D on sd.Dept_Id  = D.Dept_Id 
ORDER BY SubDept_Name">
                        <SelectParameters>
                            <%--<asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />--%>
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                
                        </SelectParameters>


                    </asp:SqlDataSource>
 </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Reporting Authorities :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlApprovalAuthority" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Employee" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>


                    <asp:SqlDataSource ID="SDS_Employee" runat="server"
                       ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                        SelectCommand="SELECT Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')+' '+Cast(Employee.EmpID as varchar)+' '+' ('+Cast( Designation.Designation_Name as varchar )+')' AS Name
                                        FROM  Employee inner join Designation on Employee.DesignationID=Designation.Designation_ID	    
                                        WHERE (Employee.ActiveStatus=1)  and SubDeptId=@deptid order by Name,EmpID"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Branch" Name="deptid"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:DropDownList ID="ddlApprovalAuthority2" runat="server"
                        CssClass="drop_down" DataSourceID="sds_Employee2" DataTextField="Name"
                        DataValueField="EmpID" AutoPostBack="true" OnSelectedIndexChanged="ddlApprovalAuthority2_SelectedIndexChanged" Visible="false">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sds_Employee2" runat="server"
                       ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                        SelectCommand="select 0 AS EmpID, '---Select Employee For Search---' AS Name union
                                        SELECT Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')+' '+Cast(Employee.EmpID as varchar)+' '+' ('+Cast( Designation.Designation_Name as varchar )+')' AS Name
                                        FROM  Employee inner join Designation on Employee.DesignationID=Designation.Designation_ID	    
                                        WHERE 
                                        (Employee.ActiveStatus=1)  order by Name,EmpID"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                            <%--<asp:ControlParameter ControlID="DDL_Branch" Name="SubDept_Id"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="Emp_ID" Type="Int32" />--%>
                        </SelectParameters>
                    </asp:SqlDataSource>




                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>For Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlSubDepartment" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Branch" DataTextField="SubDept_Name"
                        DataValueField="SubDept_Id" AutoPostBack="True" OnSelectedIndexChanged="ddlSubDepartment_SelectedIndexChanged">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Branch" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                        SelectCommand="select SubDept_Id,SubDept_Name from SubDepartment SD order by SubDept_Name" >
                        <SelectParameters>
                            <asp:SessionParameter Name="DesignationId" SessionField="DesignationID"/>
                            <%--<asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />--%>
                        </SelectParameters>
                    </asp:SqlDataSource>




                </td>
                </tr>


            <tr>
                <td align="right" class="style1">
                    <strong>Employee :</strong></td>
                <td colspan="2">
                    <div style="overflow: scroll; width: 600px; height: 250px">
                        Select/Deselect All :<asp:CheckBox ID="cbAll" AutoPostBack="true" OnCheckedChanged="cbAll_CheckedChanged" runat="server"   />
                                        <asp:CheckBoxList ID="CheckBoxList_Emp" runat="server" Width="82%" DataSourceID="sdsEmployee"
                                            DataTextField="Name" DataValueField="EmpID" Height="33px"
                                            >
                                        </asp:CheckBoxList>
                                    </div>



                    
                    <asp:SqlDataSource ID="sdsEmployee" runat="server"
                        ConnectionString="<%$ ConnectionStrings:HRConnectionString %>"
                        SelectCommand="SELECT Employee.EmpID,  ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '')+' '+Cast(Employee.EmpID as varchar)+' '+' ('+Cast( Designation.Designation_Name as varchar )+')' AS Name
                                        FROM  Employee inner join Designation on Employee.DesignationID=Designation.Designation_ID	    
                                        WHERE 
                                        (Employee.ActiveStatus=1) and (Employee.SubDeptId = @SubDeptId or @SubDeptId = 0)  order by Name,EmpID">
                        <SelectParameters>
                           <%-- <asp:SessionParameter Name="DesignationId" SessionField="DesignationID"/>--%>
                            <asp:ControlParameter ControlID="ddlSubDepartment" Name="SubDeptId"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>




                </td>
                </tr>
            
            
            
            <tr>
                <td align="right" class="style1">&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="btn_Save" runat="server" Text="Save" CssClass="btn_hacims" OnClick="btn_Save_Click"/>
                </td>
            </tr>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" AllowPaging="true" OnRowDataBound="GridView1_RowDataBound" Visible="false">
                <Columns>
                    <%--<asp:boundfield itemstyle-width="20px" datafield="categoryid" headertext="category id" Visible="false" />--%>
                    <%--<asp:TemplateField HeaderText="CategoryId" Visible="false">
            <ItemTemplate>
                <asp:Label ID="lbl1" runat="server" text='<%#Eval("CategoryId") %>'/>
               
            </ItemTemplate>
        </asp:TemplateField>--%>
                    <asp:TemplateField HeaderText="Category">
                        <ItemTemplate>
                            <asp:Label ID="lblcategory" runat="server" Text='<%#Eval("category") %>' />
                            <%--<asp:boundfield itemstyle-width="20px" datafield="category" headertext="category" />--%>
                            <asp:HiddenField ID="hiddenfield1" runat="server" Value='<%#Eval("CategoryId") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- 
           <asp:templatefield headertext="category">
            <itemtemplate>
                <asp:label id="lbl_category" runat="server" value='<%#eval("category") %>'/>
                <asp:hiddenfield id="hf_category" runat="server" value='<%#eval("category") %>' />
            </itemtemplate>
        </asp:templatefield> --%>
                    <asp:TemplateField HeaderText="Select Level">
                        <HeaderStyle Width="66%" />
                        <ItemStyle Wrap="false" Width="200px" />
                        <ItemTemplate>
                            <asp:RadioButtonList ID="radiobtn" runat="server" RepeatDirection="Horizontal" OnSelectedIndexChanged="radiobtn_SelectedIndexChanged" AutoPostBack="true">
                            </asp:RadioButtonList>
                            <asp:HiddenField ID="hf_CategoryId" runat="server" Value='<%#Eval("CategoryId") %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Define Authority" Visible="false">
                       
                        <ItemTemplate>
                           <asp:LinkButton ID="lnkAuthority" Text="Reporting To" runat="server" CommandArgument='<%#Eval("CategoryId") %>' OnClick="lnkAuthority_Click"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <tr style="display:none;">
                <td>&nbsp;</td>
                <td colspan="1" align="right" >
                    <asp:Button CssClass="btn1" ID="Button_Save" runat="server" Text="Save" OnClick="Button_Save_Click"  style ="margin-left: 374px;" Visible="false" /></td>
            </tr>
        </table>
      
       <%-- <rsweb:ReportViewer ID="ReportViewer1" runat="server"></rsweb:ReportViewer>--%>
        <br />
        <asp:GridView ID="gvd_EmployeeAuthorities" AutoGenerateColumns="false" runat="server">
        <Columns>
             <asp:TemplateField HeaderText="ID">
                <ItemTemplate>
                    <%#Container.DataItemIndex + 1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Employee ID">
                <ItemTemplate>
                    <asp:Label ID="lblID" runat="server"  Text='<%#Bind("EmpID")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  HeaderText="Employee Name">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblbEmployeeName" Text='<%#Bind("EmpName")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Desiganation">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblDesiganation" Text='<%#Bind("Designation_Name")%>'></asp:Label> 
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Department">
                <ItemTemplate>
                    <asp:Label runat="server" ID="lblSubdepartment" Text='<%#Bind("SubDept_Name")%>'></asp:Label> 
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category"/>
             <asp:BoundField DataField="Level" HeaderText="Reporting Level" SortExpression="Level"/>
            <asp:BoundField DataField="ApprovalAuthority" HeaderText="Approval Authority" SortExpression="ApprovalAuthority"/>
            <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                   <asp:LinkButton ID="lnk_Delete" runat="server" Text="Delete" CommandArgument='<%#Bind("Id")%>' OnClick="lnk_Delete_Click" OnClientClick="return confirmationDelete();"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    </div>

    


     <asp:hiddenfield id="hf_catid" runat="server" />
    <div class="=lightbox_bg">
        <asp:Panel ID="pnlAuthority" class="lightbox" Style="width: 400px; height: 400px !important" runat="server"
            Visible="false">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                    <td style="background-color:antiquewhite;">
                        <asp:Label ID="lblCategory" runat="server" Font-Bold="true"></asp:Label>
                       <asp:Label ID="lblLevel" runat="server" Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                </table>
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="false" AllowPaging="true" OnRowDataBound="GridView3_RowDataBound">
                <Columns>

                    <%--<asp:BoundField HeaderText="Name" DataField="Level" />--%>
                    <asp:TemplateField HeaderText="Authorities">
                        <ItemTemplate>
                            <asp:Label ID="lbl_level" runat="server" Text='<%# Eval("Authority") %>' />
                            
                            <asp:HiddenField ID="Hf_AuthorityId" runat="server" Value='<%# Eval("AuthorityNo") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Approval Authority">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlEmployee" DataTextField="EMPLOYEE_NAME" DataValueField="EmpId" runat="server">
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>


            <asp:Button CssClass="btn2" ID="Button1" runat="server" Text="Save" OnClick="Button1_Click" />
            <asp:Button CssClass="btn2" ID="btnClose" runat="server" Text="Close" OnClick="btnClose_Click" />
 
        </asp:Panel>
    </div>
    <br />
    <asp:HiddenField ID="hf_level" runat="server"/>
    <asp:HiddenField ID="hfd_employee" runat="server"/>
</asp:Content>
