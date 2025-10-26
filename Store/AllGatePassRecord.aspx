<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Store_AllGatePassRecord, App_Web_tnnmgguv" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            height: 24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table class="inner_content">
        <tr>
             <td>&nbsp;</td>
             
            <td align="right"><strong>From Date :</strong></td>
            <td> 
                

                    <igsch:WebDateChooser Width="180px" ID="WebDateChooser_Fromdate" runat="server">
                     <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                    </igsch:WebDateChooser>
                    
                   <asp:HiddenField ID="HiddenFieldFromDate" runat="server" />
                    
                   </td>
        </tr>
        <tr>
             <td>&nbsp;</td>
            <td align="right"><strong>To Date :</strong></td>
            <td>
                    <igsch:WebDateChooser Width="180px" ID="WebDateChooserToDate" runat="server">
                     <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                    </igsch:WebDateChooser>
                   <asp:HiddenField ID="HiddenFieldToDate" runat="server" />
                </td>
        </tr>
        <tr>
             <td>&nbsp;</td>
            <td align="right" class="auto-style1">R<strong>eturnable / Non Returnable Type :</strong></td>
            <td class="auto-style1">
                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem Selected="True" >All</asp:ListItem>
                    <asp:ListItem>Returnable</asp:ListItem>
                    <asp:ListItem>Non Returnable</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
              <td>&nbsp;</td>
            <td>
                       <asp:Button ID="Button_Report" runat="server" Text="View Report" OnClick="Button_Report_Click"/>
                   </td>
        </tr>
     
        
    </table>

    <div>
        <table>
           <tr>
            <td colspan="2">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
                
                       
                    <Columns>
                        <asp:TemplateField HeaderText="GatePass Date">
                          <ItemTemplate>
                                  <asp:Label ID="lbldate" Text='<%# Bind("Gate_PassDate") %>' runat="server" />
                               </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="GatePass #">
                          <ItemTemplate>
                                  <asp:Label ID="groupLabel" Text='<%# Bind("G_PassNO") %>' runat="server" />
                               </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Reference #" >
                          <ItemTemplate>
                                  <asp:Label ID="groupLabel1" Text='<%# Bind("ReferenceNo") %>' runat="server" />
                               </ItemTemplate>
                        </asp:TemplateField>

                          <asp:TemplateField HeaderText="Transporter" >
                          <ItemTemplate>
                                  <asp:Label ID="groupLabel2" Text='<%# Bind("Transporter") %>' runat="server" />
                               </ItemTemplate>
                        </asp:TemplateField>

                          <asp:TemplateField HeaderText="Vehicle #" >
                          <ItemTemplate>
                                  <asp:Label ID="groupLabel3" Text='<%# Bind("Vehicle_No") %>' runat="server" />
                               </ItemTemplate>
                        </asp:TemplateField>

                          <asp:TemplateField HeaderText="Transfer From" >
                          <ItemTemplate>
                                  <asp:Label ID="groupLabel4" Text='<%# Bind("Trv_From") %>' runat="server" />
                               </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Transfer To" >
                          <ItemTemplate>
                                  <asp:Label ID="groupLabel5" Text='<%# Bind("Trv_To") %>' runat="server" />
                               </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Reason" >
                          <ItemTemplate>
                                  <asp:Label ID="groupLabel6" Text='<%# Bind("Reason") %>' runat="server" />
                               </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Type" >
                          <ItemTemplate>
                                  <asp:Label ID="groupLabel7" Text='<%# Bind("Type") %>' runat="server" />
                               </ItemTemplate>
                        </asp:TemplateField>
                        

                       <asp:HyperLinkField  HeaderText="Status" DataNavigateUrlFields="G_PassNO"  
                           DataNavigateUrlFormatString="~\Store\Approve_RequisitionForGatePass.aspx?G_PassNO={0}" 
                           DataTextField="Workflow_Process"
                           Target="_blank" />
                </Columns>

        </asp:GridView>
        
            </td>
        </tr>
        </table>

    </div>

</asp:Content>

