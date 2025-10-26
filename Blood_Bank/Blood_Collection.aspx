<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage.master" inherits="Blood_Bank_Blood_Collection, App_Web_ob4gay25" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebSchedule.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="ig_sched" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

 
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


 
         <asp:HiddenField ID="HiddenField_Donor_Reg_No" runat="server" />
        <asp:HiddenField ID="HiddenField_Visit_No" runat="server" />
        <asp:HiddenField ID="HiddenField_Emp_Id" runat="server" />
     
        <asp:Button ID="Button_Full_Process" runat="server" OnClick="Button_Full_Process_Click"
            Text="Bleed With Product Formation" />
        <asp:Button ID="Button_Partial_Process" runat="server" OnClick="Button_Partial_Process_Click"
            Text="Only Bleed" />
        <asp:Button ID="Button_Formation" runat="server" OnClick="Button_Formation_Click"
            Text="Only Formation" /> 
      
        <asp:Panel ID="Panel_Bleed_With_Product_Formation" runat="server"   Width="100%" Visible="False" >
       
       <h1 class="h1"><span>Bleed With Product Formation</span></h1>
       <div class="bxmain">
        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
             
            <tr>
                <td align="right" width="25%" >
                    Bleeding Date :<asp:HiddenField ID="HiddenField_Bag_Nofull" runat="server" />
                </td>
                <td width="25%" >
                    <igtxt:webdatetimeedit id="Webdatetimeedit1" runat="server" displaymodeformat="dd/MM/yyyy"
                editmodeformat="dd" Width="100px" Culture="English (United Kingdom)">
                  </igtxt:WebDateTimeEdit>
              </td>
                <td align="right" width="25%">
                    Bleeding Time :<asp:HiddenField ID="HiddenField_Date_Timefull" runat="server" />
                </td>
                <td width="25%">
                    <igtxt:webdatetimeedit id="Webdatetimeedit2" runat="server" displaymodeformat="H:mm"
                editmodeformat="H:mm" Width="100px">
                    </igtxt:WebDateTimeEdit>
                </td>
          </tr>
            <tr>
                <td align="right" >
                    <asp:Label ID="Label_BagTypeAlert" runat="server" Text="Select Bag Type :"></asp:Label>
                    <asp:SqlDataSource ID="SqlDataSource_Bag_Type" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                        SelectCommand="SELECT Bag_Type_Id, Bag_Name FROM Bag_Type ORDER BY Bag_Name" UpdateCommand="Blood_Collection_Update_Status" UpdateCommandType="StoredProcedure">
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="HiddenField_Visit_No" Name="visit_Id" PropertyName="Value"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="HiddenField_Donor_Reg_No" Name="Donor_Reg" PropertyName="Value"
                                Type="String" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
                <td >
                    <asp:DropDownList ID="DropDownList_BagType" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Bag_Type" DataTextField="Bag_Name" DataValueField="Bag_Type_Id" OnSelectedIndexChanged="DropDownList_BagType_SelectedIndexChanged" Width="202px">
                  </asp:DropDownList>
              </td>
                <td align="right"  >
                    <asp:Label ID="Label_ComponentAlert" runat="server" Text="Select Component :"  ></asp:Label><strong>
                    </strong>
                    <asp:SqlDataSource ID="SqlDataSource_Component" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                        InsertCommand="INSERT INTO Donor_Product_Formation(Donation_Id, Component_Id, Product_Qty, Bag_Type_Id, Product_Formation_Status, Formation_DateTime, Expiry_DateTime, Bag_Id) VALUES (@Donation_Id, @Component_Id, @Product_Qty, @Bag_Type_Id, @Product_Formation_Status, @Formation_DateTime, @Expiry_DateTime, @Bag_Id)"
                        SelectCommand="SELECT [Component_id], [Component_Name] FROM [Blood_Component]">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="HiddenField_Donor_Reg_No" Name="Donation_Id" PropertyName="Value" />
                            <asp:ControlParameter ControlID="DropDownList_Component" Name="Component_Id" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="TextBox_Product_Amount" Name="Product_Qty" PropertyName="Text" />
                            <asp:Parameter Name="Bag_Type_Id" />
                            <asp:ControlParameter ControlID="Label_Acronym" Name="Product_Formation_Status" PropertyName="Text" />
                            <asp:Parameter Name="Formation_DateTime" />
                            <asp:ControlParameter ControlID="HiddenField_emp_Id" Name="Expiry_DateTime" PropertyName="Value" />
                            <asp:ControlParameter ControlID="Label_Bag_No" Name="Bag_Id" PropertyName="Text" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                </td>
                <td >
                    <asp:DropDownList ID="DropDownList_Component" runat="server" AutoPostBack="True"
                        DataSourceID="SqlDataSource_Component" DataTextField="Component_Name" DataValueField="Component_id"
                        OnSelectedIndexChanged="DropDownList_Component_SelectedIndexChanged" Width="202px" EnableTheming="True" OnDataBound="DropDownList_Component_DataBound">
                    </asp:DropDownList></td>
          </tr>
             </table>
             </div>
             <br />

                
                
                
                
                
        <table border="0" cellpadding="0" cellspacing="0" class="Grid_1" width="100%">
            <tr>
                <th width="11%" >
                    Acronym </th>
                <th width="11%" >
                    Manufact. Date</th>
                <th width="11%" >
                    Status</th>
                <th width="11%" >
                     Expiry Hours Left 
                </th>
                <th  >
                    Expiry Date</th>
                <th width="11%" >
                    Amount</th>
            </tr>
            <tr>
                <td >
                    <asp:Label ID="Label_Acronym" runat="server"></asp:Label></td>
                <td >
                    <asp:Label ID="Label_Start_Date" runat="server"></asp:Label></td>
                <td >
                    <asp:DropDownList ID="DropDownList_status" runat="server" Width="100%">
                        <asp:ListItem>Bank</asp:ListItem>
                        <asp:ListItem>Reserved</asp:ListItem>
                    </asp:DropDownList></td>
                <td >
                    <asp:Label ID="Label_ExpiryHours" runat="server" Width="160px"></asp:Label></td>
                <td  >
                     <asp:Label ID="Label_End_Date" runat="server"></asp:Label>
                    <asp:HiddenField ID="HiddenField_Label_End_Date" runat="server" />
                   
                </td>
                <td >
                    <asp:TextBox ID="TextBox_Product_Amount" runat="server" Width="140px"></asp:TextBox></td>
            </tr>
        </table>
        
        <br />
