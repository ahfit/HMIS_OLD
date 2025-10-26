<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Certification.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Certification" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

     <script type="text/javascript">
        function ValidateAlpha(evt) {
            var keyCode = (evt.which) ? evt.which : evt.keyCode
            if ((keyCode < 65 || keyCode > 90) && (keyCode < 97 || keyCode > 123) && keyCode != 32)

                return false;
            return true;
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode
            return !(charCode > 31 && (charCode < 48 || charCode > 57));

        }

    </script>




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td style="display:none" class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
<asp:Panel ID="Panel1" runat="server" Visible="False"></asp:Panel>
</td>
<td  style="width:auto;" valign="top" >
     <div class="bxmain inner_content" style="text-align:left; width:100%;background-color:transparent; border:none; font-weight:bold;">
<h2><span>Employee Certification</span> </h2>
<div class="bxmain" style="padding: 17px; padding-bottom: 2.3em;">

<div >

<asp:FormView  ID="FormView1" runat="server" DataKeyNames="EmpID" DataSourceID="dsEmployeeInfo"
                    HorizontalAlign="Left" Width="100%">
                    <ItemTemplate>
                    
                  <asp:Image  Visible="false" ID="Image2" runat="server" Style="position:absolute; margin-left:25px; margin-top:60px;" 
                                            ImageUrl=' <%# Convert.ToString("~/DisplayPic.ashx?Emp_Id=") + Convert.ToString(Eval("EmpID")) %>' 
                                            Width="77px" Height="90px" />  
                    
                        <div class="bxinset radius4">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
     
    <td valign="top">  
    
 <ul class="empinfo">
 <li class="name" style="display:inline;">  <asp:Label ID="Label_EmpName" runat="server"    Text='<%# Eval("[Employee Name]") %>'   ToolTip="Employee Name"></asp:Label></li> <span class="splt">|</span> 
<li style="display:inline;"><asp:Label ID="Designation_NameLabel" runat="server" style="color:#c60c0c; font-weight:bold;"  Text='<%# Bind("Designation_Name") %>'></asp:Label> <asp:Label ID="Designation_NameLabel0" Visible="false" runat="server"  Text='<%# Convert.ToString("( ")+ Convert.ToString(Eval("SubDept_Name"))+Convert.ToString(" )") %>'></asp:Label></li><span class="splt">|</span>
<li class="div" style="display:inline;"><asp:Label ID="Designation_NameLabel1" runat="server" Text='<%# Eval("Dept_Name") %>'  ></asp:Label></li><span class="splt">|</span> 
<li style="display:inline;"> Emp #  <strong><asp:Label ID="RegistrationNo" runat="server" Text='<%# Eval("EmpNo") %>'  ToolTip="Patient Registration Number"></asp:Label></strong>
<span class="spl">|</span>
Join Date : <strong><asp:Label ID="Label_JoinDate" runat="server" Text='<%# Bind("JoinDate") %>' ToolTip="Patient Age"></asp:Label></strong>
<span class="spl">|</span>
 <strong><asp:Label ID="Label_CNIC" runat="server"  Visible="false"  Text='<%# Eval("CNIC") %>' ToolTip="Identity Card #"></asp:Label></strong>
 
<strong><asp:Label ID="LabelGender" Visible="false" runat="server"  Text='<%# Eval("Gender") %>' ToolTip="Patient Gender"></asp:Label></strong>
  </li></ul>                                     


</td>
  </tr>
</table>
</div>
                        
                    </ItemTemplate>
                </asp:FormView>
                
                
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


</div>  
        </div>  



 <div class="bxmain">
  <table cellpadding="0" cellspacing="0" border="0" width="100%" class="table" >
  <tr>
    <td align="right">Certification No :</td>
    <td width="18%">
      <asp:TextBox ID="TextBox_Certification_No"  runat="server" CssClass="input_txt" required    ></asp:TextBox><%--onkeypress="return isNumberKey(event)"--%>
    </td>

       <td align="right">Date From : </td>
    <td>
        <%--<igsch:webdatechooser id="WebDateChooser_Date_From" runat="server" CssClass="drop_date" Width="202px" ></igsch:webdatechooser>--%>
        <asp:TextBox ID ="WebDateChooser_Date_From" runat="server" TextMode="Date" Width="202px" required>      </asp:TextBox>
