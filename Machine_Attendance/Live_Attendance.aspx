<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Machine_Attendance_Live_Attendance, App_Web_aiw43tag" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:content id="Content1" contentplaceholderid="head" runat="Server">
</asp:content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
<div class="bxmain inner_content" style="width:100%">
    <h2><span>Live Attendance</span></h2>
    <table>
        <tr>
            <td>
                IP:
            </td>
            <td>
                <asp:TextBox runat="server" Text="192.168.1.201" ID="txtIP" ></asp:TextBox>
            </td>
            <td>
                Port:
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtPort" Text="4370"></asp:TextBox>
                <asp:Button Text="Connect" ID="btnConnect" OnClick="btnConnect_Click" runat="server" />
                <asp:Label ID="lblState" runat="server" />
                
            </td>
        </tr>
        
        <tr>
            <td colspan="4">
                  <asp:Label runat="server" ID="lblMsg" />
            </td>
        </tr>
        <tr>
            <td colspan="4">
                  <asp:TextBox ID="txtLogs" runat="server" TextMode="MultiLine" Height="200px" Width="500px" />
            </td>
        </tr>
    </table>
  
</div>
</asp:content>
