<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Consumption_Wise_ReturnItems.aspx.cs" Inherits="Store_Consumption_Wise_ReturnItems" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            height: 208px;
        }
        .style3
        {
            height: 18px;
        }
        .centerClass
        {
            text-align:center;
            
            }
            Grid_1 td 
            {
                
                
                
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div align="center" style="width:100%;margin:auto;">
   
        <table class="style1">
            <tr>
                <td align="left">
                   
                </td>
                                
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <table width = "100%">
                        <tr>
                            <td style="font-weight:bold;width:50%;text-align:right;padding-right:5px;">
                                <asp:Label ID="lbl_dept" runat="server" Text="Deaprtment:" Visible = "False" 
                                    Font-Bold="True"></asp:Label>
&nbsp;</td>
                            <td align="left">
                                <asp:DropDownList ID="ddlDepartment" runat="server" DataSourceID="dsDepartment" DataTextField="Dept_Name"
                                    DataValueField="Dept_ID" AutoPostBack="true" Visible="False">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="dsDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    SelectCommand="Select Dept_ID,Dept_Name From Department Order By Dept_Name">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight:bold;text-align:right;padding-right:5px;">
                               
                                <asp:Label ID="lbl_subdept" runat="server" Text="Sub Deaprtment:" 
                                    Visible = "False" Font-Bold="True"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlSubDepartment" DataSourceID="dsSubDepartment" 
                                    DataTextField="SubDept_Name" DataValueField="SubDept_Id" runat="server" 
                                    Visible="False">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="dsSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    SelectCommand="Select SubDept_Id,SubDept_Name From SubDepartment Where Dept_Id = @Dept_Id Order By SubDept_Name">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlDepartment" DefaultValue="SelectedValue" Name="Dept_Id"
                                            PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight:bold;text-align:right;padding-right:5px;">
                                &nbsp;</td>
                            <td align="left">
                                &nbsp;</td>
                        </tr>
                        </table>
                </td>
                
            </tr>
            <tr>
                <td align="center">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="SqlDataSource1" Width="90%" 
                        onprerender="GridView1_PreRender">
                        <Columns>
                         <asp:BoundField DataField="Item_Name" HeaderText="Item Name" 
                                SortExpression="Item_Name" />
                                 <asp:BoundField DataField="Item_Code" HeaderText="Item Code" 
                                SortExpression="Item_Code" />
                                
                            <asp:BoundField DataField="PO_ID" HeaderText="PO #" 
                                SortExpression="PO_ID" />
                       <asp:BoundField DataField="Consumed_Date" HeaderText="Sale Date"
                                SortExpression="Consumed_Date" DataFormatString="{0:dd/MM/yyyy}" />
                                 <asp:BoundField DataField="Consumed_QTY" HeaderText="Consumed Qty"
                                SortExpression="Consumed_Date" />
                                <asp:BoundField DataField="QtyReturn" HeaderText="Qty Returned"
                                SortExpression="QtyReturn" />
                          <asp:TemplateField HeaderText="Reserved Qty">
                          <ItemTemplate>
                            <asp:TextBox ID="txtQty" runat="server" Text='<%# Bind("Return_Qty") %>'></asp:TextBox>
                            <asp:HiddenField ID="hfChkSer" runat="server" Value='<%# Eval("Total_Serial") %>' />
                            <asp:HiddenField ID="HF_ConQty" runat="server" Value='<%# Eval("Consumed_QTY") %>'  />
                          </ItemTemplate>
                          </asp:TemplateField>
                           <asp:TemplateField>
                                <ItemTemplate>
                                   <%-- <asp:CheckBox ID="Chk_Status" runat="server" Height="10px" Width="50px" />--%>
                                    <asp:LinkButton ID="Chk_Status" runat="server" Text="Mark" 
                                      CommandArgument='<%# Eval("Consumption_Detail_ID") %>'   onclick="btnChk_Status_Click"></asp:LinkButton>
                                    <br />
                                    <asp:HiddenField ID="HF_Item_Code1" runat="server" Value='<%# Eval("Item_Code") %>' />
                                    <asp:HiddenField ID="HF_Cost1" runat="server" Value='<%# Eval("Purchase_Cost") %>' />
                                    <asp:HiddenField ID="HF_CQ" runat="server" Value='<%# Eval("Consumed_QTY") %>'  />
                                    <asp:HiddenField ID="HF_PO_ID" runat="server" Value='<%# Eval("PO_ID") %>'  />
                                    <asp:HiddenField ID="HF_Sub_Id" runat="server" Value='<%# Eval("Consumption_Detail_ID") %>'  />
                                    
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnSerials" runat="server" Text="Serials" 
                                        CommandArgument='<%# Eval("Consumption_Detail_ID") %>' onclick="btnSerials_Click"></asp:LinkButton>
                                        <asp:HiddenField ID="HF_ICode" runat="server" Value='<%# Eval("Item_Code") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                         
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsInsertReceiveMain" runat="server"
                    ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                    InsertCommand="usp_Insert_Receive_main_Return" 
                        InsertCommandType="StoredProcedure" oninserted="sdsInsertReceiveMain_Inserted"
                    >
                        <InsertParameters>
                            <asp:ControlParameter ControlID="HF_IB_ID" Name="IB_ID" PropertyName="Value" 
                                Type="String" />
                            <asp:ControlParameter ControlID="ddlDepartment" Name="Receive_Dept_Id" 
                                PropertyName="SelectedValue" Type="Int32" />
                            <asp:SessionParameter Name="Receive_Emp_Id" SessionField="Emp_Id" 
                                Type="Int32" />
                            <asp:ControlParameter ControlID="ddlSubDepartment" Name="Receive_Sub_dept_Id" 
                                PropertyName="SelectedValue" Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="ShiftID" Type="Int32" />
                            <asp:Parameter DefaultValue="" Direction="InputOutput" Name="Receive_Main_ID" 
                                Type="Int32" />
                            <asp:ControlParameter ControlID="HF_Company_ID" Name="Company_ID" 
                                PropertyName="Value" Type="Int32" />
                            <asp:Parameter DefaultValue="0"  Name="Item_Issue_Main_ID" Type="Int32" />
                            <asp:QueryStringParameter Name="Consumption_ID" QueryStringField="C_ID" 
                                Type="Decimal" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sdsInsertReceiveSub" runat="server"
                     ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                     InsertCommand="usp_Insert_Receive_sub_Return" 
                        InsertCommandType="StoredProcedure" oninserted="sdsInsertReceiveSub_Inserted"
                    >
                        <InsertParameters>
                            <asp:Parameter Name="Receive_Main_ID" Type="Int32" />
                            <asp:Parameter Name="Effected_Item_Code" Type="String" />
                            <asp:Parameter Name="Effected_Item_QTY" Type="Int32" />
                            <asp:Parameter Name="Effected_Purchase_Price" Type="Double" />
                            <asp:Parameter Name="PO_ID" Type="String" />
                            <asp:Parameter Direction="InputOutput" Name="Sub_Id" Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>


                    <asp:SqlDataSource ID="sdsSaleReturnMain" runat="server"
                    ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                    InsertCommand="usp_Insert_Sale_Return_main" 
                        InsertCommandType="StoredProcedure" oninserted="sdsSaleReturnMain_Inserted"
                    >
                        <InsertParameters>
                            <asp:ControlParameter ControlID="ddlDepartment" Name="Receive_Dept_Id" 
                                PropertyName="SelectedValue" Type="Int32" />
                            <asp:SessionParameter Name="Receive_Emp_Id" SessionField="Emp_Id" 
                                Type="Int32" />
                            <asp:ControlParameter ControlID="ddlSubDepartment" Name="Receive_Sub_dept_Id" 
                                PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="HF_Company_ID" Name="Company_ID" 
                                PropertyName="Value" Type="Int32" />
                            <asp:QueryStringParameter Name="Consumption_ID" QueryStringField="C_ID" 
                                Type="Decimal" />
                            <asp:Parameter Name="Sale_Return_Id" Type="Int32" Direction="InputOutput" />
                        </InsertParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="sdsSaleReturnSub" runat="server"
                     ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                     InsertCommand="usp_Insert_Sale_Return_Sub" 
                        InsertCommandType="StoredProcedure" oninserted="sdsSaleReturnSub_Inserted"
                    >
                        <InsertParameters>
                            <asp:Parameter Name="Sale_Return_Id" Type="Int32" />
                            <asp:Parameter Name="Effected_Item_Code" Type="String" />
                            <asp:Parameter Name="Effected_Item_QTY" Type="Int32" />
                            <asp:Parameter Name="PO_ID" Type="String" />
                            <asp:Parameter Direction="InputOutput" Name="Sale_Sub_Id" Type="Int32" />
                            <asp:Parameter Name="Consumption_Sub_Id" Type="Int32" />
                        </InsertParameters>
                    </asp:SqlDataSource>



                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="Return_Consumption_WiseItems"
                        SelectCommandType="StoredProcedure" InsertCommand="Insert_Store_Item_Return_Receive"
                        InsertCommandType="StoredProcedure">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="HF_IB_ID" Name="IB_ID" PropertyName="Value" Type="String" />
                            <%--<asp:ControlParameter ControlID="HF_deptid" Name="Receive_Dept_Id" PropertyName="Value"
                                Type="Int32" />--%>
                            <asp:ControlParameter ControlID="ddlDepartment" Name="Receive_Dept_Id" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:SessionParameter DefaultValue="" Name="Receive_Emp_Id" SessionField="Emp_ID"
                                Type="Int32" />
                            <%--<asp:ControlParameter ControlID="HF_Subdeptid" Name="Receive_Sub_dept_Id" PropertyName="Value"
                                Type="Int32" />--%>
                            <asp:ControlParameter ControlID="ddlSubDepartment" Name="Receive_Sub_dept_Id" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="ShiftID" Type="Int32" />
                            <asp:ControlParameter ControlID="HiddenFieldReceive_Main_id" DefaultValue="" Direction="InputOutput"
                                Name="Receive_Main_ID" PropertyName="Value" Type="Int32" />
                            <asp:ControlParameter ControlID="HF_Company_ID" Name="Company_ID" PropertyName="Value"
                                Type="Int32" />
                            <asp:Parameter DefaultValue="0" Name="Item_Issue_Main_ID" Type="Int32" />
                            <asp:ControlParameter ControlID="Hf_Item_Code" Name="Effected_Item_Code" PropertyName="Value"
                                Type="String" />
                            <asp:ControlParameter ControlID="HiddenField_Qty" Name="Effected_Item_QTY" PropertyName="Value"
                                Type="Double" />
                            <asp:ControlParameter ControlID="HF_Serial_No_ID" Name="ItemSerial_Id" PropertyName="Value"
                                Type="Decimal" />
                            <asp:ControlParameter ControlID="HiddenField_Purchase_Cost" Name="Effected_Purchase_Price"
                                PropertyName="Value" Type="Decimal" />
                            <asp:QueryStringParameter Name="Consumption_ID" QueryStringField="C_ID" 
                                Type="Decimal" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:QueryStringParameter Name="Consumption_Id" QueryStringField="C_ID" Type="Decimal" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="style3">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td align="center">
                
                    <asp:Label ID="LBL_MSG" runat="server"></asp:Label>
                    <br />
                    <asp:Button ID="btn_forward" runat="server" OnClick="btn_forward_Click" 
                        Text="Item Return" Visible="False" />
                   
                        <asp:Button ID="btnShow_return" runat="server" OnClick="btnShow_return_Click" 
                        Text="Show Return Items" Visible="true" />
                        
                    
                </td>
            </tr>
            <tr>
                <td align="center">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Large"
                        ForeColor="#FF6666" Text="Item Returned" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center">
                   
                </td>
            </tr>


            <tr>
                <td align="center">


                 <asp:GridView BackColor="LightGray" ID="gvReturnItems" runat="server" Width="80%"  Visible="False" 
                       AutoGenerateColumns="false">
                         <Columns>
                            <asp:BoundField DataField="Item_Name" HeaderText="Item" SortExpression="Item_Name" />
                            <asp:BoundField DataField="Item_Code" HeaderText="Item Code" SortExpression="Item_Code" />
                            <asp:BoundField DataField="MarkedQty" HeaderText="Selected Qty" SortExpression="MarkedQty" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDelete" runat="server" Text="Delete"
                                    CommandArgument='<%# Eval("Consumption_Detail_ID") %>' 
                                        onclick="btnDelete_Click"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                         </Columns>

                        </asp:GridView>
                       
                </td>
            </tr>





            <tr>
                <td align="right">
                    <asp:GridView ID="gvSerials" runat="server" Width="50%"  Visible="False" 
                        AutoGenerateColumns="False" DataSourceID="sdsSerials" 
                        EnableModelValidation="True" onprerender="gvSerials_PreRender">
                        <Columns>
                                 <asp:TemplateField HeaderText="Sr. #">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSr" runat="server" Font-Bold="true"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:BoundField DataField="Item_Code" HeaderText="Item Code" 
                                SortExpression="Item_Code" />
                            <asp:BoundField DataField="Serial_No" HeaderText="Serial #" 
                                SortExpression="Serial_No" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSerials" runat="server" Height="10" Width="50" />
                                        <asp:HiddenField ID="HF_Item_Code" runat="server" Value='<%# Eval("Item_Code") %>' />
                                        <asp:HiddenField ID="HF_ItemTagID" runat="server" Value='<%# Eval("Item_Tag_ID") %>' />
                                        <asp:HiddenField ID="HF_SerialNo" runat="server" Value='<%# Eval("Serial_No") %>'  />
                                        <asp:HiddenField ID="HF_SerialNO_Id" runat="server" Value='<%# Eval("Serial_No_ID") %>'  />
                                        <asp:HiddenField ID="HF_Consumption_Detail_ID" runat="server" Value='<%# Eval("Consumption_Detail_ID") %>'  />
                                        <asp:HiddenField ID="HF_Consumption_Serial_ID" runat="server" Value='<%# Eval("Consumption_Serial_ID") %>'  />

                                    </ItemTemplate>
                                </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsSerials" runat="server" 
                     ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                     SelectCommand="usp_Select_Serials_By_Consumption" SelectCommandType="StoredProcedure"
                     InsertCommand="usp_Insert_Serials_Return" InsertCommandType="StoredProcedure"
                    >
                        <InsertParameters>
                            <asp:ControlParameter ControlID="hdf_Receive_Sub_Id" Name="Receive_Sub_ID" 
                                PropertyName="Value" Type="Int32" />
                            <asp:Parameter Name="Serial_No" Type="String" />
                            <asp:Parameter Name="Previous_Serial_No_ID" Type="String" />
                            <asp:Parameter Name="PO_ID" Type="String" />
                            <asp:ControlParameter ControlID="hdf_Sale_Sub_Id" Name="Sale_Sub_Id" 
                                PropertyName="Value" Type="Int32" />
                            <asp:ControlParameter ControlID="hdf_Consumption_Sub_Id" 
                                Name="Consumption_Sub_Id" PropertyName="Value" Type="Int32" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:Parameter Name="Sub_Id" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <div style="text-align:right;">
                        <asp:Button ID="btnReturnSerials" runat="server" Text="Mark Item(s)" 
                            Visible="false" onclick="btnReturnSerials_Click" />
                    </div>
                    
                    </td>
            </tr>
            <tr>
                <td align="left" class="style2">
                    <asp:HiddenField ID="HF_IB_ID" runat="server" />
                    <asp:HiddenField ID="HF_Company_ID" runat="server" />
                    <asp:HiddenField ID="HF_Recieve_main_id" runat="server" />
                     <asp:HiddenField ID="hdf_Sale_Return_Id" runat="server" />
                     <asp:HiddenField ID="hdf_Receive_Sub_Id" runat="server" />
                     <asp:HiddenField ID="hdf_Sale_Sub_Id" runat="server" />
                     <asp:HiddenField ID="hdf_Consumption_Sub_Id" runat="server" />
                    <br />
                </td>
            </tr>
            <tr align="center">
                <td>
                    
                </td>
            </tr>
            
        </table>
        <br />
        <asp:SqlDataSource ID="sdsInserVoucher" runat="server" 
         ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
         InsertCommand="JV_ReturnItem_Stock_Received" InsertCommandType="StoredProcedure"
        >
            <InsertParameters>
                <asp:SessionParameter Name="By_Emp_Id" SessionField="Emp_Id" Type="Int32" />
                <asp:ControlParameter ControlID="ddlDepartment" Name="Receiving_Dept_Id" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ddlSubDepartment" Name="Receiving_SubDept_Id" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="HF_Recieve_main_id" Name="Receive_Main_ID" 
                    PropertyName="Value" Type="Decimal" />
                <asp:ControlParameter ControlID="HF_Company_ID" Name="Company_Id" 
                    PropertyName="Value" Type="Decimal" />
                <asp:Parameter Name="Amount" Type="Decimal" />
                <asp:QueryStringParameter Name="Consumption_ID" QueryStringField="C_ID" 
                    Type="Decimal" />
            </InsertParameters>
        </asp:SqlDataSource>
    
 
    </div>
    <br />

    </asp:Content>

