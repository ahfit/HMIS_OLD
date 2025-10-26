<%@ Page Language="VB" AutoEventWireup="false"  MasterPageFile="~/hacims_masterpage.master" CodeFile="NursingOrderReception.aspx.vb" Inherits="NursingOrderReception" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<style type="text/css">

.input_txt {width:150px; }
.input_txt:focus {width:150px; }
</style>

<script src="../css_hacims/ck.js" type="text/javascript"></script>
<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr>
<td class="leftnav" valign="top" >
<asp:Label ID="LabelSideMenu" runat="server"></asp:Label>
 
</td>
<td  style="width:auto;" valign="top" >
     
     



<div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                      <!--DWLayoutTable-->
                      <tr>
                        <td align="right"  width="25%" >C.O.D. &nbsp;No.  :&nbsp;</td>
                        <td width="25%" ><asp:TextBox ID="TextBox1" runat="server" ></asp:TextBox></td>
     
                        <td align="right" width="25%"   > Registration No . :&nbsp; </td>
                        <td  width="25%" ><asp:TextBox ID="TextBoxRegNo" runat="server"  ></asp:TextBox></td>
      </tr>
                      <tr>
                        <td align="right"  > Patient First Name :</td>
                        <td ><asp:TextBox ID="TextBoxPFname" runat="server" ></asp:TextBox></td>
     
                        <td align="right" > Patient Middle Name :&nbsp; </td>
                        <td ><asp:TextBox ID="TextBoxPMName" runat="server" ></asp:TextBox></td>
      </tr>
                      <tr>
                        <td align="right"    > Patient Relation :&nbsp; </td>
                        <td  width="25%"><asp:TextBox ID="TextBoxRelation" runat="server" ></asp:TextBox></td>
      
                        <td align="right"    > Relation First Name :&nbsp; </td>
                        <td  ><asp:TextBox ID="TextBoxRFName" runat="server" ></asp:TextBox></td>
      </tr>
                      <tr>
                        <td align="right"    > Relation Middle Name :&nbsp; </td>
                        <td  ><asp:TextBox ID="TextBoxRMName" runat="server" ></asp:TextBox></td>
      
                        <td align="right"    > Patient Age :&nbsp;</td>
                        <td ><asp:TextBox ID="TextBoxAge" runat="server" ></asp:TextBox></td>
      </tr>
              <tr>
                <td colspan="4"  align="center"><asp:Button   ID="Search" runat="server" Text="Search" />                        
                <asp:Button  ID="Refresh" runat="server" Text="Refresh"  />
                    <asp:Button ID="btn_backpage" runat="server" Text="Physician Page" /></td>
        </tr>
    </table>
          </div>                                                                                                                                                                                                                                                                          
                                                                                                                                                                 
