<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Patient_Sample.aspx.vb"  MasterPageFile="~/hacims_masterpage_billing.master" Inherits="Pathology_Patient_Sample" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
 <style type="text/css">
 
 #nav {display:none; }
     .style1
     {
         width: 26%;
     }
     .style2
     {
         height: 29px;
         width: 26%;
     }
 p.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:10.0pt;
	margin-left:0in;
	line-height:115%;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	}
 </style>
 
 
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain">

   <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form" >
        <tr style = " display:none; ">
            <td align="right" class="style1">
                </td>
            <td style="width: 311px" >
                <asp:TextBox ID="TextBox_Sample_no" runat="server" Width="200px" Visible="False"></asp:TextBox></td>
            <td align="right"  width="25%"><asp:DropDownList ID="DropDownList_sample" runat="server" DataSourceID="SqlDataSource_Sample"
                    DataTextField="Sample_Name" DataValueField="Sample_Id"  Width="240px"  >
            </asp:DropDownList>
                :</td>
            <td width="25%" >
                </td>
        </tr>
        <tr>
            <td align="right" class="style1"  >
                &nbsp;</td>
          <td colspan="3" ><asp:DropDownList ID="DropDownList_PreRefrenceNo" runat="server" 
                  Width="208px" DataSourceID="SqlDataSource_Reference_Sample" 
                  DataTextField="Sample_No" DataValueField="Sample_No" >
            </asp:DropDownList></td>
        </tr>
       <tr>
           <td align="right" class="style1" >
               Collected at :</td>
           <td >
              <asp:RadioButtonList ID="RadioButtonList1" runat="server" 
                   RepeatDirection="Horizontal" Height="16px" Width="300px" AutoPostBack="True">
                    <asp:ListItem Selected="True">Main Lab</asp:ListItem>
                    <asp:ListItem>Satellite Center</asp:ListItem>
                </asp:RadioButtonList>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <asp:DropDownList ID="DropDownList_Outlet" runat="server" Width="136px" Visible="False" DataSourceID="SqlDataSource_Outlet" DataTextField="Outlet_Name" DataValueField="Outlet_ID"  >
               </asp:DropDownList>
               </td>
           <td >
               &nbsp;
               <asp:DropDownList ID="DropDownList_OutSideLab" runat="server" Width="136px" Visible="False" DataSourceID="SqlDataSource_OutSideLab" DataTextField="OutSideLab_Name" DataValueField="OutSideLab_ID"  >
               </asp:DropDownList>
               <asp:TextBox ID="TextBox_Out_Side_Lab_No" runat="server" Width="200px" Visible="False"></asp:TextBox></td>
           <td >
           </td>
       </tr>
       <tr style ="display:none ">
           <td align="right" class="style1" >
               &nbsp;<p class="MsoNormal">
                   Performed at</p>
           </td>
           <td >
              <asp:RadioButtonList ID="RadioButtonList2" runat="server" 
                   RepeatDirection="Horizontal" Height="16px" Width="440px" AutoPostBack="True">
                    <asp:ListItem Selected="True">Main Lab</asp:ListItem>
                    <asp:ListItem Value="Satellite Cente">Send Out</asp:ListItem>
                </asp:RadioButtonList></td>
           <td >
               &nbsp;</td>
           <td >
               &nbsp;</td>
       </tr>
        <tr>
            <td align="right" class="style2" >
                Bar Code :</td>
            <td style="width: 311px; height: 29px" >
                <asp:Panel runat="server" DefaultButton="lnkSearch">
                <asp:TextBox ID="txtbox_BarCode" runat="server"></asp:TextBox>
                <asp:LinkButton ID="lnkSearch" runat="server" Text="Search" style="display:none" OnClick="lnkSearch_Click"></asp:LinkButton>
                    </asp:Panel>
            </td>
            <td style="height: 29px" >
                &nbsp;</td>
            <td style="height: 29px" >
                &nbsp;</td>
        </tr>
        <tr>
            <td align="right" class="style2" >
                Clinical Diagnosis :</td>
            <td style="width: 311px; height: 29px" >
                <asp:TextBox ID="TextBox_Description" runat="server" Height="48px" TextMode="MultiLine" Width="464px"></asp:TextBox></td>
            <td style="height: 29px" >
            </td>
            <td style="height: 29px" >
            </td>
        </tr>
        <tr>
           <td align="right" class="style2">
               Select Printer Location:
           </td>
           <td>
               <asp:DropDownList id="ddPrinterLocation"
                AppendDataBoundItems="True" ValidationGroup="g1"
                runat="server"  AutoPostBack = "true">
              <asp:ListItem  Value="0">----Select----</asp:ListItem>
                   <asp:ListItem  Value="P-01">P-01</asp:ListItem>
                   <asp:ListItem  Value="P-02">P-02</asp:ListItem>
                   <asp:ListItem  Value="P-03">P-03</asp:ListItem>
                   <asp:ListItem  Value="P-04">P-04</asp:ListItem>
                   <asp:ListItem  Value="P-05">P-05</asp:ListItem>
                   <asp:ListItem  Value="P-06">P-06</asp:ListItem>

           </asp:DropDownList>
           </td>
            <asp:CompareValidator ControlToValidate="ddPrinterLocation" ID="CompareValidator1"
    ValidationGroup="g1" CssClass="errormesg" ErrorMessage="Please select a type"
    runat="server" Display="Dynamic" 
    Operator="NotEqual" ValueToCompare="0" Type="Integer" />
       </tr>
       <tr>
           <td align="right" class="style2">
           </td>
           <td style="width: 311px; height: 29px">
           </td>
           <td style="height: 29px">
           </td>
           <td style="height: 29px">
           </td>
       </tr>
       <tr>
           <td align="right" class="style1">
               
           <td style="width: 311px">
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="SqlDataSource_Specimen" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="TB_Name" HeaderText="Name" SortExpression="TB_Name" />
                        <asp:BoundField DataField="Specimen_Required_By_Test" HeaderText="Specimen Required For Test"
                            SortExpression="Specimen_Required_By_Test" />
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">Check All</asp:LinkButton>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox_Status" runat="server" Checked="True" />
                                <asp:HiddenField ID="HiddenField_TB_ID" runat="server" Value='<%# Eval("TB_ID", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_ID" runat="server" Value='<%# Eval("ID", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_S_ID" runat="server" Value='<%# Eval("S_Id") %>' />
                                <asp:HiddenField ID="HfTGID" runat="server" Value='<%# Eval("MG_ID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Send Out">
                            <ItemTemplate>
                                <asp:CheckBox ID="CH_Other_Lab" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkPrintBarCode" runat="server" Visible="false" CommandArgument='<%# Eval("TB_ID") %>' CommandName='<%# Eval("MG_ID") %>' OnClick="lnkPrintBarCode_Click">Print Barcode</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                        
                    </Columns>
                </asp:GridView>
           </td><%--<asp:TemplateField >
                            <ItemTemplate>
                                <asp:LinkButton ID="linkButton_PrintBarCode" runat="server" OnClick="linkButton_PrintBarCode_Click">Print Barcode</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
           <td>
           </td>
           <td>
           </td>
       </tr>
       <asp:SqlDataSource ID="SDS_Send_out" runat="server"></asp:SqlDataSource>
        <tr>
            <td colspan="4" align="center" >
              <asp:SqlDataSource ID="SqlDataSource_Sample" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                    SelectCommand="SELECT [Sample_Id], [Sample_Name] FROM [Path_Sample]"></asp:SqlDataSource>
              <asp:SqlDataSource ID="SqlDataSource_insert_test_Sample" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                    DeleteCommand="DELETE FROM [Path_Sample] WHERE [Path_Sample_ID] = @Path_Sample_ID"
                    InsertCommand="insert_path_Sample1"
                    SelectCommand="SELECT [Sample_No], [Sample_Date], [Status], [Sample_Collect_AT], [Collect_By], [Sample_Id], [Path_Sample_ID] FROM [Path_Sample]  where  [Sample_No]=@Sample_Id"
                    
                    UpdateCommand="UPDATE [Path_Sample] SET [Sample_No] = @Sample_No, [Sample_Date] = @Sample_Date, [Status] = @Status, [Sample_Collect_AT] = @Sample_Collect_AT, [Collect_By] = @Collect_By, [Sample_Id] = @Sample_Id WHERE [Path_Sample_ID] = @Path_Sample_ID" 
                    InsertCommandType="StoredProcedure">
                <DeleteParameters>
                  <asp:Parameter Name="Path_Sample_ID" Type="Int32" />
                  </DeleteParameters>
                <UpdateParameters>
                  <asp:Parameter Name="Sample_No" Type="String" />
                  <asp:Parameter Name="Sample_Date" Type="DateTime" />
                  <asp:Parameter Name="Status" Type="Int32" />
                  <asp:Parameter Name="Sample_Collect_AT" Type="String" />
                  <asp:Parameter Name="Collect_By" Type="Int32" />
                  <asp:Parameter Name="Sample_Id" Type="Int32" />
                  <asp:Parameter Name="Path_Sample_ID" Type="Int32" />
                  </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="RadioButtonList1" DefaultValue="" Name="Sample_Collect_AT"
                        PropertyName="SelectedValue" Type="String" />
                    <asp:SessionParameter DefaultValue="" Name="Collect_By" SessionField="emp_ID" />
                    <asp:QueryStringParameter Name="Main_Id" QueryStringField="Main_ID" />
                    <asp:ControlParameter ControlID="HiddenField_Reference_Sample" DefaultValue="1" Name="Reference_Sample"
                        PropertyName="Value" />
                    <asp:ControlParameter ControlID="TextBox_Out_Side_Lab_No" Name="Out_side_lab_no"
                        PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text"
                        Type="String" />
                    <asp:ControlParameter ControlID="DropDownList_OutSideLab" DefaultValue="" Name="Out_side_lab_ID"
                        PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList_Outlet" DefaultValue="" Name="Outlet_ID"
                        PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="DropDownList_PreRefrenceNo" DefaultValue="" 
                        Direction="Output" Name="Sample_No" PropertyName="SelectedValue" Size="20" 
                        Type="String" />
                    <asp:Parameter Name="LAB_Type" Type="String" />
                    <asp:ControlParameter ControlID="hf_Data" Name="Data" PropertyName="Value" 
                        Type="String" />
                    <asp:ControlParameter ControlID="HfTGID" Name="TGID" PropertyName="Value"/>
                    <asp:ControlParameter ControlID="ddPrinterLocation" DefaultValue="" Name="PrinterLocation"
                        PropertyName="SelectedValue" />
                  </InsertParameters>
                <SelectParameters>
                  <asp:ControlParameter ControlID="TextBox_Sample_no" Name="Sample_Id" PropertyName="Text" />
                  </SelectParameters>
                </asp:SqlDataSource>
            <asp:Button ID="Button_Save" runat="server" Text="Save" Width="80px" />            
                <asp:Button ID="Button1" runat="server" Text="Upload Machine Sample" Width="168px" Visible="False" />
                <asp:HiddenField ID="HiddenField_StrMessage" runat="server" />
                <asp:SqlDataSource ID="SqlDataSourceMachineMessage" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                    InsertCommand="delete from PT_TestMessages where  Machine_id=@Machine_id  and Sample_No=@Sample_No&#13;&#10;INSERT INTO PT_TestMessages(Sample_No, Sent_Message, Status_Id, Machine_id) VALUES (@Sample_No, @Sent_Message, @Status_Id, @Machine_id)"
                    SelectCommand="SELECT [Pt_Message_Id], [Sample_No], [Sent_Message], [Received_Message], [Status_Id], [Machine_id] FROM [PT_TestMessages]">
                    <InsertParameters>
                        <asp:QueryStringParameter Name="Sample_No" QueryStringField="Main_Id" />
                        <asp:Parameter DefaultValue="0" Name="Status_Id" />
                        <asp:Parameter DefaultValue="2" Name="Machine_id" />
                        <asp:ControlParameter ControlID="HiddenField_StrMessage" Name="Sent_Message" PropertyName="Value" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Sample_No" runat="server" />
                <asp:HiddenField ID="hf_Data" runat="server" />
                <asp:SqlDataSource ID="SqlDataSource_Outlet" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                    SelectCommand="SELECT [Outlet_ID], [Outlet_Name] FROM [Outlet]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_OutSideLab" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
                    SelectCommand="SELECT OutSideLab_ID, OutSideLab_Name FROM OutSideLab" InsertCommand="INSERT INTO Lab_Sendout_Record
                      (TB_ID, Order_ID, Status)
