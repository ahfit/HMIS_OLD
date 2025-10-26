<%@ page language="C#" masterpagefile="~/hacims_masterpage.master" autoeventwireup="true" inherits="Blood_Bank_Issue_Blood1, App_Web_k10uyj0r" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div style="width: 100%">
        <table style="width: 100%">
            <tr>
                <td width="50%">
                    <table>
                        <tr>
                            <td colspan="1">
                                <div class="bxmain inner_content" style="width: 100%">
                                    <h2><span>Blood Request</span></h2>

                                    <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        DataSourceID="SqlDataSource_blood_Group" Height="1px" OnPreRender="GridView2_PreRender"
                                        PageSize="1" Width="533px">
                                        <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                        <Columns>
                                            <asp:BoundField DataField="Sample No" HeaderText="Sample No" SortExpression="Sample No" />
                                            <asp:BoundField DataField="Group" HeaderText="Group Name" SortExpression="Group" />
                                            <asp:BoundField DataField="Rh Factor" HeaderText="Rh Factor" SortExpression="Rh Factor" />
                                            <asp:BoundField DataField="Bags Qty" HeaderText="Bags Qty" SortExpression="Bags Qty" />
                                        </Columns>
                                        <RowStyle CssClass="GridItem" Height="8px" />
                                        <HeaderStyle CssClass="GridHeader" />
                                    </asp:GridView>
                                </div>
                                <asp:SqlDataSource ID="SqlDataSource_blood_Group" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"
                                    SelectCommand="BloodBank_Select_BloodGroup" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="Blood_Request_Id"
                                            PropertyName="Value" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                &nbsp;
                <asp:SqlDataSource ID="SqlDataSource_ReservedBloodBags" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                    SelectCommand="SELECT  Donor_Product_Formation.Product_Formation_Id, Donor_Product_Formation.Donor_Registration_No, Donor_Product_Formation.Expiry_DateTime, Donor_Product_Formation.Bag_No, Donor_Product_Formation.Product_Formation_Id, Bag_Type.Bag_Name, Blood_Component.Component_Name, Blood_Component.Acronym, Donor_Product_Formation.Is_Issued, Donor_Product_Formation.Request_ID FROM Donor_Product_Formation INNER JOIN Blood_Component ON Donor_Product_Formation.Component_Id = Blood_Component.Component_id INNER JOIN Bag_Type ON Donor_Product_Formation.Bag_Type_Id = Bag_Type.Bag_Type_Id WHERE (Donor_Product_Formation.Request_ID = @Reserved_For_Request) and (Donor_Product_Formation.Product_Formation_Status ='Reserved')"
                    UpdateCommand="UPDATE Donor_Product_Formation SET Request_ID = '', Product_Formation_Status = 'Bank' WHERE (Product_Formation_Id = @Product_Formation_Id)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="Reserved_For_Request"
                            PropertyName="Value" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="HiddenField_PFID" Name="Product_Formation_Id" PropertyName="Value" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenField_PFID" runat="server" Value='<%# Eval("Product_Formation_Id") %>' />
                                &nbsp;&nbsp;
                <asp:SqlDataSource ID="SqlDataSource_Component" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"
                    SelectCommand="BloodBank_Select_Components_marked" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="Blood_Request_Id"
                            PropertyName="Value" />
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                                &nbsp;
                <asp:HiddenField ID="HiddenField_PFI" runat="server" />
                                <asp:SqlDataSource ID="SqlDataSource_Reserve" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                                    InsertCommand="BloodBank_insert_BagReservation" InsertCommandType="StoredProcedure"
                                    SelectCommand="SELECT * FROM [Donor_Product_Formation]" UpdateCommand="UPDATE Donor_Product_Formation SET Product_Formation_Status = 'Reserved', Request_ID = @Reserved_For_Request WHERE (Product_Formation_Id = @Product_Formation_Id)">
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="Reserved_For_Request"
                                            PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenField_PFI" Name="Product_Formation_Id" PropertyName="Value" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="HiddenField_PFI" Name="Product_Formation_Id" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="Request_Id"
                                            PropertyName="Value" />
                                        <asp:SessionParameter DefaultValue="" Name="Emp_Id" SessionField="Emp_Id" />
                                        <asp:ControlParameter ControlID="HiddenField_WhenNeeded" Name="When_Needed" PropertyName="Value" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                &nbsp;
                <asp:SqlDataSource ID="SqlDataSource_ReservedBloodBags1" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                    SelectCommand="SELECT Donor_Product_Formation.Donor_Registration_No, Donor_Product_Formation.Expiry_DateTime, Donor_Product_Formation.Bag_No, Donor_Product_Formation.Product_Formation_Id, Bag_Type.Bag_Name, Blood_Component.Component_Name, Blood_Component.Acronym, Donor_Product_Formation.Is_Issued, Donor_Product_Formation.Request_ID FROM Donor_Product_Formation INNER JOIN Blood_Component ON Donor_Product_Formation.Component_Id = Blood_Component.Component_id INNER JOIN Bag_Type ON Donor_Product_Formation.Bag_Type_Id = Bag_Type.Bag_Type_Id WHERE (Donor_Product_Formation.Request_ID = @Reserved_For_Request)"
                    UpdateCommand="usp_CancelBloodReservation" UpdateCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="Reserved_For_Request"
                            PropertyName="Value" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="HiddenField_PFID" Name="Product_Formation_Id" PropertyName="Value" />
                        <asp:SessionParameter Name="Cancelation_Emp_ID" SessionField="Emp_Id" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenField_WhenNeeded" runat="server" OnValueChanged="HiddenField_WhenNeeded_ValueChanged" />
                                &nbsp;&nbsp;
                <asp:SqlDataSource ID="SqlDataSource_Formed_Products" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                    InsertCommand="INSERT INTO Donor_Product_Formation(Donation_Id, Component_Id, Product_Qty, Product_Formation_Status, Formation_DateTime, Expiry_DateTime, Bag_Id, Request_ID) VALUES (@Donation_Id, @Component_Id, @Product_Qty, @Product_Formation_Status, @Formation_DateTime, @Expiry_DateTime, @Bag_Id, @Request_ID)"
                    OnSelecting="SqlDataSource_Formed_Products_Selecting" SelectCommand="SELECT Donor_Product_Formation.Bag_No, Donor_Blood_Group_Marked.Group_Name, Donor_Blood_Group_Marked.Rh_Factor, Donor_Product_Formation.Component_Id, Donor_Product_Formation.Formation_DateTime, Donor_Product_Formation.Expiry_DateTime, Blood_Component.Component_Name, Donor_Product_Formation.Product_Formation_Status, Donor_Product_Formation.Product_Formation_Id, Donor_Product_Formation.Donor_Visit_Id, Donor_Product_Formation.Donor_Registration_No, Donor_Product_Formation.Is_Issued, Donor_Product_Formation.Is_Disposed FROM Donor_Product_Formation INNER JOIN Blood_Component ON Donor_Product_Formation.Component_Id = Blood_Component.Component_id INNER JOIN Donor_Blood_Group_Marked ON Donor_Product_Formation.Donor_Registration_No = Donor_Blood_Group_Marked.Donor_Registration_No WHERE (Donor_Product_Formation.Component_Id = @Component_Id) AND (Donor_Blood_Group_Marked.Blood_Group_Id = @Group_Id) AND (Donor_Product_Formation.Is_Issued = 0) AND (Donor_Product_Formation.Is_Disposed = 0) AND (Donor_Product_Formation.Expiry_DateTime >= @Expiry_DateTime) AND (Donor_Product_Formation.Product_Formation_Status = 'Bank')">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenField_Donation_Id" Name="Donation_Id" PropertyName="Value" />
                        <asp:ControlParameter ControlID="DropDownList_Component" Name="Component_Id" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="TextBox_Product_Amount" Name="Product_Qty" PropertyName="Text" />
                        <asp:ControlParameter ControlID="DropDownList_status" Name="Product_Formation_Status"
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="HiddenField_start_date" Name="Formation_DateTime"
                            PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_end_date" Name="Expiry_DateTime" PropertyName="Value" />
                        <asp:ControlParameter ControlID="Label_Bag_No" Name="Bag_Id" PropertyName="Text" />
                        <asp:ControlParameter ControlID="HiddenField_Request_ID" Name="Request_ID" PropertyName="Value" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Lbl_Componet" Name="Component_Id" PropertyName="Text" />
                        <asp:ControlParameter ControlID="HiddenField_BloodGroupId" Name="Group_Id" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_WhenNeeded" Name="Expiry_DateTime" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
                                &nbsp; &nbsp;
                <asp:SqlDataSource ID="SqlDataSource_AfterProduct_Formation" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                    OnSelecting="SqlDataSource_AfterProduct_Formation_Selecting" SelectCommand="SELECT Donor_Product_Formation.Product_Formation_Id, Donor_Product_Formation.Donation_Id, Donor_Product_Formation.Product_Qty, Donor_Product_Formation.Formation_DateTime, CONVERT (DATETIME, Donor_Product_Formation.Expiry_DateTime, 103) AS Expiry_DateTime, Donor_Product_Formation.Bag_No, Blood_Component.Component_Name, Bag_Type.Bag_Name FROM Donor_Product_Formation INNER JOIN Blood_Component ON Donor_Product_Formation.Component_Id = Blood_Component.Component_id INNER JOIN Bag_Type ON Donor_Product_Formation.Bag_Type_Id = Bag_Type.Bag_Type_Id"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1">
                                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                    DataSourceID="SqlDataSource_Question" Height="1px" OnPreRender="GridView2_PreRender"
                                    OnSelectedIndexChanged="GridView2_SelectedIndexChanged" PageSize="15" Width="100%">
                                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                    <Columns>
                                        <asp:BoundField DataField="Question_Text" HeaderText="Question" SortExpression="Question_Text">
                                            <ItemStyle CssClass="text_boxtitle" HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Question_Option_1" HeaderText="Question_Option_1" SortExpression="Question_Option_1"
                                            Visible="False" />
                                        <asp:BoundField DataField="Question_Option_2" HeaderText="Question_Option_2" SortExpression="Question_Option_2"
                                            Visible="False" />
                                        <asp:CheckBoxField DataField="Question_Ans" HeaderText="Question_Ans" SortExpression="Question_Ans"
                                            Visible="False" />
                                        <asp:TemplateField HeaderText="Answer">
                                            <ItemStyle HorizontalAlign="Left" />
                                            <ItemTemplate>
                                                <asp:RadioButton ID="RadioButton_yes" runat="server" Enabled="False" />
                                                <asp:Label ID="Label_yes" runat="server" CssClass="text_boxtitle" Text='<%# Eval("Question_Option_1", "{0}") %>'></asp:Label>
                                                <asp:RadioButton ID="RadioButton_No" runat="server" Enabled="False" />
                                                &nbsp;
                                <asp:Label ID="Label_no" runat="server" CssClass="text_boxtitle" Text='<%# Eval("Question_Option_2", "{0}") %>'></asp:Label>
                                                <asp:HiddenField ID="HiddenField_yes" runat="server" Value='<%# Eval("Question_Ans", "{0}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle CssClass="GridItem" Height="8px" />
                                    <HeaderStyle CssClass="GridHeader" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="bxmain inner_content" style="width: 100%">
                                    <h2><span>Blood Request Detail</span></h2>

                                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        DataSourceID="SqlDataSource_Component" Height="1px" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                                        PageSize="15" Width="375px">
                                        <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                        <Columns>
                                            <asp:BoundField DataField="Component_Name" HeaderText="Component_Name" SortExpression="Component_Name" />
                                            <asp:BoundField DataField="Required_Qty" HeaderText="Required_Qty" ReadOnly="True"
                                                SortExpression="Required_Qty" />
                                            <asp:TemplateField HeaderText="Same_Blood_Group" SortExpression="Same_Blood_Group">
                                                <EditItemTemplate>
                                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Same_Blood_Group") %>' />
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <br />
                                                    <asp:LinkButton ID="LinkButton_ClickHere" runat="server" OnClick="LinkButton_ClickHere_Click">Select</asp:LinkButton>
                                                    <asp:HiddenField ID="HiddenField_BloodGroup" runat="server" Value='<%# Eval("Group_Name") %>' />
                                                    <asp:HiddenField ID="HiddenField_Componet_Id" runat="server" Value='<%# Eval("Component_id") %>' />
                                                    <asp:HiddenField ID="HiddenField_Rh_Factor" runat="server" Value='<%# Eval("Rh_Factor") %>' />
                                                    <asp:HiddenField ID="HiddenField_BGID" runat="server" Value='<%# Eval("Blood_Group_Id") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Group_Name" HeaderText="Group_Name" SortExpression="Group_Name" />
                                            <asp:BoundField DataField="Rh_Factor" HeaderText="Rh_Factor" SortExpression="Rh_Factor" />
                                            <asp:BoundField DataField="Blood_Group_Id" HeaderText="Blood_Group_Id" SortExpression="Blood_Group_Id" />
                                        </Columns>
                                        <RowStyle CssClass="GridItem" Height="8px" />
                                        <HeaderStyle CssClass="GridHeader" />
                                    </asp:GridView>
                                    &nbsp;
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td style="width: 16px"></td>
                                        <td style="width: 16px">
                                            <asp:Label ID="Label_Blood_Group" runat="server"></asp:Label></td>
                                        <td style="width: 18px">
                                            <asp:Label ID="Lbl_Rh_Factor" runat="server"></asp:Label></td>
                                        <td style="width: 46px">
                                            <asp:Label ID="Lbl_Componet" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 16px"></td>
                                        <td style="width: 16px">
                                            <asp:DropDownList ID="DropDownList_Compatibility" runat="server" AutoPostBack="True"
                                                DataSourceID="SqlDataSource_Compatibility" DataTextField="Compatible_Blood_Group"
                                                DataValueField="Blood_Group_Id" OnSelectedIndexChanged="DropDownList_Compatibility_SelectedIndexChanged">
                                            </asp:DropDownList></td>
                                        <td style="width: 18px">
                                            <igsch:WebDateChooser ID="WebDateChooser1" runat="server"></igsch:WebDateChooser>
                                        </td>
                                        <td style="width: 46px">
                                            <asp:CheckBox ID="CheckBox2" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="CheckBox2_CheckedChanged" /></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 16px"></td>
                                        <td style="width: 16px"></td>
                                        <td style="width: 18px">
                                            <asp:Label ID="Lbl_BloodGroup" runat="server"></asp:Label></td>
                                        <td style="width: 46px"></td>
                                    </tr>
                                </table>
                                <asp:Button ID="Button3" runat="server" OnClick="Button3_Click1" Text="ISSUE Bags" Visible="False" />
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;&nbsp;
                <table>
                    <tr>
                        <td colspan="3">
                            <div class="bxmain inner_content" style="width: 100%">
                                <h2><span style="background-color: greenyellow">Available Blood Bags</span></h2>
                                <asp:GridView ID="GridView_Formed_Products" runat="server" AutoGenerateColumns="False"
                                    DataSourceID="SqlDataSource_Formed_Products" OnSelectedIndexChanged="GridView_Formed_Products_SelectedIndexChanged">
                                    <Columns>
                                        <asp:BoundField DataField="Bag_No" HeaderText="Bag Number" SortExpression="Bag_No" />
                                        <asp:BoundField DataField="Product_Formation_Status" HeaderText="Product_Formation_Status"
                                            SortExpression="Product_Formation_Status" />
                                        <asp:BoundField DataField="Formation_DateTime" HeaderText="Formation_DateTime" SortExpression="Formation_DateTime" />
                                        <asp:BoundField DataField="Expiry_DateTime" HeaderText="Expiry_DateTime" SortExpression="Expiry_DateTime" />
                                        <asp:BoundField DataField="Component_Name" HeaderText="Component_Name" SortExpression="Component_Name" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" runat="server" />
                                                <asp:HiddenField ID="HiddenField_Product_id" runat="server" Value='<%# Eval("Product_Formation_Id") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <br />
                                <asp:Button ID="Button_Reserve" Visible="false" runat="server" OnClick="Button_Reserve_Click" Text="Reserve" />
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="3">
                            <div class="bxmain inner_content" style="width: 100%">
                                <h2><span style="background-color: greenyellow">Reserved Blood Bags</span></h2>
                                <asp:GridView ID="GridView_ReservedBloodBags" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="Product_Formation_Id" DataSourceID="SqlDataSource_ReservedBloodBags">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Bag No">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBagNo" Text='<%# Bind("Bag_No") %>' ToolTip='<%#Bind("Product_Formation_Id") %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Component_Name" HeaderText="Component" SortExpression="Component_Name" />
                                        <asp:BoundField DataField="Bag_Name" HeaderText="Bag Type" SortExpression="Bag_Name" />
                                        <asp:BoundField DataField="Expiry_DateTime" HeaderText="Expiry Date Time" SortExpression="Expiry_DateTime" />
                                        <asp:BoundField DataField="Acronym" HeaderText="Acronym" SortExpression="Acronym" />
                                        <asp:BoundField DataField="Donor_Registration_No" HeaderText="Donor Reg No" SortExpression="Donor_Registration_No" />
                                        <asp:BoundField DataField="Is_Issued" HeaderText="Is Issued" SortExpression="Is_Issued" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton_Cancel" runat="server" OnClick="LinkButton_Cancel_Click">Cancel</asp:LinkButton>
                                                <asp:HiddenField ID="HiddenField_PF_ID" runat="server" Value='<%# Eval("Product_Formation_Id") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkBoxIssue" runat="server"></asp:CheckBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <br />
                                <asp:Button Text="Issue" ID="btnIssue" OnClick="btnIssue_Click" Visible="false" runat="server" />
                            </div>
                        </td>
                    </tr>
                </table>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:SqlDataSource ID="SqlDataSource_Compatibility" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                                    OnSelecting="SqlDataSource_Compatibility_Selecting" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"
                                    SelectCommand="Select_Compatible_Products" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Componet_Id" Name="Component" PropertyName="Value"
                                            Type="Int32" />
                                        <asp:ControlParameter ControlID="HiddenField_BloodGroupId" Name="Blood_Group_Id"
                                            PropertyName="Value" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_forward" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                                    InsertCommand="pt_InnerDepartment_PatientForward" InsertCommandType="StoredProcedure"
                                    ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                                    <InsertParameters>
                                        <asp:Parameter DefaultValue="2" Name="ToSubDept" Type="Int32" />
                                        <asp:Parameter DefaultValue="17" Name="SendingDept" Type="Int32" />
                                        <asp:Parameter DefaultValue="11" Name="iRequestTypeTo" Type="Int32" />
                                        <asp:Parameter DefaultValue="0" Name="iRequestTypeBy" Type="Int32" />
                                        <asp:ControlParameter ControlID="HiddenField_Registration_No" Name="RegNo" PropertyName="Value"
                                            Type="String" />
                                        <asp:SessionParameter DefaultValue="" Name="EmpID" SessionField="emp_id" Type="Int32" />
                                        <asp:ControlParameter ControlID="HiddenField_Yearly_No" DefaultValue="" Name="PayID"
                                            PropertyName="Value" Type="Decimal" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="Label1" runat="server" Enabled="False" Text="Already Assigned Or Find +ve Or Invalid #"
                                    Visible="False"></asp:Label>
                                <asp:Button ID="Button1" runat="server" CssClass="bt2up" OnClick="Button1_Click"
                                    onmousedown="this.className='bt2down'" onmouseout="this.className='bt2up'" onmouseover="this.className='bt2over'"
                                    Text="Assign Bag" Visible="false" />
                                <asp:TextBox ID="TextBox_bag_No" runat="server" Visible="false" Width="75px"></asp:TextBox>
                                <asp:HiddenField ID="HiddenField_BloodGroupId" runat="server" />
                                <asp:SqlDataSource ID="SqlDataSource_bags_detail" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                                    SelectCommand="SELECT Donor_Detail.Prefix + ' ' + Donor_Detail.First_Name + ' ' + ISNULL(Donor_Detail.Last_Name, '') AS [Donor Name], Donor_Detail.Relation, Donor_Detail.Relation_First_Name + ' ' + ISNULL(Donor_Detail.Relation_Last_Name, '') AS [Relation Name], Donor_Transfusion_Detail.Bag_No AS [Bag No], Donor_Blood_Group_Marked.Group_Name + ' ' + Donor_Blood_Group_Marked.Rh_Factor AS [Blood Group] FROM Donor_Transfusion_Detail INNER JOIN Blood_Donation ON Donor_Transfusion_Detail.Bag_No = Blood_Donation.Bag_No INNER JOIN Donor_Detail ON Blood_Donation.Donor_Registration_No = Donor_Detail.Donor_Registration_No INNER JOIN Donor_Blood_Group_Marked ON Donor_Detail.Donor_Registration_No = Donor_Blood_Group_Marked.Donor_Registration_No WHERE (Donor_Transfusion_Detail.BloodRequest_Id = @BloodRequest_Id)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="BloodRequest_Id"
                                            PropertyName="Value" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_Issue_Bag" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                                    InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"></asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenField_Componet_Id" runat="server" />
                                <asp:GridView ID="GridView4" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                    DataKeyNames="Bag No" DataSourceID="SqlDataSource_bags_detail" Height="1px" OnPreRender="GridView2_PreRender"
                                    PageSize="2" Width="100%">
                                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                    <Columns>
                                        <asp:BoundField DataField="Donor Name" HeaderText="Donor Name" ReadOnly="True" SortExpression="Donor Name" />
                                        <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation" />
                                        <asp:BoundField DataField="Relation Name" HeaderText="Relation Name" ReadOnly="True"
                                            SortExpression="Relation Name" />
                                        <asp:BoundField DataField="Bag No" HeaderText="Bag No" ReadOnly="True" SortExpression="Bag No" />
                                        <asp:BoundField DataField="Blood Group" HeaderText="Blood Group" ReadOnly="True"
                                            SortExpression="Blood Group" />
                                    </Columns>
                                    <RowStyle CssClass="GridItem" Height="8px" />
                                    <HeaderStyle CssClass="GridHeader" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:SqlDataSource ID="SqlDataSource_transfusion" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                                    InsertCommand="INSERT INTO Donor_Transfusion_Detail(Patient_Registration_No, BloodRequest_Id, Emp_Id, Dept_Id, Date_Time, Bag_No) VALUES (@Patient_Registration_No, @BloodRequest_Id, @Emp_Id, @Dept_Id, GETDATE(), @Bag_No)"
                                    ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Blood_Request SET Status = 1 WHERE (Blood_Request_Id = @Blood_Request_Id)">
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Registration_No" Name="Patient_Registration_No"
                                            PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="BloodRequest_Id"
                                            PropertyName="Value" />
                                        <asp:SessionParameter DefaultValue="" Name="Emp_Id" SessionField="emp_id" />
                                        <asp:Parameter DefaultValue="11" Name="Dept_Id" />
                                        <asp:ControlParameter ControlID="TextBox_bag_No" DefaultValue="" Name="Bag_No" PropertyName="Text" />
                                    </InsertParameters>
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="Blood_Request_Id"
                                            PropertyName="Value" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenField_Blood_Request_Id" runat="server" />
                                <asp:SqlDataSource ID="SqlDataSource_Question" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>"
                                    SelectCommand="BloodBank_Select_Questions_marked" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE Blood_Request SET Status = 1 WHERE (Blood_Request_Id = @Blood_Request_Id)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="Blood_Request_Id"
                                            PropertyName="Value" />
                                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="Blood_Request_Id"
                                            PropertyName="Value" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:SqlDataSource ID="SqlDataSource_status_of" runat="server" ConnectionString="<%$ ConnectionStrings:Reg_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Reg_ConnectionString.ProviderName %>" UpdateCommand="UPDATE Forward_To_Sub_Dept  SET status = 1 WHERE (dumypointer = @Request_ID)">
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="HiddenField_for_Id" Name="Request_ID" PropertyName="Value" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="HiddenField_for_Id" runat="server" />
                                <asp:HiddenField ID="HiddenField_Yearly_No" runat="server" />
                                <asp:HiddenField ID="HiddenField_Registration_No" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="50%" valign="top">
                    <div class="bxmain inner_content" style="width: 100%">
                        <h2><span style="background-color: greenyellow">Issued Blood Detail</span></h2>
                        <table>
                            <tr>
                                <td>
                                    <asp:GridView runat="server" Width="100%" ID="GridViewIssuedBag" DataSourceID="SqlDataSource_IssuedBag" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Donor Reg#">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDonorRegNo" Text='<%#Bind("Donor_Registration_No") %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Donor Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDonorName" Text='<%#Bind("Donor_Name") %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Bag No">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBagNo" Text='<%#Bind("Bag_No") %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Bag">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBagName" Text='<%#Bind("Bag_Name") %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Component">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcomponent" Text='<%#Bind("Component_Name") %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Expiry">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExpiry" Text='<%#Bind("Expiry_DateTime") %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbtnCancelIssuedBlood" Text="Cancel" OnClick="lbtnCancelIssuedBlood_Click" CommandArgument='<%# Bind("Product_Formation_Id") %>' runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                    <br />
                                    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Blood Request Completed" />
                                    <asp:Button ID="btnReport" runat="server" Text="Report" OnClick="btnReport_Click" />
                                    <asp:SqlDataSource ID="SqlDataSource_IssuedBag" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                                        SelectCommand="usp_GetIssuedBloodDetail" SelectCommandType="StoredProcedure"
                                        UpdateCommand="UPDATE Donor_Product_Formation SET Request_ID = '', Product_Formation_Status = 'Bank' WHERE (Product_Formation_Id = @Product_Formation_Id)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="HiddenField_Blood_Request_Id" Name="Reserved_For_Request"
                                                PropertyName="Value" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:ControlParameter ControlID="HiddenField_PFID" Name="Product_Formation_Id" PropertyName="Value" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>

                    </div>
                </td>
            </tr>
        </table>

    </div>

</asp:Content>

