<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Blood_Bank_Issue_Chits_Display2xx2, App_Web_k10uyj0r" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
            <%--<div class="bxmain inner_content" style="width:100%">
            <h2><span style="font-size: 20px !important">Blood Product Formation</span></h2>
                </div>--%>

        <table cellpadding="0" cellspacing="0" border="0" width="100%"  >
            <tr>
                <td width="50%" valign="top">
                    <asp:SqlDataSource ID="SqlDataSource_Display" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                        InsertCommand="Issue_Sub" InsertCommandType="StoredProcedure" SelectCommand="SELECT Issue_Chit.Issue_Chit_Id, Issue_Chit.Date_Time, Issue_Chit.Reg_No, Issue_Chit.Is_Issued, Issue_Chit.YearlyNo, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS RequestedBy, Department.Dept_Name, Designation_View.Designation_Name FROM Issue_Chit INNER JOIN Employee ON Issue_Chit.Emp_Id = Employee.EmpID INNER JOIN Department ON Employee.DeptID = Department.Dept_ID INNER JOIN Designation_View ON Employee.DesignationID = Designation_View.Designation_ID WHERE (Issue_Chit.Is_Issued = 0)"
                        UpdateCommand="UPDATE Issue_Chit SET Is_Issued = 1 WHERE (Issue_Chit_Id = @Issue_Chit_Id)">
                        <UpdateParameters>
                            <asp:ControlParameter Name="Issue_Chit_Id" ControlID="HiddenField_Issue_Id" PropertyName="Value" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:ControlParameter ControlID="Product_Formation_Id" Name="Product_Formation_Id"
                                PropertyName="Value" Type="Int32" />
                            <asp:ControlParameter ControlID="Issue_Chit_Id" Name="Issue_Chit_Id" PropertyName="Value"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="Issue_Chit_Sub_Id" Name="Issue_Chit_Sub_Id" PropertyName="Value"
                                Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="Emp_Id" Type="Int32" />
                            <asp:ControlParameter ControlID="HiddenField_RegNo" Name="RegNo" PropertyName="Value"
                                Type="String" />
                            <asp:ControlParameter ControlID="HiddenField_YearlyNo" Name="YearlyNo" PropertyName="Value"
                                Type="Decimal" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView_Display" runat="server" AutoGenerateColumns="False" DataKeyNames="Issue_Chit_Id" Width="98%"
                        DataSourceID="SqlDataSource_Display" OnPreRender="GridView_Display_PreRender">
                        <Columns>
                            <asp:BoundField DataField="Reg_No" HeaderText="Patient Reg No" SortExpression="Reg_No" />
                            <asp:TemplateField HeaderText="Issue Chit Date" SortExpression="Date_Time">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Date_Time") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Date_Time") %>'></asp:Label>
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Reg_No") %>' />
                                    <asp:HiddenField ID="HiddenField2" runat="server" Value='<%# Eval("YearlyNo") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="RequestedBy" HeaderText="Requested By" SortExpression="RequestedBy" />
                            <asp:BoundField DataField="Designation_Name" HeaderText="Designation" SortExpression="Designation_Name" />
                            <asp:BoundField DataField="Dept_Name" HeaderText="Department" SortExpression="Dept_Name" />
                            <asp:CheckBoxField DataField="Is_Issued" HeaderText="Issued" SortExpression="Is_Issued" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton_Detail" runat="server" OnClick="LinkButton_Detail_Click">Details</asp:LinkButton><br />
                                    <asp:HiddenField ID="HiddenField_IssueChitId" runat="server" Value='<%# Eval("Issue_Chit_Id") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
                <td  width="50%" valign="top">
                    <asp:SqlDataSource ID="SqlDataSource_Details" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                        SelectCommand="SELECT Issue_Chit_Sub.Product_Formation_Id, Issue_Chit_Sub.Issue_Chit_Id, Issue_Chit_Sub.Issue_Chit_Sub_Id, Blood_Component.Component_Name, Blood_Component.Acronym, Donor_Product_Formation.Product_Qty, Bag_Type.Bag_Name, Donor_Product_Formation.Product_Formation_Status, Donor_Product_Formation.Expiry_DateTime, Donor_Product_Formation.Bag_No, Donor_Product_Formation.Is_Issued, Donor_Product_Formation.Donor_Registration_No FROM Issue_Chit_Sub INNER JOIN Donor_Product_Formation ON Issue_Chit_Sub.Product_Formation_Id = Donor_Product_Formation.Product_Formation_Id INNER JOIN Blood_Component ON Donor_Product_Formation.Component_Id = Blood_Component.Component_id INNER JOIN Bag_Type ON Donor_Product_Formation.Bag_Type_Id = Bag_Type.Bag_Type_Id WHERE (Issue_Chit_Sub.Issue_Chit_Id = @Issue_Chit_Id)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_Issue_Id" Name="Issue_Chit_Id" PropertyName="Value"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    &nbsp;
                    <asp:HiddenField ID="HiddenField_Issue_Id" runat="server" />
                </td>
                
            </tr>
            <tr>
                <td valign="top" width="50%">
                    <asp:GridView ID="GridView_Details" runat="server" AutoGenerateColumns="False" DataKeyNames="Issue_Chit_Sub_Id" Width="100%"
                        DataSourceID="SqlDataSource_Details" OnPreRender="GridView_Details_PreRender">
                        <Columns>
                            <asp:BoundField DataField="Bag_No" HeaderText="Bag No" SortExpression="Bag_No" />
                            <asp:BoundField DataField="Component_Name" HeaderText="Component" SortExpression="Component_Name" />
                            <asp:BoundField DataField="Acronym" HeaderText="Acronym" SortExpression="Acronym" />
                            <asp:BoundField DataField="Product_Qty" HeaderText="Qty" SortExpression="Product_Qty" />
                            <asp:BoundField DataField="Bag_Name" HeaderText="Bag Type" SortExpression="Bag_Name" />
                            <asp:BoundField DataField="Product_Formation_Status" HeaderText="Status" SortExpression="Product_Formation_Status" />
                            <asp:BoundField DataField="Expiry_DateTime" HeaderText="Expiry" SortExpression="Expiry_DateTime" />
                            <asp:BoundField DataField="Donor_Registration_No" HeaderText="Donor Reg No" SortExpression="Donor_Registration_No" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged" />
                                    <asp:HiddenField ID="HiddenField_IssueSubID" runat="server" Value='<%# Eval("Issue_Chit_Sub_Id") %>' />
                                    <asp:HiddenField ID="HiddenField_IssueChitid" runat="server" Value='<%# Eval("Issue_Chit_Id") %>' />
                                    <asp:HiddenField ID="HiddenField_PF_Id" runat="server" Value='<%# Eval("Product_Formation_Id") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
                <td valign="top" width="50%">
                </td>
            </tr>
            </table>
                <br>

                <div align="center"> 
                    <asp:Button ID="Button_Issue" runat="server" OnClick="Button_Issue_Click" Text="Issue"
                        Visible="False" /></div>
                    <asp:HiddenField ID="HiddenField_Flag" runat="server" />
                    <asp:HiddenField ID="Issue_Chit_Sub_Id" runat="server" />
                    <asp:HiddenField ID="Product_Formation_Id" runat="server" />
                    <asp:HiddenField ID="Issue_Chit_Id" runat="server" />
                    <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
                    <asp:HiddenField ID="HiddenField_RegNo" runat="server" />
                 <br>
<br>

    
  </asp:Content>