<asp:Label ID="Label2" runat="server" ForeColor="Red" Text="*" Visible="false"></asp:Label>
<%--<asp:RequiredFieldValidator ID="RequiredFieldValidator_institution_name"  runat="server" ControlToValidate="TextBox_Institution_Name" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
<asp:Label ID="Label3" runat="server" ForeColor="Red" Text="*" Visible="false"></asp:Label><asp:HiddenField ID="HiddenField_Date_From" runat="server" /></td>
  </tr>
  <tr>
    <td align="right">Certification Name :</td>
    <td>
      <asp:TextBox ID="TextBox_certification_Name"  runat="server"  required CssClass="input_txt" onkeypress="return ValidateAlpha(event)" ></asp:TextBox>
      <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="*"></asp:Label>
      <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator_certification" runat="server"
          ControlToValidate="TextBox_certification_Name" ErrorMessage="*"></asp:RequiredFieldValidator>--%>
    </td>

       <td align="right">Date to : 
       
        
   </td>
    <td>
        <%--<igsch:webdatechooser  id="WebDateChooser_Date_To" runat="server" CssClass="drop_date" Width="202px" ></igsch:webdatechooser>--%>
        <asp:TextBox  id="WebDateChooser_Date_To" runat="server" Width="202px"  TextMode="Date" required>
        </asp:TextBox>
        <asp:Label ID="Label4" runat="server" ForeColor="Red" Text="*" Visible="false"></asp:Label>
        <asp:HiddenField ID="HiddenField_date_to" runat="server" /></td>
  </tr>
  <tr>
    <td align="right">Institution Name :</td>
    <td>
      <asp:TextBox ID="TextBox_Institution_Name"  runat="server" CssClass="input_txt" onkeypress="return ValidateAlpha(event)"  ></asp:TextBox>
    </td>

        <td align="right">
        Need Renewal:
    </td>
    <td>
          <asp:CheckBox ID="chkNeedRenuwal" runat="server" />
    </td>
  </tr>
        
  <tr>
      <td align="right">Detail :</td>
    <td>
      <asp:TextBox ID="TextBox_Detail" runat="server" CssClass="input_txt" Width="200px" Height="35px" TextMode="MultiLine"></asp:TextBox>
    </td>
    <td align="right">
        Expiry Date:
    </td>
    <td>
        <%--<igsch:webdatechooser id="WDC_ExpiryDate" runat="server" CssClass="drop_date" Width="202px" >
        </igsch:webdatechooser>--%>
        <asp:TextBox id="WDC_ExpiryDate" runat="server" CssClass="drop_date" Width="202px" TextMode="Date" required ></asp:TextBox>
         <asp:HiddenField ID="hdf_ExpiryDate" runat="server" />
      <td>
       
    </td>
  </tr>


  <tr>
    <td align="right">Certification Type :</td>
    <td  align="right">
      <asp:DropDownList Width="200px" ID="ddlCertificationType"  runat="server"></asp:DropDownList>
    </td>
      <td align="right">Attach Image :</td>
    <td><asp:FileUpload ID="FileUpload1" runat="server"  Height="20px"
               /></td>
  </tr>
      <tr>
          <td colspan="5" align="center" >
              <asp:Button CssClass="btn1" ID="Button_Save" runat="server" Text="Save" />      &nbsp;&nbsp;
          </td>
      </tr>
      
        
