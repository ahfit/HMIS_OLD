<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_Promotion, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            text-align:right;
            width: 256px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h4>Employee promotion/Demotion:</h4>
<div class="bxmain"> 
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="EmpID" 
        DataSourceID="dsEmployeeInfo" HorizontalAlign="Left" Width="100%">
        <ItemTemplate>
            <div class="bxinset radius4">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="center" valign="top" width="100">
                            <asp:Image ID="Image2" runat="server" Height="90px" 
                                ImageUrl=' <%# Convert.ToString("~/DisplayPic.ashx?Emp_Id=") + Convert.ToString(Eval("EmpID")) %>' 
                                Width="77px" />
                        </td>
                        <td valign="top">
                            <ul class="empinfo">
                                <li class="name">
                                    <asp:Label ID="Label_EmpName" runat="server" 
                                        Text='<%# Eval("[Employee Name]") %>' ToolTip="Employee Name"></asp:Label>
                                </li>
                                <li>
                                    <asp:Label ID="Designation_NameLabel" runat="server" 
                                        Style="color: #c60c0c; font-weight: bold;" 
                                        Text='<%# Bind("Designation_Name") %>'></asp:Label>
                                    <asp:Label ID="Designation_NameLabel0" runat="server" 
                                        Text='<%# Convert.ToString("( ")+ Convert.ToString(Eval("SubDept_Name"))+Convert.ToString(" )") %>'></asp:Label>
                                </li>
                                <li class="div">
                                    <asp:Label ID="Designation_NameLabel1" runat="server" 
                                        Text='<%# Eval("Dept_Name") %>'></asp:Label>
                                </li>
                                <li>Emp # <strong>
                                    <asp:Label ID="RegistrationNo" runat="server" Text='<%# Eval("EmpID") %>' 
                                        ToolTip="Patient Registration Number"></asp:Label>
                                    </strong><span class="spl">|</span> Join Date : <strong>
                                    <asp:Label ID="Label_JoinDate" runat="server" Text='<%# Bind("JoinDate") %>' 
                                        ToolTip="Patient Age"></asp:Label>
                                    </strong><span class="spl">|</span> CNIC : <strong>
                                    <asp:Label ID="Label_CNIC" runat="server" Text='<%# Eval("CNIC") %>' 
                                        ToolTip="Identity Card #"></asp:Label>
                                    </strong><span class="spl">|</span> <strong>
                                    <asp:Label ID="LabelGender" runat="server" Text='<%# Eval("Gender") %>' 
                                        ToolTip="Patient Gender"></asp:Label>
                                    </strong></li>
                            </ul>
                        </td>
                    </tr>
                </table>
            </div>
        </ItemTemplate>
    </asp:FormView>
    <h1 style="color:  Maroon; font-size:medium" >&nbsp;</h1></div>
