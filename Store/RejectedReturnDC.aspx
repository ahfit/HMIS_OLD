<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="RejectedReturnDC.aspx.cs" Inherits="Store_RejectedReturnDC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div style="width: 100%" class="bxmain inner_content">
        <h2>
            <span>Rejected Returned DC</span>
        </h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">

            <tr>
                <td width="25%" align="right">Department : </td>
                <td>
                    <asp:DropDownList ID="ddlFromOffice" runat="server" DataSourceID="SQL_ForSubDepartment"
                        DataTextField="SubDept_Name" DataValueField="SubDept_Id">
                    </asp:DropDownList>

                        <asp:SqlDataSource ID="SQL_ForSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT        S.SubDept_Name, S.SubDept_Id
FROM            SubDepartment AS S JOIN
                         requisition_department_filter AS R ON S.SubDept_Id = R.sub_Subdept_ID
WHERE        (R.Main_Subdept_ID = @SubDept_Id) and (R.Requisition_Type = 'Internal')" >
        <SelectParameters>
            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
        </SelectParameters>
      
    </asp:SqlDataSource>


              
                </td>
            </tr>
            <tr>
                <td width="25%" align="right">Start Date : </td>
                <td>
                    <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td width="25%" align="right">End Date :</td>
                <td>
                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" class="auto-style1"></td>
                <td>
                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" CssClass="btn_hacims"
                        Text="Search" />
                    <asp:Label ID="lblmsg" Font-Size="Large" Font-Bold="true" Visible="false" runat="server" />
                </td>
            </tr>
        </table>
    </div>




  <asp:Panel ID="Panel_Remarks" runat="server" Visible="False" CssClass="lightbox" Wrap="False">
        <br /> 
          <div class="bxmain">
               &nbsp;<strong style="font-weight: bold; font-size: 13px;">Requisition No. : </strong>
               
            <asp:Label ID="Lbl_Requisition_No" runat="server" Style="color: #900; font-weight: bold;
            font-size: 13px; padding-bottom: 5px;"></asp:Label>
      <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%"> 
        <tr>
            <td>
                 <asp:TextBox ID="TextBox_Remarks"  runat="server" Width="100%" Height="250px" TextMode="MultiLine"></asp:TextBox>
            </td>
            </tr> 
        <tr>
            
            <td colspan="2" align="center">               
                 <asp:Button ID="btn_Save" runat="server" OnClick="btn_Save_Click"   Text="Resend" />
            <asp:Button ID="btn_Cancel" runat="server" OnClick="btn_Cancel_Click" Text="Cancel" />
            </td>           
        </tr>
          </table>
              </div> 
        <asp:SqlDataSource ID="Sql_Remarks" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            UpdateCommand="Resend_Requisition"
            UpdateCommandType="StoredProcedure">
            <UpdateParameters>
                <asp:ControlParameter ControlID="TextBox_Remarks" Name="Resend_Remarks" PropertyName="Text" />
                <asp:ControlParameter ControlID="HF_Re_ID" Name="Consumption_Id" PropertyName="Value" />
                <asp:SessionParameter Name="Approved_by" SessionField="emp_id" Type="Int32" />               
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <div align="center">           
            <strong> <asp:Label ID="Label" runat="server" Style="color: #CC0000;"></asp:Label></strong></div>
        <br />
        <asp:HiddenField ID="HiddenField1" runat="server" />
    </asp:Panel> 

    <asp:GridView ID="gridview1" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField HeaderText="IB_ID">
                <ItemTemplate>
                    <asp:Label ID="label_IBID" Text='<%# Bind("IB_ID") %>' runat="server" />
                <asp:HiddenField ID="hfIBID" runat="server" Value='<%#Bind("IB_ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Department">
                <ItemTemplate>
                    <asp:Label ID="label2" Text='<%# Bind("ByDepartment") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="DateTime">
                <ItemTemplate>
                    <asp:Label ID="label3" Text='<%# Bind("DateTime") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Issued_By">
                <ItemTemplate>
                    <asp:Label ID="label4" Text='<%# Bind("Issued_By") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Remarks">
                <ItemTemplate>
                    <asp:Label ID="label67" Text='<%# Bind("Reject_Remarks") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="label5" Text='<%# Bind("Rejected_Status") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>

      <asp:TemplateField Visible="false" HeaderText="Resend">
                <ItemTemplate>
                    <asp:LinkButton ID="lbn_Remarks" runat="server" CommandArgument='<%# Eval("Consumption_Id") %>'
                        OnClick="lbn_Remarks_Click">Resend</asp:LinkButton>
                    <asp:HiddenField ID="hf_Consumption" runat="server" Value='<%# Eval("IB_ID") %>'/> 
                </ItemTemplate>
            </asp:TemplateField> 


              <asp:HyperLinkField DataNavigateUrlFields="Consumption_Id,IB_ID,subdeptid" HeaderText="Receive Rejected Items wise" DataNavigateUrlFormatString="RejectedItemsRecieved.aspx?C_ID={0}&amp;IB_ID={1}&subdeptid={2}"
                            Text="Receive" /> 


              <asp:TemplateField  Visible="false" HeaderText="View Returned /Receive ">
                <ItemTemplate>
                    <asp:LinkButton ID="lbreturn" Text="View Returned /Receive" CommandArgument='<%#Bind("Consumption_Id") %>' runat="server"  OnClick="lbreturn_Click" ></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField> 
        </Columns>
    </asp:GridView>

     <asp:HiddenField ID="HF_Re_ID" runat="server" />


</asp:Content>

