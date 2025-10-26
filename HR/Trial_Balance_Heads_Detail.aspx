<%@ page language="VB" autoeventwireup="false" inherits="audit_GeneralLedger, App_Web_ybbpntbq" masterpagefile="~/hacims_masterpage_admin.master" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>
   <%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <div align="right"> 
 <asp:Button ID="Btn_Print" runat="server" Text="Print" Visible="False"  />
  <asp:Button id="btnEExcel" runat="server" Text="Export To Excel"  Visible="False" />
  </div>     
<br />

        <asp:HiddenField ID="HiddenFieldEdate" runat="server" />
        <asp:HiddenField ID="HiddenFieldSdate" runat="server" />
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td align="center" colspan="3" >
                   <div class ="h1" width ="100%"><strong> 
                       <asp:Label ID="lbl_head_name" runat="server"></asp:Label> 
                   
                   </strong></div></td>
            </tr>
           
                 
            <tr>
                <td align="center" colspan="3" >
                    <div class="header" width="100%">
                        <strong><span class="bx_msg"> Duration :
                        <asp:Label ID="lbl_dates" runat="server"></asp:Label>
                        </span></strong>
                    </div>
                </td>
            </tr>
           
                 
            <tr>
                <td align="right" >
                    &nbsp;&nbsp;</td>
                <td colspan="2" >
                    &nbsp;</td>
            </tr>
           
                 
            <tr>
                <td align="right" >
                    <strong>
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" ForeColor="Blue" Text="Opening Balance"
                        Visible="False"></asp:Label>&nbsp;&nbsp;
                </strong></td>
                <td >
            <asp:Label ID="lbl_Dr" runat="server" Font-Bold="True" Text=" Dr : " Visible="False"></asp:Label><asp:Label
                        ID="lblOBDr" runat="server" Font-Bold="True" ForeColor="Black" Text="0" Visible="False"></asp:Label></td>
                <td >
                    <asp:Label ID="lbl_Cr" runat="server" Font-Bold="True" Text=" Cr : " Visible="False"></asp:Label><asp:Label
                        ID="lblOBCr" runat="server" Font-Bold="True" ForeColor="Black" Text="0" Visible="False"></asp:Label></td>
            </tr>
           
                 
        </table>
<br />
 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceforGrid"
            Visible="False" Width="100%" ShowFooter="True" EmptyDataText="No Record Found."
        EnableModelValidation="True" DataKeyNames="Voucher_Trans_Id" >
            <Columns>
                <asp:TemplateField HeaderText="S No">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
                <ItemStyle Width="30px" />
            </asp:TemplateField>
                <asp:BoundField DataField="For_Date" HeaderText="Date" SortExpression="For_Date" ItemStyle-Width="75px" />
                <asp:BoundField DataField="E_code" HeaderText="Code" SortExpression="E_code" />
                <asp:BoundField DataField="Voucher_No" HeaderText="Voucher#" SortExpression="Voucher_No" />
                <asp:BoundField DataField="E_Name" HeaderText="Account Head" SortExpression="E_Name" />
                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                <%--<asp:BoundField DataField="Cheq" HeaderText="Cheq/Inv#" SortExpression="Cheq" />--%>
                <asp:TemplateField HeaderText="Dr" ItemStyle-CssClass="AmountAlign" SortExpression="Dr">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Dr") %>'></asp:Label>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblDr" ForeColor="Red"  runat="server" Font-Bold="True" Text="0"></asp:Label>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="LabelDr"  runat="server" Text='<%# Eval("Dr","{0:#,#}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Cr" ItemStyle-CssClass="AmountAlign" SortExpression="Cr">
                    <EditItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Cr") %>'></asp:Label>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblCr" ForeColor="Red" runat="server" Font-Bold="True" Text="0"></asp:Label>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="LabelCr" runat="server" Text='<%# Eval("Cr","{0:#,#}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Balance" >
                    <ItemTemplate>
                        <asp:Label ID="lblbal" runat="server" Text='<%# Eval("balance") %>' ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField HeaderText="Print Voucher" SelectText="Print Voucher" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Center"
                    ShowSelectButton="True" />
                <%--<asp:BoundField DataField="Adjusted_Account_Head" HeaderText="" />--%>
                
               <%-- <asp:TemplateField HeaderText="Adjusted Account">
                    <ItemTemplate>
                        <asp:Label ID="ltrAdjAccount" runat="server" Text='<%# Bind("Adjusted_Account_Head") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>--%>
            </Columns><AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSourceforGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            SelectCommand="select abc.E_Name,abc.E_Code,convert(varchar,abc.For_Date,106) For_Date,abc.Voucher_Trans_Id, '' as Voucher_No,abc.Dr,abc.Cr,abc.Description,SUM(abc.Dr) over(order by abc.Dr asc ) as balance

 from (
SELECT     Expenditure.E_Name, Expenditure.E_Code, SUM((CASE WHEN Reciept_Disbursement_Detail.Cr_Dr_Action_Id = 1 THEN isnull(Reciept_Disbursement_Detail.Amount, 
                      0) ELSE 0 END)) AS Dr, SUM((CASE WHEN Reciept_Disbursement_Detail.Cr_Dr_Action_Id = 2 THEN isnull(Reciept_Disbursement_Detail.Amount, 0) 
ELSE 0 END)) 
                      AS Cr,  Receipt_Disbursement_AccountHeads.For_Date AS For_Date, Reciept_Disbursement_Detail.Description,Receipt_Disbursement_AccountHeads.Voucher_Trans_Id
					  ,Receipt_Disbursement_AccountHeads.For_Date as for_date2
FROM         Reciept_Disbursement_Detail INNER JOIN
                      Expenditure ON Reciept_Disbursement_Detail.Account_Head_id = Expenditure.E_Code INNER JOIN
                      Receipt_Disbursement_AccountHeads ON Reciept_Disbursement_Detail.Voucher_Trans_Id = Receipt_Disbursement_AccountHeads.Voucher_Trans_Id
WHERE     (Receipt_Disbursement_AccountHeads.For_Date BETWEEN @S_Date AND @E_Date) AND (Reciept_Disbursement_Detail.Account_Head_id = @E_Code)
           And (Receipt_Disbursement_AccountHeads.Financial_Company_Id=@Financial_Company_Id) and (@Company_Branch_Id =0 OR Receipt_Disbursement_AccountHeads.Company_Branch_Id=@Company_Branch_Id)
GROUP BY Expenditure.E_Name, Expenditure.E_Code, CONVERT(varchar, Receipt_Disbursement_AccountHeads.For_Date, 103), Reciept_Disbursement_Detail.Description, 
                        Receipt_Disbursement_AccountHeads.Voucher_Trans_Id,Receipt_Disbursement_AccountHeads.For_Date)abc
ORDER BY abc.for_date2 asc" 
            
        ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:QueryStringParameter Name="E_Code" QueryStringField="E_Code" />
                <asp:SessionParameter Name="S_Date" SessionField="Sdate" />
                <asp:SessionParameter Name="E_Date" SessionField="Edate" />
                <asp:SessionParameter Name="Financial_Company_Id" SessionField="FCID" />
                <asp:SessionParameter Name="Company_Branch_Id" SessionField="CBID" />
            </SelectParameters>
        </asp:SqlDataSource>


</asp:Content>
