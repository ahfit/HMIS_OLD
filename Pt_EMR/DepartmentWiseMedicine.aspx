<%@ Page  Language="C#" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="true" CodeFile="DepartmentWiseMedicine.aspx.cs" Inherits="Pt_EMR_DepartmentWiseMedicine" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .medbg {
        /*border-radius: 4px;
    border: #CCC solid 1px;*/
    /* padding: 2px; */
    /* display: inline-block; */
    /* height: auto; */
        }
    </style>
    <script type="text/javascript">
        function ClientItemSelected(sender, e) {
            alert(e.get_value());
            $get("<%=hfName.ClientID %>").value = e.get_value();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true">
        <Services>
            <asp:ServiceReference Path="../autocomplete.asmx" />
        </Services>
    </asp:ScriptManager>


    <cc1:AutoCompleteExtender ID="GetMedication" runat="server" TargetControlID="TextBox_specificMedicine"
        ServicePath="../AutoComplete.asmx" ServiceMethod="GetMedication" MinimumPrefixLength="3"
        EnableCaching="true" CompletionSetCount="12" CompletionListHighlightedItemCssClass="AutoExtenderHighlight"
        CompletionListItemCssClass="AutoExtenderList" CompletionListCssClass="AutoExtender" OnClientItemSelected="ClientItemSelected"
        CompletionInterval="10">
    </cc1:AutoCompleteExtender>


    <asp:HiddenField ID="hfName" runat="server" />
    <div style="width:100%;" class="bxmain inner_content">
        <h2><span>Add Medicine(s) to Template</span></h2>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width ="50%" align="right">
                Select Template :
            </td>
            <td width ="50%" align="left">
                <asp:DropDownList  ID="ddl_med_category" runat="server"></asp:DropDownList>
            </td>
        </tr>
    </table>    
    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="   background-color: honeydew;" class="Grid_1">                                                                                    
                               
        
         <tr>
                                    <th align="center" style="width: 180px">
                                        Name</th>
                                    <th style="width:60px" align="center">
                                        Route</th>
                                    <th style="width:155px" align="center">
                                        Frequency</th>
                                    <th style="width:30px" align="center">
                                        Days</th>                                    
                                   <th style="width:30px" >Meal</th>                                    
                                    <th align="center" colspan="1">
                                        Physican Notes</th>
                                   
                                </tr>
                                <tr>
                                    <td valign="top" style="width: 195px">
                                        <asp:TextBox ID="TextBox_specificMedicine" CssClass="input_txt" Width="200px" Height="25px" runat="server"
                                            AccessKey="n" ></asp:TextBox>
                                        <br />                                      
                                        <asp:Label ID="Label1" CssClass="red" runat="server"></asp:Label>
                                        
                                    </td>
                                    <td valign="top">
                                        <asp:DropDownList ID="DropDownList_route" Height="40px" runat="server" DataSourceID="SqlDataSource_route"
                                            DataTextField="Description" DataValueField="Id" Width="60px">
                                        </asp:DropDownList>
                                      </td>
                                    <td valign="top">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ID="DropDownList_frequencyName"  runat="server" AutoPostBack="True"
                                                        DataTextField="Name" DataValueField="id"
                                                        Width="100px">
                                                    </asp:DropDownList>
                                              
                                                
                                                    <asp:TextBox ID="TextBox_Frequency" Visible="true" runat="server" AutoPostBack="True" Width="16px">1</asp:TextBox>
                                                    <asp:ImageButton Visible="false" OnClick="ImageButton_Frequency_ShowHide_Click"   ID="ImageButton_Frequency_ShowHide" runat="server" ImageUrl="../images_hacims/add.png" />
                                                </td>
                                            </tr>
                                        </table>
                                        
                                        <ul id="CollapsiblePanel1" style="">
                                            <li style="text-align: right;">
                                                

                                                
                                            </li>
                                            <li >
                                                    <asp:DataList ID="DataList_Frequency" runat="server" DataKeyField="Frequency_Sub_Id"
                                                         DataSourceID="SqlDataSource_FrequencyDataList" RepeatColumns="10"
                                                        RepeatDirection="Horizontal">
                                                        <ItemTemplate>
                                                            <div class="medbg">
                                                                <asp:Label ID="FrequencyLabel" runat="server" Text='<%# Eval("Frequency") %>' Style="display: block;
                                                                    font-family: arial; font-size: 9px;"></asp:Label>
                                                                <asp:TextBox ID="TextBox_dosage2" runat="server" Width="26px" Style="height: 10px;
                                                                    display: inline;">1</asp:TextBox>
                                                                <asp:HiddenField ID="HF_F_S_Id" runat="server" Value='<%# Eval("id") %>' />
                                                                <asp:HiddenField ID="Frequency_Sub_ID" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                </li>
                                            
                                        </ul>
                                    </td>
                                    <td align="center" valign="top">
                                        <asp:TextBox ID="TextBox_days"  Height="25px" runat="server" CssClass="input_txt" Width="25px" AutoPostBack="True">1</asp:TextBox>
                                        </td>
                                    
                                    
                                    
                                    
                                    <td>
                                          <asp:DropDownList ID="DropDownList_Meal" runat="server" Height="25px" Width="87px">
                                            <asp:ListItem Value="NA">NA</asp:ListItem>
                                            <asp:ListItem Value="Before Meal">Before</asp:ListItem>
                                            <asp:ListItem Value="After Meal">After</asp:ListItem>
                                        </asp:DropDownList>  
                                    </td>
                                    <td valign="top" >
                                                                           

                                       <asp:TextBox ID="TextBoxInstruction" TextMode="MultiLine" runat="server" CssClass="input_txt" Height="25px" Width="99%"></asp:TextBox>                                                                        
                                        </td>
                                </tr>
                            </table>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox_specificMedicine"
                                ErrorMessage="RequiredFieldValidator" EnableViewState="False">Select Medicine</asp:RequiredFieldValidator>&nbsp;
                            <div align="center">                               
                                <asp:Button ID="ButtonSave" runat="server" Text="Save" CausesValidation="False" OnClick="ButtonSave_Click" />
                               
                                <asp:Label ID="LabelMessage"  runat="server" Font-Bold="True"></asp:Label>
                            </div>
                            
                       

                            <br />
                   
                            <asp:HiddenField ID="HiddenField2" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                SelectCommand="OPD_Encounter_Medication" SelectCommandType="StoredProcedure"
                                DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
                                    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Name="priscription_id"
                                        PropertyName="Value" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                           
                          
                            <br />
                            
                           
                          <div class="bxmain inner_content" style="width:100%"><span><h2>Favourite Medicine List</h2></span>
                              <asp:GridView Width="100%" AutoGenerateColumns="false" BackColor="LightBlue" ID="gvdFavouriteMedicine" runat="server" ShowHeader="false" ShowFooter="false" OnRowDataBound="gvdFavouriteMedicine_RowDataBound">
                                  <Columns>
                                      <asp:TemplateField>
                                          <ItemTemplate>
                                     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Grid_1">                                                                                    
                                <tr>
                                    <th align="center" style="width: 180px">
                                        Name</th>
                                    <th style="width:60px" align="center">
                                        Route</th>
                                    <th style="width:155px" align="center">
                                        Frequency</th>
                                    <th style="width:30px" align="center">
                                        Days</th>                                    
                                    
                                   <th style="width:30px" >Meal</th>                                    
                                    <th align="center" colspan="1">
                                        Physican Notes</th>
                                   
                                </tr>
                                <tr>
                                    <td valign="top" style="width: 195px">
                                        <asp:TextBox Text='<%# Bind("MedicineName") %>' ID="txtboxMedicineName" Enabled="false" CssClass="input_txt" Width="200px" Height="28px" runat="server" ></asp:TextBox>                                                                                                                        
                                    </td>
                                    <td valign="top">
                                        <asp:DropDownList ID="ddlRoute" Height="28px" runat="server" DataSourceID="SqlDataSource_route"
                                            DataTextField="Description" DataValueField="Id" Width="60px">
                                        </asp:DropDownList>
                                        <asp:HiddenField Value='<%# Eval("Route") %>' ID="hfDDlRuteValue" runat="server" />
                                      </td>
                                    <td valign="top">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ID="ddlFrequency" Enabled="false"  runat="server" AutoPostBack="True"
                                                        DataTextField="Name" DataValueField="id"
                                                        Width="100px">
                                                    </asp:DropDownList>   
                                        <asp:HiddenField ID="hfFrequencyID" Value='<%# Eval("FrequencyID_FK") %>' runat="server" />    
                                        <asp:HiddenField ID="hfDeptMedID" Value='<%# Eval("DeptMedID") %>' runat="server" />    
                                                                                                                                                                      
                                                </td>
                                            </tr>
                                        </table>
                                        
                                        <ul id="CollapsiblePanel1" style="height:32px;">
                                            <li style="text-align: right;">                                                
                                            </li>
                                            <li >
                                                
     <asp:SqlDataSource ID="SqlDataSourceForFreqency" runat="server" ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>"
                                ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>" SelectCommand="SELECT     Medicine_Frequency.Name,Medicine_Frequency.id, Medicine_Frequency_Detail.Frequency , &#13;&#10;                      Medicine_Frequency_Detail.TimeDuration_Hour, Medicine_Frequency_Detail.Sequence_No, Medicine_Frequency_Detail.Frequency_Sub_Id,&#13;&#10;                      Medicine_Frequency_Detail.Frequency_Id&#13;&#10;FROM         Medicine_Frequency_Detail INNER JOIN&#13;&#10;                      Medicine_Frequency ON Medicine_Frequency_Detail.Frequency_Id = Medicine_Frequency.id&#13;&#10;WHERE     (Medicine_Frequency.id = @id)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hfFrequencyID" Name="id" PropertyName="Value" />
                                </SelectParameters>
                            </asp:SqlDataSource>  
                                                <%--DataSourceID="SqlDataSourceForFreqency"--%>
                                               <asp:DataList ID="ddlFrequencyList" Width="183px" runat="server" DataKeyField="Frequency_Sub_Id"
                                                         
                                                    RepeatColumns="4"
                                                        RepeatDirection="Horizontal">
                                                        <ItemTemplate>
                                                            <div class="medbg">
                                                                <asp:Label ID="FrequencyLabel" runat="server" Text='<%# Eval("Frequency") %>' Style="display: block;
                                                                    font-family: arial; font-size: 9px;"></asp:Label>
                                                                <asp:TextBox Enabled="false" ID="TextBox_dosage2" runat="server" Width="30px" Style="height: 12px;
                                                                    display: inline;">1</asp:TextBox>
                                                                <asp:HiddenField ID="HF_F_S_Id" runat="server" Value='<%# Eval("id") %>' />
                                                                <asp:HiddenField ID="Frequency_Sub_ID" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:DataList>
                                                </li>
                                            
                                        </ul>
                                    </td>
                                    <td align="center" valign="top">
                                        <asp:TextBox Enabled="false" ID="txtDays" Text='<%# Eval("Days") %>'  Height="25px" runat="server" CssClass="input_txt" Width="25px" AutoPostBack="True">1</asp:TextBox>
                                        </td>                                                                        
                                    <td>
                                          <asp:DropDownList ID="ddlMeals" Enabled="false" runat="server" Height="30px" Width="87px">
                                            <asp:ListItem Value="NA">NA</asp:ListItem>
                                            <asp:ListItem Value="Before Meal">Before</asp:ListItem>
                                            <asp:ListItem Value="After Meal">After</asp:ListItem>
                                        </asp:DropDownList>  
                                        <asp:HiddenField ID="hfMeals" runat="server" Value='<%# Eval("Meal") %>' />
                                    </td>
                                    <td valign="top" >
                                                                           

                                       <asp:TextBox ID="physicanNotes" ForeColor="navy" Enabled="false" Text='<%# Eval("PhysicanNotes") %>' TextMode="MultiLine" runat="server" CssClass="input_txt" Height="28px" Width="99%"></asp:TextBox>                                                                        
                                </tr>
                            </table>
                                              </ItemTemplate>
                                      </asp:TemplateField>
                                  </Columns>
                              </asp:GridView>
                          </div>
                          
                                    
                            <br />
                            <asp:SqlDataSource ID="SqlDataSource_Confirmed_Prescriptions" runat="server"  ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                SelectCommand="Select_Med_Presc_Urdu" DeleteCommand="DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)"
                                SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:SessionParameter Name="RegNo" SessionField="registrationno" Type="String" />
                                    <asp:SessionParameter Name="YearlyNo" SessionField="YearlyNo" Type="Decimal" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="HiddenField_Prescription_Id" Name="priscription_id"
                                        PropertyName="Value" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SDS_Gen_Requisition" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                InsertCommand="usp_Automatic_Requisition_For_Patient" InsertCommandType="StoredProcedure"
                                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
                                <InsertParameters>
                                    <asp:SessionParameter Name="Registration_NO" SessionField="RegistrationNo" />
                                    <asp:SessionParameter DefaultValue="" Name="Yearly_NO" SessionField="YearlyNo" />
                                    <asp:SessionParameter DefaultValue="" Name="Dept_id" SessionField="Dept_id" />
                                    <asp:SessionParameter Name="subdeptid" SessionField="Subdeptid" />
                                    <asp:SessionParameter Name="ShiftID" SessionField="Shiftid" />
                                    <asp:SessionParameter Name="Emp_id" SessionField="Emp_id" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <br />
                        </div>
     



    
     <asp:SqlDataSource ID="SqlDataSource_FrequencyDataList" runat="server" ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>"
                                ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>" SelectCommand="SELECT     Medicine_Frequency.Name,Medicine_Frequency.id, Medicine_Frequency_Detail.Frequency , &#13;&#10;                      Medicine_Frequency_Detail.TimeDuration_Hour, Medicine_Frequency_Detail.Sequence_No, Medicine_Frequency_Detail.Frequency_Sub_Id,&#13;&#10;                      Medicine_Frequency_Detail.Frequency_Id&#13;&#10;FROM         Medicine_Frequency_Detail INNER JOIN&#13;&#10;                      Medicine_Frequency ON Medicine_Frequency_Detail.Frequency_Id = Medicine_Frequency.id&#13;&#10;WHERE     (Medicine_Frequency.id = @id)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList_frequencyName" Name="id" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSource_Medicine_Advice_Category" runat="server" ConnectionString="<%$ ConnectionStrings:TreatmentConnectionString %>"
                                SelectCommand="SELECT [Medicine_Advice_Category_ID], [Medicine_Advice_Category_Name] FROM [Medicine_Advice_Category]">
                            </asp:SqlDataSource>

     
     
     <asp:SqlDataSource ID="SqlDataSource_route" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                    SelectCommand="Select_Medicine_Category" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                    SelectCommandType="StoredProcedure">                    
                </asp:SqlDataSource>

</asp:Content>