<div class="bxmain">
        
         
<table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                            <tr>
                                <td width="25%" align="right">
                                    Bag No. :</td>
                                    
                                     <td width="25%">
        <asp:HiddenField ID="HiddenField_BagNo" runat="server" />
                    <asp:Label ID="Label_Bag_No" runat="server"  ></asp:Label></td>
                                <td width="25%" align="right">
                                    Product Bag No. :</td>
                             
                               
                              <td width="25%">
                    <asp:HiddenField ID="HiddenField_NewBagNo" runat="server" />
                    <asp:Label ID="Label_NewBagNo" runat="server"  ></asp:Label></td>
                            </tr>
                        </table>
                     </div>
                  <asp:SqlDataSource ID="SqlDataSource_Save" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                        InsertCommand="Blood_Collection_With_Formation" InsertCommandType="StoredProcedure" SelectCommand="SELECT Donor_Registration_No, Date_Time FROM Blood_Donation" OnInserted="SqlDataSource_Save_Inserted" OnSelecting="SqlDataSource_Save_Selecting" ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="HiddenField_Donor_Reg_No" Name="Donor_Registration_No"
                                PropertyName="Value" Type="String" />
                            <asp:ControlParameter ControlID="HiddenField_BagNo" Name="Bag_No" PropertyName="Value"
                                Type="String" />
                            <asp:ControlParameter ControlID="HiddenField_Emp_Id" Name="Emp_Id" PropertyName="Value"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="HiddenField_Visit_No" Name="Donor_Visit_Id" PropertyName="Value"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList_BagType" Name="Bag_Type_Id" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="DropDownList_Component" Name="Component_Id" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="TextBox_Product_Amount" Name="Product_Qty" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="DropDownList_status" Name="Product_Formation_Status"
                                PropertyName="SelectedValue" Type="String" />
                            <asp:ControlParameter ControlID="HiddenField_NewBagNo" Name="New_Bag_No" PropertyName="Value"
                                Type="String" />
                            <asp:Parameter Direction="Output" Name="RESPONSE" Size="100" Type="String" />
                            <asp:ControlParameter ControlID="Label_End_Date" Name="Expiry_DateTime" PropertyName="Text"
                                Size="20" Type="String" />
                        </InsertParameters>
                    </asp:SqlDataSource><br />

                   <div align="center" > <asp:Button ID="Button_Save" runat="server" OnClick="Button_Save_Click" Text="Save" />                    