</table>
</div>


  
<br />
    
      <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                    DeleteCommand="DELETE FROM [Certification] WHERE [Employee_ID] = @Employee_ID AND [Certification_ID] = @Certification_ID"
                    InsertCommand="INSERT INTO Certification(Employee_ID, Certification, Date_From, Date_To, Institution, Detail, Certification_No, validity, Image_name, Image_URL, Need_renewal, expiry_date,Certificate_Type) VALUES (@Employee_ID, @Certification, @Date_From, @Date_To, @Institution, @Detail, @Certification_No, @validity, @Image_name, @Image_URL, @Need_renewal, @expiry_date,@CertificationType)"
                    UpdateCommand="UPDATE [Certification] SET [Certification] = @Certification, [Date_From] = @Date_From, [Date_To] = @Date_To, [Institution] = @Institution, [Detail] = @Detail WHERE [Employee_ID] = @Employee_ID AND [Certification_ID] = @Certification_ID">
                    <DeleteParameters>
                        <asp:Parameter Name="Employee_ID" Type="Int32" />
                        <asp:Parameter Name="Certification_ID" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Certification" />
                        <asp:Parameter Name="Date_From" />
                        <asp:Parameter Name="Date_To" />
                        <asp:Parameter Name="Institution" />
                        <asp:Parameter Name="Detail" />
                        <asp:Parameter Name="Employee_ID" />
                        <asp:Parameter Name="Certification_ID" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="emp" SessionField="Enter_emp_ID" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="ddlCertificationType" Name="CertificationType"
                            PropertyName="SelectedValue"  />                        
                        <asp:SessionParameter Name="Employee_ID" SessionField="Enter_emp_ID" />
                        <asp:ControlParameter ControlID="TextBox_certification_Name" Name="Certification"
                            PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="HiddenField_Date_From" Name="Date_From" PropertyName="Value"
                            Type="DateTime" />
                        <asp:ControlParameter ControlID="HiddenField_date_to" Name="Date_To" PropertyName="Value"
                            Type="DateTime" />
                        <asp:ControlParameter ControlID="TextBox_Institution_Name" Name="Institution" PropertyName="Text"
                            Type="String" />
                        <asp:ControlParameter ControlID="TextBox_Detail" Name="Detail" PropertyName="Text"
                            Type="String" />
                        <asp:ControlParameter ControlID="TextBox_Certification_No" Name="Certification_No"
                            PropertyName="Text" />
                        <asp:ControlParameter ControlID="TextBox_Validity" Name="validity" PropertyName="Text" />
                        <asp:ControlParameter ControlID="HiddenField_fileName" Name="Image_name" PropertyName="Value" />
                        <asp:ControlParameter ControlID="HiddenField_file_URL" Name="Image_URL" PropertyName="Value" />
                        <asp:ControlParameter ControlID="chkNeedRenuwal" Name="Need_renewal"
                            PropertyName="Checked" />
                        <asp:ControlParameter ControlID="hdf_ExpiryDate" Name="expiry_date"
                            PropertyName="Value" />
                    </InsertParameters>
                </asp:SqlDataSource>

  <asp:TextBox ID="TextBox_Validity" runat="server" CssClass="textbox_normal"  Width="250px" onactivate="this.className='textbox_focus';" ondeactivate="this.className='textbox_normal';" Visible="False"></asp:TextBox>
     <asp:Label ID="Label5" runat="server" ForeColor="Red" Text="Date From is Less Than Date To"
         Visible="False"></asp:Label>

<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  Width="100%"  >
            <Columns>
                <asp:BoundField DataField="Certification" HeaderText="Certification" SortExpression="Certification" >
                    <ControlStyle CssClass="txt_inside" Width="75px" />
                    
                </asp:BoundField>
                <asp:BoundField DataField="CertificationType" HeaderText="Type"   >
                    <ControlStyle CssClass="txt_inside" Width="75px" />
                    
                </asp:BoundField>                 
                <asp:BoundField DataField="Institution" HeaderText="Institution" SortExpression="Institution" >
                    <ControlStyle CssClass="txt_inside" Width="75px" />
                </asp:BoundField>
                <asp:BoundField DataField="Date_From" HeaderText="Date From" SortExpression="Date_From" >
                    <ControlStyle CssClass="txt_inside" Width="50px" />
                </asp:BoundField>
                <asp:BoundField DataField="Date_To" HeaderText="Date To" SortExpression="Date_To" >
                    <ControlStyle CssClass="txt_inside" Width="50px" />
                </asp:BoundField>
                <asp:BoundField DataField="Expiry_Date" HeaderText="Expiry Date"  >
                    <ControlStyle CssClass="txt_inside" Width="50px" />
                </asp:BoundField>


                <asp:HyperLinkField DataNavigateUrlFields="Image_URL" DataNavigateUrlFormatString="Documents/{0}"
                    DataTextField="Image_name" HeaderText="Images" Target="_blank" />
                <asp:HyperLinkField DataNavigateUrlFields="Certification_ID,Employee_ID" DataNavigateUrlFormatString="~/HR/Certification_view.aspx?Certification_ID={0}&amp;Employee_ID={1}"
                    HeaderText="View Detail" Text="View Detail" />
            </Columns>
              
               
                <AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>
                <asp:HiddenField ID="HiddenField_fileName" runat="server" />
                <asp:HiddenField ID="HiddenField_file_URL" runat="server" />
			<br />
            
           
</td>
</tr>
</table>
      
            
            
 </asp:Content>
 