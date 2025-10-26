<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="Approve_Demand_Requisition_Request.aspx.cs" Inherits="Store_Approve_Demand_Requisition_Request" %>

<%--<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .Form_View tr
        {
            height: 25px;
        }
        
        .labelColor
        {
            width: 50px;
            height: 18px;
            text-align: center;
            color: White;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            <div class="bxmain inner_content" style="width: 100%;">
                <h2>
                    <span>Approve Demand Requisition Request</span></h2>
                <table width="100%">
                    <tr>
                        <td style="width: 800px;">
                            <asp:FormView ID="FormView1" DataSourceID="SqlDataSource1" Width="100%" runat="server"
                                EnableModelValidation="True" AllowPaging="True" OnPreRender="FormView1_PreRender">
                                <ItemTemplate>
                                    <table class="Form_View" width="100%">
                                        <tr>
                                            <td>
                                                Requistions ID :
                                            </td>
                                            <td>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Demand_RQ_ID") %>'></asp:Label>
                                                <asp:HiddenField ID="hdfApprovalStatus" runat="server" Value='<%# Eval("Is_Approved") %>' />
                                            </td>
                                            <td>
                                                Date Time :
                                            </td>
                                            <td>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Date_Time", "{0:d}") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                           
                                            <td>
                                                From Department :
                                            </td>
                                            <td>
                                             <asp:Label ID="Label9" runat="server" Text='<%# Eval("From_Sub_Dept") %>'></asp:Label>
                                               
                                            </td>
                                            <td>
                                                To Department :
                                            </td>
                                            <td>
                                                <asp:Label ID="Label7" runat="server" Text='<%# Eval("To_Sub_Dept") %>' ></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                             <td>
                                                Remarks :
                                            </td>
                                            <td>
                                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                            </td>
                                            <td style="display:none;">
                                                Department :
                                            </td>
                                            <td style="display:none;">
                                                <asp:Label ID="Label8" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label>
                                            </td>
                                            
                                        </tr>
                                        <tr style="display:none;">
                                            <td>
                                                Company Name :<asp:HiddenField ID="hf_isgst" runat="server" Value='<%# Eval("IsGST") %>' />
                                                <asp:HiddenField ID="hf_gst" runat="server" Value='<%# Eval("GST") %>' />
                                                <asp:HiddenField ID="hf_iswht" runat="server" Value='<%# Eval("ISWHT") %>' />
                                                <asp:HiddenField ID="hf_wht" runat="server" Value='<%# Eval("WHTax") %>' />
                                                <asp:HiddenField ID="hf_isit" runat="server" Value='<%# Eval("ISITax") %>' />
                                                <asp:HiddenField ID="hf_it" runat="server" Value='<%# Eval("ITax") %>' />
                                                <asp:HiddenField ID="hf_isother" runat="server" Value='<%# Eval("isOtherTax") %>' />
                                                <asp:HiddenField ID="hf_other" runat="server" Value='<%# Eval("OtherTax") %>' />
                                            </td>
                                            <td>
                                                <asp:Label ID="Label10" runat="server" Text='<%# Eval("Company_name") %>'></asp:Label>
                                            </td>
                                            <td>
                                                End User :
                                            </td>
                                            <td>
                                                <asp:Label ID="Label11" runat="server" Text='<%# Eval("end_user") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:FormView>
                        </td>
                        <td>
                            <asp:GridView ID="gvRequisitionApprovalLevels" ShowHeader="false" Width="100%" runat="server"
                                EmptyDataText="No Record(s) Found" AutoGenerateColumns="False" DataSourceID="SqlDataSource4"
                                OnRowDataBound="gvRequisitionApprovalLevels_RowDataBound">
                                <Columns>
                                    <asp:TemplateField ItemStyle-Width="55px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblColor" CssClass="labelColor" runat="server" Width="25px" Text='<%# Eval("Auth_Level") %>'></asp:Label>
                                            <asp:HiddenField ID="hfldColor" runat="server" Value='<%# Eval("Color") %>' />
                                        </ItemTemplate>
                                        <ItemStyle Width="55px"></ItemStyle>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" SortExpression="Name" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                SelectCommand="GetDemandRequisitionApprovalLevels" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="Requisition_ID" QueryStringField="RQ_ID" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <%--updatequery:UPDATE Demand_Requisition_Main SET OtherTax = @OtherTax, isOtherTax = @isOtherTax, ITax = @ITax, ISITax = @ISITax, WHTax = @WHTax, IsGST = @IsGST, GST = @GST, ISWHT = @ISWHT WHERE (Demand_RQ_ID = @Demand_RQ_ID)--%>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                SelectCommand="uspGetDemandBasicInfo" SelectCommandType="StoredProcedure"
                UpdateCommand="UPDATE Demand_Requisition_Main SET OtherTax = @OtherTax,  ITax = @ITax,  WHTax = @WHTax,  GST = @GST WHERE (Demand_RQ_ID = @Demand_RQ_ID)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Demand_RQ_ID" QueryStringField="RQ_ID" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="OtherTax" />
                   
                    <asp:Parameter Name="ITax" />
                    
                    <asp:Parameter Name="WHTax" />
                  
                    <asp:Parameter Name="GST" />
                   
                    <asp:Parameter Name="Demand_RQ_ID" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <div class="lightbox" id="pnlChangeCode" runat="server" visible="false" style="text-align:center">
                
                <asp:Label runat="server" ID="lblOldItemCode" Text="Old Item Code:" ></asp:Label>
                <asp:TextBox runat="server" ID="txtItemCodeOld" Text="" Enabled="false" Height="30px" Font-Size="Medium"></asp:TextBox>
                <br />
                <asp:Label runat="server" ID="lblNewItemCode" Text="New Item Code:"></asp:Label>
                <asp:TextBox runat="server" ID="txtItemCodeNew" Text="" Enabled="true" Height="30px" Font-size="Medium"></asp:TextBox>
                <br />
                <asp:Label ID="lblMessage" runat="server" Text="" Font-Size="Larger" Font-Bold="true"></asp:Label><br />
                
                <asp:Button ID="btnUpDATE" runat="server" Text="Update" OnClick="btnUpDATE_Click" />
                <asp:Button ID="btnclose" runat="server" Text="Close" OnClick="btnclose_Click" />
            </div>
            <asp:GridView ID="gvRequistionDetail" runat="server" Width="100%" AutoGenerateColumns="False"
                DataKeyNames="Demand_RQ_ID,Item_Code" DataSourceID="sqlDs_RequistionDetail" EnableModelValidation="True"
                OnPreRender="gvRequistionDetail_PreRender" OnLoad="gvRequistionDetail_Load">
                <Columns>
                    <asp:BoundField DataField="Demand_RQ_ID" HeaderText="Demand_RQ_ID" ReadOnly="True"
                        SortExpression="Demand_RQ_ID" Visible="False" />
                    <asp:BoundField DataField="Item_Code" HeaderText="Item Code" ReadOnly="True" SortExpression="Item_Code" />
                    <asp:TemplateField Visible="false" >
                        <ItemTemplate>
                            
                            <asp:HiddenField ID="hfld_RQ_ID" runat="server" Value='<%#Eval("Demand_RQ_ID") %>' />
                            <asp:HiddenField ID="hfld_Item_Code" runat="server" Value='<%#Eval("Item_Code") %>' />
                            <asp:Button ID="Changebtn" runat="server" Text="Change" OnClick="Changebtn_Click" CommandArgument='<%#Eval("Item_Code") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Units" HeaderText="Units" SortExpression="Units" Visible="False" />
                    <asp:BoundField DataField="Item_Name" HeaderText="Item_Name" SortExpression="Item_Name" />
                    <asp:BoundField DataField="Item_Qty" HeaderText="Qty" SortExpression="Item_Qty" />
                    <%--<asp:BoundField DataField="Item_Rate" HeaderText="Rate" SortExpression="Item_Rate" DataFormatString="{0:N2}" />--%>
                    <asp:TemplateField HeaderText="New Demand Qty" Visible="false" >
                        <ItemTemplate>
                            <asp:TextBox ID="txtNewQty" runat="server" Width="50px" OnTextChanged="txtNewQty_TextChanged"
                                AutoPostBack="True"></asp:TextBox>
                            <asp:HiddenField ID="hfld_qty" runat="server" Value='<%#Eval("Item_Qty") %>' />
                            <asp:HiddenField ID="hfld_Rate" runat="server" Value='<%#Eval("Item_Rate") %>' />
                            <asp:HiddenField ID="hfld_Discount" runat="server" Value='<%#Eval("Discount") %>' />
                            <asp:HiddenField ID="hfid_Total_Amount_Sale" runat="server" Value='<%#Eval("Total_Amount") %>' />
                            <asp:HiddenField ID="hfid_Purchase_rate" runat="server" Value='<%#Eval("Purchase_rate") %>' />
                            <asp:HiddenField ID="hfid_Rebate" runat="server" Value='<%#Eval("Rebate") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Estimated Rate">
                        <ItemTemplate>
                            <asp:TextBox ID="txtRate" runat="server" Width="150px" OnTextChanged="txtRate_TextChanged"
                                AutoPostBack="True" Enabled="false"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Discount" Visible="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtDiscount" runat="server" Width="50px" OnTextChanged="txtDiscount_TextChanged"
                                AutoPostBack="True"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Estimated Total">
                        <ItemTemplate>
                            <asp:TextBox ID="txtTotalAmount" runat="server" Enabled="False" Width="150px"></asp:TextBox>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtTotalAmount" runat="server" Enabled="False" ForeColor="Red" Visible="false"
                                Width="50px"></asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Cost/ Unit" Visible="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtPO" runat="server" Width="50px" AutoPostBack="True" OnTextChanged="txtPO_TextChanged"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Cost" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="LBL_Total_Cost" runat="server" Text="0"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Back End Rebate %" Visible="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtRebate" runat="server" AutoPostBack="True" Width="50px" MaxLength="3"
                                OnTextChanged="txtRebate_TextChanged"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Rebate Amount" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="LBL_Total_Rebate" runat="server" Text="0"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Net Cost" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="LBL_Total_NetCost" runat="server" Text="0"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Profit" Visible="false"></asp:TemplateField>
                    <asp:TemplateField Visible="false">
                        <ItemTemplate>
                            <asp:Button ID="btn_delete" runat="server" Text="Delete" OnClick="btn_delete_Click" CausesValidation="false" OnClientClick="return confirm(Are you sure you want to delete this item?)" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <div width="100%" align="right" >
                <table width="20%">
                    <tr>
                        <td width="50%" align="left">
                            <strong>Total Amount :</strong>
                        </td>
                        <td width="50%" align="right">
                            <asp:TextBox ID="Txt_Total" runat="server" Enabled="false" Width="100px" Style="margin-bottom: 0px">0</asp:TextBox>
                        </td>
                    </tr>
                </table>
                <table width="20%" frame="box" style="display:none;">
                    <tr>
                        <td align="center" bgcolor="#78A5BA">
                            <strong>Expanse Type</strong>
                        </td>
                       <%-- <td align="center" bgcolor="#78A5BA">
                            <strong>Is Included</strong>
                        </td>--%>
                        <td align="center" bgcolor="#78A5BA">
                            <strong>Percent %</strong>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            GST :
                        </td>
                        <%-- <td align="center">
                            <asp:CheckBox ID="CKGST" runat="server" AutoPostBack="True" OnCheckedChanged="CKGST_CheckedChanged" />
                        </td>--%>
                        <td align="left">
                            <asp:TextBox ID="TXT_GST" runat="server" Text="0" AutoPostBack="True" Width="50px"
                                MaxLength="5" Enabled="true" OnTextChanged="TXT_TaxChanged"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            With Holding Tax :
                        </td>
                        <%--<td align="center">
                            <asp:CheckBox ID="CKWHT" runat="server" AutoPostBack="True" OnCheckedChanged="CKWHT_CheckedChanged">
                            </asp:CheckBox>
                        </td>--%>
                        <td align="left">
                            <asp:TextBox ID="TXT_WHT" runat="server" Text="0" OnTextChanged="TXT_TaxChanged"
                                Enabled="true" Width="50px" MaxLength="5" AutoPostBack="True">

                            </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Income Tax :
                        </td>
                        <%--  <td align="center">
                            <asp:CheckBox ID="CKIncometax" runat="server" AutoPostBack="True" OnCheckedChanged="CKIncometax_CheckedChanged">
                            </asp:CheckBox>
                        </td>--%>
                        <td align="left">
                            <asp:TextBox ID="TXT_IT" runat="server" Text="0" Enabled="true" AutoPostBack="True"
                                OnTextChanged="TXT_TaxChanged" Width="50px" MaxLength="5" Height="22px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Other Tax:
                        </td>
                        <%--<td align="center">
                            <asp:CheckBox ID="CKoTHER" runat="server" OnCheckedChanged="CKoTHER_CheckedChanged"
                                AutoPostBack="True" />
                        </td>--%>
                        <td align="left">
                            <asp:TextBox ID="TXT_oTHER" runat="server" Enabled="true" MaxLength="5" Text="0"
                                AutoPostBack="True" OnTextChanged="TXT_TaxChanged" Width="50px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <table width="20%"  style="display:none;">
                    <tr>
                        <td width="50%" align="left">
                            <strong>Final Amount :</strong>
                        </td>
                        <td width="50%" align="right">
                            <asp:TextBox ID="TxtFTamount" runat="server" Enabled="false" Width="100px" Style="margin-bottom: 0px">0</asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:SqlDataSource ID="sqlDs_RequistionDetail" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                SelectCommand="SELECT
	Demand_Requisition_Sub.Demand_RQ_ID,
	Demand_Requisition_Sub.Item_Code,
	Demand_Requisition_Sub.Item_Qty,
	Demand_Requisition_Sub.Item_Specification,
	ISNULL(PR.Rate,0) Item_Rate,
	Demand_Requisition_Sub.Units,
	Demand_Requisition_Sub.Qty_Per_Unit,
	Demand_Requisition_Sub.Original_Item_Qty,
    Demand_Requisition_Sub.Discount,
    (ISNULL(Demand_Requisition_Sub.Item_Qty,0)*ISNULL(PR.Rate,0)) Total_Amount,
    Demand_Requisition_Sub.Purchase_rate,
    Demand_Requisition_Sub.Rebate,
	Store_Items.Item_Name
FROM Store_Items
INNER JOIN Demand_Requisition_Sub
	ON Store_Items.Item_Code = Demand_Requisition_Sub.Item_Code Left Outer Join
	 (
		Select * From (
						Select   Rate,Item_Code,PO_ID,RANK() Over(PARTITION By Item_Code  Order By Entry_Date Desc) R
								From Purchase_Order_Sub 
								Where  ISNULL(Rate,0)>0 
						) a
						Where R=1
	 ) PR On Demand_Requisition_Sub.Item_Code=PR.Item_Code
WHERE Demand_RQ_ID=@Demand_RQ_ID" InsertCommand="uspCreateDemandApprovalRequest" InsertCommandType="StoredProcedure"
                UpdateCommand="UPDATE Demand_Requisition_Sub SET Item_Qty = @Qty, Item_Rate = @Rate, Discount = @Discount, Total_Amount = @Amount, Purchase_rate =@Purchase ,Rebate =@Rebate WHERE (Demand_RQ_ID = @Demand_RQ_ID) AND (Item_Code = @Item_Code)">
                <InsertParameters>
                    <asp:Parameter Name="Requisition_ID" />
                    <asp:Parameter Name="Send_By" />
                    <asp:Parameter Name="Send_By_Sub_Dept_Id" />
                    <asp:Parameter Name="Send_To" />
                    <asp:Parameter Name="Send_To_Sub_Dept_Id" />
                    <asp:Parameter Name="SendDate" />
                    <asp:Parameter Name="Requisition_Remarks" />
                    <asp:Parameter Name="Parent_Approval_Request_Id" />
                    <asp:Parameter Name="Approved_Status" />
                    <asp:Parameter Name="Approved_Date" />
                    <asp:Parameter Name="Request_Level" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="Demand_RQ_ID" QueryStringField="RQ_ID" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Qty" />
                    <asp:Parameter Name="Demand_RQ_ID" />
                    <asp:Parameter Name="Item_Code" />
                    <asp:Parameter Name="Rate" />
                    <asp:Parameter Name="Discount" />
                    <asp:Parameter Name="Amount" />
                    <asp:Parameter Name="Purchase" />
                    <asp:Parameter Name="Rebate" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <div class="bxmain inner_content" style="width: 100%;">
                <table width="100%">
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td style="text-align: right;" colspan="5">
                            <asp:Button ID="btnSaveQuantity" runat="server" Text="Save Quantity" OnClick="btnSaveQuantity_Click" Visible="false" />
                            <asp:Button ID="btnconsumption" runat="server" Text="Previous Consumption" OnClick="btnconsumption_Click" />
                            <asp:Label ID="lbl_msg" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td style="display:none;">
                            <table>
                                <tr>
                                    <td>
                                        Remarks :
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Rows="7" Height="50px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Send To :
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSendTo" runat="server" DataSourceID="SqlDataSource2" DataTextField="Employee_Name"
                                            DataValueField="EmpID">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                            SelectCommand="SELECT	Employee.EmpID,ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' '
+ ISNULL(Employee.ELName, '') + ' ( ' + CAST(Approval_Authority_For_Demand.Auth_Level AS varchar) + ' )' Employee_Name
FROM Approval_Authority_For_Demand INNER JOIN Employee
	ON Approval_Authority_For_Demand.EmployeeId = Employee.EmpID
WHERE Approval_Authority_For_Demand.SubDeptId = @SubDeptId
ORDER BY Auth_Level, Employee.EFName">
                                            <SelectParameters>
                                                <asp:SessionParameter Name="SubDeptId" SessionField="SubDeptID" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td>
                                        <asp:Button ID="btnSave" runat="server" Text="Forward For Approval" OnClick="btnSave_Click" />
                                        <asp:Label ID="lbl_f_" runat="server" ForeColor="Red"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        Approval Remarks :
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtApprovalRemarks" TextMode="MultiLine" Rows="7" Height="50px"
                                            runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnApprove" runat="server" Text="Approve" OnClick="btnApprove_Click" />
                                        <asp:Label ID="lbl_approve" runat="server" ForeColor="Red"></asp:Label>
                                        <asp:SqlDataSource ID="sqlDs_Approve" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                            SelectCommand="Select Top 1 * From Approval_Request_For_Demand" UpdateCommand="UpdateDemandApprovalRequest"
                                            UpdateCommandType="StoredProcedure">
                                            <UpdateParameters>
                                                <asp:Parameter Name="Approval_Remarks" />
                                                <asp:Parameter Name="Approved_Date" />
                                                <asp:Parameter Name="Approval_Request_Id" />
                                            </UpdateParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        Rejection Remarks :
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRejectedReason" TextMode="MultiLine" Rows="7" Height="50px" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnReject" runat="server" Text="Reject" OnClick="btnReject_Click" />
                                        <asp:Label ID="lbl_reject" runat="server" ForeColor="Red"></asp:Label>
                                        <asp:SqlDataSource ID="sqlDs_Reject" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                            SelectCommand="Select Top 1 * From Approval_Request_For_Demand" UpdateCommand="UpdateDemandRejectStatus"
                                            UpdateCommandType="StoredProcedure">
                                            <UpdateParameters>
                                                <asp:Parameter Name="Remarks" />
                                                <asp:Parameter Name="Demand_RQ_ID" />
                                                <asp:Parameter Name="Parent_Request_Id" />
                                            </UpdateParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="display:none;">
                            <table>
                                <tr>
                                    <td>
                                        Hold Remarks :
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtHoldRemarks" TextMode="MultiLine" Rows="7" Height="50px" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnhold" runat="server" Text="Hold" OnClick="btnhold_Click" />
                                        <asp:Label ID="lbl_Hold" runat="server" ForeColor="Red"></asp:Label>
                                        <asp:SqlDataSource ID="sqlDs_Hold" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                             UpdateCommand="UpdateDemandHoldStatus"
                                            UpdateCommandType="StoredProcedure">
                                            <UpdateParameters>
                                                <asp:Parameter Name="Remarks" />
                                                <asp:Parameter Name="Demand_RQ_ID" />
                                                <asp:Parameter Name="Parent_Request_Id" />
                                            </UpdateParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <div class="bx_infos_patients">
                                <h2>
                                    <span><a style="text-decoration: none">Requisition Remarks</a></span></h2>
                                <div style="height: auto" class="bxinfo_margin">
                                    <asp:DataList ID="DataList_Requisition_Remarks" runat="server" DataSourceID="SqlDataSource3"
                                        Width="100%">
                                        <ItemTemplate>
                                            <div class="bx_pathology">
                                                <ul id="CollapsiblePanelp_<%# Eval("Send_By_Employee") %>">
                                                    <li><span style="font-weight: bold;">
                                                        <asp:Label ID="Label10" runat="server" ToolTip="Send Date" Text='<%# Eval("Send_By_Employee") %>'></asp:Label>
                                                    </span>( <span>
                                                        <asp:Label ID="PrefixLabel" runat="server" ToolTip="Send Date" Text='<%# Eval("SendDate") %>'></asp:Label>
                                                    </span>) ( <span>
                                                        <asp:Label ID="Label15" runat="server" ToolTip="Send Date" Text='<%# Eval("Approved_Status") %>'></asp:Label>
                                                    </span>) </li>
                                                    <li><span style="padding-left: 20px; padding-right: 20px;">
                                                        <asp:Label ID="Label11" runat="server" ToolTip="Send Date" Text='<%# Eval("Requisition_Remarks") %>'></asp:Label>
                                                    </span></li>
                                                    <li><span style="font-weight: bold;">
                                                        <asp:Label ID="Label12" runat="server" ToolTip="Send Date" Text='<%# Eval("Send_To_Employee") %>'></asp:Label>
                                                    </span>( <span>
                                                        <asp:Label ID="Label13" runat="server" ToolTip="Send Date" Text='<%# Eval("Approved_Date") %>'></asp:Label>
                                                    </span>) </li>
                                                    <li><span style="padding-left: 20px; padding-right: 20px;">
                                                        <asp:Label ID="Label14" runat="server" ToolTip="Send Date" Text='<%# Eval("Approval_Remarks") %>'></asp:Label>
                                                    </span></li>
                                                </ul>
                                                <script type='text/javascript'>var CollapsiblePanelp_<%# Eval("Send_By_Employee") %> = 
                                    new Spry.Widget.CollapsiblePanel('CollapsiblePanelp_<%# Eval("Send_By_Employee") %>',{contentIsOpen:false});</script>
                                            </div>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                SelectCommand="SELECT
	Approval_Request_For_Demand.SendDate,
	Approval_Request_For_Demand.Requisition_Remarks,
	Approval_Request_For_Demand.Approved_Status,
	Approval_Request_For_Demand.Approved_Date,
	Approval_Request_For_Demand.Approval_Remarks,
	ISNULL(Employee_1.Prefix, '') + ' ' + ISNULL(Employee_1.EFName, '')
	+ ' ' + ISNULL(Employee_1.ELName, '') AS Send_To_Employee,
	ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.ELName, '')
	AS Send_By_Employee
FROM Approval_Request_For_Demand
INNER JOIN Employee
	ON Approval_Request_For_Demand.Send_By = Employee.EmpID
INNER JOIN Employee AS Employee_1
	ON Approval_Request_For_Demand.Send_To = Employee_1.EmpID
WHERE (Approval_Request_For_Demand.Requisition_ID = @Requisition_ID)
ORDER BY SendDate">
                <SelectParameters>
                    <asp:QueryStringParameter Name="Requisition_ID" QueryStringField="RQ_ID" />
                </SelectParameters>
            </asp:SqlDataSource>
        <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
    <asp:SqlDataSource ID="sdsDemandReqEmail" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="DemandReport" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="QO_ID" QueryStringField="RQ_ID" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HF_Load_back" runat="server" Value="1" />
    <%-- <rsweb:ReportViewer ID="ReportViewer2" runat="server" Width="100%" Height="500px">
    </rsweb:ReportViewer>--%>
</asp:Content>
