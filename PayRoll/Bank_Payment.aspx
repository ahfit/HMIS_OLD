<%@ page language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="PayRoll_Bank_Payment, App_Web_xk2k0ijz" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" namespace="Infragistics.WebUI.WebSchedule" tagprefix="igsch" %>


 



  
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 
    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
       
<%--        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
       <ContentTemplate>--%>
 <div class="bxmain">
    <table  cellpadding="0" cellspacing="0" border="0" class="tbl_form" width="100%">
       
        <tr>
            <td width="40%" align="right" >
                Month &amp; Year : 
                </td>
               <td width="60%"> 
                <asp:DropDownList ID="DDL_Month" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSourceMonth" DataTextField="Month_Name" Width="100px"  
                    DataValueField="Month_No">
                </asp:DropDownList>
                <asp:DropDownList ID="DDL_Year" runat="server" AutoPostBack="True" Width="100px" >
                </asp:DropDownList>
              
                <asp:SqlDataSource ID="SqlDataSourceMonth" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                    SelectCommand="SELECT Month_Name, Month_No FROM Year_Months">
                </asp:SqlDataSource>
            </td>
            </tr>
            <tr>
            <td align="right" >
                Employee Type :
               
            </td>
            <td> <asp:DropDownList ID="DDL_Employee_Type" runat="server" Width="200px" >
                    <asp:ListItem>Permanent</asp:ListItem>
                    <asp:ListItem>Contigent</asp:ListItem>
                </asp:DropDownList></td>
            
            
        </tr>
        <tr>
            <td align="right">&nbsp;
                </td>
            <td>
                <asp:Button ID="Button_Search" runat="server" Text="Search" />
            </td>
        </tr>
       </table>
</div><br />

<div class="bxmain"><h2> <span><asp:Label ID="label_VoucherDetail" runat="server" Text="Voucher Detail"></asp:Label></span> </h2>

               <div align="center">
                
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="98%" 
                    DataKeyNames="Voucher_Trans_Id" DataSourceID="SqlDataSourceGrid">
                    <Columns>
                        <asp:TemplateField AccessibleHeaderText="Report" ShowHeader="False" 
                            HeaderText="Detailed Report">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1D" runat="server" CausesValidation="False" 
                                    Text="Print" onclick="LinkButton1D_Click" CommandName="Select"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField AccessibleHeaderText="Report" ShowHeader="False" 
                            HeaderText="Summarized Report">
                            <ItemTemplate>
                                <asp:HiddenField ID="HiddenField1" runat="server" 
                                    Value='<%# Eval("Voucher_Trans_Id") %>' />
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                    Text="Print" onclick="LinkButton1_Click" CommandName="Select"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Reference_No" HeaderText="Reference No" 
                            SortExpression="Reference_No" />
                        <asp:BoundField DataField="Voucher_Type" HeaderText="Voucher Type" 
                            SortExpression="Voucher_Type" />
                        <asp:BoundField DataField="Description" HeaderText="Description" 
                            SortExpression="Description" ReadOnly="True" />
                        <asp:ButtonField CommandName="select" DataTextField="Amount" 
                            HeaderText="Amount" SortExpression="Amount" />
                        <asp:BoundField DataField="Amount" HeaderText="Amount" 
                            SortExpression="Amount" Visible="False" />
                    </Columns><AlternatingRowStyle CssClass="GridAltItem" />
                     <SelectedRowStyle CssClass="gridselect" />
<PagerStyle CssClass="GridPager" />
                </asp:GridView>
           </div>
       
           
                <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
                    
                    
        SelectCommand="SELECT Reference_No, Voucher_Type, ISNULL(Description, '') AS Description, Amount, Voucher_Trans_Id FROM Receipt_Disbursement_AccountHeads WHERE (CAST(FLOOR(CAST(For_Date AS FLOAT)) AS DATETIME) = @For_Date) AND (Trans_Type_Id = @Voucher_Type_Id)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="HF_Date" Name="For_Date" 
                            PropertyName="Value" />
                        <asp:Parameter DefaultValue="7" Name="Voucher_Type_Id" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HF_Date" runat="server" />
             <br />

         <div style="height:200px; width:100%; overflow:auto; overflow-x:hidden; display:inline-block;">   