VALUES     (@TB_ID,@Order_ID, 1)">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenField_TB_ID" Name="TB_ID" 
                            PropertyName="Value" />
                        <asp:QueryStringParameter Name="Order_ID" QueryStringField="Main_ID" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_OutSideLab0" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                    SelectCommand="SELECT OutSideLab_ID, OutSideLab_Name FROM OutSideLab" InsertCommand="INSERT INTO Lab_Sendout_Record
                      (TB_ID, Order_ID, Status)
VALUES     (@TB_ID,@Order_ID, 1)" 
                    ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="HiddenField_TB_ID" Name="TB_ID" 
                            PropertyName="Value" />
                        <asp:QueryStringParameter Name="Order_ID" QueryStringField="Main_ID" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSource_Reference_Sample" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                    SelectCommand="SELECT     TOP (5) Path_Sample.Sample_No &#13;&#10;FROM         Test_Booking_Services INNER JOIN&#13;&#10;                      Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN&#13;&#10;                      Path_Sample ON Test_Booking_Services.Main_ID = Path_Sample.Main_Id &#13;&#10; WHERE (Path_Result_Delivery.Reg_no = @Reg_no) AND (Path_Result_Delivery.Yearly_No = @Yearly_No) AND (NOT (Test_Booking_Services.Sample_No IS NULL)) &#13;&#10;GROUP BY Path_Sample.Sample_No&#13;&#10;ORDER BY Path_Sample.Sample_No  DESC">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Reg_no" QueryStringField="Reg_No" />
                        <asp:QueryStringParameter Name="Yearly_No" QueryStringField="YearlyNo" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="HiddenField_Reference_Sample" runat="server" />
                <asp:HiddenField ID="HiddenFieldSend_out" runat="server" />
                <asp:HiddenField ID="HiddenField_ID" runat="server" />
            </td>
        </tr>
       <tr>
           <td align="center" colspan="4">
           </td>
       </tr>
    </table></div>
    <asp:SqlDataSource ID="SqlDataSource_Booking" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Path_ConnectionString.ProviderName %>" UpdateCommand="UPDATE    Test_Booking_Services&#13;&#10;SET              Status = @Status, Sample_No = @Sample_No, Report_Deliver_Date = dateadd (hh,isnull(Test_Booking.Collection_Time,3),getdate())&#13;&#10;&#13;&#10;,Sample_Collection_Date= getdate()&#13;&#10;FROM         Test_Booking_Services INNER JOIN&#13;&#10;                      Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID&#13;&#10;WHERE     (Test_Booking_Services.Main_ID = @Main_ID) AND (Test_Booking_Services.TB_ID = @TB_ID) AND (Test_Booking_Services.ID = @ID)&#13;&#10;&#13;&#10;                             UPDATE       Path_Result_Delivery&#13;&#10;                              SET                 Path_Result_Delivery.Description = @description ,  Path_Result_Delivery.Sample_Collection_Date= getdate()&#13;&#10;&#13;&#10;&#13;&#10;WHERE Path_Result_Delivery.Main_ID = @Main_ID" 
        InsertCommand="insert_lab_status_record" InsertCommandType="StoredProcedure">
