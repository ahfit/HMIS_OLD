<%@ page language="C#" autoeventwireup="true" inherits="Blood_Bank_Issue_Chit, App_Web_ob4gay25" masterpagefile="~/hacims_masterpage_admin.master" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
 
 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 
 
 
        <asp:HiddenField ID="HiddenField_RegNo" runat="server" />
        <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
        
     <asp:GridView ID="GridView_Issueable" runat="server" AutoGenerateColumns="False" Width="100%"
            DataSourceID="SqlDataSource_Issueable">
            <Columns>
                <asp:BoundField DataField="Bag_No" HeaderText="Bag No" SortExpression="Bag_No" />
                <asp:BoundField DataField="Bag_Name" HeaderText="Bag Type" SortExpression="Bag_Name" />
                <asp:BoundField DataField="Product_Formation_Status" HeaderText="Status" SortExpression="Product_Formation_Status" />
                <asp:BoundField DataField="Product_Qty" HeaderText="Qty" SortExpression="Product_Qty" />
                <asp:BoundField DataField="Component_Name" HeaderText="Component" SortExpression="Component_Name" />
                <asp:BoundField DataField="Acronym" HeaderText="Acronym" SortExpression="Acronym" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" />
                        <asp:HiddenField ID="HiddenField_PFID" runat="server" Value='<%# Eval("Product_Formation_Id") %>' />
                        <asp:HiddenField ID="HiddenField_Request_Id" runat="server" Value='<%# Eval("Request_ID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    
    
    <br>

    
  
        <asp:SqlDataSource ID="SqlDataSource_Issueable" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
            InsertCommand="INSERT INTO Issue_Chit_Sub(Issue_Chit_Id, Product_Formation_Id) VALUES (@Issue_Chit_Id, @Product_Formation_Id)"
            SelectCommand="SELECT Donor_Product_Formation.Bag_No, Donor_Product_Formation.Product_Formation_Status, Bag_Type.Bag_Name, Donor_Product_Formation.Product_Qty, Blood_Component.Component_Name, Blood_Component.Acronym, Blood_Request.Registration_No, Donor_Product_Formation.Product_Formation_Id, Donor_Product_Formation.Request_ID FROM Blood_Request INNER JOIN Donor_Product_Formation ON Blood_Request.Blood_Request_Id = Donor_Product_Formation.Request_ID INNER JOIN Bag_Type ON Donor_Product_Formation.Bag_Type_Id = Bag_Type.Bag_Type_Id INNER JOIN Blood_Component ON Donor_Product_Formation.Component_Id = Blood_Component.Component_id WHERE (Donor_Product_Formation.Is_Issued = 0) AND (Blood_Request.Registration_No = @Registration_No) AND (Donor_Product_Formation.Product_Formation_Id NOT IN (SELECT Product_Formation_Id FROM Issue_Chit_Sub))">
            <SelectParameters>
                <asp:QueryStringParameter QueryStringField="Registration" Type="String"  Name="Registration_No" />
            </SelectParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="HiddenField_NewIssueChitId" Name="Issue_Chit_Id"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenField_ProductFormationId" Name="Product_Formation_Id"
                    PropertyName="Value" />
            </InsertParameters>
        </asp:SqlDataSource>
        
        <div align="center">
        <asp:Button ID="Button_Issue" runat="server" OnClick="Button_Issue_Click" Text="Issue" UseSubmitBehavior="False" /> </div>
        <asp:HiddenField ID="HiddenField_ProductFormationId" runat="server" />
        <asp:HiddenField ID="HiddenField_NewIssueChitId" runat="server" />
    <table>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
                    <asp:GridView ID="GridView_Display" runat="server" AutoGenerateColumns="False" DataKeyNames="Issue_Chit_Id" Width="98%"
                        DataSourceID="SqlDataSource_Display">
                        <Columns>
                            <asp:TemplateField HeaderText="Issue Chit Date" SortExpression="Date_Time">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Date_Time") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Date_Time") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CheckBoxField DataField="Is_Issued" HeaderText="Is_Issued" SortExpression="Is_Issued" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton_Detail" runat="server" OnClick="LinkButton_Detail_Click">Details</asp:LinkButton><br />
                                    <asp:HiddenField ID="HiddenField_IssueChitId" runat="server" Value='<%# Eval("Issue_Chit_Id") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
                    <asp:GridView ID="GridView_Details" runat="server" AutoGenerateColumns="False" DataKeyNames="Issue_Chit_Sub_Id" Width="100%"
                        DataSourceID="SqlDataSource_Details">
                        <Columns>
                            <asp:BoundField DataField="Bag_No" HeaderText="Bag No" SortExpression="Bag_No" />
                            <asp:BoundField DataField="Component_Name" HeaderText="Component" SortExpression="Component_Name" />
                            <asp:BoundField DataField="Acronym" HeaderText="Acronym" SortExpression="Acronym" />
                            <asp:BoundField DataField="Product_Qty" HeaderText="Qty" SortExpression="Product_Qty" />
                            <asp:BoundField DataField="Bag_Name" HeaderText="Bag Type" SortExpression="Bag_Name" />
                            <asp:BoundField DataField="Product_Formation_Status" HeaderText="Status" SortExpression="Product_Formation_Status" />
                            <asp:BoundField DataField="Expiry_DateTime" HeaderText="Expiry" SortExpression="Expiry_DateTime" />
                            <asp:BoundField DataField="Donor_Registration_No" HeaderText="Donor Reg No" SortExpression="Donor_Registration_No" />
                            <asp:CheckBoxField DataField="Is_Issued" HeaderText="Issued" SortExpression="Is_Issued" />
                        </Columns>
                    </asp:GridView>
            </td>
        </tr>
    </table>
       <br>

        <table cellpadding="0" cellspacing="0" border="0" width="100%"   >
            <tr>
                <td width="50%" valign="top">
                    <asp:SqlDataSource ID="SqlDataSource_Display" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                        SelectCommand="SELECT Issue_Chit_Id, CONVERT (VARCHAR, Date_Time, 103) AS Date_Time, Reg_No, Is_Issued FROM Issue_Chit WHERE (Reg_No = @Reg_No) AND (YearlyNo = @YearlyNo)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HiddenField_RegNo" Name="Reg_No" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HiddenField_YearlyNo" Name="YearlyNo" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    &nbsp;
                </td>
             <td width="50%" valign="top">
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
            
        </table>
        </asp:Content>