<br />
<div class="bxmain">
    <table class="ui-accordion">
        <tr>
            <td class="style1">
                Current Designation :</td>
            <td>
                <asp:DropDownList ID="ddlistCurr_Desig" runat="server" 
                    DataSourceID="SqlDataSource_Curr_Desig" DataTextField="Designation_Name" 
                    DataValueField="Designation_ID" Enabled="true">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Promotion/Demotion :</td>
            <td>
                <asp:RadioButtonList ID="RBL_Promotion_Status" runat="server" AutoPostBack="True" 
                    RepeatDirection="Horizontal" 
                    >
                    <asp:ListItem Selected="True" Value="1">Promotion</asp:ListItem>
                    <asp:ListItem Value="2">Demotion</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Promotion/Demotion Date:</td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server" 
                            CssClass="drop_date" Width="200px">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                        <asp:HiddenField ID="HiddenField_start_Date" runat="server" /></td>
        </tr>
        <tr>
            <td class="style1">
                New Designation :</td>
            <td>
                <asp:DropDownList ID="ddlNew_Desig" runat="server" 
                    DataSourceID="SqlDataSource_Pro_Desig" DataTextField="Designation_Name" 
                    DataValueField="Designation_ID">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Ordered By :</td>
            <td>
                <asp:DropDownList ID="ddlPromote_by" runat="server" 
                    DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="EmpID">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Promotion/Demotion Discription:</td>
            <td>
                <asp:TextBox ID="tbxPromotion_reason" runat="server" Height="100px" 
                    TextMode="MultiLine" Width="300px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" BorderColor="#FF6600" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style1">
                </td>
            <td>
                <asp:TextBox ID="tbxremarks" runat="server" Height="50px" TextMode="MultiLine" 
                    Width="300px" Visible="false"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">
                </td>
            <td>
                <asp:Button ID="btnsave" runat="server" Text="Save" onclick="btnsave_Click" />
                <asp:Label ID="Label2" runat="server" BorderColor="Red"></asp:Label>
                <asp:SqlDataSource ID="SqlDataSource_Curr_Desig" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                    
                    SelectCommand="SELECT Designation.Designation_ID, Designation.Designation_Name FROM Designation INNER JOIN Employee ON Designation.Designation_ID = Employee.DesignationID WHERE (Employee.EmpID = @EmpID) ORDER BY Designation.Designation_Name">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="EmpID" QueryStringField="empid" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_Pro_Desig" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" SelectCommand="select Designation_ID,Designation_Name from Designation
order by Designation_Name"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:HRConnectionString %>" 
                    InsertCommand="usp_Promotion" InsertCommandType="StoredProcedure" 
                    
                    
                    
                    
                    
                    
                    SelectCommand="SELECT Employee.Name AS Employee_Name, Employee.Relation, Employee.RFName AS Rel_Name, Promotion.Perv_Desig, Promotion.Promotion, Promotion.New_Desig, Promotion.Promotion_Date, Promotion.Promote_By, Promotion.Promotion_Reason, Promotion.Remarks, Department.Dept_Name, SubDepartment.SubDept_Name, Designation.Designation_Name, Promotion.Emp_ID, Employee.EmpID FROM Employee LEFT OUTER JOIN Promotion ON Employee.EmpID = Promotion.Emp_ID LEFT OUTER JOIN Department ON Employee.DeptID = Department.Dept_ID LEFT OUTER JOIN SubDepartment ON Employee.SubDeptId = SubDepartment.SubDept_Id LEFT OUTER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID WHERE (Employee.EmpID = 1)">
                    <InsertParameters>
                        <asp:QueryStringParameter Name="EmpID" QueryStringField="empid" Type="Int32" />
                        <asp:ControlParameter Name="Curr_Desig" Type="Int32" 
                            ControlID="ddlistCurr_Desig" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="RBL_Promotion_Status" Name="Prom_Status" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlNew_Desig" Name="New_Desig" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlPromote_by" Name="Promote_By" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="tbxPromotion_reason" Name="Promote_Reason" 
                            PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="tbxremarks" Name="Remarks" PropertyName="Text" 
                            Type="String" />
                        <asp:SessionParameter Name="Entry_By" SessionField="emp_id" Type="Int32" />
                        <asp:ControlParameter ControlID="HiddenField_start_Date" Name="Permote_Date" 
                            PropertyName="Value" Type="DateTime" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:QueryStringParameter Name="empid" QueryStringField="empid" />
                    </SelectParameters>
                </asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsEmployeeInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="EmpID" QueryStringField="empid" />
        </SelectParameters>
    </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                    
                    SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') + '( ' + Designation.Designation_Name + ' )' AS Name FROM Employee INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table><br />
 </div>
    <br/>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  
                    DataKeyNames="EmpID" DataSourceID="SqlDataSource2" 
        Width="100%" EmptyDataText="No Record Found">
                    <Columns>
                  

                    </Columns>
                </asp:GridView>
                
</asp:Content>

