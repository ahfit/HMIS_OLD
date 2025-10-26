<%@ Page Title="" Language="C#" MasterPageFile="~/customer_masterpage.master" AutoEventWireup="true" CodeFile="~/Pathology/SearchCorporateLabPatient.aspx.cs" Inherits="Pathology_SearchCorporateLabPatient" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content" style="width:100%"><span><h2>Search Estimate Bill Detail</h2></span>
    <table class="diagnosis_list">
       <tr>
                <td align="right" width="50%">
                    Start Date :
                </td>
                <td>
                    <igsch:webdatechooser Width="180px" ID="startDateChooser" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:webdatechooser>
                    <asp:HiddenField ID="HiddenField_StartDate" runat="server" />
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="right">
                    End Date :
                </td>
                <td colspan="2">
                    <igsch:webdatechooser Width="180px" ID="endDateChooser" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:webdatechooser>
                    <asp:HiddenField ID="HiddenField_EndDate" runat="server" />
                </td>
            </tr>
            <tr>
            <td align="right">Reg No:</td>
            <td colspan="2"><asp:TextBox ID="txtRegNo" runat="server" style="width:177px;"></asp:TextBox> </td>

            </tr>
          <tr>
            <td align="right">Reference #:</td>
            <td colspan="2"><asp:TextBox ID="txtReference" runat="server" style="width:177px;"></asp:TextBox> </td>

            </tr>
            <tr style="display:none">
            <td align="right">Yearly No:</td>
            <td colspan="2"><asp:TextBox ID="txtVisitNo" runat="server" style="width:177px;"></asp:TextBox> </td>

            </tr>
        <tr>
            <td>&nbsp;</td>
            <td colspan="2">
                <asp:Button ID="btn_Search" runat="server" Text="Search" OnClick="btn_Search_Click"
                   />
                
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        </table>
        </div>
        <div>
                  <asp:GridView ID="GridView1" runat="server" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging"
                        EmptyDataText="No data" Width="100%" PageSize="25"   AllowSorting="true" AutoGenerateColumns="false" >
                    
                  <Columns>
                       <asp:TemplateField  >
                          <ItemTemplate >
                              
                              <asp:HiddenField ID="hfRegNo" runat="server" Value='<%#Eval("Reg_No") %>' /> 
                               <asp:HiddenField ID="hfYearly" runat="server" Value='<%#Eval("PayID")%>' /> 
                               <asp:HiddenField ID="hfMain_ID" runat="server" Value='<%#Eval("Main_ID")%>' /> 
                               <asp:HiddenField ID="hfLab_No" runat="server" Value='<%#Eval("Lab_No")%>' /> 
                               <asp:HiddenField ID="hfPatient" runat="server" Value='<%#Eval("Patient_Name")%>' /> 
                              <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Eval("Grid_Title")%>' PostBackUrl='<%# Eval("URL") %>'
                                  ></asp:LinkButton >
                          </ItemTemplate>
                      </asp:TemplateField>
                      
                      <asp:BoundField DataField="Lab_No" HeaderText="Lab #" SortExpression="Lab_No" />
                      <asp:BoundField DataField="Reg_No" HeaderText="Mr #" SortExpression="Reg_No" />
                      <asp:BoundField DataField="Patient_Name" HeaderText="Patient" SortExpression="Patient_Name" />
                      <asp:BoundField DataField="Relation" HeaderText="Relation" SortExpression="Relation" />
                      <asp:BoundField DataField="Relation_Name" HeaderText="Relation Name" SortExpression="Relation_Name" />
                      <asp:BoundField DataField="Age" HeaderText="Age" SortExpression="Age" />
                      <asp:BoundField DataField="Requested_Date" HeaderText="Requested Date" SortExpression="Requested_Date" />
                      <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
                      <asp:BoundField DataField="Patient_Type" HeaderText="Patient_Type" SortExpression="Patient_Type" />
                      <asp:BoundField DataField="Collected_At" HeaderText="Collected At" SortExpression="Collected_At" />
                     
                  </Columns><RowStyle CssClass="GridItem" />
<AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />

                  </asp:GridView>
                    <asp:HiddenField runat="server" id = "HF_Status"></asp:HiddenField>  
            </div>
</asp:Content>