<UpdateParameters>
    <asp:ControlParameter ControlID="HiddenField_TestStatus" DefaultValue="1" Name="Status"
        PropertyName="Value" />
            <asp:QueryStringParameter DefaultValue="" Name="Main_ID" QueryStringField="Main_ID" />
    <asp:ControlParameter ControlID="HiddenField_TB_ID" DefaultValue="" Name="TB_ID"
        PropertyName="Value" />
    <asp:ControlParameter ControlID="HiddenField_Sample_No" DefaultValue="" Name="Sample_No"
        PropertyName="Value" />
    <asp:ControlParameter ControlID="HiddenField_ID" DefaultValue="" Name="ID" PropertyName="Value" />
    <asp:ControlParameter ControlID="TextBox_Description" DefaultValue="" Name="description"
        PropertyName="Text" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter DefaultValue="" Name="Main_ID" QueryStringField="Main_ID"
                Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="Status" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_TB_ID" Name="TB_ID" PropertyName="Value"
                Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_TestStatus" runat="server" Value="1" />
 <br>

 <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top" width="50%">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Path_Sample_ID" Width="98%"
        DataSourceID="SqlDataSource_insert_test_Sample" Visible="False">
        <Columns>
            <asp:TemplateField HeaderText="Sample" SortExpression="Sample_Id">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList_sample" runat="server" DataSourceID="SqlDataSource_Sample"
                        DataTextField="Sample_Name" DataValueField="Sample_Id" SelectedValue='<%# Bind("Sample_Id", "{0}") %>'
                        Width="207px">
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Sample_Id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Sample_No" HeaderText="Sample No" SortExpression="Sample_No" />
            <asp:BoundField DataField="Sample_Date" HeaderText="Sample Date" SortExpression="Sample_Date" />
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
            <asp:TemplateField HeaderText="Sample Collect AT" SortExpression="Sample_Collect_AT">
                <EditItemTemplate>
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal"
                        SelectedValue='<%# Bind("Sample_Collect_AT", "{0}") %>'>
                        <asp:ListItem>In Lab</asp:ListItem>
                        <asp:ListItem>From Patient</asp:ListItem>
                        <asp:ListItem>From Centre</asp:ListItem>
                    </asp:RadioButtonList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Sample_Collect_AT") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowDeleteButton="True" />
            <asp:CommandField ShowEditButton="True" />
        </Columns>
    </asp:GridView>
        <asp:HiddenField ID="HiddenField_TB_ID" runat="server" /><asp:HiddenField ID="HiddenField_S_ID" runat="server" />
    </td>
    <td valign="top" width="50%">
        &nbsp;<asp:SqlDataSource ID="SqlDataSource_Specimen" runat="server" ConnectionString="<%$ ConnectionStrings:Path_ConnectionString %>"
                    SelectCommand="Specimen_val" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Main_ID" QueryStringField="Main_ID" Type="Int32" />
                        
                        <asp:ControlParameter ControlID="HfStatus" Name="Status" PropertyName="Value"/>
                    </SelectParameters>
                </asp:SqlDataSource></td>
  </tr>
</table>
    <asp:HiddenField ID="HfSaveStatus" runat="Server"/>
    <asp:HiddenField ID="HfStatus" runat="Server"/>
    <asp:HiddenField ID="HfTGID" runat="server" />
<asp:panel id = "pnl_Lab_No" runat = "Server" CssClass = "lightbox_bg" Visible = "false">
<div class = "lightbox">
<br />
<br />
<br />
<div align = "center" width = "100%"><h1 style = "color :Red; font-size :xx-large;" ><span>LAB No. </span> </h1> </div>
<br />
<br />
<br />
<div  align = "center" width = "100%"><h2 style = "font-size :large; color :Orange;" ><span> <asp:Label ID = "lbl_Sample" runat = "server"> test</asp:Label></span></h2></div>
<br />
<br />
<br />
<div  align = "center" width = "100%"> <asp:Button ID = "btn_Return" Text = "Return"
        runat = "server" OnClick="btn_Return_Click"/>
    <asp:LinkButton ID="LinkButton_Show_Report" runat="server" CssClass="report" Visible="false"><span></span>show Barcode</asp:LinkButton>
</div>
</div>

</asp:panel>
    
             <br>

            <br>
<br>

  </asp:Content>