<asp:Panel ID="Panel1" runat="server"   >
                  

                  <asp:GridView ID="GridView_AcHeads" runat="server" AutoGenerateColumns="False"  Width="100%"
                        DataKeyNames="E_ID" DataSourceID="SqlDataSourceAcHeads">
                        <Columns>
                            
                          <asp:TemplateField AccessibleHeaderText="Report" ShowHeader="False" 
                            HeaderText="Detailed Report">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1D" runat="server" CausesValidation="False" 
                                    Text="Print" onclick="LinkButton1D_Click" CommandName="Select"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField AccessibleHeaderText="Report" ShowHeader="False" 
                            HeaderText="Summarized Report">
                            <ItemTemplate>
                                <asp:HiddenField ID="HiddenField1" runat="server" 
                                    Value='<%# Eval("Voucher_Trans_Id") %>' />
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                    Text="Print" onclick="LinkButton1_Click" CommandName="Select"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                            <asp:BoundField DataField="Account_Head_id" HeaderText="Account Code" 
                                SortExpression="Account_Head_id" />
                            <asp:ButtonField CommandName="select" DataTextField="E_Name" 
                                HeaderText="Account Head" SortExpression="E_Name" Text="Account Head" />
                            <asp:BoundField DataField="amount" HeaderText="Amount" ReadOnly="True" 
                                SortExpression="amount" />
                            <asp:BoundField DataField="E_ID" HeaderText="E_ID" InsertVisible="False" 
                                ReadOnly="True" SortExpression="E_ID" Visible="False" />
                            <asp:BoundField DataField="Voucher_Trans_Id" HeaderText="Voucher_Trans_Id" 
                                SortExpression="Voucher_Trans_Id" Visible="False" />
                            <asp:BoundField DataField="E_Name" HeaderText="Account Head" 
                                SortExpression="E_Name" Visible="False" />
                        </Columns><AlternatingRowStyle CssClass="GridAltItem" />
<PagerStyle CssClass="GridPager" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceAcHeads" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
                        SelectCommand="
SELECT DISTINCT 
                      Reciept_Disbursement_Detail.Account_Head_id, Reciept_Disbursement_Detail.Voucher_Trans_Id, amount.amount, Expenditure.E_Name, Expenditure.E_ID, 
                      Reciept_Disbursement_Detail.Cr_Dr_Action_Id
FROM         Reciept_Disbursement_Detail INNER JOIN
                      Expenditure ON Reciept_Disbursement_Detail.Account_Head_id = Expenditure.E_Code LEFT OUTER JOIN
                          (SELECT     SUM(Amount) AS amount, Account_Head_id, Voucher_Trans_Id
                            FROM          Reciept_Disbursement_Detail AS Reciept_Disbursement_Detail_1
                            GROUP BY Account_Head_id, Voucher_Trans_Id) AS amount ON Reciept_Disbursement_Detail.Voucher_Trans_Id = amount.Voucher_Trans_Id AND 
                      Reciept_Disbursement_Detail.Account_Head_id = amount.Account_Head_id
WHERE     (Reciept_Disbursement_Detail.Voucher_Trans_Id = @Voucher_Trans_Id ) AND (Reciept_Disbursement_Detail.Cr_Dr_Action_Id = 2)
and  Reciept_Disbursement_Detail.Account_Head_id=99999999">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HF_Voucher_Trans_Id" Name="Voucher_Trans_Id" 
                                PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    </asp:Panel></div>
           <br />
            
 <div style="height:250px; width:100%; overflow:auto; overflow-x:hidden; display:inline-block;">   
 <asp:Panel ID="Panel2" runat="server"  Visible="False" style="height:400px; overflow:auto; overflow-x:hidden;"    >
                
                 <div class="bxmain">
                 
                    <table cellpadding="0" cellspacing="0" border="0" class="tbl_form" width="100%">
                        <tr>
                            <td align="right" width="40%" >
                                Bank :</td>
                            <td  width="60%">
                                <asp:DropDownList ID="DDL_Bank_Heads" runat="server" 
                                    DataSourceID="SqlDataSource_Bank" DataTextField="E_Name" 
                                    DataValueField="E_Code" Width="300px">
                                </asp:DropDownList>
                               
                                <asp:SqlDataSource ID="SqlDataSource_Bank" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" SelectCommand="SELECT E_Code, E_ID, E_Name FROM Expenditure WHERE (E_Code LIKE '3201%') OR (E_Code LIKE '1545%')
