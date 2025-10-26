<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Cash_Reception.aspx.vb"  MasterPageFile="~/hacims_masterpage.master" Inherits="Cash_Reception" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


 

 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script language="javascript" type ="text/javascript" >
    function Validation()
    {
     var PFName = document.getElementById("textboxpfname").value;
     var PMName = document.getElementById("textboxpmname").value;
     var RFName = document.getElementById("textboxrfname").value;
     var RMName = document.getElementById("textboxrmname").value;
    if(document.getElementById("TextBox1").value.length !=0)
    {
        if(document.getElementById("TextBox1").value - 0  != document.getElementById("TextBox1").value)
        {
        alert("Enter Correct Yearly No.");
        document.getElementById("TextBox1").focus();
        return false;
        }
    }
    //alert("sdfs");
if(document.getElementById("textboxpfname").value.length!=0)
{
        for (i=0;i<PFName.length;i++)
          {
          if(PFName.charAt(i)>=0 || PFName.charAt(i)<=9)
           {
            alert("Integer not allowed in Patient First Name");
            document.getElementById("textboxpfname").focus();
            return false;
           }
          }
  }
if(document.getElementById("textboxpmname").value.length!=0)
        {
        for (i=0;i<PMName.length;i++)
          {
          if(PMName.charAt(i)>=0 || PMName.charAt(i)<=9)
           {
            alert("Integer not allowed in Patient Last Name");
            document.getElementById("textboxpmname").focus();
            return false;
           }
          }
        }
        
if(document.getElementById("textboxrfname").value.length!=0)        
        for (i=0;i<RFName.length;i++)
          {
          if(RFName.charAt(i)>=0 || RFName.charAt(i)<=9)
           {
            alert("Integer not allowed in Patient Relative  First Name");
            document.getElementById("textboxrfname").focus();
            return false;
           }
          }
if(document.getElementById("textboxrmname").value.length!=0)
        {
        for (i=0;i<RMName.length;i++)
          {
          if(RMName.charAt(i)>=0 || RMName.charAt(i)<=9)
           {
            alert("Integer not allowed in Patient Relative Last Name");
            document.getElementById("textboxrmname").focus();
            return false;
           }
          }
        }


    }
    </script>
