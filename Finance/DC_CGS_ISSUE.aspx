<%@ Page Language="C#" AutoEventWireup="true" Inherits="DC_CGS_ISSUE" MasterPageFile="~/tcp_masterpage.master" CodeFile="DC_CGS_ISSUE.aspx.cs" Theme="SkinFile" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width:100%; margin-bottom:10px;">
       <h2><span>&nbsp;Delivery Chellan&nbsp; CGS Voucher Post</span></h2>
     <table class="style1">
        <tr>
            <td colspan="2">
                <div style="width: 100%;">
                    <table style="width: 700px; margin: auto;">
                        <tr>
                            <td style="font-weight: bold;">Company
                            </td>
                            <td style="font-weight: bold;">:
                            </td>
                            <td>
                                <asp:DropDownList ID="DDL_Company" runat="server" DataSourceID="SDS_Company" DataTextField="Financial_Company_Name"
                                    DataValueField="Financial_Company_Id" AutoPostBack="True" OnSelectedIndexChanged="DDL_Company_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SDS_Company" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    SelectCommand="SELECT Financial_Company_Id, Financial_Company_Name FROM Group_Financial_Companies WHERE (Financial_Company_Id IN (SELECT Financial_Company_ID FROM Employee_Rights_Company_Wise WHERE (Emp_ID = @emp_id)))">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="Emp_ID" SessionField="emp_id" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                            <td style="font-weight: bold;">To Branch
                            </td>
                            <td>
                                <strong>:</strong>
                            </td>
                            <td>
                                <asp:DropDownList ID="DDL_Branch" runat="server" DataSourceID="SDS_Branch" DataTextField="SubDept_Name"
                                    DataValueField="SubDept_Id">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SDS_Branch" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
                                    SelectCommand="SELECT distinct SubDept_Id, SubDept_Name FROM SubDepartment  WHERE (Financial_Company_Id = @Financial_Company_Id) and (Company_Branch_Id in (select Company_Branch_Id from vw_EmployeeDepartmentRights where (Emp_ID = @Emp_ID)))">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DDL_Company" Name="Financial_Company_Id" PropertyName="SelectedValue" />
                                        <asp:SessionParameter Name="emp_id" SessionField="Emp_id" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">Issue Date From
                            </td>
                            <td style="font-weight: bold;">:
                            </td>
                            <td>
                                 <asp:TextBox ID ="WebDateChooser_date_From" runat ="server" TextMode ="date"  Width="202px"></asp:TextBox>
                                
                            </td>
                            <td style="font-weight: bold;">From Branch</td>
                            <td>
                                <strong>:</strong>
                            </td>
                            <td>
                                
                                <asp:DropDownList ID="DDL_TBranch" runat="server" DataSourceID="SDS_TBranch" DataTextField="SubDept_Name"
                                    DataValueField="SubDept_Id">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SDS_TBranch" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
                                    SelectCommand="SELECT 0  SubDept_Id,  ' --- All ---' SubDept_Name  union SELECT  SubDept_Id, SubDept_Name FROM BasicDataInfo.dbo.SubDepartment S where S.Is_Hidden is null order by SubDept_Name">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DDL_Company" Name="Financial_Company_Id" PropertyName="SelectedValue" />
                                        <asp:SessionParameter Name="emp_id" SessionField="Emp_id" />
                                    </SelectParameters>
                                </asp:SqlDataSource></td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">Issue Date To
                            </td>
                            <td style="font-weight: bold;">:
                            </td>
                            <td>
                                <asp:TextBox ID ="WebDateChooser_Date_To" runat ="server" TextMode ="date"  Width="202px"></asp:TextBox>
                               <%-- <igsch:WebDateChooser ID="WebDateChooser_Date_To" runat="server" Width="202px">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>--%>
                            </td>

                            <td style="font-weight: bold;">Requisition No
                            </td>
                            <td style="font-weight: bold;" >:</td>
                            <td style="font-weight: bold;">
                                <asp:TextBox ID="txtRequistionNo" runat="server"></asp:TextBox>
                            </td>

                        </tr>
                        <tr>
                            <td style="font-weight: bold;">For Company</td>
                            <td style="font-weight: bold;">:</td>
                            <td>
                                <asp:DropDownList ID="DDL_Party" runat="server" DataSourceID="SDS_Party" DataTextField="Party_Name" DataValueField="Party_Id">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SDS_Party" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    SelectCommand="Select Party_Id,Party_Name from ( 
SELECT 0 Party_Id, ' All 'Party_Name
 
Union 
SELECT Party_Id, ltrim(Rtrim(Party_Name)) Party_Name FROM parties where party_id not in (Select C.Account_No from Finance.dbo.Group_Company_Branches C) 
and not(Party_Name is null or Party_Name = '')

) a
order by Party_Name">
                                </asp:SqlDataSource>
                            </td>

                            <td style="font-weight: bold;">
                <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                            </td>
                            <td style="font-weight: bold;" >&nbsp;</td>
                            <td style="font-weight: bold;">
                
                <asp:Button ID="Btn_Post" runat="server"  Text="Post" OnClick="Btn_Post_Click" OnClientClick='return confirm("Are you sure you want to Post this Voucher?");' />
                
                            </td>

                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">&nbsp;
                </td>
            <td  align="right">&nbsp;
                </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                
                <asp:Label ID="lbl_Total_Amount" runat="server" Text="0" ForeColor ="Red" Font-Size="X-Large" ></asp:Label>
                
            </td>
        </tr>
        <tr>
            <td>&nbsp;
            </td>
            <td>&nbsp;
            </td>
        </tr>
    </table>
       </div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Consumption_Id" Width="99%" EmptyDataText="No Record(s) Found"
                    ShowFooter="True">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr. No.">
                            <ItemTemplate>
                               <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                            <ItemStyle Width="50px"></ItemStyle>
                        </asp:TemplateField>
                        <asp:HyperLinkField DataNavigateUrlFields="Consumption_Id" Target="_blank" DataTextField="Requisition_Id"
                            DataNavigateUrlFormatString="~/Store/Search_Order_Wise.aspx?C_ID={0}" />
                        <asp:BoundField DataField="Consumed_Date" DataFormatString="{0:dd/MM/yyyy}"
                            HeaderText="Issue Date" SortExpression="Consumed_Date" />
                        <asp:BoundField DataField="IssueToSub" HeaderText="Issue To" SortExpression="IssueToSub" />
                        <asp:BoundField DataField="SubDept_Name" HeaderText="Issue From" SortExpression="SubDept_Name" />  
                        <asp:BoundField DataField="party_name" HeaderText="For Company" SortExpression="party_name" />                    
                        <asp:TemplateField HeaderText="Cost" SortExpression="Cost">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Cost") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_cost" runat="server" Text='<%# Bind("Cost") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total Qty">
                            <ItemTemplate>
                                <asp:Label ID="lblqty" runat="server" Text='<%# Eval("Qty") %>'></asp:Label>
                                <asp:HiddenField ID="hf_Consumption_Id" runat="server" Value='<%# Eval("Consumption_Id") %>' ></asp:HiddenField>
                                <asp:HiddenField ID="hf_SubDept_Id" runat="server" Value='<%# Eval("SubDept_Id") %>' ></asp:HiddenField>
                                <asp:HiddenField ID="hf_Requisition_Id" runat="server" Value='<%# Eval("Requisition_Id") %>' ></asp:HiddenField>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lbltotalqty" runat="server" Text=""></asp:Label>
                                
                            </FooterTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="POST">
                            <HeaderTemplate>
                                <asp:CheckBox ID="CB_Header" runat="server" AutoPostBack="True" Text="POST " TextAlign="Left" OnCheckedChanged="CB_Header_CheckedChanged" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="CB_Item" runat="server" OnCheckedChanged="CB_Item_CheckedChanged" Enabled="false" AutoPostBack="True" Visible ='<%# Eval("vis_CB") %>' />
                                <asp:LinkButton ID ="lbl_V_Voucher" runat ="server"  Visible='<%# Eval("vis_VTI") %>' Text ='<%# Eval("VTI") %>' OnClick="lbl_V_Voucher_Click"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                    </Columns>
                </asp:GridView>
    
</asp:Content>