<asp:Label ID="Label_Saved" runat="server" Text="Record Saved" Visible="False" ForeColor="Red"></asp:Label> </div>
            <br />
         
         
         
          
        <asp:GridView ID="GridView_Display" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Display"  >
            <Columns>
                <asp:BoundField DataField="Bag_No" HeaderText="Bag No" SortExpression="Bag_No" />
                <asp:BoundField DataField="Component_Name" HeaderText="Component" SortExpression="Component_Name" />
                <asp:BoundField DataField="Acronym" HeaderText="Acronym" SortExpression="Acronym" />
                <asp:BoundField DataField="Product_Qty" HeaderText="Qty" SortExpression="Product_Qty" />
                <asp:BoundField DataField="Bag_Name" HeaderText="Bag Type" SortExpression="Bag_Name" />
                <asp:BoundField DataField="Formation_DateTime" HeaderText="Formation Date" SortExpression="Formation_DateTime" />
                <asp:BoundField DataField="Expiry_DateTime" HeaderText="Expiry Date" SortExpression="Expiry_DateTime" />
                <asp:BoundField DataField="Donor_Registration_No" HeaderText="Donor Reg No" SortExpression="Donor_Registration_No">
                    <ItemStyle BackColor="#E0E0E0" />
                </asp:BoundField>
                <asp:BoundField DataField="BG" HeaderText="Blood Group" ReadOnly="True" SortExpression="BG">
                    <ItemStyle BackColor="#E0E0E0" />
                </asp:BoundField>
                <asp:BoundField DataField="FromBagNo" HeaderText="From Bag No" SortExpression="FromBagNo">
                    <ItemStyle BackColor="#E0E0E0" />
                </asp:BoundField>
                <asp:BoundField DataField="FromBagName" HeaderText="From Bag Type" SortExpression="FromBagName">
                    <ItemStyle BackColor="#E0E0E0" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
                     
        <asp:SqlDataSource ID="SqlDataSource_Display" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>" SelectCommand="SELECT     Blood_Component.Component_Name, Blood_Component.Acronym, Donor_Product_Formation.Product_Qty, Bag_Type.Bag_Name, &#13;&#10;                      Donor_Product_Formation.Formation_DateTime, Donor_Product_Formation.Expiry_DateTime, Donor_Product_Formation.Bag_No, ISNULL(Blood_Group.Group_Name, &#13;&#10;                      '') + ISNULL(Blood_Group.Rh_Factor, '') AS BG, Blood_Donation.Donor_Registration_No, Blood_Donation.Bag_No AS FromBagNo, &#13;&#10;                      Bag_Type_1.Bag_Name AS FromBagName&#13;&#10;FROM         Donor_Product_Formation INNER JOIN&#13;&#10;                      Blood_Donation ON Donor_Product_Formation.Donation_Id = Blood_Donation.Donation_Id INNER JOIN&#13;&#10;                      Blood_Component ON Donor_Product_Formation.Component_Id = Blood_Component.Component_id INNER JOIN&#13;&#10;                      Bag_Type ON Donor_Product_Formation.Bag_Type_Id = Bag_Type.Bag_Type_Id INNER JOIN&#13;&#10;                      Donor_Blood_Group_Marked ON Blood_Donation.Donor_Registration_No = Donor_Blood_Group_Marked.Donor_Registration_No AND &#13;&#10;                      Blood_Donation.Donor_Visit_Id = Donor_Blood_Group_Marked.Donor_Visit_Id INNER JOIN&#13;&#10;                      Blood_Group ON Donor_Blood_Group_Marked.Blood_Group_Id = Blood_Group.Blood_Group_Id INNER JOIN&#13;&#10;                      Bag_Type AS Bag_Type_1 ON Blood_Donation.Bag_Type_Id = Bag_Type_1.Bag_Type_Id&#13;&#10;&#13;&#10; WHERE (Donor_Product_Formation.Bag_No = @Bag_No)">
            <SelectParameters>
                <asp:ControlParameter ControlID="Label_NewBagNo" Name="Bag_No" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
                    
         
        </asp:Panel>
        
        <asp:Panel ID="Panel_Only_Bleed" runat="server" Visible="False" Width="100%">
            <h1 class="h1"><span>Enter Bleeding Date and Time</span></h1>
            <div class="bxmain">
