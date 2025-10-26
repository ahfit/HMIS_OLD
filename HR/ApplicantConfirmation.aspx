<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="ApplicantConfirmation.aspx.cs" Inherits="HR_ApplicantConfirmation" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style2
        {
            text-align:right;
           
        }
        .style3
        {
            width: 272px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 style="color: Maroon; font-size: medium"> Employee Confirmation</h1>
    <br />
    <br />
    <div style="width: 100%; margin: aut0;" class="bxmain inner_content">
        <h2>
            <span>Selected Candidates Joining Setup</span></h2>
        <table style="width: 100%; margin: auto">
          
            <tr>
                <td style="width: 45%; text-align: right;" align="right">
                    Advertisment :&nbsp;
                </td>
                <td>
                    <%--<asp:TextBox ID="txtobxCnic" runat="server" CssClass="input_txt"></asp:TextBox>--%>                      
                                <asp:DropDownList ID="DDL_Advertizement" AutoPostBack="true" 
                        runat="server" 
                        onselectedindexchanged="DDL_Advertizement_SelectedIndexChanged" ></asp:DropDownList>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="mainApp" runat="server" ControlToValidate="DDL_Advertizement"
                        ErrorMessage="*">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 45%; text-align: right;" align="right">
                    Post :&nbsp;
                </td>
                <td>
                    <%--<asp:TextBox ID="txtobxCnic" runat="server" CssClass="input_txt"></asp:TextBox>--%>                      
                                <asp:DropDownList ID="DDL_Posts" AutoPostBack="true" runat="server" 
                        onselectedindexchanged="DDL_Posts_SelectedIndexChanged" ></asp:DropDownList>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="mainApp" runat="server" ControlToValidate="DDL_Posts"
                        ErrorMessage="*">*</asp:RequiredFieldValidator>
                </td>
            </tr>





          
          
            <tr>
                <td style="width: 45%; text-align: right;" align="right">
                    Selected Candidates :&nbsp;
                </td>
                <td>
                    <%--<asp:TextBox ID="txtobxCnic" runat="server" CssClass="input_txt"></asp:TextBox>--%>                      
                                <asp:DropDownList ID="ddlCandidates" runat="server" AutoPostBack="false"
                        onselectedindexchanged="ddlCandidates_SelectedIndexChanged" ></asp:DropDownList>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="mainApp" runat="server" ControlToValidate="ddlCandidates"
                        ErrorMessage="*">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                    <td class="style2">
                        Join Date:
                    </td>
                    <td class="style3">
                        <igsch:WebDateChooser ID="WebDateJoinDate" Width="250px" runat="server" CssClass="drop_date"
                            Visible="true">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                        
                    </td>
                    <td></td>
                </tr>

             <tr>
                    <td style="width: 45%; text-align: right;" align="right">
                        Confirmation Recomended By:
                    </td>
                    <td class="style3">
                        <asp:DropDownList ID="ddRecBy" runat="server" DataSourceID="sdsRecBy" DataTextField="Name"
                            DataValueField="EmpID">
                        </asp:DropDownList>
                        
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                        Approval Date:
                    </td>
                    <td class="style3">
                        <igsch:WebDateChooser ID="WDCapproval" Width="250px" runat="server" CssClass="drop_date"
                            Visible="true">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                        
                    </td>
                    <td></td>
                </tr>

                <tr>
                    <td class="style2">
                        Amount
                    </td>
                    <td class="style3">
                        <asp:TextBox ID="txtboxSalary" runat="server" ></asp:TextBox>
                    </td>
                    <td></td>
                </tr>

                 <tr>
                    <td class="style2">
                        Remarks/Reason:
                    </td>
                    <td class="style3">
                        <asp:TextBox ID="tbxRemarks" runat="server" Height="40px" TextMode="MultiLine" Width="300px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                <td colspan="3" align="center" style="line-height:3">
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />  <asp:Label ID="lblMsg" Visible="false" Font-Bold="true" runat="server" ForeColor="Green" Text="Data is Save Successfully..."></asp:Label>
                </td>
                </tr>


           
        </table>
    </div>
    
                
               
                        
                        <asp:SqlDataSource ID="sdsemployeerec" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                            SelectCommand="usp_employeerecord" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                <asp:QueryStringParameter Name="empid" QueryStringField="empid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsconfirminfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            InsertCommand="INSERT INTO Employee_Confirmed_info(Emp_Id, Remarks, Is_Confirmed, Confirmation_Rec_By, Approval_Date) VALUES (@empid, @remarks, 1, @ddRecBy, @wdcApprov)"
                            SelectCommand="SELECT Emp_Id, Is_Confirmed, Remarks, Confirmation_Rec_By, Approval_Date FROM Employee_Confirmed_info">
                            <InsertParameters>
                                <asp:QueryStringParameter Name="empid" QueryStringField="empid" />
                                <asp:Parameter Name="remarks" />
                                <asp:Parameter Name="ddRecBy" />
                                <asp:Parameter Name="wdcApprov" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsRecBy" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                            SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Name
FROM Employee where Employee.empid in (123,165,29)">
                        </asp:SqlDataSource>
                
        
    
    

                
        
    
</asp:Content>

