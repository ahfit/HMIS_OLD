<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Discount_Policy_Update.aspx.cs" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Administrator_Discount_Policy_Update" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        function addPercentage() {
            var percentage = $.trim($("[id$='txtboxPercentage']").val());
            $("[id*='txtAmount']").val(percentage);

        }

    </script>
       <script type="text/javascript">
           function validate() {
               debugger;
               var FieldVal = parseInt($('[id$=txtboxPercentage]').val());

               //  var FieldVal = document.getElementById('txt_Percentage').value;
               if (FieldVal > 100) {
                   $('[id$=lblerr]').html("Discount can't be greater than 100!");
                   $('[id$=txtboxPercentage]').val("100");
               } else if (FieldVal < 0) {
                   $('[id$=lblerr]').html("Discount can't be less than 0!");
                   $('[id$=txtboxPercentage]').val("0");
               }
               else {
                   $('[id$=lblerr]').html("");
               }
           }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

<div align="center">
        <asp:Button ID="Button1" runat="server" Text=" >> " OnClick="Button1_Click" />
        <asp:Button ID="Button3" runat="server" Text=" << " OnClick="Button3_Click" />
    </div>

    <div class="bxmain inner_content" style="width:100%; margin-top:20px">
         <span><h2>Set Discount Policy</h2></span>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="50%" valign="top">
            
             <h1 class="h1" style="width: 98%">
                    <span>Avaiable Services</span></h1>
            
                <div class="bxmain" style="width: 98%">
                    <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                        <tr>
                            <td width="24%" align="right">
                                Hospital :</td>
                            <td width="76%">
                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource_Hospital"
                                    DataTextField="Hospital_Name" DataValueField="Hospital_ID" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital] ORDER BY [Attachment_Name]">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                Patient Type :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Patient_Type" runat="server" DataSourceID="SqlDataSourcePatientType"  OnSelectedIndexChanged="DropDownList_Patient_Type_SelectedIndexChanged"
                                    DataTextField="Patient_Type" DataValueField="Patient_Type_ID" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourcePatientType" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT Patient_Type_ID, Patient_Type FROM Patient_type WHERE (Active = 1) order by Patient_Type_ID asc">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                              <td align="right">
                                Company Name : 
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Company" runat="server" DataSourceID="SqlDataSource1"
                                    DataTextField="Party_Name" DataValueField="Party_id" AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand=" if @PatientTypeID =4 Begin  select Party_Id,Party_Name from Parties  END  ELSE BEGIN select 0 as Party_Id,'' as Party_Name END">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_Patient_Type" Name="PatientTypeID" PropertyName="SelectedValue" />
                                    </SelectParameters>
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
                                    SelectCommand="SELECT 0 [Asc_id], '----- ALL -----' [Asc_Name] union SELECT [Asc_id], [Asc_Name] FROM [Admin_Service_Category] Order By Asc_Name"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                        <td align="right">
                            IPD/OPD :
                        </td>
                        <td>
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" AutoPostBack="True">
                                <asp:ListItem Selected="True" >IPD</asp:ListItem>
                                <asp:ListItem>OPD</asp:ListItem>
                                <asp:ListItem>Both</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        </tr>
                         <tr>
                                <td align="right">Type :
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="RadioButtonList2" runat="server"
                                        RepeatDirection="Horizontal"
                                        AutoPostBack="True">
                                        <asp:ListItem Selected="True" Value="Pr">P</asp:ListItem>
                                        <asp:ListItem Value="F">F</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                     </table> </div>
                    
                <br />
                <div style="padding:5px;">
                    Policy Percentage : <asp:TextBox ID="txtboxPercentage" onKeyUp="validate()" runat="server" onblur="addPercentage()"></asp:TextBox> <asp:Label ID="lblerr" runat="server" ForeColor="Red"  Font-Bold="true" ></asp:Label>
                </div>

                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Services"
                    DataKeyNames="S_ID" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="98%">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="S_Name" HeaderText="Service Name" SortExpression="S_Name" />
                        <asp:TemplateField HeaderText="Amount (%)" SortExpression="S_Amount">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("S_Amount") %>'></asp:TextBox>
                                
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="txtAmount" runat="server" Text='<%# Bind("S_Amount") %>' Width="55px"></asp:TextBox>
                                <asp:Label ID="Label1" runat="server" ForeColor="#FF0066" Text='<%# Eval("Ognl_amount") %>'></asp:Label>
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
                    SelectCommand="usp_Set_Discount_Policy" ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>" 
                    SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Hospital_Id" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DropDownList_Patient_Type" Name="Patient_Type_Id"
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="RadioButtonList1" Name="IPD_OPD" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="ddlCategory" Name="S_Category" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DropDownList_Company" Name="CompayId" 
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                
                </td>
                
            <td width="50%" valign="top">
                <h1 class="h1">
                    <span>Selected Services</span></h1>
                <asp:GridView ID="GridView_HospitalServices" runat="server" AutoGenerateColumns="False"
                    Width="98%" DataKeyNames="Hospital_Id,S_Id,Patient_Type_Id,Party_Id" DataSourceID="SqlDataSource_HospitalServices">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="S_Name" HeaderText="Service Name" SortExpression="S_Name" />
                        <asp:BoundField DataField="Discount_Percentage" HeaderText="Percentage" SortExpression="Discount_Percentage" />
                        <asp:BoundField DataField="D_Type" HeaderText="Percentage" SortExpression="D_Type" />
                        <asp:BoundField DataField="S_Amount" HeaderText="Amount" SortExpression="S_Amount" />
                        <asp:BoundField DataField="DiscountAmout" HeaderText="Discount Amout" SortExpression="DiscountAmout" />
                        <asp:BoundField DataField="IPD_OPD" HeaderText="IPD/OPD" SortExpression="IPD_OPD" />
                        <asp:BoundField DataField="Party_Name" HeaderText="Party Name" SortExpression="Party_Name" />
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

                <asp:SqlDataSource ID="SqlDataSource_HospitalServices" runat="server" 
    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
    SelectCommand="
        SELECT 
            Discount_Policy.Hospital_Id, 
            Discount_Policy.S_Id, 
            Discount_Policy.Patient_Type_id, 
            Discount_Policy.Discount_Percentage, 
            Discount_Policy.IPD_OPD,
            Discount_Policy.D_Type,
            Admin_Services.S_Name, 
            Admin_Services.S_Category, 
            Parties.Party_Name,
            Discount_Policy.Party_Id,
            Admin_Services.S_Amount,
            CASE 
                WHEN Discount_Policy.D_Type='Pr' 
                    THEN Admin_Services.S_Amount - (Admin_Services.S_Amount * Discount_Policy.Discount_Percentage / 100) 
                ELSE 
                    Admin_Services.S_Amount - Discount_Policy.Discount_Percentage 
            END AS DiscountAmout
        FROM Discount_Policy
        INNER JOIN Admin_Services ON Discount_Policy.S_Id = Admin_Services.S_ID 
        LEFT OUTER JOIN Parties ON Discount_Policy.Party_Id = Parties.Party_Id
        WHERE 
            (Discount_Policy.Hospital_Id = @Hospital_Id) 
            AND (Discount_Policy.Patient_Type_id = @Patient_Type_Id) 
            AND (Discount_Policy.IPD_OPD = @IPD_OPD OR @IPD_OPD='Both') 
            AND (Discount_Policy.D_Type = @D_Type) 
            AND (@S_Category=0 OR Admin_Services.S_Category = @S_Category)"
    
    DeleteCommand="DELETE FROM PatientBillling.dbo.Discount_Policy 
                   WHERE (Patient_Type_Id = @Patient_Type_Id) 
                     AND (S_Id = @S_Id) 
                     AND (Hospital_Id = @Hospital_Id)"
    
    InsertCommand="INSERT INTO Discount_Policy
                   (Hospital_Id, S_Id, Patient_Type_Id, IPD_OPD, Discount_Percentage, Party_Id, D_Type ) 
                   VALUES 
                   (@Hospital_Id, @S_Id, @Patient_Type_Id, @IPD_OPD , @Discount_Percentage, @Party_Id, @D_Type )">
    
    <SelectParameters>
        <asp:ControlParameter ControlID="DropDownList1" Name="Hospital_Id" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="DropDownList_Patient_Type" Name="Patient_Type_Id" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="ddlCategory" Name="S_Category" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="RadioButtonList1" Name="IPD_OPD" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="RadioButtonList2" Name="D_Type" PropertyName="SelectedValue" />
    </SelectParameters>

    <DeleteParameters>
        <asp:ControlParameter ControlID="DropDownList_Patient_Type" Name="Patient_Type_Id" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="HiddenFieldSID" Name="S_Id" PropertyName="Value" />
        <asp:ControlParameter ControlID="DropDownList1" Name="Hospital_Id" PropertyName="SelectedValue" />
    </DeleteParameters>

    <InsertParameters>
        <asp:ControlParameter ControlID="DropDownList1" Name="Hospital_Id" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="HiddenFieldSID" Name="S_Id" PropertyName="Value" />
        <asp:ControlParameter ControlID="DropDownList_Patient_Type" Name="Patient_Type_Id" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="RadioButtonList1" Name="IPD_OPD" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="HiddenFieldAmount" Name="S_Amount" PropertyName="Value" />
        <asp:ControlParameter ControlID="HiddenFieldAmount" Name="Discount_Percentage" PropertyName="Value" />
        <asp:ControlParameter ControlID="DropDownList_Company" Name="Party_Id" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="RadioButtonList2" Name="D_Type" PropertyName="SelectedValue" />
    </InsertParameters>
