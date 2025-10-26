<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AddAccountInforamtion.aspx.cs" Inherits="PayRoll_AddAccountInforamtion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">

        #tbleAccount td {
        width:50px;
        }

         .align {
        text-align:right;
        
        }


        #tbleAccount tr {
        line-height:2;
        }


    </style>

    <script type="text/javascript">

        $(document).ready(function () {
            $
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <div style="display: inline; float: left; width: 100%;" class="bxmain inner_content">
                <h2>
                    <span>Add Bank Detail</span></h2>
                <table id="tbleAccount" width="100%">
                    <tr>                        
                        <td  class="align"  >
                            <asp:Label   ID="lbl" runat="server" Text="Department :"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="DDLDept"  runat="server"
                        Width="250px" AutoPostBack="True" Visible="true" OnSelectedIndexChanged="DDLDept_SelectedIndexChanged"  >
                    </asp:DropDownList>
                            
       
                        </td>

                        <td class="align">
                            &nbsp;</td>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>                        
                        <td  class="align"  >
                            Subdepartment :</td>
                        <td>
                            <asp:DropDownList ID="DDLSubDept"  runat="server"
                       Width="250px" AutoPostBack="True" Visible="true">
                    </asp:DropDownList>

                           
                        </td>

                        <td class="align">
                            <asp:Label  ID="lblEmployee" runat="server" Text="Employee :"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlEmployee" DataTextField="empolyeeName" DataValueField="EmpID" DataSourceID="SqlDataSourceEmployeeName" runat="server"></asp:DropDownList>

                             <asp:SqlDataSource ID="SqlDataSourceEmployeeName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="select 0 as EmpID,'---ALL---' empolyeeName union  SELECT     Employee.EmpID,  ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ')   + ' ' + ISNULL(Employee.ELName, ' ')   AS empolyeeName FROM         Employee  WHERE (Employee.ActiveStatus = 1) AND (Employee.SubDeptId = @SubDeptID) order by empolyeeName">
        <SelectParameters>
           
            <asp:ControlParameter ControlID="DDLSubDept" Name="SubDeptID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>



                        </td>
                    </tr>
                        <tr>                        
                        <td class="align">
                            <asp:Label CssClass="align" ID="Label1" runat="server" Text="Bank Name :"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlBankName" runat="server"></asp:DropDownList>
                        </td>

                        <td class="align">
                            <asp:Label ID="Label2" CssClass="align" runat="server" Text="Account # :"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtboxAccount" runat="server" ></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4" align="center" >
                            <asp:Button ID="btnSave" runat="server" Text="Save Account Info" OnClick="btnSave_Click" />
                            <asp:Button ID="btnSearch" runat="server" Text="Search Account Info" OnClick="btnSearch_Click" />
                        </td>
                    </tr>

                     <tr>
                        <td colspan="4" align="center" >
                            <asp:Label ID="lblMsg" runat="server" Font-Bold="true" Font-Size="16px"></asp:Label>
                        </td>
                    </tr>

                </table>
            </div>    


    <div>
         <asp:UpdatePanel ID="pnl_grdViewEmployeeAdvanceLoanDetails" runat="server">
            <ContentTemplate>
        <asp:GridView ID="gvd" EmptyDataText="No Record Found. . ."
            AllowSorting="true" 
            OnSorting="gvd_Sorting"
            OnPageIndexChanging="gvd_PageIndexChanging"
            CssClass="table table-bordered table-hover" 
            runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />              
             <asp:BoundField DataField="SubDept_Name" HeaderText="SubDept Name" SortExpression="SubDept_Name" />              
             <asp:BoundField DataField="Account_Number" HeaderText="Account Number" SortExpression="Account_Number" />              
            
            </Columns>
        </asp:GridView>
                 <asp:UpdateProgress ID="upd_Cnicgvd" runat="server">
                    <ProgressTemplate>
                        <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                            <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                            </span>
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>