<table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                 
                <tr>
                    <td colspan="3" align="right" width="40%"  >
                        Collection
                        Date : </td>
                                        <td>
                                            <igtxt:webdatetimeedit id="Webdatetimeedit_Date" runat="server" displaymodeformat="dd/MM/yyyy"
                editmodeformat="dd" Width="202px" Culture="English (United Kingdom)">
                        </igtxt:WebDateTimeEdit>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="right">
                        Collection
                        Time :
                    </td>
                                        <td>
                        <igtxt:webdatetimeedit id="Webdatetimeedit_Time" runat="server" displaymodeformat="H:mm"
                editmodeformat="H:mm" Width="202px">
                        </igtxt:WebDateTimeEdit>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="right">
              Bag Type :</td>
                    <td>
                        <asp:DropDownList ID="DropDownList_BagTypePB" runat="server" DataSourceID="SqlDataSource_BagTypePB"
                            DataTextField="Bag_Name" DataValueField="Bag_Type_Id" Width="202px">
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td colspan="3" align="right" style="height: 18px">
                        <asp:Label ID="Label_lblBagNoPB" runat="server" Text="Bag No. :" Visible="False" ></asp:Label></td>
                    <td style="height: 18px"  >
                  <asp:Label ID="Label_BagNoPB" runat="server" Text="Label" Visible="False" ></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="3" align="right">
                        Quantity :</td>
                    <td>
                  <asp:TextBox ID="TextBox_QuantityPB" runat="server"  >450</asp:TextBox>ml</td>
                </tr>
                <tr>
                    <td colspan="3" align="right">&nbsp;
                        </td>
                                        <td>
                        <asp:Button ID="Button_SavePB" runat="server" OnClick="Button_SavePB_Click" Text="Save" /><asp:Label ID="Label_SavedPB" runat="server" ForeColor="Red" Text="Record Saved"
                            Visible="False"></asp:Label>
                     
            <asp:SqlDataSource ID="SqlDataSource_SavePB" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                InsertCommand="Blood_Collection_OnlyBleed" InsertCommandType="StoredProcedure"
                OnInserted="SqlDataSource_SavePB_Inserted" SelectCommand="SELECT Blood_Donation.Bag_No, Blood_Donation.Donor_Registration_No, Blood_Donation.Blood_Group, Blood_Donation.Donor_Visit_Id, Bag_Type.Bag_Name, Blood_Donation.Assesment_Id, Blood_Donation.Quantity, Blood_Donation.Collected_At FROM Blood_Donation INNER JOIN Bag_Type ON Blood_Donation.Bag_Type_Id = Bag_Type.Bag_Type_Id WHERE (Blood_Donation.Donor_Visit_Id = @Donor_Visit_Id) AND (Blood_Donation.Donor_Registration_No = @Donor_Registration_No) AND (Blood_Donation.Bag_No = @Bag_No)">
                <InsertParameters>
                    <asp:ControlParameter ControlID="HiddenField_Donor_Reg_No" Name="Donor_Registration_No"
                        PropertyName="Value" Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_Bag_NoPB" Name="Bag_No" PropertyName="Value"
                        Type="String" />
                    <asp:SessionParameter Name="Emp_Id" SessionField="Emp_Id" Type="Int32" />
                    <asp:ControlParameter ControlID="HiddenField_Visit_No" Name="Donor_Visit_Id" PropertyName="Value"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="DropDownList_BagTypePB" Name="Bag_Type_Id" PropertyName="SelectedValue"
                        Type="Int32" />
                    <asp:ControlParameter ControlID="TextBox_QuantityPB" Name="Quantity" PropertyName="Text"
                        Type="Double" />
                    <asp:Parameter Direction="InputOutput" Name="RESPONSE" Size="100" Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_Date_TimePB" Name="Collected_At" PropertyName="Value"
                        Type="DateTime" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField_Visit_No" Name="Donor_Visit_Id" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenField_Donor_Reg_No" Name="Donor_Registration_No"
                        PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenField_Bag_NoPB" Name="Bag_No" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
                    </td>
                </tr>
                </table></div>
                <br />

                      
                      
                        <asp:GridView ID="GridView_DisplayPB" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="SqlDataSource_SavePB"  >
                            <Columns>
                                <asp:BoundField DataField="Donor_Registration_No" HeaderText="Donor Reg No" SortExpression="Donor_Registration_No" />
                                <asp:BoundField DataField="Bag_No" HeaderText="Bag No" SortExpression="Bag_No" />
                                <asp:BoundField DataField="Blood_Group" HeaderText="Blood Group" SortExpression="Blood_Group" />
                                <asp:BoundField DataField="Bag_Name" HeaderText="Bag Type" SortExpression="Bag_Name" />
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                                <asp:BoundField DataField="Collected_At" HeaderText="Collected At" SortExpression="Collected_At" />
                            </Columns>
                        </asp:GridView>
                    
            <asp:SqlDataSource ID="SqlDataSource_BagTypePB" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="SELECT Bag_Name, Bag_Type_Id FROM Bag_Type ORDER BY Bag_Type_Id DESC"></asp:SqlDataSource>
                        <asp:HiddenField ID="HiddenField_Date_PB" runat="server" />
                    <asp:HiddenField ID="HiddenField_Time_PB" runat="server" />
        <asp:HiddenField ID="HiddenField_Bag_NoPB" runat="server" />
            <asp:HiddenField ID="HiddenField_Date_TimePB" runat="server" />
            &nbsp;
            
        </asp:Panel>
        
        <asp:Panel ID="Panel_PF" runat="server" Width="100%" Visible="False">
          <asp:SqlDataSource ID="SqlDataSource_BComponent_PF" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="SELECT Component_id, Component_Name, Acronym, Expiry_Days FROM Blood_Component WHERE (Expiry_Days IS NOT NULL)">
            </asp:SqlDataSource>
        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
                <tr>
                    <td align="right">Date:
                    </td>
                    <td><igtxt:webdatetimeedit id="Webdatetimeedit3" runat="server" displaymodeformat="MM/dd/yyyy"
                editmodeformat="dd" Width="100px">
                    </igtxt:WebDateTimeEdit>
                    </td>
                    <td align="right">Time:
                    </td>
                                        <td><igtxt:webdatetimeedit id="Webdatetimeedit4" runat="server" displaymodeformat="H:mm"
                editmodeformat="H:mm" Width="100px">
                                        </igtxt:WebDateTimeEdit>
                    </td>
                </tr>
       
            </table>
            <br />
            <asp:GridView ID="GridView_PF" runat="server" AutoGenerateColumns="False" DataKeyNames="Component_id"
                DataSourceID="SqlDataSource_BComponent_PF" CssClass="Grid_1" OnPreRender="GridView_PF_PreRender" ShowFooter="True">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged" />
                            <asp:HiddenField ID="HiddenField_Component_Id" runat="server" Value='<%# Eval("Component_id") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Component_Name" HeaderText="Component Name" SortExpression="Component_Name" />
                    <asp:TemplateField HeaderText="Acronym" SortExpression="Acronym">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Acronym") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label_Achronym" runat="server" Text='<%# Bind("Acronym") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Expiry Days" SortExpression="Expiry_Days">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Expiry_Days") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label_ExpiryDays" runat="server" Text='<%# Bind("Expiry_Days") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Expiry Hours Left">
                        <ItemTemplate>
                            <asp:Label ID="Label_HoursLeft" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Expiry Date">
                        <ItemTemplate>
                            <asp:Label ID="Label_ExpiryDate" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Product Bag Type">
                        <ItemTemplate>
                            <asp:DropDownList ID="DropDownList_BagTypePB" runat="server" DataSourceID="SqlDataSource_BagTypePB"
                            DataTextField="Bag_Name" DataValueField="Bag_Type_Id" Width="176px">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource_BagTypePB" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
                SelectCommand="SELECT [Bag_Name], [Bag_Type_Id] FROM [Bag_Type]"></asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="DropDownList_status" runat="server" Width="100%">
                                <asp:ListItem Selected="True">Bank</asp:ListItem>
                                <asp:ListItem>Reserved</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Product Bag No">
                        <ItemTemplate>
                            <asp:Label ID="Label_ProductBagNo" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Qty">
                        <ItemTemplate>
                            <asp:TextBox ID="TextBox_Qty" runat="server" Enabled="False" AutoPostBack="True"></asp:TextBox>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="Label_TotalAmount" runat="server"></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
           
         <div align="center"> <asp:Button ID="Button_Save_PF" runat="server" OnClick="Button_Save_PF_Click"
                Text="Save" />
            <asp:Label ID="Label_SavedPF" runat="server" ForeColor="Red" Visible="False">Record Saved</asp:Label></div>&nbsp;<br />
            <br />
            <asp:HiddenField ID="HiddenField_FormationTime" runat="server" />
            <br />
