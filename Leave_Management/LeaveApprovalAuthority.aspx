<%@ Page Title="" Language="C#" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="true" CodeFile="~/Leave_Management/LeaveApprovalAuthority.cs" Inherits="Leave_Management_LeaveApprovalAuthority" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">     
        function AlertFunction() {
            if (confirm('Are you sure you want to Delete Authority?')) {
                return;
            } else {
                return false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="bxmain inner_content" style="width: 100%; float: left">

        <h2><span>Mark Employee Reporting Departments</span></h2>
        
         <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">

            <tr>
                <td  align="right">
                    <b>Hospital Name: </b></td>
                <td>
                    <asp:DropDownList ID="ddlHospital" runat="server"></asp:DropDownList>
                </td>

           
                <td align="right">
                    <b>Department:</b></td>
                <td>
                    <asp:DropDownList ID="ddldepartment" runat="server" DataTextField="SubDept_Name" DataValueField="SubDept_ID">
                    </asp:DropDownList>
                </td>


               <td  align="center">
                    <asp:Button ID="btnShow" runat="server"  Text="Show" OnClick="btnShow_Click" />

                </td>
            </tr>

         
        </table>
</div>

    <div style="margin-top: 10px">
        
   <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>--%>
        <asp:GridView ID="Gridview1" runat="server" AutoGenerateColumns="false" 
            
            OnPageIndexChanging="Gridview1_PageIndexChanging"
             Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Sr.#">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Employee Name" SortExpression="Employee_Name">
                    <ItemTemplate>
                        <asp:Label ID="lbEName" Text='<%# Bind("Employee_Name") %>' runat="server" />

                        <asp:HiddenField ID="hfEmpID" runat="server" Value='<%# Bind("EmpID") %>' />

                    </ItemTemplate>
                </asp:TemplateField>
               
                   <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name"/>
                        <asp:BoundField DataField="SubDept_Name" HeaderText="Department" SortExpression="SubDept_Name"/>

                <asp:TemplateField HeaderText="Mark Authority">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnMark" runat="server" Text="Mark Authority" CommandArgument='<%# Bind("EmpID") %>' OnClick="btnMark_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
                <%--     <asp:TemplateField HeaderText="Assign Authority">
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Visible='<%#Bind("is_assigned") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Remove">
                    <ItemTemplate>

                        <asp:LinkButton ID="lnkbtnRemoveLeft" Text="Remove" Visible='<%#Bind("is_removable") %>'  CommandName='<%#Bind("ReportingID") %>' runat="server" OnClick="lnkbtnRemoveLeft_Click"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>--%>
            </Columns>
        </asp:GridView>
         <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                    <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                </span>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>--%>
           <%--     </ContentTemplate>
            </asp:UpdatePanel>--%>
    </div>

     <asp:Panel ID="panel" runat="server" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div class="bxmain inner_content">

                <h2><span>Reporting Authority</span></h2>
                <table style="margin: 10px; line-height: 2">
                    <tr>
                        <td>
                            <b>Employee Name:</b>
                        </td>
                        <td>
                            <asp:Label ID="lblEmpName" runat="server" Text="Label"></asp:Label>

                        </td>
                    </tr>
                    <tr>
                        <td width="35%" align="right">

                            <b>Department:</b> </td>
                        <td>
                            <asp:DropDownList ID="ddlsubdeptReporting" OnSelectedIndexChanged="ddlsubdeptReporting_SelectedIndexChanged" runat="server" DataValueField="SubDept_ID" DataTextField="SubDept_Name">
                            </asp:DropDownList></td>
                    </tr>
                    <tr style="display:none">
                        <td width="35%" align="right">

                            <b>Employee Name:</b> </td>
                        <td>
                            <asp:DropDownList ID="ddlEmpName" runat="server" DataValueField="EmpID" DataTextField="Employee_Name">
                            </asp:DropDownList></td>

                    </tr>

                    <tr style="display:none">
                        <td width="35%" align="right">
                            <b>Authority Level:</b> </td>
                        <td>
                            <asp:TextBox ID="txtboxPriority" runat="server"></asp:TextBox>
                        </td>
                    </tr>




                    <tr>
                        <td width="20%" colspan="24" align="center">
                            <asp:Button ID="btnReporting" runat="server" Text="Mark Reporting Authority" OnClick="btnReporting_Click" />
                            <asp:Label ID="lblexist" runat="server" Visible="false"></asp:Label>
                            <asp:Label ID="Label1" runat="server" Text="Update Successfully..." ForeColor="Green" Visible="false"></asp:Label>
                        </td>
                        <td>
                            <asp:Button ID="closebtnPanel" Text="Close" runat="server" OnClick="closebtnPanel_Click" />

                        </td>
                    </tr>
                </table>
            </div>
           <div style="height: 253px; overflow-y: scroll;">
                <asp:GridView ID="Gridview2" runat="server"
                     AutoGenerateColumns="false" Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.#">
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Employee Name">
                            <ItemTemplate>
                                <asp:Label ID="lbEName" Text='<%# Bind("Employee_Name") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Department">
                            <ItemTemplate>
                                <asp:Label ID="lbEnaa" Text='<%# Bind("SubDepT_Name") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                       
                     

                         <asp:TemplateField >
                            <ItemTemplate>
                                <asp:LinkButton Text="Delete" ID="btnDelAuthority" CommandArgument='<%#Bind("ReportingId") %>' OnClick="btnDelAuthority_Click" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                      </div>
            </div>
    </asp:Panel>
    <br /><br /><br />

<div class="bxmain inner_content" style="width:100%; margin-top: 2%; display:none;">
           <h2><span>Set Leave/Overtime Approval Authorities</span></h2>
                <table class="style1" style="margin-left:300px">
            
                    <tr>
                        <td class="style2">
                           Department :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddl_SubDeptId" runat="server"  OnSelectedIndexChanged="ddl_SubDeptId_SelectedIndexChanged" AutoPostBack="true"
                                DataTextField="EmployeeName" DataValueField="EmpID" 
                                Width="200px" >
                            </asp:DropDownList>
                        </td>
                        <td style="padding-left:30px;" class="style2">
                           Select HOD :
                        </td>
                        <td class="style3">
                            <asp:DropDownList ID="ddlDesignation" runat="server"                                   
                                Width="200px" >
                            </asp:DropDownList>
                        </td>                    
                   </tr>
                   
                    
         
                    <tr>
         
                    <td colspan="2" align="center" style="padding-top:25px;">
                        <asp:Button ID="btnSave" runat="server" Text="Save"  OnClick="btnSave_Click"
                             CssClass="btn_1" style="float:right"/>

                      </td>                        
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <asp:Label ForeColor="Red" Font-Bold="true" Font-Size="17px" ID="lblMsg" runat="server"></asp:Label>
                        </td>
                    </tr>
    </table>



    </div>
    
<div style="margin-top:10px; display:none;"  class="bxmain inner_content"> <h2><span>Departments HODS</span></h2>
        <asp:GridView ID="gvd" CssClass="Grid_1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" Visible="false"/>

                <asp:TemplateField HeaderText="Department">
                    <ItemTemplate>
                        <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("SubDept_Name") %>'></asp:Label>
                        <asp:HiddenField ID="hfID" runat="server" Value='<%# Eval("ID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Designation">
                    <ItemTemplate>
                        <asp:Label ID="lblDesignation" runat="server" Text='<%# Eval("Designation_Name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Delete">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandArgument='<%# Eval("ID") %>' OnClick="lnkDelete_Click" OnClientClick="return AlertFunction();"/>
                    </ItemTemplate>
                </asp:TemplateField>
                
            </Columns>
        </asp:GridView>

        

    </div>
   
    <asp:HiddenField ID="HfEmpId" runat="server"/>


</asp:Content>

