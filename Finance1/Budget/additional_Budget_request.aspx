<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="additional_Budget_request.aspx.vb" Inherits="Finance_Budget_additional_Budget_request" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div align="center" class="bxmain inner_content " style="width: 100%;"  >
        <h2>Additional Budget Request</h2>
        <table style="width:100%">
            <tr>
                <td>
                    <asp:gridview runat="server" id ="gv_Record" AutoGenerateColumns="False" DataSourceID="sds_record" width="100%" DataKeyNames="ID">
                        <Columns>
                            
                            <asp:BoundField DataField="Name" HeaderText="Reuested By" ReadOnly="True" SortExpression="Name" />
                            <asp:BoundField DataField="Request_Date" HeaderText="Request On" SortExpression="Request_Date" />
                            <asp:BoundField DataField="E_Name" HeaderText="Expense Head" SortExpression="E_Name" />
                            <asp:BoundField DataField="Amount" HeaderText=" For Amount" SortExpression="Amount" />
                            <%--<asp:BoundField DataField="Budget_status" HeaderText=" Request Time Budget Status" SortExpression="Budget_status" />--%>
                            <asp:BoundField DataField="Request" HeaderText="Request" SortExpression="Request" />
                            
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <%--<asp:linkbutton runnat="server" id="lnk_approve" > Approve/Reject</asp:linkbutton>--%>
                                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click" CommandArgument='<%# Eval("ID") %>'>Approve/ Reject</asp:LinkButton>
                                    <asp:HiddenField ID="hf_E_Code" runat="server" Value='<%# Eval("E_Code") %>' />
                                    <asp:HiddenField ID="hf_E_Name" runat="server" Value='<%# Eval("E_Name") %>'/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                        </Columns>
                    </asp:gridview>
                    <asp:sqldatasource runat="server" id ="sds_record" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>" 
                        SelectCommand="SELECT A.ID, R.Name, A.Request_Date, A.Request, E.E_Name, A.amount ,Budget_status,E.E_code
                        FROM additionalBudgetRequest AS A INNER JOIN Expenditure AS E ON A.E_code = E.E_Code INNER JOIN Employee AS R ON A.Request_By = R.EmpID 
                        WHERE (A.Status IS NULL)" UpdateCommand="UPDATE additionalBudgetRequest 
SET Approve_by = @Approve_by ,Approve_date = GETDATE(), Approval_remarks = @Approval_remarks, Status =@status WHERE (ID = @ID)">
                        <UpdateParameters>
                            <asp:ControlParameter ControlID="txt_remarks" Name="Approval_remarks" PropertyName="Text" />
                            <asp:ControlParameter ControlID="hf_request_ID" Name="ID" PropertyName="Value" />
                            <asp:ControlParameter ControlID="hf_status" Name="status" PropertyName="Value" />
                            <asp:SessionParameter Name="Approve_by" SessionField="emp_id" />
                        </UpdateParameters>
                    </asp:sqldatasource>
                    <br />
                </td>

            </tr>
            <tr>
                <td>
                     <asp:Panel ID ="pnl_Request" runat="server"  Visible="false"  CssClass="lightbox_bg">
      <div class="lightbox">
            <div align="center" class="bxmain inner_content " style="width: 100%;"  >
             <h2 style ="font-size:x-large;"> Additional Budget Request Approve Reject</h2>
            <span style="width:100%; font-size:larger; ">
                <asp:Label ID="lbl_headName" ForeColor="DarkBlue" runat="server" Text="E_Code"></asp:Label> </span>
            
            <asp:TextBox ID="txt_remarks" runat="server" TextMode="MultiLine" Height="250px" Width="98%"></asp:TextBox>
                <br />
            
           <div style="width:100%; align-items:center;" align="center">
                <asp:Button ID="btn_Approve" runat="server" Text="Approve"  />
               <asp:Button ID="btn_reject" runat="server" Text="Reject"  />
                <asp:Button ID="btn_req_cancel" runat="server" Text="close"  />
               <asp:Label ID ="lbl_req_Msg" runat="server"></asp:Label>
               <asp:HiddenField ID="hf_status" runat="server" />
               <asp:HiddenField ID="hf_request_ID" runat="server" />

           </div>
        </div>

      </div>
    </asp:Panel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

