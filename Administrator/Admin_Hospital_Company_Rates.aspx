<%@ Page Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="Admin_Hospital_Company_Rates.aspx.cs" Inherits="Administrator_Admin_Hospital_Company_Rates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<div align="center">
        <asp:Button ID="Button1" runat="server" Text=" >> " OnClick="Button1_Click" />
        <asp:Button ID="Button3" runat="server" Text=" << " OnClick="Button3_Click" />
    </div>
    <div class="bxmain inner_content" style="width:100%">
         <span><h2>Set Company Rates</h2></span>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="50%" valign="top">
            
             <h1 class="h1" style="width: 98%">
                    <span>Avaiable Services</span></h1>
            
                <div class="bxmain" style="width: 98%">
                    <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                       
                        <tr>
                            <td align="right">
                                Company Name : 
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Company" runat="server" DataSourceID="SqlDataSourcePatientType"
                                    DataTextField="Party_Name" DataValueField="Party_id" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourcePatientType" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="select P.Party_Id,Party_Name from Parties P  Join PatientBillling.dbo.Patient_Billing_Party PBP ON P.Party_Id=PBP.Party_Id order by Party_Name asc ">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Service Category :</td>
                            <td>
                                <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True" DataSourceID="SQL_ServiceCategory"
                                    DataTextField="Asc_Name" DataValueField="Asc_id">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SQL_ServiceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                    SelectCommand=" SELECT [Asc_id], [Asc_Name] FROM [Admin_Service_Category] oRDER bY Asc_Name"></asp:SqlDataSource>
                            </td>
                        </tr>
                         <tr>
                        <td align="right">

                            (%) Increase (+):&nbsp;</td>
                        <td>
                            <asp:TextBox ID="txtpercen" OnTextChanged="txtpercen_TextChanged" runat="server" AutoPostBack="true" min="0" max="100" TextMode="Number"></asp:TextBox>
                            &nbsp;</td>
                        </tr>
                         <tr>
                        <td align="right">

                            (%) Subtraction (-) :&nbsp; </td>
                        <td><asp:TextBox ID="txtPercenSub" OnTextChanged="txtPercenSub_TextChanged" runat="server" AutoPostBack="true" min="0" max="100" TextMode="Number"></asp:TextBox>
                            &nbsp;</td>
                        </tr>
                        <tr>
                        <td align="right">
                            IPD/OPD :
                        </td>
                        <td>
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                                <asp:ListItem Selected="True">OPD</asp:ListItem>
                                <asp:ListItem >IPD</asp:ListItem>
                                
                            </asp:RadioButtonList>
                        </td>
                        </tr>
                     </table> </div>
                     <br />

                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Services"
                    DataKeyNames="S_ID" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="98%">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="S_Name" HeaderText="Service Name" SortExpression="S_Name" />
                        <asp:TemplateField HeaderText="Amount" SortExpression="S_Amount">                           
                            <ItemTemplate>
                                <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("S_Amount") %>'></asp:Label>
                            </ItemTemplate>                           
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Company Rate" SortExpression="S_Amount">
                            <ItemTemplate>
                                <asp:TextBox ID="txtCompanyAmount" runat="server" Text='<%# Eval("S_Amount") %>'></asp:TextBox>                            
                            </ItemTemplate>                            
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HiddenField ID="HiddenField_SID" runat="server" Value='<%# Eval("S_ID") %>' />
                                <asp:CheckBox ID="CheckBox1" runat="server" />
                            </ItemTemplate>
                            <HeaderTemplate>
                                <asp:CheckBox ID="CheckBox3" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox3_CheckedChanged" />
                            </HeaderTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_Services" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    SelectCommand="SELECT S_ID, S_Name, S_Amount FROM Admin_Services WHERE Active=1 and (S_ID NOT IN (SELECT S_Id FROM Hospital_Company_Services_Rates WHERE (Company_ID = @Party_id)  AND (IPD_OPD = @IPD_OPD))AND (S_Category = @S_Category))"
                    ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>">
                    <SelectParameters>
                   
                        <asp:ControlParameter ControlID="DropDownList_Company" Name="Party_id"
                            PropertyName="SelectedValue" />
                     
                        <asp:ControlParameter ControlID="ddlCategory" Name="S_Category" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="RadioButtonList1" Name="IPD_OPD" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
                </td>
                
            <td width="50%" valign="top">
                <h1 class="h1">
                    <span>Selected Services</span></h1>
                <asp:GridView ID="GridView_HospitalServices" runat="server" AutoGenerateColumns="False"
                    Width="98%" DataKeyNames="S_Id,Company_id" DataSourceID="SqlDataSource_HospitalServices">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="S_Name" HeaderText="Service Name" SortExpression="S_Name" />
                        <asp:BoundField DataField="S_Amount" HeaderText="Company Rate" SortExpression="S_Amount" /> 
                        <asp:BoundField DataField="IPD_OPD" HeaderText="OPD/IPD" SortExpression="IPD_OPD" />                        
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox ID="CheckBox4" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox4_CheckedChanged" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox2" runat="server" />
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("S_Id") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_HospitalServices" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT Hospital_Company_Services_Rates.Hospital_Id, Hospital_Company_Services_Rates.Company_ID, Hospital_Company_Services_Rates.S_Id, Hospital_Company_Services_Rates.S_Amount, Admin_Services.S_Name, Admin_Services.S_Category, Hospital_Company_Services_Rates.IPD_OPD FROM Hospital_Company_Services_Rates INNER JOIN Admin_Services ON Hospital_Company_Services_Rates.S_Id = Admin_Services.S_ID WHERE  (Hospital_Company_Services_Rates.Company_ID = @Company_ID) AND (Admin_Services.S_Category = @S_Category) AND (Hospital_Company_Services_Rates.IPD_OPD = @IPD_OPD)"
                    DeleteCommand=" DELETE FROM Hospital_Company_Services_Rates WHERE (Company_ID = @Company_ID) AND (S_Id = @S_Id) AND (Hospital_Id = @Hospital_Id)"
                    InsertCommand="INSERT INTO Hospital_Company_Services_Rates(Hospital_Id, S_Id, Company_ID, S_Amount, Entry_Date, Entry_By,S_Category,IPD_OPD) VALUES (@Hospital_Id, @S_Id, @Company_ID, @S_Amount, GETDATE(), @Entry_By,@S_Category,@IPD_OPD)">
                    <SelectParameters>
                        
                       
                        <asp:ControlParameter ControlID="DropDownList_Company" Name="Company_ID"
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="ddlCategory" Name="S_Category" PropertyName="SelectedValue" />
                       
                        <asp:ControlParameter ControlID="RadioButtonList1" Name="IPD_OPD" PropertyName="SelectedValue" />
                       
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="DropDownList_Company" Name="Company_ID"
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="HiddenFieldSID" Name="S_Id" PropertyName="Value" />
                        
                        <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
                    </DeleteParameters>
                    <InsertParameters>
                         
                        <asp:SessionParameter Name="Hospital_Id" SessionField="HospitalID" />
                        <asp:ControlParameter ControlID="HiddenFieldSID" Name="S_Id" PropertyName="Value" />
                        <asp:ControlParameter ControlID="DropDownList_Company" Name="Company_ID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="HiddenFieldAmount" Name="S_Amount" PropertyName="Value" />
                          <asp:SessionParameter Name="Entry_By" SessionField="emp_id" />
                          <asp:ControlParameter ControlID="ddlCategory" Name="S_Category" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="RadioButtonList1" Name="IPD_OPD" PropertyName="SelectedValue" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldAmount" runat="server" />
                <asp:HiddenField ID="HiddenFieldSID" runat="server" />
            </td>
            

        
        </tr>
    </table>
    </div>
    
</asp:Content>