<asp:HiddenField ID="HiddenField_Bag_No_PF" runat="server" />
<asp:HiddenField ID="HiddenField_Date_Time_PF" runat="server" />
<asp:HiddenField ID="HiddenField_Donation_Id_PF" runat="server" />
<asp:HiddenField ID="HiddenField_Bag_Type_Id_PF" runat="server" />
<asp:HiddenField ID="HiddenField_Quantity_PF" runat="server" />
<asp:HiddenField ID="HiddenField_Status_PF" runat="server" />
            
        </asp:Panel>
         
       <asp:SqlDataSource ID="SqlDataSource_Formed_Products" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
            InsertCommand="INSERT INTO Donor_Product_Formation(Donation_Id, Component_Id, Product_Qty, Product_Formation_Status, Formation_DateTime, Expiry_DateTime, Bag_Type_Id, Emp_Id, Bag_No) VALUES (@Donation_Id, @Component_Id, @Product_Qty, @Product_Formation_Status, @Formation_DateTime, @Expiry_DateTime, @Bag_Type_Id, @Emp_Id, @Bag_No)"
            SelectCommand="SELECT Donor_Product_Formation.Bag_Id, Donor_Product_Formation.Product_Formation_Status, Donor_Product_Formation.Formation_DateTime, Donor_Product_Formation.Expiry_DateTime, Blood_Component.Component_Name FROM Donor_Product_Formation INNER JOIN Blood_Component ON Donor_Product_Formation.Component_Id = Blood_Component.Component_id WHERE (Donor_Product_Formation.Donation_Id = @Donation)">
            <SelectParameters>
                <asp:Parameter Name="Donation" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Name="Donation_Id" />
                <asp:ControlParameter ControlID="DropDownList_Component" Name="Component_Id" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="TextBox_Product_Amount" Name="Product_Qty" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList_status" Name="Product_Formation_Status"
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="HiddenField_ReturnedDate" Name="Formation_DateTime"
                    PropertyName="Value" />
                <asp:ControlParameter ControlID="Label_End_Date" Name="Expiry_DateTime" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList_BagType" Name="Bag_Type_Id" PropertyName="SelectedValue" />
                <asp:SessionParameter Name="Emp_Id" SessionField="Emp_Id" />
                <asp:ControlParameter ControlID="Label_NewBagNo" Name="Bag_No" PropertyName="Text" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_screening_pointer" runat="server" ConnectionString="<%$ ConnectionStrings:BloodBank_ConnectionString %>"
            InsertCommand="INSERT INTO Donor_Screening_Pointer(Donor_Registration_No, Status) VALUES (@Donor_Registration_No, 0)"
            ProviderName="<%$ ConnectionStrings:BloodBank_ConnectionString.ProviderName %>">
            <InsertParameters>
                <asp:ControlParameter ControlID="HiddenField_Donor_Reg_No" Name="Donor_Registration_No"
                    PropertyName="Value" />
            </InsertParameters>
        </asp:SqlDataSource>
        <br />
   
  </asp:Content>
