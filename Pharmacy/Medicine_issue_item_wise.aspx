<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Medicine_issue_item_wise.aspx.vb" MasterPageFile="~/hacims_masterpage_billing.master" Inherits="Medicine_issue_item_wise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
    <style type="text/css">
        
        #p_info ul {
            margin: 0;
            padding: 0px;
            font-size: 1em;
        }

        .bxmain_1 {
            min-height: 5em;
            min-width: 26em;
            margin-top: 0px;
            height: auto;
            width: 117%;
            margin-left: -126px;
            -top: 0px;
            border: #dddddd solid 1px;
            background: #f7f7f7;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            padding-top: 3px;
            padding-bottom: 3px;
            display: block;
        }

    </style>
   
   <style>
        .focus-button {
            transition: background-color 0.3s;
        }
        .focus-button:focus {
            background-color: #008000 !important; /* Change this to your desired color */
            outline: none; /* Optional: Remove the default outline */
        }
    </style>
    <script type="text/javascript">
        function changeButtonColor(button) {
            button.style.backgroundColor = "#008000"; // Change this to your desired color
        }

        function resetButtonColor(button) {
            button.style.backgroundColor = ""; // Reset to original color
        }
    </script>


    <script type="text/javascript">
        function clickButton(e, buttonId) {
            var key = e.keyCode || e.which; // cross-browser key code retrieval

            if (key === 13) { // Check if Enter key is pressed
                e.preventDefault(); // Prevent default form submission

                var btn = document.getElementById(buttonId); // Get the button object
                if (btn) {
                    btn.click(); // Trigger the button click event
                }
                return false;
            } else {
                return true; // Allow default behavior for other keys
            }
        }

       

</script>


   
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"  EnableCdn="true" >
    </asp:ScriptManager>
    
    
    

    <script type="text/javascript">
        
       $(document).ready(function () {
              $("#<%=TextBox_specificMedicine.ClientID %>").keyup(function (event) {
                  
                  if (event.keyCode == 13) {

                      $("#<%=Button1.ClientID %>").click();
                     
   
    }
});
        })
       
      <%--window.onload = function () {
            document.getElementById('<%= TextBox_specificMedicine.ClientID %>').focus();
        };--%>
        function discountfunction() {
            var discount = document.getElementById("ctl00_ContentPlaceHolder1_GridViewMedicine_ctl02_txtboxDiscount");
            //if (discount.value > 50) {
            //    discount.value = 50.00;
            //}
        }
        function doit_onkeypress(event) {

            
            if (event.keyCode == 13 || event.which == 13) {                             
                $("#<%=Button1.ClientID %>").click();
            }

        }



        //$(document).ready(function () {
        //    debugger;
        //    $("#ctl00_hlk_D_P1").hide();
        //});
      

</script>
    



    <div class="bxmain">
        <div class="bxmain inner_content">
            <h2>Medicine Issue Item Wise</h2>
            <div style="margin-top: -1.5em;">
                <table width="100%" cellpadding="0" cellspacing="0" class="table">
                    <li>
                        <asp:Button ID="Btn_Medication" runat="server" Text="Medication" Visible="false" />
                    </li>
                    <br />

                    <tr align="center">
                        <td align="right">Patient&nbsp;Mr#</td>
                        <td align="left">
                            <asp:TextBox Style="height: 1.8em; width: 22em;" Placeholder="Mr #" ID="txtboxMr" runat="server"></asp:TextBox></td>
                        <td align="right">Visit&nbsp;# </td>
                        <td align="left">
                            <asp:TextBox Placeholder="Visit No" Style="height: 1.8em; width: 22em;" ID="txtVisitNo" runat="server"></asp:TextBox>
                        </td>
                        <td align="left">
                            <asp:Button Style="padding: 0em 3em" runat="server" Text="Search" ID="btnSearch" />
                            &nbsp;
                   

                        </td>
                        <td>
                            <asp:Button ID="Btn_loadWI" runat="server" Text="Load Walk In Patient " Visible="false" /></td>
                    </tr>




                    <tr>
                        <td align="right">COD&nbsp;No.&nbsp;:</td>
                        <td>
                            <asp:TextBox ID="TextBox_CODNo" Style="height: 1.8em; width: 22em;" runat="server" CssClass="input_txt"
                                AutoPostBack="True" Enabled="False" ReadOnly="True" Width="45%"></asp:TextBox>
                        </td>
                        <td align="right" width="25%" style="height: 18px">Patient&nbsp;Name :</td>
                        <td width="60%" style="height: 18px">
                            <asp:TextBox Style="height: 1.8em; width: 22em;" ID="TextBox_PAtient_name" runat="server" Width="45%"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>



                    <tr>
                        <td align="right">Doctor:</td>
                        <td colspan="3">
                            <asp:TextBox ID="txtDoctorName" Style="height: 1.8em; width: 22em;" runat="server" CssClass="input_txt"
                                Width="45%"></asp:TextBox>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>



                    <tr id="isPatient" runat="server" style="display: contents">
                        <td align="right">Select&nbsp;:
                        </td>
                        <td colspan="3">
                            <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">--%>
                            <%--<contenttemplate>--%>

                            <asp:RadioButtonList ID="RadioButtonList_Medicine_OF" runat="server" AutoPostBack="True"
                                RepeatDirection="Horizontal">
                                <asp:ListItem Value="P">Patient Medicine &nbsp;&nbsp;</asp:ListItem>
                                <asp:ListItem Selected="True" Value="D">Department Medicine  &nbsp;&nbsp;</asp:ListItem>
                                <asp:ListItem Value="PK">Medicine Package &nbsp;&nbsp;</asp:ListItem>
                                <asp:ListItem Value="RQ">Requested Medicine</asp:ListItem>
                            </asp:RadioButtonList>
                            <asp:HiddenField ID="Hf_Med_Of" runat="server" Value="D" />
                            <%-- </contenttemplate>--%>
                            <%-- </asp:UpdatePanel>--%>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
                <hr style="margin-top: -21px; margin-bottom: -9px;" />

            </div>

    <br />
    <%--<asp:UpdatePanel ID="UpdatePanel2" runat="server">
    --%>
  <%--  <contenttemplate>--%>
        <div style="display: flex; align-items: flex-start;">
        <!-- Scrollable part of the table -->
        <div style="overflow-y: auto;">    
