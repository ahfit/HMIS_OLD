<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Designation, App_Web_pvcsvhw1" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

   
<script type="text/javascript" src="jquery.tablesorter.min.js"></script>




 

<script type="text/javascript">

$(document).ready(function() 
    { 
        $("#ctl00_ContentPlaceHolder1_GridView1").tablesorter(); 
		 
    } 
); 
  
</script>

  <script language="javascript" type="text/javascript">
 $(document).ready(function(e) {
     
	
	$("#ctl00_ContentPlaceHolder1_save").click(function(){
		
		if($("#ctl00_ContentPlaceHolder1_TextBox_DesignationName").val()==""){
			
			
			alert("Please Enter Designation Name");
			$("#ctl00_ContentPlaceHolder1_TextBox_DesignationName").focus();
			return false;
			}
		
	 	 
		})
	 
})	
  
</script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


 
 
<div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                
                 
                  <tr>
                    <td width="40%"  align="right"  >Designation Name  : </td>
                              <td width="60%"  ><asp:TextBox ID="TextBox_DesignationName" runat="server" Width="250px" Style="background-color: #f9dde2;"  ></asp:TextBox>
                                  <asp:Button ID="ButtonSearch" runat="server"  Text="Search" /></td>
      </tr>
                  <tr>
                    <td align="right"  >Minimum Pay Scale   : </td>
                      <td ><asp:TextBox ID="TextBox_PayScale" runat="server" Width="250px"  ></asp:TextBox></td>
                    </tr>
                  <tr>
                    <td align="right"  ><!--DWLayoutEmptyCell-->&nbsp;</td>
                    <td ><asp:Button  ID="save" runat="server" Text="Save" /> &nbsp; <asp:Label ID="LabelMessage" runat="server" Visible="False"></asp:Label>                   </td>
                  </tr>
                   
                  
                  
                  </table></div><br />
<asp:SqlDataSource ID="SqlDataSourceInsert" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                              InsertCommand="INSERT INTO Designation(Designation_Name, Min_PayScale) VALUES (@DesignationName, @MinPayScale)"
                              ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
              <InsertParameters>
                <asp:ControlParameter ControlID="TextBox_DesignationName" Name="DesignationName" PropertyName="Text" />
                <asp:ControlParameter ControlID="TextBox_PayScale" Name="MinPayScale" PropertyName="Text" />
              </InsertParameters>
            </asp:SqlDataSource>

              <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Designation_ID" 
                  DataSourceID="SqlDataSourceGrid"   Width="100%">
                <Columns>
                    <asp:TemplateField>
                        <EditItemTemplate>
                           
                            <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.gif" />&nbsp;<asp:ImageButton
                                ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images/icon_err.gif" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            &nbsp;
                            <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images_hacims/icon_edit.gif"
                                OnClientClick="return confirmation_edit(this)" ToolTip="Edit" /><asp:ImageButton
                                    ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"
                                    OnClientClick="return confirmation(this)" ToolTip="Delete" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Designation_ID" HeaderText="Designation ID" Visible="false"
                        ReadOnly="True" SortExpression="Designation_ID" />
                    <asp:BoundField DataField="Designation_Name" HeaderText="Designation Name" SortExpression="Designation_Name" />
                    <asp:BoundField DataField="Min_PayScale" HeaderText="Min Pay Scale" SortExpression="Min_PayScale" />
                </Columns>
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />              
                <AlternatingRowStyle CssClass="GridAltItem" /><PagerStyle CssClass="GridPager"  />
              </asp:GridView>
                  <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                      DeleteCommand="DELETE FROM Designation WHERE (Designation_ID = @Designation_ID)"
                      ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                      SelectCommand="SELECT Designation_ID, Designation_Name, Min_PayScale, Designation_Type, Main_Cat, Dept_Id, Request_Forwarding FROM Designation&#13;&#10;WHERE Designation_Name like @Designation_Name" UpdateCommand="UPDATE Designation SET Designation_Name = @Designation_Name, Min_PayScale = @Min_PayScale WHERE (Designation_ID = @Designation_ID)">
                      <DeleteParameters>
                          <asp:ControlParameter ControlID="GridView1" Name="Designation_ID" PropertyName="SelectedValue" />
                      </DeleteParameters>
                      <UpdateParameters>
                          <asp:Parameter Name="Designation_Name" Type="String" />
                                                    <asp:Parameter Name="Min_PayScale" Type="String" />
                                                    <asp:Parameter Name="Designation_ID" Type="String" />

                          <%--<asp:ControlParameter ControlID="HiddenFieldDesignationName" Name="Designation_Name"
                              PropertyName="Value" />
                          <asp:ControlParameter ControlID="HiddenFieldPayScale" Name="Min_PayScale" PropertyName="Value" />
                          <asp:ControlParameter ControlID="HiddenFieldDesignationID" Name="Designation_ID"
                              PropertyName="Value" />--%>
                      </UpdateParameters>
                      <SelectParameters>
                          <asp:ControlParameter ControlID="HiddenField_Designation" Name="Designation_Name"
                              PropertyName="Value" />
                      </SelectParameters>
                  </asp:SqlDataSource>
                  <asp:HiddenField ID="HiddenFieldDesignationName" runat="server" />
                  <asp:HiddenField ID="HiddenFieldPayScale" runat="server" />
                  <asp:HiddenField ID="HiddenFieldDesignationID" runat="server" />
              <br />
    <asp:HiddenField ID="HiddenField_Designation" runat="server" />
<br />


  </asp:Content>