"></asp:SqlDataSource>
                            </td>
                            <td >&nbsp;
                                </td>
                            <td>
                                <asp:TextBox ID="txt_ChequeNo" runat="server" Visible="False" ></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" >
                                Amount : </td>
                            <td >
                                <asp:TextBox ID="txt_Amount" runat="server"></asp:TextBox>
                            </td>
                            <td >&nbsp;
                                </td>
                            <td>
                                <igsch:WebDateChooser ID="WebDateChooser1" runat="server" Visible="False">
                                </igsch:WebDateChooser>
                            </td>
                        </tr>
                       
                        <tr>
                            <td align="right">&nbsp;
                                </td>
                            <td>
                                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True">
                                    <asp:ListItem Selected="True" Value="%">All</asp:ListItem>
                                    <asp:ListItem>Officer</asp:ListItem>
                                    <asp:ListItem>Staff</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>&nbsp;
                                </td>
                            <td>&nbsp;
                                </td>
                        </tr>
                       
                    </table>
                
                </div>
                    <br />
                    <asp:GridView ID="GridView_Employee_Detail" runat="server"  Width="98%" Style="margin-left:10px;"
                        AutoGenerateColumns="False" DataKeyNames="E_ID" 
                        datasourceid="SqlDataSource_Employee_Detail">
                        <Columns>
                            <asp:BoundField DataField="Account_Head_id" HeaderText="Account Code" 
                                SortExpression="Head Code" />
                            <asp:BoundField DataField="E_Name" HeaderText="E_Name" 
                                SortExpression="E_Name" />
                            <asp:BoundField DataField="Employee" HeaderText="Employee" ReadOnly="True" 
                                SortExpression="Employee" />
                            <asp:BoundField DataField="Amount" HeaderText="Amount" 
                                SortExpression="Amount" />
                            <asp:BoundField DataField="Voucher_Trans_Id" HeaderText="Voucher_Trans_Id" 
                                SortExpression="Voucher_Trans_Id" Visible="False" />
                            <asp:BoundField DataField="Party_ID" HeaderText="Party_ID" 
                                SortExpression="Party_ID" Visible="False" />
                            <asp:BoundField DataField="E_ID" HeaderText="E_ID" InsertVisible="False" 
                                ReadOnly="True" SortExpression="E_ID" Visible="False" />
                            <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" 
                                SortExpression="EmpID" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chk_Selected" runat="server" AutoPostBack="True" Text=" " />
                                </ItemTemplate>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="Chk_All" runat="server" AutoPostBack="True" 
                                        oncheckedchanged="Chk_All_CheckedChanged" Text=" " />
                                </HeaderTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource_Employee_Detail" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
                        
                        
                     
                     
                     SelectCommand="SELECT Reciept_Disbursement_Detail.Account_Head_id, Expenditure.E_Name, Employee.Name + ' ( ' + ISNULL(Designation.Designation, '') + ' )' AS Employee, Reciept_Disbursement_Detail.Amount, Reciept_Disbursement_Detail.Voucher_Trans_Id, Reciept_Disbursement_Detail.Party_ID, Expenditure.E_ID, Employee.EmpID FROM Reciept_Disbursement_Detail INNER JOIN Expenditure ON Reciept_Disbursement_Detail.Account_Head_id = Expenditure.E_Code INNER JOIN Employee ON Reciept_Disbursement_Detail.Party_ID = Employee.EmpID LEFT OUTER JOIN Designation ON Employee.DesignationID = Designation.ID WHERE (Expenditure.E_ID = @E_ID) AND (Reciept_Disbursement_Detail.Voucher_Trans_Id = @Voucher_Trans_Id) AND (Designation.Designation_Type LIKE '%' + @Designation_Type + '%')">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="HF_E_ID" Name="E_ID" PropertyName="Value" />
                            <asp:ControlParameter ControlID="HF_Voucher_Trans_Id" Name="Voucher_Trans_Id" 
                                PropertyName="Value" />
                            <asp:ControlParameter ControlID="DropDownList1" Name="Designation_Type" 
                                PropertyName="SelectedValue" DefaultValue="%" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                  
                  
                </asp:Panel></div>
           <br />

           <div align="center">
                <asp:Button ID="btn_GenerateVoucher" runat="server" Text="Generate Voucher" 
                     
                    /> </div>
        
    <asp:HiddenField ID="HF_Voucher_Trans_Id" runat="server" />
                <asp:HiddenField ID="HF_E_ID" runat="server" />
                <br />
            
<%--    </ContentTemplate>
     </asp:UpdatePanel>--%>
    <br />
<br />

    </div>
    
</asp:Content>