</asp:SqlDataSource>
               <%-- <asp:SqlDataSource ID="SqlDataSource_HospitalServices" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT     Discount_Policy.Hospital_Id, Discount_Policy.S_Id, Discount_Policy.Patient_Type_id, Discount_Policy.Discount_Percentage , Discount_Policy.IPD_OPD, Discount_Policy.D_Type,
                      Admin_Services.S_Name, Admin_Services.S_Category, Parties.Party_Name,Discount_Policy.Party_Id,Admin_Services.S_Amount,
                      Admin_Services.S_Amount -(Admin_Services.S_Amount*Discount_Policy.Discount_Percentage/100) DiscountAmout
FROM         Discount_Policy INNER JOIN
                      Admin_Services ON Discount_Policy.S_Id = Admin_Services.S_ID LEFT OUTER JOIN
                      Parties ON Discount_Policy.Party_Id = Parties.Party_Id
WHERE     (Discount_Policy.Hospital_Id = @Hospital_Id) AND (Discount_Policy.Patient_Type_id = @Patient_Type_Id) AND (Discount_Policy.IPD_OPD = @IPD_OPD or @IPD_OPD='Both') AND 
                      (@S_Category=0 or Admin_Services.S_Category = @S_Category)"
                   
                    
                  DeleteCommand="DELETE FROM PatientBillling.dbo.Discount_Policy WHERE (Patient_Type_Id = @Patient_Type_Id) AND (S_Id = @S_Id) AND (Hospital_Id = @Hospital_Id)"
                    InsertCommand="INSERT INTO Discount_Policy(Hospital_Id, S_Id, Patient_Type_Id,IPD_OPD,Discount_Percentage,Party_Id,D_Type) 
                                VALUES (@Hospital_Id, @S_Id, @Patient_Type_Id, @IPD_OPD, @S_Amount,@PartyId,@D_Type)"

                                >
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Hospital_Id" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DropDownList_Patient_Type" Name="Patient_Type_Id"
                            PropertyName="SelectedValue" />

                        <asp:ControlParameter ControlID="ddlCategory" Name="S_Category" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="RadioButtonList1" Name="IPD_OPD" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="RadioButtonList2" Name="D_Type" PropertyName="SelectedValue" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:ControlParameter ControlID="DropDownList_Patient_Type" Name="Patient_Type_Id"
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="HiddenFieldSID" Name="S_Id" PropertyName="Value" />
                        <asp:ControlParameter ControlID="DropDownList1" Name="Hospital_Id" PropertyName="SelectedValue" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="Hospital_Id" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="HiddenFieldSID" Name="S_Id" PropertyName="Value" />
                        <asp:ControlParameter ControlID="DropDownList_Patient_Type" Name="Patient_Type_Id"
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="HiddenFieldAmount" Name="S_Amount" PropertyName="Value" />
                        <asp:ControlParameter ControlID="RadioButtonList1" Name="IPD_OPD" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="RadioButtonList2" Name="D_Type" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DropDownList_Company" Name="PartyId" 
                            PropertyName="SelectedValue" />
                    </InsertParameters>
                </asp:SqlDataSource>--%>
                <asp:HiddenField ID="HiddenFieldAmount" runat="server" />
                <asp:HiddenField ID="HiddenFieldSID" runat="server" />
            </td>
            

        
        </tr>
    </table>
    </div>
    
</asp:Content>

