<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ApproveStaffLoanRequests.aspx.cs" Inherits="HR_ApproveStaffLoanRequests" MasterPageFile="~/hacims_masterpage_admin.master" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        //Confirmation fucntion in java script
        function confirmationApproval() {
            var radioButtons = document.getElementById('<%=radoApprovalStatus.ClientID %>');
            var txtval = ""
            var checlval = ""
            for (x = 0; x < radioButtons.length; x++)
            {

                if (radioButtons[x].checked) {
                    //if (radioButtons[x].value == "1")
                    //    checlval = "Approve";
                    //else
                    //    checlval = "Reject";

                    txtval = "Are you sure you want" + checlval + " loan request...";
                }
                else {
                    //if (radioButtons[x].value == "1")
                    //    checlval = "Approve";
                    //else
                    //    checlval = "Reject";
                    txtval = "Are you sure you want" + checlval + " loan request...";
                }
            }
            if (confirm("Are you sure you want to save??")) {
                    return true;
                } else {
                    return false;
                }
            }
    </script>
    <style type="text/css">
        .style1 {
            width: 410px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>
        <iframe id="frmPrint" name="IframeName" width="500" 
  height="200" runat="server" 
  style="display:none" ></iframe>
    <div class="bxmain inner_content" style="width: 100%">
        <h2><span> Loan Requests</span></h2>
        <br />

    <asp:GridView ID="gvList" runat="server" AutoGenerateColumns="False" 
        CssClass="Grid_1" Width="100%" AllowPaging="True" DataKeyNames="LoanID"
        PageSize="50" EnableModelValidation="True" EmptyDataText="No Record Found" EmptyDataRowStyle-Font-Size="X-Large" EmptyDataRowStyle-HorizontalAlign="Center" EmptyDataRowStyle-ForeColor="Maroon">
        <Columns>
            <asp:TemplateField  HeaderText="Application #">
                     <ItemTemplate>
                <asp:Label ID="lblApplicationId" runat="server" Text='<%# Bind("LoanID") %>'></asp:Label>   
                         <asp:HiddenField ID="HiddenField_EmpId" runat="server"  Value='<%# Eval("LoanEmpId") %>' />                        
                           <asp:HiddenField ID="HiddenField_ApporvedId" runat="server"  Value='<%# Eval("ApporvedId") %>' />                         
         </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>


            <asp:TemplateField  HeaderText="Employee">
                     <ItemTemplate>
                <asp:Label ID="lblEmployee" runat="server" Text='<%# Bind("Employee") %>'></asp:Label>   
         </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  HeaderText="Apply Date">
                     <ItemTemplate>
                <asp:Label ID="lblApplyDate" runat="server" Text='<%# Bind("ApplyDate") %>'></asp:Label>   
         </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  HeaderText="Loan Amount">
                     <ItemTemplate>
                <asp:Label ID="lblLoanAmount" runat="server" Text='<%# Bind("LoanAmount") %>'></asp:Label>   
         </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  HeaderText="Surity Employee">
                     <ItemTemplate>
                <asp:Label ID="lblSurityEmployee" runat="server" Text='<%# Bind("SurityEmployee") %>'></asp:Label>   
         </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  HeaderText="Installment">
                     <ItemTemplate>
                <asp:Label ID="lblInstallment" runat="server" Text='<%# Bind("Installment") %>'></asp:Label>   
         </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  HeaderText="Requested Month">
                     <ItemTemplate>
                <asp:Label ID="lblRequestedMonth" runat="server" Text='<%# Bind("StartMonthName") %>'></asp:Label>   
                         <asp:HiddenField ID="HfRequestedMonth" runat="server" 
                             Value='<%# Bind("RequestedMonth") %>' />
         </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField  HeaderText="Requested Year">
                     <ItemTemplate>
                <asp:Label ID="lblRequestedYear" runat="server" Text='<%# Bind("RequestedYear") %>'></asp:Label> 
                         <asp:HiddenField ID="HfRequestedYear" runat="server" 
                             Value='<%# Bind("RequestedYear") %>' />  
                         
         </ItemTemplate>
            </asp:TemplateField>

           <%-- <asp:BoundField DataField="ApprovedByHR" HeaderText="Approved By HR" SortExpression="ApprovedByHR" />
            <asp:BoundField DataField="ApprovedByFinance" HeaderText="Approved By Finance" SortExpression="ApprovedByFinance" />--%>
            <asp:TemplateField HeaderText="Action">
                    <ItemStyle Width="10%" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkApprove" CausesValidation="false" Text='Approve' CommandName='<%# Bind("LoanID") %>' 
                            runat="server" OnClick="lnkApprove_Click" ></asp:LinkButton>
                        <asp:HiddenField ID="HfJoinDate" runat="server" 
                             Value='<%# Bind("JoiningDate") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

    </div>

    

   <asp:Panel ID="pnl_Approval" runat="Server" CssClass="lightbox_bg" Visible="false">
        <div class ="lightbox">
            <div class="title-Model">Approve Loan Request</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr>
                    <td align="right">
                    <strong>Application No. :</strong></td>
                <td>
                    <asp:Label ID="lblApplicationNo" CssClass="label-bold" runat="server"></asp:Label>
                    
                  </td>
                    <td align="right">
                        <strong>Date Of Joining :</strong></td>
                  
                   
                <td> <asp:Label ID="lblDateOfJoining" CssClass="label-bold" runat="server"></asp:Label>
                  
                  </td>
                   
                </tr>

                <tr>
                   
                     <td align="right">
                      <strong>Employee :</strong></td>
                <td>
                    
                    <asp:Label ID="lblEmpName" CssClass="label-bold" runat="server"></asp:Label>
                    
                  </td>
                    
                     <td align="right">
                    <strong>Surity Employee :</strong></td>
                <td>
                    
                    <asp:Label ID="lblSurityEmployee"  CssClass="label-bold" runat="server"></asp:Label>
                  </td>
                </tr>
                <tr>
                    <td colspan="4">
                         <h3 class="title">
                             Loan Details
                             </h3>
                    </td>
                </tr>
                 <tr>
                       <td align="right">
                    <%--<strong>Total Gross Salary :</strong>--%>
                           <strong>Approval Status :</strong>
                       </td>
                <td>
                      <asp:RadioButtonList ID="radoApprovalStatus" RepeatDirection="Horizontal" runat="server" AutoPostBack="true">
                        <asp:ListItem Text="Approved" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Rejected" Value="0"></asp:ListItem>
                    </asp:RadioButtonList>
                     <asp:Label ID="lblTotalGrossSalary"  Visible="false" CssClass="label-bold" runat="server"></asp:Label>
                  </td>

                    <td align="right">
                        
                    </td>
                <td>
                  
                    
                  </td>
                </tr>
                <tr>
                     <td align="right" class="style1">
                    <strong>Total Loan Amount :</strong></td>
                <td >
                    <asp:TextBox ID="txtApproveLoanAmount" runat="server" SkinID="intdata"></asp:TextBox>
                    </td>
                    <td align="right" class="style1">
                    <strong>Monthly Installment :</strong></td>
                <td>
                    <asp:TextBox ID="txtApprovedInstallment" runat="server" SkinID="intdata"></asp:TextBox>
                    </td>
                </tr>

                <tr>
                  
                       <td align="right" class="style1"><strong>Start Year :</strong></td>

                    <td>
                         <asp:DropDownList ID="ddlYear" runat="server">
                       </asp:DropDownList>
                    </td>

                       <td align="right" class="style1"><strong>Start Month :</strong></td>
                <td>
                   <asp:DropDownList ID="ddlMonth" runat="server">
                       <asp:ListItem Value="1">January</asp:ListItem>
                    <asp:ListItem Value="2">February</asp:ListItem>
                    <asp:ListItem Value="3">March</asp:ListItem>
                    <asp:ListItem Value="4">April</asp:ListItem>
                    <asp:ListItem Value="5">May</asp:ListItem>
                    <asp:ListItem Value="6">Jun</asp:ListItem>
                    <asp:ListItem Value="7">July</asp:ListItem>
                    <asp:ListItem Value="8">August</asp:ListItem>
                    <asp:ListItem Value="9">September</asp:ListItem>
                    <asp:ListItem Value="10">October</asp:ListItem>
                    <asp:ListItem Value="11">November</asp:ListItem>
                    <asp:ListItem Value="12">December</asp:ListItem>
                   </asp:DropDownList>
                    
                </td>
                </tr>

               

                <tr>
                   
                    <td align="center" colspan="4">
                        <asp:Button Id="btnApprove" runat="server" Text="Save" OnClientClick="return confirmationApproval();" OnClick="btnApprove_Click"/>
                        <asp:Button Id="btnClose" runat="server" Text="Close" OnClick="btnClose_Click"/>
                    </td>
                </tr>
            </table>
            <br />
            <%--<asp:GridView ID="gvSessions" runat="server" AutoGenerateColumns="false" DataSourceID="sdsSessions" Width="90%" Visible="false">
            <Columns>
                <asp:TemplateField HeaderText="Sr #">
                    <ItemStyle Width="10%" />
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Title">
                    <ItemTemplate>
                        <asp:Label ID="lblTitle" Text='<%# Bind("Title") %>' runat="server" />
                         <asp:HiddenField ID="HfId" runat="server" Value='<%# Bind("ID") %>'/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Date">
                    <ItemTemplate>
                        <asp:Label ID="lblDate" Text='<%# Bind("StringDate") %>' runat="server" />
                        <asp:HiddenField ID="HfDate" runat="server" Value='<%# Bind("Date") %>'/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Facilitator">
                    <ItemTemplate>
                        <asp:Label ID="lblFacilitator" Text='<%# Bind("Facilitator") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" Text='<%# Bind("StringStatus") %>' runat="server" />
                        <asp:HiddenField ID="HfStatus" runat="server" Value='<%# Bind("Status") %>'/>
                    </ItemTemplate>
                </asp:TemplateField>--%>
                <%--<asp:TemplateField HeaderText="Update">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkUpdate" CausesValidation="false" Text="Update" CommandName='<%# Bind("ID") %>' runat="server" OnClick="lnkUpdateSession_Click"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Delete">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkDelete" CausesValidation="false" Text="Delete" CommandName='<%# Bind("ID") %>' runat="server" OnClick="lnkDeleteSession_Click"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>--%>


         <%--   </Columns>
        </asp:GridView>--%>
      
        </div>

    </asp:Panel>

    <asp:HiddenField ID="HfEmpId" runat="server"/>
    <asp:HiddenField ID="HFApporvedId" runat="server"/>

</asp:Content>

