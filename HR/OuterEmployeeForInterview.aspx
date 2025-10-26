<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_OuterEmployeeForInterview, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span>Outer Employee For Interview </span></h2>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tbl_form">


             <tr>
                <td align="right" style="width: 10%;">
                    <b> Employee Name:</b>
                </td>
                <td style="width: 10%;">
                   <asp:TextBox ID="txtEmp" runat="server" ></asp:TextBox>
                    </td>     

                </tr> 
            
            
            
            
            
            <tr>
                <td align="right" style="width: 10%;">
                    <b> Department:</b>
                </td>
                <td style="width: 10%;">
                   <asp:TextBox ID="txtDeprt" runat="server" ></asp:TextBox>
                    </td>     

                </tr>
           
                <tr>
                    <td align="right" style="width: 10%;">
                        
                     <b>Designation:</b>
                        </td>
                     <td style="width: 10%;">
                    <asp:TextBox ID="txtDesignation" runat="server" ></asp:TextBox>
                </td>
                </tr>
            
             <tr>
                <td align="right" style="width: 10%;">
                    <b> Scale :</b>
                </td>
                <td style="width: 10%;">
                    <asp:TextBox ID="textScale" runat="server" ></asp:TextBox>
                </td>

                </tr>

              <tr>
                <td align="right" style="width: 10%;">
                    <b> Institute Name :</b>
                </td>
                <td style="width: 10%;">
                    <asp:TextBox ID="txtInstut" runat="server" ></asp:TextBox>
                </td>

                </tr>


               <tr>
                <td align="right" style="width: 10%;">
                    <b> Experience :</b>
                </td>
                <td style="width: 10%;">
                    <asp:TextBox ID="txtExper" runat="server" ></asp:TextBox>
                </td>

                </tr>


              <tr>
                <td align="right" style="width: 10%;">
                    <b> Expertise :</b>
                </td>
                <td style="width: 10%;">
                    <asp:TextBox ID="txtExpertise" runat="server" ></asp:TextBox>
                </td>

                </tr>



             <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:Button ID="btn_save" runat="server" Text="Save" OnClick="btn_save_Click" />
                <asp:Label ID="lblmsg" Text="Save Successfully...." Visible="false" runat="server"></asp:Label>
            </td>

        </tr>


            </table>
     </div>


  <div style=" margin-top:10px;  padding-top:10px;" >

    <asp:GridView ID="gridviewOuter" runat="server" AutoGenerateColumns="false" >
        <Columns>
        <asp:TemplateField HeaderText="Name">
            <ItemTemplate>
            <asp:Label ID="lblName" Text='<%# Bind("EmployeeName") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Dept Name">
            <ItemTemplate>
            <asp:Label ID="lblDname" Text='<%# Bind("DepartmentName") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="Designation">
            <ItemTemplate>
            <asp:Label ID="lblDesig" Text='<%# Bind("Designation") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
             <asp:TemplateField HeaderText="Scale">
            <ItemTemplate>
            <asp:Label ID="lblScale" Text='<%# Bind("Scale") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
             <asp:TemplateField HeaderText="Institute">
            <ItemTemplate>
            <asp:Label ID="lblinst" Text='<%# Bind("Institute") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
             <asp:TemplateField HeaderText="Experience">
            <ItemTemplate>
            <asp:Label ID="lblExper" Text='<%# Bind("Experience") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
             <asp:TemplateField HeaderText="Expertise">
            <ItemTemplate>
            <asp:Label ID="lblexptise" Text='<%# Bind("Experties") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

             <asp:TemplateField>
               
             <ItemTemplate>
                    <asp:LinkButton ID="del" Text="Delete" CommandName='<%# Bind("OuterEmployee_ID") %>' runat="server" OnClick="deleteRecord" > </asp:LinkButton>
                </ItemTemplate>
           
                 </asp:TemplateField>
            




           </Columns>

        </asp:GridView>
        </div>











</asp:Content>

