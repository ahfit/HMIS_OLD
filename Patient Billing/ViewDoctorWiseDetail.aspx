<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="~/Patient Billing/ViewDoctorWiseDetail.aspx.cs" Inherits="Patient_Billing_ViewDoctorWiseDetail" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
        }
    </script>
</asp:Content>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style=" padding-bottom:10p;"><span><h2>View Doctor Wise Patients</h2></span>
    <table width="100%">
          <tr>
            <td align="right">Hospital :</td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="202px" >
                    
                </asp:DropDownList> 
            </td>
        </tr>
        <tr>
            <td style="width:30% ;text-align:right;">
                <asp:Label ID="Label1" runat="server" Text="Employee Name"></asp:Label> </td>

             <td style="width:30% ;text-align:left;">
                    <asp:TextBox runat="server" ID="txtboxDoctorName" AutoPostBack="True" OnTextChanged="txtboxDoctorName_TextChanged"></asp:TextBox>
                     <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtboxDoctorName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList" 
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                    </asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfItemCode" runat="server" />
                    </td>
        </tr>
        <tr>
            <td style="width:30% ;text-align:right;">
                &nbsp;</td>

             <td style="width:30% ;text-align:left;">
                    &nbsp;</td>
        </tr>
        <tr>
            <td style="width:30% ;text-align:right;">
                &nbsp;</td>

             <td style="width:30% ;text-align:left;">
                    <asp:Button ID="Button1" runat="server" Text="Search"  OnClick="Button1_Click"/>
                    </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center;padding-top:10px;">

                <asp:Label ID="Lblmsg" Font-Size="Medium" runat="server" Visible="false" ForeColor="Red"></asp:Label>
                
            </td>
        </tr>


    </table>
    </div>
    <div style=" margin-top:10px;  padding-top:10px;"  class="bxmain inner_content"><span><h2>Patient's List</h2></span>

    <asp:GridView ID="gridviewEPLOYEE" runat="server" AutoGenerateColumns="false" OnRowCommand="gridviewEPLOYEE_RowCommand" >
        <Columns>

              <asp:TemplateField HeaderText="Category">
                                <ItemTemplate>
                                    <asp:LinkButton CommandName="ViewDetails" ID="lnkViewDetails" runat="server" Text =<%# Eval("Refer_Doctor_Name") %>></asp:LinkButton>
                                <asp:HiddenField ID="hdnDoctorNAme" runat="server"  Value='<%# Eval("Refer_Doctor_Name") %>' />
                                </ItemTemplate>
                               
               </asp:TemplateField>
             

                                 
            <asp:TemplateField HeaderText="Total Patients">
            <ItemTemplate>
                 <asp:Label ID="label1" Text='<%# Bind("TotalPatient") %>' runat="server" />
                </ItemTemplate>
                  </asp:TemplateField>
            
           
                 
             <%--  <asp:TemplateField HeaderText="Delete">
             <ItemTemplate>
                    <asp:LinkButton ID="del" Text="Delete" CommandName='<%# Bind("EmpID") %>' runat="server" OnClick="deleteRecord" > </asp:LinkButton>
                </ItemTemplate>
           
                 </asp:TemplateField>--%>
        </Columns>
       
       


        </asp:GridView>
        </div>


    </asp:Content>