<table width="100%" border="1" cellspacing="0" cellpadding="0" class="" style="border-collapse: collapse;">
    <tr>
        <td valign="top" width="40%" style="background: url(../images_hacims/img_dots_ver.png) top right repeat-y;">

            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                <tr style="display: none">
                    <td width="20%" align="right">Type :</td>
                    <td width="80%">
                        <asp:RadioButtonList ID="RadioButtonList_medkind" runat="server" CssClass="text_boxtitle" OnSelectedIndexChanged="RadioButtonList_medkind_SelectedIndexChanged"
                            RepeatColumns="5" RepeatLayout="Flow">
                            <asp:ListItem Value="i%">INJ</asp:ListItem>
                            <asp:ListItem Value="t%">TAB</asp:ListItem>
                            <asp:ListItem Value="c%">CAP</asp:ListItem>
                            <asp:ListItem Selected="True" Value="%">ANY</asp:ListItem>
                        </asp:RadioButtonList></td>
                </tr>
                <tr id="pkg" runat="server" visible="false">
                    <td align="right">Packages :</td>
                    <td>
                        <asp:DropDownList ID="DropDownList_Admin_Service_Package" Width="239px" Font-Size="small" Height="23px"
                            Visible="true" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_Admin_Service_Package_SelectedIndexChanged"
                            DataTextField="MP_Name" DataValueField="AMP_ID">
                        </asp:DropDownList>
                        <asp:LinkButton ID="Label_Amount" runat="server" OnClick="lbl_Amount_Click" Font-Size="Medium">

                        </asp:LinkButton><asp:Label ID="lblinfo" runat="server" Visible="false" Text=" estimated" ForeColor="Gray"></asp:Label>
                    </td>
                </tr>
                <tr id="med" runat="server">
                    <td align="right">Name :</td>
                    <td>
                        <asp:TextBox ID="TextBox_specificMedicine" runat="server" CssClass="input_txt" Width="239px" BackColor="#66CCFF" BorderColor="#0066FF" Font-Bold="True" Font-Size="Medium"  onkeypress="doit_onkeypress(event);" Height="28px"></asp:TextBox>

                    </td>

                </tr>
                  <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                                        MinimumPrefixLength="3" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="TextBox_specificMedicine" FirstRowSelected="true"    CompletionListCssClass="AutoExtender" 
                      CompletionListItemCssClass="AutoExtenderList"
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight" >
                                    </asp:AutoCompleteExtender>
                <tr id="medc" runat="server">
                    <td align="right">Medicine Code:</td>
                    <td>
                        <asp:TextBox ID="TextBox_Med_Code" runat="server" Width="239px" Height="28px" CssClass="input_txt" TabIndex="20"></asp:TextBox>

                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="Button1" runat="server" Text="Search" Width="80px" TabIndex="19" />
                         <asp:LinkButton ID="lnkReport" style="float:right;margin-right: 30px;" runat="server" Font-Bold="true" ForeColor="Blue" Visible="false" Text="View Slip" PostBackUrl="~/Pt_EMR/MedicineSlip.aspx"></asp:LinkButton>
                    </td>
                </tr>
            </table>







            <br />
            <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>--%>
            <div>
                <asp:GridView ID="GridViewMedicine" runat="server" AutoGenerateColumns="False"
                    Width="98%" AllowSubmitOnEnter="true" EnableKeyboardShortcuts="true"
                    AllowPaging="True" PageSize="50">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr #">
                            <ItemTemplate>
                                <%#Container.DataItemIndex + 1%>
                            </ItemTemplate>
                            <ItemStyle Width="8%" />
                        </asp:TemplateField>
                        <%-- <asp:BoundField DataField="Stock" HeaderText="Stock" SortExpression="Stock" />--%>
                        <asp:BoundField DataField="MedCode" HeaderText="MedCode" ReadOnly="True" SortExpression="MedCode"
                            Visible="False" />
                        <asp:ButtonField DataTextField="Medicine Name" HeaderText="Medicine Name"  Visible="False" CommandName="Select" SortExpression="Medicine Name" />
                        <asp:BoundField DataField="Medicine Name" HeaderText="Medicine Name" SortExpression="Medicine Name"
                            Visible="False" />
                        <asp:TemplateField HeaderText="Medicine Name">
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lnkMedicineName" CommandName="Select" Text='<%# Eval("Medicine Name") %>' TabIndex="18"></asp:LinkButton>
                                           <asp:HiddenField runat="server" ID="hf_Sub_ID" Value='<%# Eval("Sub_id") %>' />   
                                            <asp:Label ID="lblPara" runat="server" Text='<%# Eval("Para") %>'></asp:Label>  
                                        </ItemTemplate>
                         </asp:TemplateField>
                        <asp:TemplateField HeaderText="Batch No." SortExpression="BatchNo">
                            
                            <ItemTemplate>
                                <asp:Label ID="lblBatch" runat="server" Text='<%# Bind("BatchNo") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Expire Date " SortExpression="exp">
                            
                            <ItemTemplate>
                                <asp:Label ID="lblExpire" runat="server" Text='<%# Bind("exp") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qty Issue">
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox_Qty" Visible="true" runat="server" CssClass="input_txt" Width="50px" OnTextChanged="TextBox_Qty_TextChanged" TabIndex="17"></asp:TextBox>

                                <%-- <asp:TextBox ID="TextBox_Qty" Visible="false" runat="server" Text='<%# Bind("Default_Qty", "{0}") %>' CssClass="input_txt" Width="50px" ></asp:TextBox>--%>
                                <asp:HiddenField ID="HiddenField_RetailPrice" runat="server" Value='<%# Eval("Retail_Unit_Price", "{0}") %>' />
                                <asp:HiddenField ID="HiddenFieldMedCode" runat="server" Value='<%# Eval("MedCode", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_s_ID" runat="server" Value="3161" />
                                <asp:HiddenField ID="HiddenField_Reg_No" runat="server" />
                                <asp:HiddenField ID="hdfDefaultQty" runat="server" Value='<%# Bind("PQty") %>' />
                                <asp:HiddenField ID="HfIsNarcotic" runat="server" Value='<%# Bind("Is_Narcotic") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Stock">
                            <ItemTemplate>
                                <asp:Label ID="lbl_Batch_Qty" runat="server" Text='<%# Bind("Stock", "{0}") %>'></asp:Label>

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Discount" SortExpression="Discount (%)">

                            <ItemTemplate>
                                <asp:TextBox ID="txtboxDiscount" TextMode="Number" onblur="discountfunction()" onkeyup="discountfunction()" Enabled="true" min="0" max="100" MaxLength="2" runat="server" Text='<%# Bind("Discount")%>' Width="50px" TabIndex="16"></asp:TextBox>


                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sale Price" SortExpression="Retail_Unit_Price">

                            <ItemTemplate>

                                <asp:TextBox ID="TextBox_RetailPrice" runat="server" Text='<%# Bind("Retail_Unit_Price") %>' Width="50px" TabIndex="15" Enabled="false"></asp:TextBox>

                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Batch">
                            <ItemTemplate>

                                <asp:DropDownList ID="DropDownList1" runat="server"
                                    DataTextField="BatchNo" DataValueField="BatchNo" AutoPostBack="true" Width="80px">
                                </asp:DropDownList>
                                <%--DataSourceID="SqlDataSourceBatch"--%>

                                <asp:HiddenField ID="HiddenField3" runat="server" Value='<%# Eval("MedCode", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_MedName" runat="server" Value='<%# Eval("[Medicine Name]") %>' />
                                <asp:SqlDataSource ID="SqlDataSourceBatch" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="
