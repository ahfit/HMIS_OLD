<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Total_Ward_Addmission.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Omer_Reports_TotalWardAddmission" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<div class="bxmain inner_content" style="width:100%;">
    <h2><span>Ward Admission</span></h2>
 <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
  <tr>
    <td width="40%" align="right"> Addmission From : </td>
    <td width="60%"><igsch:WebDateChooser ID="WebDateChooserStart" runat="server" Width="202px" CssClass="drop_date" > 
    <CalendarLayout Culture="English (United Kingdom)">
    </CalendarLayout>
</igsch:WebDateChooser></td>
  </tr>
  <tr>
    <td align="right"> Addmission To :  </td>
    <td><igsch:WebDateChooser ID="WebDateChooserEnd" runat="server" Width="202px" CssClass="drop_date" > 
    <CalendarLayout Culture="English (United Kingdom)">
    </CalendarLayout>
</igsch:WebDateChooser></td>
  </tr>
  <tr style ="display:none">
    <td align="right"> Patient Type : </td>
    <td> 
      <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatColumns="2" RepeatDirection="Horizontal"
         RepeatLayout="Flow"  >
        <asp:ListItem Value="0">General</asp:ListItem>
        <asp:ListItem Value="1">Cardiac</asp:ListItem>
      </asp:RadioButtonList>
    </td>
  </tr>
  <tr>
    <td align="right">&nbsp;</td>
    <td> 
      <asp:Button ID="Button1" runat="server" Text="Show " CssClass="btn1" />      
      <asp:Button ID="Button_export" runat="server" Text="Export To Excel " CssClass="btn1" />      

    </td>
  </tr>
     <tr>
  
    <td colspan="2" align="center"> 
      <asp:Label ID="lblTotalRecords" runat="server" Font-Bold="true" ForeColor="Green"></asp:Label>     

    </td>
  </tr>
</table></div>



 <br />


                                    <asp:GridView ID="GridView1" runat="server" CssClass="Grid_1" Width="100%" AutoGenerateColumns="False">
                                        <HeaderStyle CssClass="GridHeader" />
                                        <AlternatingRowStyle CssClass="GridAltItem" />
                                        <Columns>
                                            <asp:BoundField DataField="Sr.No." HeaderText="Sr.No." SortExpression="Sr.No." />
                                            <asp:BoundField DataField="RegNo" HeaderText="Registration" SortExpression="RegNo" />
                                           
                                           
                                            <asp:BoundField DataField="Prefix" HeaderText="Prefix" SortExpression="Prefix" />
                                            <asp:BoundField DataField="PFName" HeaderText="PFName" SortExpression="PFName" />
                                            <asp:BoundField DataField="PMName" HeaderText="PMName" SortExpression="PMName" />
                                            <asp:BoundField DataField="PLName" HeaderText="Patient Name" SortExpression="PLName" />
                                            <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation" />
                                             <asp:BoundField DataField="RelationName" HeaderText="Relation Name" SortExpression="RelationName" />
                                             <asp:BoundField DataField="Room" HeaderText="Room" SortExpression="Room" />
                                            <asp:BoundField DataField="PatID" HeaderText="File No" SortExpression="PatID" />
                                             <asp:BoundField DataField="Floor" HeaderText="Floor" SortExpression="Floor" />
                                            <asp:BoundField DataField="Consultant Name" HeaderText="Consultant Name" SortExpression="Consultant Name" />
                                            <asp:BoundField DataField="Admission" HeaderText="Admission" SortExpression="Admission" />
                                            <asp:BoundField DataField="Amount" HeaderText="Advance Amount" SortExpression="Amount" />
                                            <asp:BoundField DataField="Admitby" HeaderText="Admitted by" SortExpression="Admitby" />
                                            <asp:BoundField DataField="Discharge" HeaderText="Discharge Date" SortExpression="Discharge" />
                                              <asp:BoundField DataField="PStatus" HeaderText="Patient Status" SortExpression="PStatus" />
                                            <asp:BoundField DataField="Dischargeby" HeaderText="Discharge By" SortExpression="Dischargeby" />
                                           
                                        </Columns>
                                    </asp:GridView>        <asp:HiddenField ID="HiddenFieldStartDate" runat="server" />
                        <asp:HiddenField ID="HiddenFieldEndDate" runat="server" />




          <br />
<br />

<asp:Label ID="Label_Message" runat="server" CssClass="err" ></asp:Label><br />
<br />

  </asp:Content>