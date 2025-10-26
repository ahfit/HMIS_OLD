<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Dialysiscomplications.aspx.cs" Inherits="Pt_EMR_Default2" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span>Add Dialysis Complications</span></h2>
  <table>
              <tr>
            <td style="width:20%;text-align:right;">Discription :  </td>
     <td>
          <asp:TextBox runat="server" ID="txt" Width="801px"></asp:TextBox>
         <asp:RequiredFieldValidator ID="validtor" Display="Dynamic" ControlToValidate="txt" runat="server" ErrorMessage="Required" ForeColor="Red" ValidationGroup="mainApp"></asp:RequiredFieldValidator>
     </td>  
        </tr>
    </table>
        <div style="text-align:center;">
        <asp:Button runat="server" ValidationGroup="mainApp" ID="btn" OnClick="btn_Click" Text="Save" />
            </div>
    </div>
    <div class="bxmain inner_content " style="width: 100%;">
     <h2>
            <span>Add Dialysis Machine</span></h2>
        <asp:GridView runat="server" ID="gv" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField   DataField="id" HeaderText="id" SortExpression="id"></asp:BoundField>
              
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name"></asp:BoundField>
                <asp:ButtonField CommandName="Delete" Text="delete"></asp:ButtonField>
                <asp:CommandField ShowEditButton="True"></asp:CommandField>
            </Columns>
        </asp:GridView>
        </div>
        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:TreatmentConnectionString %>' SelectCommand="SELECT * FROM [dialysiscomplication]" DeleteCommand="DELETE FROM [dialysiscomplication] WHERE [id] = @original_id AND (([name] = @original_name) OR ([name] IS NULL AND @original_name IS NULL))" InsertCommand="INSERT INTO [dialysiscomplication] ([name]) VALUES (@name)" UpdateCommand="UPDATE [dialysiscomplication] SET [name] = @name WHERE [id] = @original_id AND (([name] = @original_name) OR ([name] IS NULL AND @original_name IS NULL))" ConflictDetection="CompareAllValues" OldValuesParameterFormatString="original_{0}">
            <DeleteParameters>
                <asp:Parameter Name="original_id" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="original_name" Type="String"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="name" Type="String"></asp:Parameter>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="name" Type="String"></asp:Parameter>
                <asp:Parameter Name="original_id" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="original_name" Type="String"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>
    
</asp:Content>