SELECT ISNULL(Batch_No, 'Nil') AS BatchNo,Count(Item_code) Qty
FROM         Store_Item_TagNo
WHERE   (Item_Code = @Item_Code) and Consumption_ID is null
AND Receive_SubDept_ID = @Sub_dept_Id
GROUP BY ISNULL(Batch_No, 'Nil')"
                                    CancelSelectOnNullParameter="False">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="HiddenField3" Name="Item_Code" PropertyName="Value" />
                                        <%--<asp:SessionParameter Name="Dept_Id" SessionField="dept_id" />--%>
                                        <asp:SessionParameter Name="Sub_dept_Id" SessionField="SubDeptId" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:HiddenField ID="hfd_batchNo" runat="server" />

                            </ItemTemplate>
                            <ControlStyle CssClass="hide" />
                            <FooterStyle CssClass="hide" />
                            <HeaderStyle CssClass="hide" />
                            <ItemStyle CssClass="hide" />
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
            </div>
            <br />
            <asp:HiddenField ID="hfd_last_item_changed" runat="server" />
            <asp:HiddenField ID="hfd_item_batch" runat="server" />
            <%--    </ContentTemplate>
    </asp:UpdatePanel>--%>

            <asp:HiddenField ID="Hf_deptid" runat="server" />
            <asp:HiddenField ID="Hf_Subdeptid" runat="server" />
            <asp:HiddenField ID="HiddenField_Qty" runat="server" />
            <asp:SqlDataSource ID="SDS_Consumption_Voucher"
                runat="server"
                ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                InsertCommand="[JV_ItemConsumption_Voucher]"
                InsertCommandType="StoredProcedure"
                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:Parameter Name="Consumption_Id" Type="Decimal" />
                    <asp:Parameter Name="IB_ID" Type="String" />
                    <asp:Parameter Name="By_Emp_Id" Type="Int32" />
                    <asp:Parameter Name="Designation_Id" Type="Int32" />
                    <asp:Parameter Name="SubDept_Id" Type="Decimal" />
                    <asp:Parameter Name="Dept_Id" Type="Decimal" />
                    <asp:Parameter Name="Company_Id" Type="Decimal" />
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:HiddenField ID="HiddenField_MedCode" runat="server" />
            <asp:HiddenField ID="HiddenField_MainId" runat="server" />
            <asp:SqlDataSource ID="SqlDataSourceInsertMain" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                InsertCommand="Store_Item_Issue_To_Patient_Main" InsertCommandType="StoredProcedure"
                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBox_CODNo" Name="YearlyNo" PropertyName="Text"
                        Type="Decimal" />
                    <asp:SessionParameter Name="ShiftID" SessionField="ShiftID" Type="Int32" />
                    <asp:SessionParameter Name="Issue_By_Dept_ID" SessionField="Dept_id" Type="Int32" />
                    <asp:SessionParameter Name="Issue_By" SessionField="Emp_id" Type="Int32" />
                    <asp:SessionParameter Name="Issue_By_Sub_Dept_ID" SessionField="SubDeptId" Type="Int32" />
                    <asp:ControlParameter ControlID="DropDownList_Department" Name="Issue_To_Dept_Id"
                        PropertyName="SelectedValue" Type="Int32" />
                    <asp:Parameter Direction="InputOutput" Name="Issue_By_Main_Id" Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceInsertSub" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                InsertCommand="Insert_Store_Item_Issue_Sub" InsertCommandType="StoredProcedure"
                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:ControlParameter ControlID="HiddenField_MedCode" Name="Item_Code" PropertyName="Value"
                        Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_Qty" Name="Item_Qty" PropertyName="Value"
                        Type="Int32" />
                    <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" Type="Int32" />
                    <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" Type="Int32" />
                    <asp:ControlParameter ControlID="HiddenFieldBatchNo" Name="BatchNo" PropertyName="Value"
                        Type="String" />
                    <asp:ControlParameter ControlID="HiddenField_MainId" Name="Store_Item_Issue_Id" PropertyName="Value"
                        Type="Decimal" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:HiddenField ID="HiddenFieldBatchNo" runat="server" />
            <asp:HiddenField ID="HiddenField_s_ID" runat="server" Value="3161" />
            <asp:HiddenField ID="HiddenField_Reg_No" runat="server" />
            <asp:HiddenField ID="HiddenField_amount" runat="server" />
            <asp:HiddenField ID="HF_Emp_subdept" runat="server" />
            <asp:HiddenField ID="HF_Emp_dept" runat="server" />
            <asp:HiddenField ID="HiddenField_smpID" runat="server" />
            <asp:HiddenField ID="HF_PS_ID" runat="server" />
            <asp:HiddenField ID="HF_Pay_MainId" runat="server" />
            <asp:HiddenField ID="HF_Yearly_no" runat="server" />
            <asp:HiddenField ID="HiddenFieldAmount" runat="server" />



        </td>
        <td>
            <div align="center" style="margin-top:-20%;margin-right:10px;"> 
       <asp:Panel ID="pnladditions" visible="false" runat="server" width="300px">
       <fieldset>
       <table style="width:130%">
           <tr>
               <td  >
        Subtract : 
               </td>
               <td>
                   <asp:TextBox ID="txtSubtract" runat="server" Width="100px" textmode="number" AutoPostBack="true" min="0" max="10" TabIndex="14">0</asp:TextBox>
               </td>
               </tr>
           <tr>
               <td>
       Addition : 
                   </td>
               <td>
                   <asp:TextBox ID="txtAddition"   Width="100px" textmode="number" runat="server" AutoPostBack="true" min="0" max="10" TabIndex="13">0</asp:TextBox>
               </td>
               </tr>
           <tr  >
               <td>
        Total Bill : 
               </td>
               <td>
                   <asp:Label ID="lblBillTotalAmount" runat="server" Text="0" style="color: red; font-weight: bold;">0</asp:Label>
               </td>
               </tr>
           <tr>
               <td>
                   Cash Received : 
               </td>
               <td>
                   <asp:TextBox ID="txtCashReceived" Width="100px" runat="server" AutoPostBack="true" textmode="number" min="0" TabIndex="12">0</asp:TextBox>
               </td>
               </tr>
           <tr> 
               <td>
        Remaning Cash : 
               </td>
               <td>
                   <asp:Label ID="lblGreatGrandTotal" runat="server" TabIndex="11">0</asp:Label>
               </td>
               </tr>
           <tr>             
               <td>
                 <asp:Button ID="Btn_Bill" runat="server" Text="Add to Bill"
                     Enabled="true" TabIndex="2" onfocus="changeButtonColor(this)"
                        onblur="resetButtonColor(this)"  CssClass="focus-button"/>
               
                </td>
               <td align="left">
                    <asp:Button ID="Button_Consumption" runat="server" Text="Issue" width="100px"
                        CssClass="focus-button"
                        OnClientClick="javascript: return confirm('Are you sure you want to Save and print?')"
                        onfocus="changeButtonColor(this)"
                        onblur="resetButtonColor(this)"/>
               </td>
               <td>
                 <asp:Button ID="btn_CreditPayment" runat="server" Text="Credit Payment"
                     Enabled="true" Visible="false" />
               
                </td>
               <td>&nbsp;</td>
               <td>&nbsp;</td>
               </tr>
           </table>
            </fieldset>
           </asp:Panel>
      <%-- </ContentTemplate></asp:UpdatePanel>--%>
    <br />
    <asp:Label ID = "Label1" runat = "server" ForeColor = "Red"></asp:Label>
    </div>
        </td>
        <td valign="top" width="80%" style="background: url(../images_hacims/img_dots_ver.png) top right repeat-y;">

            <br />
            <%--<asp:UpdatePanel ID="UpdatePanel2" runat="server"><ContentTemplate>--%>
            <asp:GridView ID="GridView_TemP_Test" runat="server" ShowFooter="True" 
                Width="96%" Style="margin-left: 10px;  border: 1px solid #e4e4e4 !IMPORTANT;" AutoGenerateColumns="False">
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
                <Columns>
                    <asp:TemplateField HeaderText="Sr #">
                        <ItemTemplate>
                         <%#Container.DataItemIndex+1%>
                        </ItemTemplate>
                        <ItemStyle Width="4%" />
                    </asp:TemplateField>
                    <asp:ButtonField CommandName="Select" ButtonType="Image" ImageUrl="~/images/deletebtn.png"/>
                    <asp:TemplateField HeaderText="Code">
                        <ItemTemplate>
                            <asp:Label ID="lbl_CODE" runat="server" Text='<%# Bind("Medcode") %>' Width="70px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Medicine" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lbl_med" runat="server" Text='<%# Bind("MedName") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <b>Total :</b>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="QTY" FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:TextBox ID="lbl_Qty" runat="server" Text='<%# Bind("Qty") %>' Width="40px" AutoPostBack="true" TabIndex="6"></asp:TextBox>
                            <asp:HiddenField ID="hf_sub_id" runat="server" Value='<%# Bind("Sub_ID") %>' />
                            <asp:HiddenField ID="hfstock" runat="server" Value='<%# Bind("Stock") %>' />
                            <%--<asp:Label ID="lbl_Qty" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>--%>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lblTotalQty" runat="server"></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Retail Price">
                        <ItemTemplate>
                            <asp:Label ID="lbl_total" runat="server" Text='<%# Bind("Total") %>'></asp:Label>
                            <asp:HiddenField ID="hf_datetime" runat="server" Value='<%# Bind("Date_Time") %>' />
                        </ItemTemplate>
                        <FooterTemplate>
                            --
                            <asp:Label ID="lbl_R_totalSum" runat="server" Font-Bold="True" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Gross Amount" FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Gross" runat="server" Text='<%# Bind("GrossAmount") %>'></asp:Label>

                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lblTotalGrossAmount" runat="server"></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Dis(%)">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Discount" runat="server" Text='<%# Bind("Discount")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Dis Amount" FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lbl_DiscountAmount" runat="server" Text='<%# Bind("DiscountAmount")%>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lbl_TotalDiscountAmount" runat="server"></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Net Amount" FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Rate" runat="server" Text='<%# Bind("NetAmount")%>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lbl_totalSum" runat="server" Font-Bold="True" />
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Batch No." >
                        <ItemTemplate>
                            <asp:Label ID="lbl_Batch" runat="server" Text='<%# Bind("BatchNO") %>'></asp:Label>
                             
                        </ItemTemplate>
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Expire Date" >
                        <ItemTemplate>
                            <asp:Label ID="lbl_ExpDate" runat="server" Text='<%# Bind("ExpiryDate") %>'></asp:Label>
                             
                        </ItemTemplate>
                     
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Is Narcotics" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblIsNarcotics" runat="server" Text='<%# Bind("IsNarcotics")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Narcotics Details" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblNarcoticsDetails" runat="server" Text='<%# Bind("NarcoticsDetails")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
                <FooterStyle CssClass="GridHeader" />
            </asp:GridView>
            <div align="center">
              

                <%--</ContentTemplate></asp:UpdatePanel>--%>
                <br />
                <asp:Label ID="lbl_Message" runat="server" ForeColor="Red"></asp:Label>
            </div>
            
            <asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                DeleteCommand="Delete_Issue_Item_To_Patient" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                SelectCommand="SELECT Store_Item_Issue_Main.YearlyNo AS [COD No.], CONVERT (varchar, Store_Item_Issue_Main.Issue_Date, 107) AS Date, CONVERT (varchar, Store_Item_Issue_Main.Issue_Date, 108) AS Time, ISNULL(Store_Items.Item_Name, '') + ' ' + ISNULL(Store_Items.Unit, '') + ' ' + ISNULL(Store_Items.Potency, '') AS [Medicine Name], Store_Item_Issue_Sub.Item_Qty, Store_Item_Issue_Sub.ID, ISNULL(Store_Items.Retail_Unit_Price, 0) AS Retail_Unit_Price FROM Store_Item_Issue_Main INNER JOIN Store_Item_Issue_Sub ON Store_Item_Issue_Main.Store_Item_Issue_Id = Store_Item_Issue_Sub.Store_Item_Issue_Id INNER JOIN Store_Items ON Store_Item_Issue_Sub.Item_Code = Store_Items.Item_Code WHERE (Store_Item_Issue_Main.YearlyNo = @yearlyNo)" DeleteCommandType="StoredProcedure">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="GridViewMedicineIssue" Name="ID" PropertyName="SelectedValue"
                        Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox_CODNo" Name="yearlyNo" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:SqlDataSource ID="SqlDataSourceCounterClose" runat="server"
                ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                InsertCommand="Insert_Counter_Close_Sub" InsertCommandType="StoredProcedure"
                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                <InsertParameters>
                    <asp:Parameter DefaultValue="0" Name="Main_Id" />
                    <asp:ControlParameter ControlID="HiddenField_amount" Name="Amount"
                        PropertyName="Value" />
                    <asp:Parameter DefaultValue="Bill" Name="Amount_Type" />
                    <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" />
                    <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
                    <asp:SessionParameter DefaultValue="" Name="Reg_No" SessionField="RegistrationNo" />
                    <asp:SessionParameter Name="YearlyNo" SessionField="yearlyNo" />
                    <asp:Parameter DefaultValue="medication" Name="PaymentCategory" />
                    <asp:SessionParameter Name="EMP_ID" SessionField="emp_id" Type="Int32" />
                    <asp:ControlParameter ControlID="HiddenField_smpID" Name="SMP_ID"
                        PropertyName="Value" Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>
        </td>
        <td valign="top" width="25%">
            <%-- <asp:BoundField DataField="Stock" HeaderText="Stock" SortExpression="Stock" />--%>

            <%--<asp:UpdatePanel ID="UpdatePanel3" runat="server"><ContentTemplate>--%>
            <asp:GridView ID="DataList_Patient_Consumption" runat="server"
                DataKeyField="Consumption_Id" AutoGenerateColumns="False"
                DataKeyNames="Consumption_Id" ShowFooter="True">
                <Columns>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1%>
                        </ItemTemplate>

                    </asp:TemplateField>

                    <asp:BoundField DataField="Consumption_Id" HeaderText="Slip No."
                        InsertVisible="False" ReadOnly="True" SortExpression="Consumption_Id" />
                    <asp:BoundField DataField="Item_Name" HeaderText="Medicine"
                        SortExpression="Item_Name" />
                    <asp:BoundField DataField="Consumed_QTY" HeaderText="Qty"
                        SortExpression="Consumed_QTY" />
                    <asp:TemplateField HeaderText="Amount" Visible="false">

                        <ItemTemplate>
                            <asp:Label ID="Lbl_Amount" runat="server"
                                Text='<%# Eval("ptcharege", "{0:#,#}") %>'></asp:Label>
                        </ItemTemplate>

                    </asp:TemplateField>
                    <asp:HyperLinkField DataNavigateUrlFields="Consumption_Id"
                        DataNavigateUrlFormatString="~/pharmacy/Consumed_Medicine_Report.aspx?C_ID={0}"
                        HeaderText="Report" Target="_blank" Text="Print" />
                    <asp:HyperLinkField DataNavigateUrlFields="Consumption_Id"
                        DataNavigateUrlFormatString="~/pharmacy/Pharmacy_ReturnItems.aspx?C_ID={0}"
                        HeaderText="Report" Target="_blank" Text="Return" />
                </Columns>
            </asp:GridView>
            <%--</ContentTemplate></asp:UpdatePanel>--%>
            <br />

            <div align="center">
                <asp:HyperLink ID="HYLK_Print" Target="_blank"
                    NavigateUrl="~/Pharmacy/Consumed_Medicine_Rpt.aspx" runat="server" Visible="false"
                    Font-Underline="False" CssClass="btn_hacims">Print Report</asp:HyperLink>
                <asp:Button ID="Button_Print" runat="server" Text="Print Report" Visible="false" />
            </div>
            <br />
            <asp:SqlDataSource ID="SqlDataSource_Patient_Consumption" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT Top(10) CONVERT(varchar, StoreItem_Consumption_Main.Consumed_Date, 103) AS Consumed_Date, StoreItems_Consumption_Detail.Item_Code, 
                      ISNULL(Store_Items.Drug_Category + ' ', '') + ISNULL(Store_Items.Item_Name + '', '') + ISNULL(Store_Items.Potency + '', '') + ISNULL(Store_Items.Unit + '', '') 
                      AS Item_Name, SUM(StoreItems_Consumption_Detail.Consumed_QTY) AS Consumed_QTY, StoreItem_Consumption_Main.Consumption_Id, 
                      StoreItems_Consumption_Detail.Consume_Amount, sum(StoreItems_Consumption_Detail.Pt_Charge_Consumption) as ptcharege
