<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="Doctor_Services.aspx.vb" Inherits="Administrator_Doctor_Services" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <script type="text/javascript">
         function ClientItemSelected2(sender, e) {
             $get("<%=hfItemCode.ClientID %>").value = e.get_value();
        }
    </script>
      <script type="text/javascript">
          $(document).ready(function () {
              $("#<%=txtItemName.ClientID %>").keyup(function (event) {

                  if (event.keyCode === 13) {
                      $("#<%=Button1_Search.ClientID %>").click();
                  }
              });
          })</script>
<script type="text/javascript">
    function addPercentage() {
        var percentage = $.trim($("[id$='txtboxPercentage']").val());
        $("[id*='TextBox_Charges']").val(percentage);

    }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain" style="width:100%">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
           <tr>
            <td align="right"><strong>Hospital :</td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" Enabled="false" runat="server" Width="250px"  AutoPostBack="true">
                    
                </asp:DropDownList> 
            </td>
        </tr>
            <tr>
                <td width="40%" align="right">
                    &nbsp;Department :
                </td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownList1" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" TabIndex="22" runat="server" 
                        Width="250px" DataTextField="SubDept_Name" DataValueField="SubDept_Id" AutoPostBack="True">
                    </asp:DropDownList>
                  
                </td>
            </tr>
            <tr>
                <td width="40%" align="right">
                    Select Doctor :
                </td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownList_Doctor" runat="server" 
                        DataTextField="Name" DataValueField="EmpID" Width="250px" AutoPostBack="True"
                        CssClass="dropbox">
                    </asp:DropDownList>
                    <asp:Label ID="Label_Message"  runat="server" CssClass="err" 
                        ForeColor="#00CC00" Font-Bold="True"></asp:Label>
                </td>
            </tr>

               <tr>
                <td width="40%" align="right">
                    Forward To :
                </td>
                <td width="60%">
                    <asp:DropDownList ID="DropDownList2" runat="server" 
                        DataTextField="Name" DataValueField="EmpID" Width="250px" AutoPostBack="True"
                        CssClass="dropbox">
                    </asp:DropDownList>
                    <asp:Label ID="Label1" runat="server" CssClass="err"></asp:Label>

                    <asp:Button id="btnForward" runat="server"   Text="Forward" 
                        onclientclick="javascript: return confirm('Do You Want to Forward these Services to Doctor?')"  />
                </td>
            </tr>
               <tr>
                <td align="right" width="40%">Item Name :</td>
                <td align="left" width="60%">
                    <asp:TextBox ID="txtItemName" runat="server"></asp:TextBox>
                    <asp:Button ID="Button1_Search" runat="server" Text="Search" OnClick="Button1_Search_Click" />
                    <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="3" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList" 
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                    </asp:AutoCompleteExtender>
                </td>
            </tr>
         <tr>
                <td align="right" width="40%">&nbsp;</td>
                <td align="left" width="60%">
                    <asp:HiddenField ID="hfItemCode" runat="server" />
                </td>
            </tr>
        </table>
    </div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="50%" valign="top" style="height: 298px">
                <asp:RadioButtonList ID="RadioButtonList_Cat" runat="server" AutoPostBack="True"
                    DataSourceID="SqlDataSource_Category" DataTextField="Asc_Name" DataValueField="Asc_id"
                    Style="font-size: 10px;" RepeatColumns="3" RepeatDirection="Horizontal">
                </asp:RadioButtonList>
                <br />
                <div style="padding:5px;">
                Doctor Share Percentage : <asp:TextBox ID="txtboxPercentage" runat="server" onblur="addPercentage()"></asp:TextBox>
                    <asp:Button ID="Button_Save" runat="server" Text="Save" />
                </div>

                <div style="height: 250px; overflow: auto; overflow-x: hidden;">
                    <asp:GridView ID="GridView_Category" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                        DataKeyNames="S_ID" DataSourceID="SqlDataSource_Service" Width="99%">
                        <Columns>
                            
                            <asp:BoundField DataField="S_ID" HeaderText="SID" InsertVisible="False" ReadOnly="True"
                                SortExpression="S_ID"  />
                            <asp:BoundField DataField="S_Name" HeaderText="Service" SortExpression="S_Name" />
                            
                            <asp:BoundField DataField="S_Amount" HeaderText="Services Charges" SortExpression="S_Amount" />
                            <asp:TemplateField HeaderText="Mode">
                                <ItemTemplate>
                                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" 
                                        RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Selected="True" Value="P">Percentage</asp:ListItem>
                                        <asp:ListItem Value="R">Rupees</asp:ListItem>
                                    </asp:RadioButtonList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Doctor Charges">
                                <ItemTemplate>
                                    <asp:TextBox ID="TextBox_Charges" runat="server" Width="95px"></asp:TextBox>
                                    <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("S_ID", "{0}") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pay via Bank" SortExpression="Bank Charges">
                                <ItemTemplate>
                                    <asp:TextBox ID="TextBox_pay_via_bank" runat="server" Width="95px" Enabled="False">100</asp:TextBox>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("[Bank Charges]") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle CssClass="GridItem" />
                        <HeaderStyle CssClass="GridHeader" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                    </asp:GridView>
                    
                </div>
                <br />
                        
            </td>
            <td width="50%" valign="top" style="height: 298px">
                <br />
              
                <div style="height: 250px; overflow: auto; overflow-x: hidden;">
                     <asp:Button ID="Button1" runat="server" Text="Update Service Rate" />
                

                <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource_Grid_View"
                    DataKeyNames="DS_ID" AutoGenerateColumns="False" AllowPaging="True" 
                        PageSize="50">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr #.">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1%>
                            </ItemTemplate>
                            <ItemStyle Width="8%" />
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="True" ButtonType="Image" 
                            DeleteImageUrl="~/images/bt-close.gif" />
                        
                        <asp:BoundField DataField="S_ID" HeaderText="S ID" 
                            SortExpression="S_ID" />
                        <asp:BoundField DataField="S_Name" HeaderText="Service" 
                            SortExpression="S_Name" />
                        <asp:BoundField DataField="Services Charges" HeaderText="Rate" 
                            SortExpression="Services Charges" />
                        <asp:BoundField DataField="Mode" HeaderText="Mode" SortExpression="Mode" />
                        <asp:BoundField DataField="Charges" HeaderText="Doctore Charges" 
                            SortExpression="Charges" />
                        <asp:BoundField DataField="Bank Charges" HeaderText="Pay via Bank" 
                            SortExpression="Bank Charges" />
                    </Columns>
                </asp:GridView>
                </div>
                <br />

               
            </td>
        </tr>
    </table>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_Save_Info" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="Insert_Doctor_Service" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        InsertCommandType="StoredProcedure" DeleteCommand="DELETE FROM Doctor_Service WHERE (DS_ID = @DS_ID)"
        SelectCommand="SELECT Admin_Services.S_Name, Doctor_Service.Charges, Doctor_Service.Doctor_ID, Doctor_Service.DS_ID, Doctor_Service.Bank_Payment AS [Bank Charges], Admin_Services.S_Amount AS [Services Charges], Admin_Services.S_ID FROM Doctor_Service INNER JOIN Admin_Services ON Doctor_Service.Service_ID = Admin_Services.S_ID WHERE (Doctor_Service.Doctor_ID = @Doctor_ID)">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_Charges" DefaultValue="" Name="Charges"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_S_ID" Name="Service_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList_Doctor" Name="Doctor_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenField_pay_via_bank" Name="pay_via_bank" PropertyName="Value"
                Type="Int32" />
            <asp:Parameter Name="mode" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Doctor" Name="Doctor_ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="DS_ID" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Service" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT distinct Admin_Services.S_Name, Admin_Services.S_ID, Admin_Services.S_Category, Admin_Services.S_Amount, Doctor_Service.Bank_Payment AS [Bank Charges] FROM Admin_Services LEFT OUTER JOIN Doctor_Service ON Admin_Services.S_ID = Doctor_Service.Service_ID WHERE Admin_Services.Active=1 AND (Admin_Services.S_Category = @S_Category) and Admin_Services.S_Name like '%'+@S_Name+'%'">
        <SelectParameters>
            <asp:ControlParameter ControlID="RadioButtonList_Cat" DefaultValue="1" Name="S_Category"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtItemName" Name="S_Name" DefaultValue="%" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Dept_Name, Dept_ID FROM Department"></asp:SqlDataSource>
    
    <asp:HiddenField ID="HiddenField_S_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_pay_via_bank" runat="server" />
    <asp:HiddenField ID="HiddenField_Charges" runat="server" />
    <div align="center">
        </div>
    <asp:SqlDataSource ID="SqlDataSource_Grid_View" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Admin_Services.S_ID, Admin_Services.S_Name, Doctor_Service.Charges, Doctor_Service.Doctor_ID, Doctor_Service.DS_ID, Doctor_Service.Bank_Payment AS [Bank Charges], 
                      Admin_Services.S_Amount AS [Services Charges], CASE WHEN Doctor_service.mode = 'P' THEN 'Percentage' ELSE 'Fixed' END AS Mode
                      FROM Doctor_Service INNER JOIN Admin_Services ON Doctor_Service.Service_ID = Admin_Services.S_ID
                      WHERE (Doctor_Service.Doctor_ID = @Doctor_ID) 
                      ORDER BY Admin_Services.S_Name "
        DeleteCommand="DELETE FROM Doctor_Service WHERE (DS_ID = @DS_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Doctor" DefaultValue="" Name="Doctor_ID"
                PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView1" Name="DS_ID" PropertyName="SelectedValue" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Category" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Asc_Name, Asc_id  FROM Admin_Service_Category"></asp:SqlDataSource>
</asp:Content>