<br />

              <asp:GridView ID="GridView1" runat="server" AllowPaging="True"
                    AutoGenerateColumns="False" CssClass="Grid_1" DataKeyNames="PayID,RegNo" DataSourceID="SqlDataSourcePatients"
                    Width="100%" Visible="False">
                  <FooterStyle CssClass="GridPager" />                
                  <Columns>
                  <asp:HyperLinkField DataNavigateUrlFields="PayID,RegNo" DataNavigateUrlFormatString="historyexamination.spx?PayId={0}&amp;?RegNo={1}&amp;cmo=&quot;cmo&quot;"
                            Text="CMO" />
                  <asp:BoundField DataField="PayID" HeaderText="PayID" InsertVisible="False" ReadOnly="True"
                            SortExpression="PayID" />
                  <asp:BoundField DataField="RegNo" HeaderText="RegNo" ReadOnly="True" SortExpression="RegNo" Visible="False" />
                  <asp:BoundField DataField="PNAME" HeaderText="Patient Name" ReadOnly="True" SortExpression="PNAME" />
                  <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation" />
                  <asp:BoundField DataField="RNAME" HeaderText="Relative Name" ReadOnly="True" SortExpression="RNAME" />
                  </Columns>
                  <RowStyle CssClass="GridItem" />
                  <HeaderStyle CssClass="GridHeader" />                
                  <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSourcePatients" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    SelectCommand="SearchEmgDeptPatient" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE Forward_To_Sub_Dept SET status = 1 WHERE (Reg_No = @reg_no) AND (yearly_no = @yearly_no) AND (request_type_id = @request_type_id) AND (to_sub_Dept = @to_sub_dept) AND (Request_ID = @Request_ID)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                  <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenFieldSubDept" DefaultValue="2" Name="SubDeptNo"
                            PropertyName="Value" Type="Int32" />
                    <asp:ControlParameter ControlID="TextBox1" DefaultValue="0" Name="YearlyNo" PropertyName="Text"
                            Type="Decimal" />
                    <asp:Parameter DefaultValue="1" Name="request_type_id" Type="Int32" />
                    <asp:Parameter DefaultValue="0" Name="Status" Type="Boolean" />
                  </SelectParameters>
                  <UpdateParameters>
                    <asp:ControlParameter ControlID="HiddenField_regno" Name="reg_no" PropertyName="Value" />
                    <asp:ControlParameter ControlID="HiddenField_yearlyno" DefaultValue="" Name="yearly_no"
                            PropertyName="Value" />
                    <asp:Parameter DefaultValue="10" Name="request_type_id" />
                    <asp:Parameter DefaultValue="17" Name="to_sub_dept" />
                    <asp:ControlParameter ControlID="HiddenFieldrequestid" Name="Request_ID" PropertyName="Value" />
                  </UpdateParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldSubDept" runat="server" />
                
                <br />

                <asp:GridView ID="GridView2" runat="server" Width="100%" EmptyDataText="No data" AllowPaging="True" CssClass="Grid_1">
                  <RowStyle CssClass="GridItem" />
                  <HeaderStyle CssClass="GridHeader" />                
                  <AlternatingRowStyle CssClass="GridAltItem" />
                  <Columns>
                  <asp:HyperLinkField DataNavigateUrlFields="RegNo,PayID" DataNavigateUrlFormatString="WardOtComponent.aspx?regno={0}&amp;PayID={1}"
                            Text="See Orders" />
                  </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="[Search_Emg_Dept_Patient]"
                    SelectCommandType="StoredProcedure">
                  <SelectParameters>
                    <asp:Parameter DefaultValue="2" Name="SubDeptNo" Type="Int32" />
                    <asp:Parameter DefaultValue="false" Name="Status" Type="Boolean" />
                    <asp:ControlParameter ControlID="TextBox1" DefaultValue="" Name="YearlyNo" PropertyName="Text"
                            Type="Decimal" />
                    <asp:Parameter DefaultValue="1" Name="request_type_id" Type="Int32" />
                    <asp:ControlParameter ControlID="TextBoxPFname" DefaultValue="%%" Name="PFName" PropertyName="Text"
                            Type="String" />
                  </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenFieldpfname" runat="server" />
                <asp:HiddenField ID="HiddenField_yearlyno" runat="server" />
                <asp:HiddenField ID="HiddenField_regno" runat="server" />
                <asp:HiddenField ID="HiddenFieldrequestid" runat="server" />
                <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
                <asp:HiddenField ID="HiddenFieldPMName" runat="server" />
                <asp:HiddenField ID="HiddenFieldRelationFirstName" runat="server" />
                <asp:HiddenField ID="HiddenFieldRelation" runat="server" />
                <asp:HiddenField ID="HiddenFieldRMName" runat="server" />
                <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
                <asp:HiddenField ID="HiddenFieldAge" runat="server" />
           
              <asp:ImageButton ID="ImageButtonhome"  ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />
              <asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server" Visible="false" />
              <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/image_logout_up.gif" Visible="false" />
       
          
           
</td>
</tr>
</table>    
          <asp:Label ID="LabelFooter" runat="server" Text="Label"></asp:Label>
    </asp:Content>   