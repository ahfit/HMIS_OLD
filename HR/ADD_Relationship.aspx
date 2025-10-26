<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ADD_Relationship.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Medical_Reimbursement_ADD_Relationship" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
        <tr>
            <td align="left" style="float: left; width: 48%;">
                <div class="bxmain inner_content" style="width: 98%;height: 250px;">
                    <h2><span>Employee Information</span></h2>
                    <asp:DataList ID="dlEMployee" runat="server" DataSourceID="dsEmployeeInfo">
                        <ItemTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                                <tr>
                                    <td align="left" valign="middle" style="width: 40%;">
                                        <asp:Image ID="imgEmployee" runat="server" ImageUrl=' <%# Bind("imgURL") %>' Width="130px" Height="130px" />
                                    </td>
                                    <td align="center" valign="top" style="width: 60%;">
                                        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%" style="text-align:center;">
                                            <tr>
                                                <td width="100%">Employee :
                                                    <asp:Label ID="lblEmployeeName" runat="server" Text='<%# Bind("EmployeeName") %>'></asp:Label>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td width="100%">Designation :
                                                    <asp:Label ID="lblDesignation" runat="server" Text='<%# Bind("Designation_Name") %>'></asp:Label>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td width="100%">Department :
                                                    <asp:Label ID="lblDepartment" runat="server" Text='<%# Bind("SubDept_Name") %>'></asp:Label>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td width="100%">Emp # :
                                                    <asp:Label ID="lblEmployeeNo" runat="server" Text='<%# Bind("EmpNo") %>'></asp:Label>
                                                </td>

                                            </tr>
                                            <tr>
                                                <td width="100%">Join Date :
                                                    <asp:Label ID="lblJoinDate" runat="server" Text='<%# Bind("JoinDate") %>'></asp:Label>
                                                </td>

                                            </tr>
                                        </table>
                                    </td>

                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="dsEmployeeInfo" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="Emp_BioData" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <%--<asp:ControlParameter ControlID="HiddenField_Emp_ID" DefaultValue="0" 
                    Name="EmpID" PropertyName="Value" />--%>
                            <asp:QueryStringParameter Name="EmpID" DefaultValue="0" QueryStringField="Emp_Id" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </td>
            <td align="right" style="float: right; width: 48%;">
                <div class="bxmain inner_content" style="width: 97%; text-align: left;">
                    <h2><span>Dependent Information</span></h2>
                    <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                        <tr>
                            <td align="right" width="40%">Relation with Employeee : </td>
                            <td align="left" width="60%">
                                <asp:RadioButtonList ID="RadioButtonList_Relation_with_patient" runat="server" RepeatDirection="Horizontal" CssClass="text_titles_01" TabIndex="7">
                                    <asp:ListItem Value="Son">Son</asp:ListItem>
                                    <asp:ListItem Value="Daughter">Daughter</asp:ListItem>
                                    <asp:ListItem Value="Mother">Mother</asp:ListItem>
                                    <asp:ListItem Value="Father">Father</asp:ListItem>
                                    <asp:ListItem Value="Wife">Wife</asp:ListItem>
                                    <asp:ListItem>Other</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Title : </td>
                            <td align="left" width="60%">
                                <asp:RadioButtonList ID="RadioButtonListPrefix" runat="server" RepeatLayout="Flow"
                                    RepeatDirection="Horizontal">
                                    <asp:ListItem Selected="True">Mr.</asp:ListItem>
                                    <asp:ListItem>Miss</asp:ListItem>
                                    <asp:ListItem>Mrs.</asp:ListItem>
                                    <asp:ListItem>Dr.</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">First Name :</td>
                            <td align="left" width="60%">
                                <asp:TextBox CssClass="d-active" ID="TextBoxFName" runat="server" Width="173px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Middle Name :</td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="TextBoxMName" runat="server" CssClass="d-active" Width="173px" TabIndex="1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Last Name : </td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="TextBoxLName" runat="server" CssClass="d-active" Width="173px" TabIndex="2"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Age : </td>
                            <td align="left" width="60%">
                                <asp:TextBox ID="textboxage" runat="server" AccessKey="a" CssClass="d-active_small"
                                    onactivate="this.className='active_small';" ondeactivate="this.className='d-active_small';"
                                    TabIndex="6" Width="92px"></asp:TextBox>
                                <asp:DropDownList ID="DropDownListBIndicator"
                                    runat="server" AccessKey="y" CssClass="text_titles_01" TabIndex="13" Width="65px">
                                    <asp:ListItem Selected="True">Years</asp:ListItem>
                                    <asp:ListItem>Months</asp:ListItem>
                                    <asp:ListItem>Days</asp:ListItem>
                                    <asp:ListItem>Hours</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="40%">Gender : </td>
                            <td align="left" width="60%">
                                <asp:DropDownList ID="Dropdownlistsex" runat="server" CssClass="text_titles_01" DataSourceID="SqlDataSourceGender"
                                    DataTextField="Gender" DataValueField="Gender_ID" Width="100px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:Button CssClass="bt1up" ID="Button_save" runat="server" Text="Save" />
                                <asp:Button ID="Button_Update" runat="server" Text="Update" Visible="False" />
                                <asp:Button ID="ButtonCancel" runat="server" Text="Cancel" Visible="False" />
                                <asp:HiddenField ID="HiddenField_SelectedID" runat="server" />
                                <asp:HiddenField ID="HiddenField_Emp_Id" runat="server" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>

    <br />
    <div style="margin-top: 230px; width: 100%">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Medical_Reimbursement_ID"
            DataSourceID="SqlDataSourceSaveInfo" CssClass="Grid_1" Width="100%">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate><%#Container.DataItemIndex + 1%></ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Family Member Name" HeaderText="Family Member Name" SortExpression="Family Member Name" />
                <asp:BoundField DataField="Relationship_with_Patient" HeaderText="Relationship with Employee"
                    SortExpression="Relationship_with_Patient" />
                <asp:BoundField DataField="Age" HeaderText="Age" SortExpression="Age" />
                <asp:CommandField ShowDeleteButton="True" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select"
                            OnClick="LinkButton1_Click">Edit</asp:LinkButton>
                        <asp:HiddenField ID="HiddenField_id" runat="server"
                            Value='<%# Eval("Medical_Reimbursement_ID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField DataNavigateUrlFields="Medical_Reimbursement_ID" DataNavigateUrlFormatString="add_bill.aspx?Medical_Reimbursement_ID={0}"
                    Text="Attach Bill" Visible="False" />
            </Columns>
            <SelectedRowStyle BackColor="Cyan" />
            <HeaderStyle CssClass="GridHeader" />
            <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            DeleteCommand="DELETE FROM [Medical_Reimbursement_master] WHERE [Medical_Reimbursement_ID] = @Medical_Reimbursement_ID"
            InsertCommand="Insert_Employee_Family_Information"
            SelectCommand="SELECT Medical_Reimbursement_master.Medical_Reimbursement_ID, Medical_Reimbursement_master.emp_ID, Medical_Reimbursement_master.Relationship_with_Patient, Medical_Reimbursement_master.Age + ' ' + ISNULL(Medical_Reimbursement_master.AgeType, '') AS Age, ISNULL(Medical_Reimbursement_master.FName, '') + ' ' + ISNULL(Medical_Reimbursement_master.MName, '') + ' ' + ISNULL(Medical_Reimbursement_master.LName, '') + ' ' + ISNULL(Medical_Reimbursement_master.Relation, '') + ' ' + ISNULL(Medical_Reimbursement_master.RFName, '') + ' ' + ISNULL(Medical_Reimbursement_master.RMame, '') + ' ' + ISNULL(Medical_Reimbursement_master.RLName, '') AS [Family Member Name], Gender.Gender, Medical_Reimbursement_master.Prefix, Medical_Reimbursement_master.FName, Medical_Reimbursement_master.MName, Medical_Reimbursement_master.LName, Medical_Reimbursement_master.Relation, Medical_Reimbursement_master.RFName, Medical_Reimbursement_master.RMame, Medical_Reimbursement_master.RLName, Medical_Reimbursement_master.Age AS Expr1, Medical_Reimbursement_master.AgeType, Medical_Reimbursement_master.Gender AS Expr2 FROM Medical_Reimbursement_master INNER JOIN Employee ON Medical_Reimbursement_master.emp_ID = Employee.EmpID INNER JOIN Gender ON Medical_Reimbursement_master.Gender = Gender.Gender_ID WHERE (Medical_Reimbursement_master.emp_ID = @emp_ID)"
            InsertCommandType="StoredProcedure"
            ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
            UpdateCommand="UPDATE Medical_Reimbursement_master SET emp_ID = @emp_ID, Prefix = @Prefix, FName = @FName, MName = @MName, LName = @LName, Relation = @Relation, RFName = @RFName, RMame = @RMame, RLName = @RLName, Relationship_with_Patient = @Relationship_with_Patient, Age = @Age, AgeType = @AgeType, DOB = @DOB, Gender = @Gender WHERE (Medical_Reimbursement_ID = @Medical_Reimbursement_ID)">
            <DeleteParameters>
                <asp:Parameter Name="Medical_Reimbursement_ID" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:ControlParameter ControlID="HiddenField_Emp_Id" Name="emp_ID"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="RadioButtonListPrefix" Name="Prefix"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBoxFName" Name="FName"
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBoxMName" Name="MName"
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBoxLName" Name="LName"
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="RadioButtonListRelation" Name="Relation"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBoxRFName" Name="RFName"
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBoxRMName" Name="RMame"
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBoxRLName" Name="RLName"
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="RadioButtonList_Relation_with_patient"
                    Name="Relationship_with_Patient" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="textboxage" Name="Age" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownListBIndicator" Name="AgeType"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="HiddenField_DOB" Name="DOB"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="Dropdownlistsex" Name="Gender"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="HiddenField_SelectedID"
                    Name="Medical_Reimbursement_ID" PropertyName="Value" />
            </UpdateParameters>
            <InsertParameters>
                <asp:QueryStringParameter Name="emp_ID" QueryStringField="Emp_Id"
                    Type="Int32" />
                <asp:ControlParameter ControlID="RadioButtonList_Relation_with_patient" Name="Relationship_with_Patient"
                    PropertyName="SelectedValue" Type="String" />
                <asp:ControlParameter ControlID="textboxage" Name="Age" PropertyName="Text" />
                <asp:ControlParameter ControlID="HiddenField_DOB" Name="DOB" PropertyName="Value" />
                <asp:ControlParameter ControlID="RadioButtonListPrefix" Name="Prefix" PropertyName="SelectedValue"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBoxFName" Name="FName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBoxMName" Name="MName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="TextBoxLName" Name="LName" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="RadioButtonListRelation" Name="Relation" PropertyName="SelectedValue"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBoxRFName" Name="RFName" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBoxRMName" Name="RMame" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="TextBoxRLName" Name="RLName" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="Dropdownlistsex" Name="Gender" PropertyName="SelectedValue"
                    Type="String" />
                <asp:ControlParameter ControlID="DropDownListBIndicator" Name="AgeType" PropertyName="SelectedValue"
                    Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="0" Name="emp_ID"
                    QueryStringField="Emp_Id" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <asp:HiddenField ID="HiddenField_age" runat="server" />
    <asp:HiddenField ID="HiddenField_DOB" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceGender" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Gender_ID, Gender FROM Gender"></asp:SqlDataSource>

    <asp:LinkButton ID="LinkButtonTrack" runat="server" CssClass="login_link2" Visible="False">Track Request</asp:LinkButton><br />
    <br />

    <div class="bxmain" style="width: 100%; display: none;">
        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
            <tr>

                <td align="right" width="15%" style="display: none;">Relation :</td>
                <td width="35%" style="display: none;">
                    <asp:RadioButtonList ID="RadioButtonListRelation" runat="server" RepeatLayout="Flow"
                        RepeatDirection="Horizontal"
                        TabIndex="9">
                        <asp:ListItem>S/O</asp:ListItem>
                        <asp:ListItem>D/O</asp:ListItem>
                        <asp:ListItem>W/O</asp:ListItem>
                        <asp:ListItem>Mother Name</asp:ListItem>
                    </asp:RadioButtonList></td>
            </tr>
            <tr>

                <td align="right" class="text_titles_bold" style="display: none;">First Name :</td>
                <td style="display: none;">
                    <asp:TextBox ID="TextBoxRFName" runat="server" CssClass="d-active" TabIndex="3"></asp:TextBox>
                </td>
            </tr>
            <tr>

                <td align="right" style="display: none;">Middle Name :</td>
                <td style="display: none;">
                    <asp:TextBox ID="TextBoxRMName" runat="server" CssClass="d-active" TabIndex="4"></asp:TextBox></td>
            </tr>
            <tr>

                <td align="right" style="display: none;">Last Name :</td>
                <td style="display: none;">
                    <asp:TextBox ID="TextBoxRLName" runat="server" CssClass="d-active" TabIndex="5"></asp:TextBox></td>
            </tr>

        </table>
    </div>


</asp:Content>