FROM         StoreItem_Consumption_Main INNER JOIN
                      StoreItems_Consumption_Detail ON StoreItem_Consumption_Main.Consumption_Id = StoreItems_Consumption_Detail.Consumption_Id INNER JOIN
                      Store_Items ON StoreItems_Consumption_Detail.Item_Code = Store_Items.Item_Code
WHERE     (StoreItem_Consumption_Main.SubDept_Id = @SubDept_Id) AND (StoreItem_Consumption_Main.Yearly_No = @Yearly_No) and (Convert(varchar,StoreItem_Consumption_Main.Consumed_Date,112) = Convert(varchar,getdate(),112))
GROUP BY StoreItem_Consumption_Main.Yearly_No, StoreItem_Consumption_Main.Consumed_Date, StoreItem_Consumption_Main.Consumption_Id, 
                      StoreItems_Consumption_Detail.Item_Code, ISNULL(Store_Items.Drug_Category + ' ', '') + ISNULL(Store_Items.Item_Name + '', '') + ISNULL(Store_Items.Potency + '', 
                      '') + ISNULL(Store_Items.Unit + '', ''), StoreItems_Consumption_Detail.Consume_Amount

">
                <SelectParameters>

                    <asp:SessionParameter Name="SubDept_Id" SessionField="subdeptID" />
                    <asp:ControlParameter ControlID="TextBox_CODNo" Name="Yearly_No" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>

        </td>
    </tr>
  <tr>
  <td colspan = "3" align ="center">

      <asp:Panel ID="Pnl_Medication" runat="server"  Visible ="false" >
      <%--CssClass = "lightbox"--%>
      <table>
              <tr>
                      
              <td>
          </td>
              <td>
              <asp:Button ID = "Btn_Close" runat = "server" Text = "Close" />
              </td>
          </tr>
          <tr>
              <td colspan = "2">

                  <asp:DataList ID="DataList_ConfirmedPrescriptions" runat="server" 
                      DataKeyField="priscription_id" 
                      DataSourceID="SqlDataSource_Confirmed_Prescriptions" style="margin-left:15px;" 
                      Width="90%">
                      <ItemTemplate>
                          <ul class="medication">
                              <li style="border-bottom: #cccccc dotted 1px; border-right: 0; border-left: 0;">
                                  <strong class="mname"><%# Eval("[Medicine Name]") %></strong><%#Eval("Para")%>
                              </li>
                              <li style="text-align :right;"><%#Eval("para_Urdu")%>
                                  </l </ul="">
                                  <asp:HiddenField ID="HiddenField_PrescriptionID0" runat="server" 
                                      Value='<%# Eval("priscription_id") %>' />
                              </li>
                          </ul>
                      </ItemTemplate>
                  </asp:DataList>
                  <asp:SqlDataSource ID="SqlDataSource_Confirmed_Prescriptions" runat="server" 
                      ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>" 
                      DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)" 
                      SelectCommand="Select_Med_Presc_Urdu" SelectCommandType="StoredProcedure">
                      <SelectParameters>
                          <asp:SessionParameter Name="RegNo" SessionField="registrationno" 
                              Type="String" />
                          <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                      </SelectParameters>
                      <DeleteParameters>
                          <asp:ControlParameter Name="priscription_id" Type="String" />
                      </DeleteParameters>
                  </asp:SqlDataSource>

              </td>
          </tr>
      </table>
      </asp:Panel>

      <asp:Panel ID="pnlNarcotics" runat="server" CssClass="lightbox" Visible="false">
        <div class="inner_content" style="width:100%;">
            <h2>Enter Narcotics Details</h2>
            <asp:GridView ID="grdNarcotics" runat="server" ShowFooter="True" 
                Width="96%" Style="margin-left: 10px;  border: 1px solid #e4e4e4 !IMPORTANT;" AutoGenerateColumns="False">
                <RowStyle CssClass="GridItem" />
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
                <Columns>
                    <asp:TemplateField HeaderText="Sr #">
                        <ItemTemplate>
                         <%#Container.DataItemIndex+1%>
                        </ItemTemplate>
                        <ItemStyle Width="4%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Item Code">
                        <ItemTemplate>
                            <asp:Label ID="lbl_CODE" runat="server" Text='<%# Bind("Medcode") %>' Width="70px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Medicine" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lbl_med" runat="server" Text='<%# Bind("MedName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="QTY" FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:TextBox ID="lbl_Qty" runat="server" Text='<%# Bind("Qty") %>' Width="40px" AutoPostBack="true"></asp:TextBox>
                           <%-- <asp:HiddenField ID="hdfStock" runat="server" Text='<%# Bind("Qty") %>' />--%>
                            <%--<asp:Label ID="lbl_Qty" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>--%>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lblTotalQty" runat="server"></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Details">
                        <ItemStyle width="50%"/>
                        <ItemTemplate>
                            <asp:TextBox ID="txtDetails" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                   <%-- <asp:TemplateField HeaderText="Retail Price">
                        <ItemTemplate>
                            <asp:Label ID="lbl_total" runat="server" Text='<%# Bind("Total") %>'></asp:Label>
                            <asp:HiddenField ID="hf_datetime" runat="server" Value='<%# Bind("Date_Time") %>' />
                        </ItemTemplate>
                        <FooterTemplate>
                            --
                            <asp:Label ID="lbl_R_totalSum" runat="server" Font-Bold="True" />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Gross Amount" FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Gross" runat="server" Text='<%# Bind("GrossAmount") %>'></asp:Label>

                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lblTotalGrossAmount" runat="server"></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Dis(%)">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Discount" runat="server" Text='<%# Bind("Discount")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Dis Amount" FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lbl_DiscountAmount" runat="server" Text='<%# Bind("DiscountAmount")%>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lbl_TotalDiscountAmount" runat="server"></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Net Amount" FooterStyle-Font-Bold="true" FooterStyle-HorizontalAlign="Right">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Rate" runat="server" Text='<%# Bind("NetAmount")%>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lbl_totalSum" runat="server" Font-Bold="True" />
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Batch No." ControlStyle-CssClass="hide">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Batch" runat="server" Text='<%# Bind("BatchNO") %>'></asp:Label>
                             
                        </ItemTemplate>
                        <ControlStyle CssClass="hide" />
                        <FooterStyle CssClass="hide" />
                        <HeaderStyle CssClass="hide" />
                        <ItemStyle CssClass="hide" />
                    </asp:TemplateField>--%>

                </Columns>
                <FooterStyle CssClass="GridHeader" />
            </asp:GridView>
            <br />
            <div style="text-align:center;">
            <asp:Button ID="btnSaveNarcotics" runat="server" Text="Save" OnClick="btnSaveNarcotics_Click"/>
                </div>
        </div>
    </asp:Panel>

  </td>
  </tr>
</table>
            </div>
             </div>
</div>
<br />
<br />
<br />
    <asp:HiddenField ID="HfIBID" runat="server" Value="0"/>
<%--</contenttemplate>--%>
    <%--CssClass = "lightbox"--%>
</asp:Content>
