<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="TotalServicesSumofPatients.aspx.cs" Inherits="DashBoards_TotalServicesSumofPatients" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       
       <div style="width: 100%" class="bxmain inner_content">
        <h2><span>Search Criteria</span></h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">

              <tr>
          <td style="padding-bottom: 10px; text-align: right;" width="41%">Hospital Name:

          </td>
          <td>
                 <asp:DropDownList ID="DropDownList_Hospital" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Hospital"
                DataTextField="Hospital_Name" DataValueField="Hospital_ID" Width="290px" style="text-transform:uppercase;">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>   
            </td> 
      </tr> 
            <tr>
                <td style="padding-bottom: 10px; text-align: right;" width="40%">From Date:
                </td>
                <td style="padding-bottom: 10px; text-align: left;" width="60%">
                    <asp:textbox id="txtDateFrom" runat="server" textmode="Date"></asp:textbox>
                    
                </td>
            </tr>
            <tr>
                <td style="padding-bottom: 10px;"" align="right">To Date:
                </td>
                <td style="padding-bottom: 10px;">

                    <asp:textbox id="txtDateTo" runat="server" textmode="Date"></asp:textbox>
                    
                </td>
            </tr>
            <tr>
                 <td style="padding-bottom: 10px;"" align="right">
                    Counter Type :</td>
                <td class="style2">
                   <asp:DropDownList ID="DDL_CounterType" runat="server" >
                    </asp:DropDownList>
                </td>
            </tr>
           
            <tr>
                 <td style="padding-bottom: 10px;"" align="right">
                     Patient Type:</td>
                <td class="style2">
                       <asp:DropDownList id="ddl_PatientType" DataTextField="Patient_type" AutoPostBack="true"  DataValueField="Patient_Type_ID" runat="server" DataSourceID="DataPatientType">
            
        </asp:DropDownList>
              <asp:SqlDataSource ID="DataPatientType" runat="server" 
                     ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
                     SelectCommand="select 0 as Patient_Type_ID, ' ---ALL---' Patient_type UNION select Patient_Type_ID,Patient_type  from Patient_type where Patient_type.Active=1 order by Patient_type ">
                 </asp:SqlDataSource>

                </td>
            </tr>
           
            <tr>
                 <td style="padding-bottom: 10px;"" align="right">
                     Parties :</td>
                <td class="style2">
               <asp:DropDownList ID="DropDownList_Parties" runat="server" AutoPostBack="false" 
                                                                    
                    DataSourceID="SqlDataSource_parties" DataTextField="Party_Name" 
                                                                    DataValueField="Party_Id">
                                                                </asp:DropDownList>
                                                                <asp:SqlDataSource ID="SqlDataSource_parties" runat="server" 
                                                                    
                                                                    
                    ConnectionString="<%$ ConnectionStrings:PatientBilllingConnectionString %>" 
                    SelectCommand="SELECT  0 as Party_Id, ' ---ALL---' Party_Name UNION  Select  Parties.Party_Id, Parties.Party_Name
FROM         Parties 
INNER JOIN   Patient_Billing_Party ON Parties.Party_Id = Patient_Billing_Party.Billing_Party_Id
order by Party_Name ">
                                                                </asp:SqlDataSource>

                </td>
            </tr>
           
            <tr>
              <td style="padding-bottom: 10px;" align="right">&nbsp;</td>
              <td style="padding-bottom: 10px;" align="left"> <asp:button id="Button1" runat="server" text="View Report" font-bold="True" font-size="Medium"
                        onclick="Button1_Click" /></td>             
          </tr>
        </table>
        </div>
       <br>
 

     
    <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
      <div style="width:100%">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px" >
    </rsweb:ReportViewer>
    </div>
</asp:Content>

