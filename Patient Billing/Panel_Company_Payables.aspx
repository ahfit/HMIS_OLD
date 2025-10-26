<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Panel_Company_Payables.aspx.cs" Inherits="Patient_Billing_Panel_Company_Payables" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>


<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

   <asp:Content ID="Content2" ContentPlaceHolderID="head" runat="Server">
   </asp:Content>
   <asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


     <asp:ScriptManager ID="ScriptManager2" runat="server">
    </asp:ScriptManager>

 <div class="bxmain">
         <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
           <tr>
            <td align="right">
                Select Company :
            </td>
            <td>
                <asp:DropDownList ID="DropDownList_Parties" runat="server" DataValueField="Party_Id"
                    DataTextField="Party_Name" DataSourceID="SqlDataSource_parties" AutoPostBack="false">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource_parties" runat="server" ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>"
                    SelectCommand="select ' ----All----' Party_Name  , 0   Party_Id  UNION SELECT     Parties.Party_Name,Parties.Party_Id  FROM Parties INNER JOIN
                                    Patient_Billing_Party ON Parties.Party_Id = Patient_Billing_Party.Billing_Party_Id">
                                           
                </asp:SqlDataSource>
             </td>
             </tr>

          <tr>
            <td width="25%" align="right">
                Start Date :
                </td>
            <td width="25%">
                <igsch:webdatechooser id="start_date" runat="server" CssClass="drop_date"></igsch:webdatechooser>
            </td>
            </tr>
        <tr>
       
            <td width="25%" align="right">
                Letter Date :</td>
            <td width="25%">
                <igsch:webdatechooser id="end_date" runat="server" CssClass="drop_date"></igsch:webdatechooser>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <asp:Button  ID="search" runat="server" Text="Search" OnClick="SearchEmployee_Click" />
            </td>
        </tr>
  
</table>

</div>

<div>
<asp:GridView ID="GridViewPatient" runat="server" AutoGenerateColumns="False" 
        onprerender="GridViewPatient_PreRender" ShowFooter="true" >
              <Columns>
                    <asp:BoundField DataField="Party_Name" HeaderText="Party Name" />
                  <asp:BoundField DataField="Prefix" HeaderText="Patient Name" />
                  <asp:BoundField DataField="S_Name" HeaderText="Service" />
                  <asp:TemplateField HeaderText="Amount">
                      <ItemTemplate>
                          <asp:Label ID="LabelAmount" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                          
                      </ItemTemplate>

                     
                       <FooterTemplate  >
                          <asp:Label ID="footerAmount" runat="server" Text="Total Amount" Font-Bold="true"></asp:Label>
                      </FooterTemplate>


                  </asp:TemplateField>
                  <asp:BoundField DataField="DateTime" HeaderText="Date" />
                 
              </Columns> 
              
</asp:GridView>
</div>



<div>
  <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%"  Height="500px">
    </rsweb:ReportViewer>
</div>




  </asp:Content>

