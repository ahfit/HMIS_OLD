<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="MapServicevsDoctor.aspx.cs" Inherits="Patient_Billing_MapServicevsDoctor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div clase="bxmain inner-content" style="width:100%"  ><h3><span>Map OPD Services with Doctor</span></h3></div>
    <table class="style1">
         <tr>
            <td align="right"><strong>Hospital :</strong></td>
            <td>
                  <asp:DropDownList ID="ddl_Hospital" runat="server" Width="290px" OnSelectedIndexChanged="ddl_Hospital_SelectedIndexChanged" AutoPostBack="true">
                    
                </asp:DropDownList> 
            </td>
        </tr>
        <tr>
            <td align="right">
                <strong>Department :</strong></td>
            <td>
                    <asp:DropDownList ID="ddldept" Width="290px" AutoPostBack="true" 
                        runat="server" OnSelectedIndexChanged="ddldept_SelectedIndexChanged">
                    </asp:DropDownList>
                                </td>
        </tr>
         <tr>
            <td align="right">
                <strong>Patient Type :</strong></td>
            <td>
                                <asp:DropDownList ID="ddlPatientType" runat="server" Width="290px" 
                                    AutoPostBack="True" OnSelectedIndexChanged="ddlPatientType_SelectedIndexChanged" 
                                     >
                                </asp:DropDownList>
                                </td>
        </tr>
        <tr>
            <td align="right">
                <b>Doctor :</b></td>
            <td>
                    <asp:DropDownList ID="ddldoctors" Width="290px" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddldoctors_SelectedIndexChanged">
                    </asp:DropDownList>
                                </td>
        </tr>
       
        <tr>
            <td align="right">
                <b>OPD Service :</b></td>
            <td>
                                <asp:DropDownList ID="ddlServices"  runat="server" 
                   Width="290px"  >
                                </asp:DropDownList>
                                </td>
        </tr>


        <tr>
            <td>
                &nbsp;</td>
            <td>
                <asp:Button ID="btn_Update" runat="server" Text="Save" OnClick="btn_Update_Click" />
                <asp:Label ID="lblmsg" Text="Save Successfully...." Visible="false" runat="server"></asp:Label>
            </td>

        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
                  <Columns>
    <asp:TemplateField HeaderText="ID ">
            <ItemTemplate>
            <asp:Label ID="lblid" Text='<%# Bind("ID") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>


    <asp:TemplateField HeaderText="Entry Date">
            <ItemTemplate>
            <asp:Label ID="lblname" Text='<%# Bind("EntryDate") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

                        <asp:TemplateField HeaderText="Department">
            <ItemTemplate>
            <asp:Label ID="lblname1" Text='<%# Bind("SubDept_Name") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

     <asp:TemplateField HeaderText="Doctor">
            <ItemTemplate>
            <asp:Label ID="lblname2" Text='<%# Bind("Doctor") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

                      <asp:TemplateField HeaderText="Service">
            <ItemTemplate>
            <asp:Label ID="lblname3" Text='<%# Bind("S_Name") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delete">
             <ItemTemplate>
                    <asp:LinkButton ID="del" Text="Delete" CommandName='<%# Bind("ID") %>' runat="server" OnClick="deleteRecord" > </asp:LinkButton>
                </ItemTemplate>
           
                 </asp:TemplateField>

           
</Columns>

                </asp:GridView>
            </td>

        </tr>
    </table>
</asp:Content>

