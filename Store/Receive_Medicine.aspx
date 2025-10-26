<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Receive_Medicine.aspx.vb" Inherits="Store_Receive_Medicine" MasterPageFile="~/hacims_masterpage_admin.master" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"> </asp:ScriptManager>--%>
  
      <DIV class="bxmain inner_content" style="width:100%;">
      <h2><span>Search / Receive Stock</span></h2>
        <TABLE class="tbl_form" cellSpacing=0 cellPadding=0 width="100%" border=0>
          <TBODY>

                <tr>
              <td align="right" width="40%">  Select Hospital :</td>
              <td width="60%">
                  <asp:DropDownList ID="DDL_Hospital" Enabled="false" runat="server" DataSourceID="SDS_Hospital" 
                DataTextField="Hospital_Name" DataValueField="Hospital_ID">
            </asp:DropDownList>
            <asp:SqlDataSource ID = "SDS_Hospital" runat = "server" 
                ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>



              </td>
            </tr>


            <TR>
              <TD align="right" width="40%">Order :</TD>
              <TD width="60%"><asp:DropDownList id="DropDownList_Order" runat="server">
                  <asp:ListItem Value="0">Pending</asp:ListItem>
                  <asp:ListItem Value="1">Complete</asp:ListItem>
                </asp:DropDownList></TD>
            </TR>
              <TR>
              <TD align="right" width="40%">Received Date From : </TD>
              <TD width="60%"><igsch:WebDateChooser id="WebDateChooser_date_from" runat="server"   Width="210px">
                  <CalendarLayout Culture="English (United Kingdom)"> </CalendarLayout>
                </igsch:WebDateChooser>
                </TD>
            </TR>
              <TR>
              <TD  align="right" width="40%">Received Date To : </TD>
              <TD  width="60%"><igsch:WebDateChooser id="WebDateChooser_date_To" runat="server"   Width="210px">
                  <CalendarLayout Culture="English (United Kingdom)"> </CalendarLayout>
                </igsch:WebDateChooser></TD>
            </TR>
              <tr>
                  <td align="right" width="40%">
                      Company :</td>
                  <td width="60%">
                      <asp:DropDownList ID="DDL_Company" runat="server" DataSourceID="SQL_Company" 
                          DataTextField="Party_Name" DataValueField="Party_Id">
                      </asp:DropDownList>
                      <asp:SqlDataSource ID="SQL_Company" runat="server" 
                          
                          SelectCommand="SELECT 0 AS Party_Id, '     All     ' AS Party_Name UNION SELECT DISTINCT parties.Party_Id, parties.Party_Name FROM Purchase_Order_Main INNER JOIN parties ON Purchase_Order_Main.Company_ID = parties.Party_Id order by  Party_Name" 
                          ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"></asp:SqlDataSource><a id="addlink0" class="add_link box" runat="server" 
                                    href="Admin_Pharmacy/Admin_Medicine.aspx">Add</a></td>
                      <asp:Label ID="Label3" runat="server"  style="color:#003399;" Text=""></asp:Label>
                  </td>
              </tr>
              <tr>
                  <td align="right" width="40%">
                      Department :</td>
                  <td width="60%">
                      <asp:DropDownList ID="DD_Department" runat="server" AutoPostBack="True" 
                          DataSourceID="SQL_Department" DataTextField="Dept_Name" 
                          DataValueField="Dept_ID">
                      </asp:DropDownList>
                      <asp:SqlDataSource ID="SQL_Department" runat="server" 
                          ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
                          
                          SelectCommand="SELECT 0 AS Dept_ID, 'ALL' AS Dept_Name UNION SELECT Dept_ID, Dept_Name FROM Department"></asp:SqlDataSource>
                  </td>
              </tr>
              <tr>
                  <td align="right" width="40%">
                      Sub Department :</td>
                  <td width="60%">
                      <asp:DropDownList ID="DD_Sub_Department" runat="server" AutoPostBack="True" 
                          DataSourceID="SubDepartment" DataTextField="SubDept_Name" 
                          DataValueField="SubDept_Id">
                      </asp:DropDownList>
                      <asp:SqlDataSource ID="SubDepartment" runat="server" 
                          ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
                          
                          SelectCommand="SELECT 0 AS SubDept_Id, 'ALL' AS SubDept_Name UNION SELECT SubDept_Id, SubDept_Name FROM SubDepartment WHERE (Dept_Id = @Dept_Id)">
                          <SelectParameters>
                              <asp:ControlParameter ControlID="DD_Department" Name="Dept_Id" 
                                  PropertyName="SelectedValue" />
                          </SelectParameters>
                      </asp:SqlDataSource>
                  </td>
              </tr>
              </TBODY>
             </table>
             </DIV> 
     
       
     <%-- <asp:UpdatePanel ID="up1" runat ="server" >--%>
    <ContentTemplate>
             <DIV class="bxmain inner_content" style="width:100%;">
              <TABLE class="tbl_form" cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <tr>
                  <td align="right" width="40%">
                      </td>
                  <td width="60%">
                      <asp:Button ID="Button_Seach" runat="server" Text="Search" />&nbsp;<asp:Button 
                          ID="btn_Report" runat="server" Text="Report" Visible="False" />
                     &nbsp; <asp:Label ID="Label2" runat="server" style="color:#CC0000;"></asp:Label>
                  </td>
              </tr>
                </TBODY>
                  <caption>
                      <br />
                      </TBODY>
                  </caption>
        </TABLE>      
           

           <%--
                   <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" 
                          AutoDataBind="true" DisplayGroupTree="False" DisplayToolbar="False" 
                          EnableDatabaseLogonPrompt="False" EnableParameterPrompt="False" />
               
         --%>
    
      <BR />
      <asp:GridView id="GridView1" runat="server" Width="100%" 
            AutoGenerateColumns="False" DataKeyNames="PO_ID" 
            DataSourceID="SqlDataSource_Select_Requisition" AllowPaging="True" PageSize="100">
        <RowStyle CssClass="GridItem"></RowStyle>
        <Columns>
        <asp:BoundField DataField="PO_ID" HeaderText="Purchase Order" ReadOnly="True" SortExpression="PO_ID"></asp:BoundField>
        <asp:BoundField DataField="Company Name" HeaderText="Company Name" SortExpression="Company Name"></asp:BoundField>
        <asp:BoundField DataField="Order Date Time" HeaderText="Order Date Time" SortExpression="Order Date Time"></asp:BoundField>
        <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject"></asp:BoundField>
            <asp:BoundField DataField="Total_Qty" HeaderText="Total Qty" 
                SortExpression="Total_Qty" />
            <asp:BoundField DataField="Total_Recieved" HeaderText="Total Recieved Qty" 
                SortExpression="Total_Recieved" />
        <asp:HyperLinkField DataNavigateUrlFields="PO_ID,Company Name" DataNavigateUrlFormatString="PurchaseRecieving.aspx?PO_ID={0}&amp;Comp_Name={1}" Text="Receive"></asp:HyperLinkField>
        <asp:HyperLinkField DataNavigateUrlFields="PO_ID" DataNavigateUrlFormatString="Received_Tag_No.aspx?PO_ID={0}" Text="View Items" Visible="false"></asp:HyperLinkField>
       <asp:HyperLinkField DataNavigateUrlFields="PO_ID" DataNavigateUrlFormatString="POWiseGRN.aspx?PO_ID={0}" Text="GRN" Target="_blank"></asp:HyperLinkField>
            <asp:HyperLinkField DataNavigateUrlFields="PO_ID,Company_ID" DataNavigateUrlFormatString="PurchaseReturn.aspx?PO_ID={0}&CID={1}" Text="Return" Target="_blank"></asp:HyperLinkField>
 
             </Columns>
        <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager"></FooterStyle>
        <PagerStyle HorizontalAlign="Center" CssClass="GridPager"></PagerStyle>
        <HeaderStyle CssClass="GridHeader"></HeaderStyle>
        <AlternatingRowStyle CssClass="GridAltItem"></AlternatingRowStyle>
      </asp:GridView>
      <BR />
      <asp:HiddenField id="HiddenField_Dept_ID" runat="server"></asp:HiddenField>
      <asp:HiddenField id="HiddenField_Emp_ID" runat="server"></asp:HiddenField>
        <asp:HiddenField ID="HiddenFieldSub_Dept_ID" runat="server" />
      <asp:SqlDataSource id="SqlDataSource_Select_Requisition" runat="server" 
            SelectCommandType="StoredProcedure" SelectCommand="Select_Receive_Medicine" 
            ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>">
        <SelectParameters>
            <asp:ControlParameter ControlID="DD_Department" Name="Dept_ID" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DDL_Company" Name="Company_id" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DD_Sub_Department" Name="SubDept_ID" 
                PropertyName="SelectedValue" />
          <asp:ControlParameter ControlID="DropDownList_Order" Name="Order_Complete" PropertyName="SelectedValue" />
          <asp:ControlParameter ControlID="HiddenField_from_date" Name="start_date" PropertyName="Value"
          Type="String" />
          <asp:ControlParameter ControlID="HiddenField_to_date" Name="end_Date" PropertyName="Value"
          Type="String" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="DDL_Hospital" Name="Hospital_ID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
      </asp:SqlDataSource>
      <asp:HiddenField id="HiddenField_from_date" runat="server"></asp:HiddenField>
      <asp:HiddenField id="HiddenField_to_date" runat="server"></asp:HiddenField>
    <%--  <DIV align=center>
        <asp:Button id="Button1" runat="server" Text="Back to Main"  Visible="False"></asp:Button>
      </DIV>--%>
    </ContentTemplate>
  <%--</asp:UpdatePanel>--%>
    </div>
</asp:Content>
