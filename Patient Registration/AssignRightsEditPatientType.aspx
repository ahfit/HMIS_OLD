<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="AssignRightsEditPatientType.aspx.cs" Inherits="Patient_Registration_AssignRightsEditPatientType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="bxmain inner_content" style="width:100%"><span><h2>Assign Edit Patient Rights</h2></span>
    <table class="diagnosis_list">
        <tr> 
        <td style="width:50%;text-align:right;padding-bottom:5px;">
                    Department : 
                </td>
                <td style="padding-bottom:5px;">
                    <asp:DropDownList ID="ddlDepartment" runat="server" DataTextField="Dept_Name" DataValueField="Dept_ID" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged" AutoPostBack="true" ></asp:DropDownList>
                </td>
            </tr>
        <tr>
         <td style="width:50%;text-align:right;padding-bottom:5px;">
                    Employee : 
                
                <td style="padding-bottom:5px;">
                    <asp:DropDownList ID="DDLEmployee" runat="server" AutoPostBack="true" DataTextField="EmpName" DataValueField="EmpID" OnSelectedIndexChanged="DDLEmployee_SelectedIndexChanged" ></asp:DropDownList>
                </td>
            </tr>
             <tr>
         <td style="width:50%;text-align:right;padding-bottom:5px;">
                    Edit Type : 
                </td>
                <td style="padding-bottom:5px;">
                    <asp:DropDownList ID="DDLEditType" runat="server" DataTextField="EditType" DataValueField="ID" ></asp:DropDownList>
                </td>
            </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <asp:Button ID="btn_markReceptionest" runat="server" Text="Assign Edit Patient Type" 
                    onclick="btn_markReceptionest_Click" />
                <asp:Label ID="lblmg" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        </table>
        </div>
        <div>
                <asp:GridView  ID="GridView1" AutoGenerateColumns="false" runat="server" Width="100%">
              <Columns>
                  
                  <asp:TemplateField HeaderText="Emp ID">
                      <ItemTemplate>
                          <asp:Label ID="lblid" runat="server" Text='<%#Bind("EmpID") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Department">
                      <ItemTemplate>
                          <asp:Label ID="lblDept_Name" runat="server" Text='<%#Bind("Dept_Name") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>

                  <asp:TemplateField HeaderText="Employee Name">
                      <ItemTemplate>
                          <asp:Label ID="lblEmployeeName" runat="server" Text='<%#Bind("EmployeeName") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Type">
                      <ItemTemplate>
                          <asp:Label ID="lblType" runat="server" Text='<%#Bind("Type") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                   <asp:TemplateField HeaderText="Delete">
             <ItemTemplate>
                    <asp:LinkButton ID="del" Text="Delete" CommandName='<%# Bind("ID") %>' runat="server" OnClick="deleteRecord" > </asp:LinkButton>
                </ItemTemplate>
           
                 </asp:TemplateField>
              </Columns>
                      </asp:GridView>
                    <asp:HiddenField runat="server" id = "HF_Status"></asp:HiddenField>  
            </div>
</asp:Content>