<form id="form1" runat="server">
  
  <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
  <tr>
                <th   align="right" width="25%"    >
                  Yearly No.  :</th>
                      <th width="25%"  align="left" ><asp:TextBox  ID="TextBox1" runat="server" Width="160px" ></asp:TextBox></th>
                      <th width="25%"  align="right" >Registration No . :
                      </th>
                      <th width="25%"  align="left" > 
                        <asp:TextBox  ID="TextBoxRegNo" runat="server" Width="160px" ></asp:TextBox>
                   </th>
                    </tr>
              <tr>
                <th align="right"    > First Name : </th>
                      <td  ><asp:TextBox  ID="TextBoxPFname" runat="server" Width="160px" ></asp:TextBox></td>
                      <td align="right"  > Last Name : </td>
                      <td  ><asp:TextBox  ID="TextBoxPMName" runat="server" Width="160px" ></asp:TextBox></td>
                </tr>
              <tr>
                <th align="right"    >Relation :</th>
                      <td colspan="3" ><asp:TextBox  ID="TextBoxRelation" runat="server" Width="160px"  Visible="false" ></asp:TextBox>
                        <asp:RadioButtonList ID="RBLrelation" runat="server" 
                        Font-Names="verdana, arial, helvetica, sans-serif" RepeatDirection="Horizontal"
                        TabIndex="9" Width="172px">
                          <asp:ListItem Selected="True">S/O</asp:ListItem>
                          <asp:ListItem>D/O</asp:ListItem>
                          <asp:ListItem>W/O</asp:ListItem>
                        </asp:RadioButtonList></td>
                </tr>
              <tr>
                <th align="right"   scope="row"> First Name : </th>
                      <td ><asp:TextBox  ID="TextBoxRFName" runat="server" Width="160px" ></asp:TextBox></td>
                      <td align="right" >Last Name :</td>
                      <td ><asp:TextBox  ID="TextBoxRMName" runat="server" Width="160px" ></asp:TextBox></td>
                </tr>
              <tr>
                <td height="35" colspan="4" align="center" >
                  <asp:Button ID="Search" runat="server" Text="Search" class="bt1upnew" onmousedown="this.className='bt1downnew'" onmouseover="this.className='bt1overnew'" onmouseout="this.className='bt1upnew'"/>            
                  <asp:Button ID="Refresh" runat="server" Text="Refresh" class="bt1upnew" onmousedown="this.className='bt1downnew'" onmouseover="this.className='bt1overnew'" onmouseout="this.className='bt1upnew'" />            
                  </td>
                    </tr>
            </table>
   

 
              <asp:GridView ID="GridView2" runat="server" Width="100%" AllowPaging="True" AutoGenerateColumns="False"  DataSourceID="SqlDataSource1" Visible="False">
                <Columns>
                  <asp:ButtonField CommandName="Select" Text="Pay Amount" />
                  <asp:BoundField DataField="YearlyNO" HeaderText="Yearly No" SortExpression="YearlyNO" />
                  <asp:BoundField DataField="RegNo" HeaderText="Registration No" SortExpression="RegNo" />
                  <asp:BoundField DataField="Patient Name" HeaderText="Patient Name" SortExpression="Patient Name" />
                  <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation" />
                  <asp:BoundField DataField="Relation Name" HeaderText="Relation Name" SortExpression="Relation Name" />
                  <asp:BoundField DataField="Patient Age" HeaderText="Patient Age" SortExpression="Patient Age" />
                  </Columns>
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
        

              <asp:GridView ID="GridView1" runat="server" Width="100%" EmptyDataText="no"  >
                <Columns>
                  <asp:HyperLinkField DataNavigateUrlFields="YearlyNo,Regno" DataNavigateUrlFormatString="patientMRI.aspx?PayId={0}&amp;RegNo={1}"
                            Text="Add Results" Visible="False" />
                  <asp:ButtonField CommandName="Select" Text="Pay Amount" Visible="False" />
                  </Columns>
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
              <asp:HiddenField ID="HiddenFieldpfname" runat="server" />
              <asp:SqlDataSource ID="SqlDataSource_Patients" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>"
                    SelectCommandType="StoredProcedure">                </asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldSubDept" runat="server" />
              <asp:SqlDataSource ID="SqlDataSourcePatients" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString2 %>"
                    SelectCommand="SearchEmgDeptPatient" SelectCommandType="StoredProcedure">
                <SelectParameters>
                  <asp:ControlParameter ControlID="HiddenFieldSubDept" DefaultValue="23" Name="SubDeptNo"
                            PropertyName="Value" Type="Int32" />
                  <asp:Parameter DefaultValue="0" Name="status" />
                  <asp:ControlParameter ControlID="TextBox1" DefaultValue="0" Name="YearlyNo" PropertyName="Text"
                            Type="Decimal" />
                  <asp:Parameter DefaultValue="12" Name="request_type_id" Type="Int32" />
                  </SelectParameters>
                </asp:SqlDataSource>
               <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString2 %>"
                    SelectCommand="Search_Patients_for_Amount" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
              <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
              <asp:HiddenField ID="HiddenFieldPMName" runat="server" />
              <asp:HiddenField ID="HiddenFieldRelationFirstName" runat="server" />
              <asp:HiddenField ID="HiddenFieldRelation" runat="server" />
              <asp:HiddenField ID="HiddenFieldRMName" runat="server" />
              <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
              <asp:HiddenField ID="HiddenFieldAge" runat="server" />
              
                <asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false"  />            
                 
                  <asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server" Visible="false"  />            
                  
                    <asp:ImageButton ID="ImageButtonlogout" runat="server" ImageUrl="images/image_logout_up.gif" Visible="false" />            <asp:TextBox ID="TextBoxAge" runat="server"  Width="160px" Visible="False"></asp:TextBox>
                  
          </form>        
  </asp:Content>