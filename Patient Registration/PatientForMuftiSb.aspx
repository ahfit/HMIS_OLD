<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="PatientForMuftiSb.aspx.cs" Inherits="Patient_Registration_PatientForMuftiSb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script type="text/javascript">
        function resetform() { document.form1.reset(); document.form1.TextBoxYearlyNo.focus(); }
        function enablelist(a) {
            if (a.checked == true) {
                document.getElementById("dropdownlistDiagnosis").disabled = false;
            }
            else {
                document.getElementById("dropdownlistDiagnosis").disabled = true;
            }

        }
    </script>
        <style type="text/css">
        .lblMsg {
            color: Green;
            font-weight: bold;
            border: solid 1px #FFF;
            padding: 3px;
            border-radius: 20px;
        }
    </style>
     <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
    <link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />
    <script src="../css_hacims/ck.js" type="text/javascript"></script>

    <style type="text/css">
        .label {
        width:50%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Patient Search OPD</span></h2>
        <table width="99%">
            <tr>
                <td style="width:50%">
                 <span style="text-align:right">   <asp:Label  Width="30%"   ID="lblName" runat="server" Text="Patient Name :"></asp:Label></span>
                    <asp:TextBox Width="50%" ID="txtboxName" runat="server"></asp:TextBox>
                </td>
                <td>
                 <span style="text-align:right"><asp:Label Width="30%" ID="Label1" runat="server" Text="Mobile # :"></asp:Label></span>
                    <asp:TextBox Width="50%"  ID="txtboxMobileno" runat="server"></asp:TextBox>
                </td>
            </tr>
             <tr>
                <td style="width:50%">
                    <span style="text-align:right"><asp:Label  Width="30%"  ID="Label2" runat="server" Text="CNIC :"></asp:Label></span>
                    <asp:TextBox Width="50%" ID="txtboxCnic" runat="server"></asp:TextBox>
                </td>
                <td>
                    <span style="text-align:right"><asp:Label Width="30%" ID="Label3" runat="server" Text="Mr # :"></asp:Label></span>
                    <asp:TextBox Width="50%"  ID="txtboxMr" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td style="width:50%">
                    <span style="text-align:right"><asp:Label  Width="30%"  ID="Label4" runat="server" Text="Patient Status :"></asp:Label></span>
                    <asp:DropDownList ID="ddlStatus" runat="server">
                        <asp:ListItem Text="Newly Forward" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Old Patients" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="btn" runat="server" Text="Search" OnClick="btn_Click" />
                </td>
            </tr>
            </table>
         </div>

<br>
    <div style="width:100%">
        <asp:GridView ID="gvd" runat="server" Width="100%" AutoGenerateColumns="false" >
            <Columns>
                                <asp:TemplateField HeaderText="Sr #.">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" OnClick="lnkbtnGoToPatient_Click" ID="lnkbtnGoToPatient" Text='<%# Eval("RegNo") %>' CommandArgument='<%# Eval("Status") %>' ></asp:LinkButton>
                        <asp:HiddenField ID="hdfYearlyNo" runat="server" Value='<%# Eval("yearly_no") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Cnic" HeaderText="Cnic" />
                <asp:BoundField DataField="MobilePhone" HeaderText="MobilePhone" />
                <asp:BoundField DataField="Relation" HeaderText="Relation" />
                <asp:BoundField DataField="RelationName" HeaderText="RelationName" />  
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton runat="server" OnClick="lnkbtnPrint_Click" ID="lnkbtnPrint" Text="Print" ToolTip='<%# Eval("RegNo") %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>              
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>

