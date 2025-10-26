<%@ Page  Language="C#" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="true" CodeFile="FavoriteMedicineDoctorWise.aspx.cs" Inherits="Pt_EMR_FavoriteMedicineDoctorWise" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
      <script type="text/javascript">
          function ClientItemSelected(sender, e) {
              var data=e.get_value().split(',')
              $get("<%=hfName.ClientID %>").value = data[0]
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true">
        <Services>
            <asp:ServiceReference Path="../autocomplete.asmx" />
        </Services>
    </asp:ScriptManager>
    <div style="width:50%;" class="bxmain inner_content">
        <span>
            <h2>Favorite Medicines</h2>
        </span>

        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="grid_form">
            <%--<tr>
                <td align="right" style="width: 20%;"><strong>Drug Name :</strong></td>
                <td align="left">
                     <asp:TextBox ID="TextBox_specificMedicine" CssClass="input_txt" Width="300px" Height="25px" runat="server"
                                            AccessKey="n" ></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox_specificMedicine"
                                ErrorMessage="RequiredFieldValidator" Display="Dynamic" ValidationGroup="mainApp" EnableViewState="False">Select Medicine</asp:RequiredFieldValidator>&nbsp;
                    </td>
                    <cc1:AutoCompleteExtender ID="GetMedication" runat="server" TargetControlID="TextBox_specificMedicine"
        ServicePath="../AutoComplete.asmx" ServiceMethod="GetMedication" MinimumPrefixLength="3"
        EnableCaching="true" CompletionSetCount="12" CompletionListHighlightedItemCssClass="AutoExtenderHighlight"
        CompletionListItemCssClass="AutoExtenderList" CompletionListCssClass="AutoExtender" OnClientItemSelected="ClientItemSelected"
        CompletionInterval="10">
    </cc1:AutoCompleteExtender>
            </tr>--%>
<tr>
                                <td valign="top" style="width: 219px">
                                    <asp:TextBox ID="TextBox_specificMedicine" CssClass="input_txt" Width="200px" runat="server"
                                        AccessKey="n"></asp:TextBox>
                                    <asp:TextBox ID="TextBox_specificMedicine_hs" CssClass="input_txt" Width="200px"
                                        runat="server" AccessKey="n" Visible="false" AutoPostBack="True"></asp:TextBox><br />
                                    <asp:DropDownList Visible="false" Width="100%" ID="ddlDepartmentMedicines" runat="server"></asp:DropDownList>
                                    <asp:Label ID="Label1" CssClass="red" runat="server"></asp:Label>

                                </td>
                                <td valign="top">
                                    <asp:DropDownList ID="DropDownList_route" runat="server" DataSourceID="SqlDataSource_route"
                                        DataTextField="Description" DataValueField="Id" Width="60px">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="DropDownList_dosage" runat="server" DataSourceID="SqlDataSource_dosage"
                                        DataTextField="Name" DataValueField="Name" Width="75px" Visible="False">
                                    </asp:DropDownList></td>
                                <td valign="top">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                        <tr>
                                            <td>

                                                <asp:DropDownList ID="DropDownList_frequencyName" runat="server" AutoPostBack="True"
                                                    DataTextField="Name" DataValueField="id"
                                                    Width="100px">
                                                </asp:DropDownList>


                                                <asp:TextBox ID="TextBox_Frequency" runat="server" AutoPostBack="True" Width="16px">1</asp:TextBox>
                                                <asp:ImageButton Visible="false" ID="ImageButton_Frequency_ShowHide" runat="server" ImageUrl="../images_hacims/add.png" />

                                            </td>
                                        </tr>
                                    </table>

                                    <ul id="CollapsiblePanel1" style="">
                                        <li style="text-align: right;"></li>
                                        <li>

                                            <asp:DataList ID="DataList_Frequency" runat="server" DataKeyField="Frequency_Sub_Id"
                                                DataSourceID="SqlDataSource_FrequencyDataList" RepeatColumns="10"
                                                RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <div class="medbg">
                                                        <asp:Label ID="FrequencyLabel" runat="server" Text='<%# Eval("Frequency") %>' Style="display: block; font-family: arial; font-size: 9px;"></asp:Label>
                                                        <asp:TextBox ID="TextBox_dosage2" runat="server" Width="30px" Style="height: 12px; display: inline;">1</asp:TextBox>
                                                        <asp:HiddenField ID="HF_F_S_Id" runat="server" Value='<%# Eval("Frequency_Sub_Id") %>' />
                                                    </div>
                                                </ItemTemplate>
                                            </asp:DataList>

                                        </li>

                                    </ul>
                                </td>
                                <td align="center" valign="top">
                                    <asp:TextBox ID="TextBox_days" runat="server" CssClass="input_txt" Width="15px" AutoPostBack="True">1</asp:TextBox>
                                    <asp:CheckBox ID="CheckBox_CT" runat="server" Text="CT" Visible="False" /></td>
                                <td valign="top">
                                    <igsch:WebDateChooser ID="WebDateChooserStartDate" runat="server" CssClass="drop_date"
                                        Width="100px" Value="2008-01-16">
                                        <CalendarLayout Culture="English (United Kingdom)">
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                                    <igsch:WebDateChooser ID="WebDateChooserEndDate" CssClass="drop_date" Visible="false"
                                        runat="server" Value="2010-06-17" Width="100px">
                                        <AutoPostBack ValueChanged="True" />
                                        <CalendarLayout Culture="English (United Kingdom)">
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                                </td>
                                <td style="display: none;">
                                    <asp:DropDownList ID="ddlMedicineType" runat="server" Style="width: 100%">
                                        <asp:ListItem Text="Discharge Medicine" Value="Discharge Medicine"></asp:ListItem>
                                        <asp:ListItem Text="Emergency Treatment" Value="Emergency Treatment"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td style="display: none;">
                                    <asp:TextBox ID="txtboxBeforeMeal" TextMode="MultiLine" Style="width: 100%; height: 35px;" runat="server"></asp:TextBox>
                                </td>
                                <td style="display: none;">
                                    <asp:TextBox ID="txtboxAfterMeal" TextMode="MultiLine" Style="width: 100%; height: 35px;" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList_Meal" runat="server" Width="87px">
                                        <asp:ListItem Value="NA">NA</asp:ListItem>
                                        <asp:ListItem Value="Before Meal">Before</asp:ListItem>
                                        <asp:ListItem Value="After Meal">After</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td valign="top" style="width: 292px;">


                                    <asp:TextBox ID="TextBoxInstruction" TextMode="MultiLine" runat="server" CssClass="input_txt" Height="45px" Width="99%"></asp:TextBox>


                                    <asp:DropDownList ID="DropDownList_Medicine_Advice_Category" runat="server" DataSourceID="SqlDataSource_Medicine_Advice_Category"
                                        Visible="false" DataTextField="Medicine_Advice_Category_Name" DataValueField="Medicine_Advice_Category_ID">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="DropDownList_diution" runat="server"
                                        DataTextField="name" DataValueField="name" Width="65px" Visible="False">
                                    </asp:DropDownList>
                                    <asp:TextBox ID="TextBox_dilution" CssClass="input_txt" runat="server" Width="25px"
                                        Visible="False"></asp:TextBox>
                                    <asp:Label ID="Label_Dilution" runat="server" Text="Dilution" Visible="False"></asp:Label></td>

                                <asp:Label ID="Label_Stock" Visible="false" runat="server"></asp:Label>
                            </tr>             
           
            
            <tr style="line-height:4">
                <td></td>
                <td align="Left" >
                    <asp:Button ID="btnSave" runat="server" Text="Save" ValidationGroup="mainApp" OnClick="btnSave_Click" Width="80px" /></td>
            </tr>

            <asp:HiddenField ID="hfName" runat="server" />
        </table>
    </div>


    <div style="width:50%;margin-top:10px;" class="bxmain inner_content"><span><h2>Medicine List</h2></span>
        <asp:GridView CssClass="Grid_1" Width="100%" ID="gvd" runat="server" AutoGenerateColumns="false" >
            <Columns>
                <asp:BoundField HeaderText="Medicine Name" DataField="Item_Name" />
                <asp:BoundField HeaderText="Doctor Name" DataField="DoctorName" />                
            </Columns>
        </asp:GridView>

    </div>


</asp:Content>

