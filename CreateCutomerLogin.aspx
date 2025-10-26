<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="CreateCutomerLogin.aspx.cs" Inherits="CreateCutomerLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

<style type="text/css">


.tbl_form2c{border:0px; border-collapse:collapse; margin-top:0px; width:100%;   }
.tbl_form2c th {border:0px; border-collapse:collapse; height:24px; font-weight:bold; padding-right:5px;  }
.tbl_form2c tr {
	
	border:0px;
	border-collapse:collapse; 
	text-align:left; 
    /*line-height:30px;*/
}
.tbl_form2c tr td:first-child { width:40%; text-align:right; }	  
.tbl_form2c td {
	border:0px; 
	border-collapse:col;
	border-style: none;
	border-color: inherit;
	border-width: 0px;
	border-collapse:collapse;
	padding-left:5px; 	
	padding-top:2px;  	
	padding-bottom:2px;  	
	min-height:18px; 
	font-weight:normal; 	
	font-size:14px; 
	color:#333;

}


</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
               <div class="main-content" style="margin-left:0 !important;">
               
               <h3> Create Customer Login</h3>
               		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form2c">
  <tr>
    <td width="34%" align="right"> UserName :  </td>
    <td width="66%"> 
      <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right"> Password : </td>
    <td> 
      <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right"> Re-enter Password :</td>
    <td> 
      <asp:TextBox ID="txtreenterPassword" runat="server" TextMode="Password"></asp:TextBox>
    </td>
  </tr>
  <tr>
    <td align="right"> Company : </td>
    <td> 
    <asp:DropDownList ID="ddlCompany" runat="server" DataSourceID="sdsCompany"
                    DataTextField="Party_Name" DataValueField="Party_Id"> </asp:DropDownList>
    <asp:SqlDataSource ID="sdsCompany" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                    SelectCommand="SELECT Party_Id, Party_Name FROM Parties
where Party_Id not in (select Account_No from Finance.dbo.Group_Company_Branches)
and Party_Id not in (200270,
200272,
200273,
200274)
and Party_Name &lt;&gt;''
order by Party_Name"></asp:SqlDataSource>
    </td>
  </tr>
  <tr>
    <td align="right"> Expiry Policy : </td>
    <td> 
      <asp:DropDownList ID="ddlExpiryPolicy" runat="server">
        <asp:ListItem Text="30 days"></asp:ListItem>
        <asp:ListItem Text="60 days"></asp:ListItem>
        <asp:ListItem Text="90 days"></asp:ListItem>
        <asp:ListItem Text="Never"></asp:ListItem>
      </asp:DropDownList>
    </td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td> 
      <asp:Button ID="btnSave" runat="Server" Text="Create" OnClick="btnSave_Click" CssClass="btn btn-warning" />      
    </td>
  </tr>
                 </table>

               
  </div>       
               
               
            
    <asp:SqlDataSource ID="sdsInsertCustomerLogin" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>" 
        InsertCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>" InsertCommand="usp_Insert_Customer_Login"
        >
        <InsertParameters>
            <asp:ControlParameter ControlID="txtUserName" Name="User_Name" PropertyName="text"
                Type="string" />
            <asp:ControlParameter ControlID="hdfPassword" Name="Password" 
                Type="string" />
            <asp:ControlParameter ControlID="ddlCompany" Name="Company_Id" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="hdfExpiryPolicy" Name="Expiry_Policy" Type="String" />
            <asp:ControlParameter ControlID="hdfPEDate" Name="Password_Expiry_Date"  Type="String" />
        </InsertParameters>
        </asp:SqlDataSource>
     
     <asp:HiddenField runat="server" ID="hdfPEDate" />
     <asp:HiddenField runat="server" ID ="hdfExpiryPolicy" />
     <asp:HiddenField runat="server" ID="hdfPassword" />
</asp:Content>
