<%@ page language="VB" autoeventwireup="false" inherits="audit_GeneralLedger" masterpagefile="~/hacims_masterpage_admin.master" codeFile="~/Finance/Trial_Balance_Heads_Detail.aspx.vb"
    enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
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
                <td align="center" colspan="3" >
                    &nbsp;</td>
            </tr>
           
                 
            <tr>
                <td align="right" >
                    Parties :</td>
                <td colspan="2" >
                    <asp:DropDownList ID="DDL_Party" runat="server" DataSourceID="Sds_Parties" AutoPostBack="True" DataTextField="Party_Name" DataValueField="party_ID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="Sds_Parties" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>" SelectCommand="Select 0 party_ID,' --- All ---' As Party_Name
Union
Select Distinct party_ID,A.Account_Title As Party_Name from Reciept_Disbursement_Detail D
Inner Join Account_Titles A On D.Party_ID = A.Account_No
where Account_Head_ID = @Account_Head_ID">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="Account_Head_ID" QueryStringField="E_Code" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
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
            Visible="False" Width="100%" ShowFooter="True" EmptyDataText="No Record Found." DataKeyNames="Voucher_Trans_Id" >
            <Columns>
                <asp:TemplateField HeaderText="S No">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
                <ItemStyle Width="30px" />
            </asp:TemplateField>
                <asp:BoundField DataField="For_Date" HeaderText="Date" SortExpression="For_Date" ItemStyle-Width="75px" >
<ItemStyle Width="75px"></ItemStyle>
                </asp:BoundField>
                <asp:BoundField DataField="E_code" HeaderText="Code" SortExpression="E_code" />
                <asp:BoundField DataField="Voucher_No" HeaderText="Voucher#" SortExpression="Voucher_No" />
                <asp:BoundField DataField="E_Name" HeaderText="Account Head" SortExpression="E_Name" />
                <asp:BoundField DataField="Party_Name" HeaderText="Vendor/ Employee" SortExpression="Party_Name" />
                <asp:BoundField DataField="Cheque_No" HeaderText="Cheque No" SortExpression="Cheque_No" />
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
                        <asp:Label ID="LabelDr"  runat="server" Text='<%# Eval("Dr", "{0:#,##;(#,#)}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Right" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Cr" ItemStyle-CssClass="AmountAlign" SortExpression="Cr">
                    <EditItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Cr", "{0:#,##;(#,#)}") %>'></asp:Label>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblCr" ForeColor="Red" runat="server" Font-Bold="True" Text="0"></asp:Label>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="LabelCr" runat="server" Text='<%# Eval("Cr", "{0:#,##;(#,#)}") %>'></asp:Label>
                    </ItemTemplate>

<ItemStyle CssClass="AmountAlign"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Balance" >
                    <ItemTemplate>
                        <asp:Label ID="lblbal" runat="server" Text='<%# Eval("balance", "{0:#,##;(#,#)}") %>' ></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTBal" ForeColor="Red" runat="server" Font-Bold="True" Text="0"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:CommandField HeaderText="Print Voucher" SelectText="Print Voucher" ItemStyle-Width="90px" ItemStyle-HorizontalAlign="Center"
                    ShowSelectButton="True" >
<ItemStyle HorizontalAlign="Center" Width="90px"></ItemStyle>
                </asp:CommandField>
                <%--<asp:BoundField DataField="Adjusted_Account_Head" HeaderText="" />--%>
                
               <%-- <asp:TemplateField HeaderText="Adjusted Account">
                    <ItemTemplate>
                        <asp:Label ID="ltrAdjAccount" runat="server" Text='<%# Bind("Adjusted_Account_Head") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>--%>
            </Columns><AlternatingRowStyle CssClass="GridAltItem" />
        </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSourceforGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
            SelectCommand="select abc.E_Name,abc.E_Code,convert(varchar,abc.For_Date,106) For_Date,abc.Voucher_Trans_Id,abc.Voucher_No  as Voucher_No,abc.Dr,abc.Cr,abc.Description,SUM(abc.Dr) over(order by abc.Dr asc ) as balance,abc.Cheque_No, abc.Party_Name
from (
		SELECT E.E_Name, E.E_Code, SUM((CASE WHEN D.Cr_Dr_Action_Id = 1 THEN isnull(D.Amount, 0) ELSE 0 END)) AS Dr, SUM((CASE WHEN D.Cr_Dr_Action_Id = 2 THEN isnull(D.Amount, 0) ELSE 0 END)) AS Cr, H.For_Date, D.Description, H.Voucher_Trans_Id, H.For_Date AS for_date2, ISNULL(H.Voucher_No, '') AS Voucher_No, Isnull(A.Account_Title,'') As Party_Name,Max(D.Cheque_No) as Cheque_No
		FROM Reciept_Disbursement_Detail AS D INNER JOIN Expenditure AS E ON D.Account_Head_id = E.E_Code INNER JOIN Receipt_Disbursement_AccountHeads AS H ON D.Voucher_Trans_Id = H.Voucher_Trans_Id LEFT OUTER JOIN Account_Titles AS A ON D.Party_ID = A.Account_No
		WHERE     (H.For_Date BETWEEN @S_Date AND @E_Date) AND (D.Account_Head_id = @E_Code) 
and (@party_ID = 0 or D.party_ID = @party_ID)
And (H.Financial_Company_Id=@Financial_Company_Id) and (@Company_Branch_Id =0 OR H.Company_Branch_Id=@Company_Branch_Id) 
		GROUP BY E.E_Name, E.E_Code, CONVERT(varchar, H.For_Date, 103), D.Description, H.Voucher_Trans_Id, H.For_Date, ISNULL(H.Voucher_No, ''), A.Account_Title
	)abc
ORDER BY abc.for_date2 asc" 
            
        ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:QueryStringParameter Name="E_Code" QueryStringField="E_Code" />
                <asp:ControlParameter ControlID="HiddenFieldSdate" Name="S_Date" PropertyName="Value" />
                <asp:ControlParameter ControlID="HiddenFieldEdate" Name="E_Date" PropertyName="Value" />
                <asp:SessionParameter Name="Financial_Company_Id" SessionField="FCID" />
                <asp:SessionParameter Name="Company_Branch_Id" SessionField="CBID" />
                <asp:ControlParameter ControlID="DDL_Party" Name="party_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>


</asp:Content>
