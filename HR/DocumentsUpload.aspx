<%@ Page Title="" Language="VB" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="false" CodeFile="DocumentsUpload.aspx.vb" Inherits="HR_DocumentsUpload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.24/themes/start/jquery-ui.css" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.24/jquery-ui.min.js"></script>
<script type="text/javascript">
    $(function () {
        $("#dialog").dialog({
            autoOpen: false,
            modal: true,
            height: 400,
            width: 600, 
            title: "Document Preview"
        });

        $("[id*=gdImage] img").click(function () { 
            $('#dialog').html('');
            $('#dialog').append($(this).clone());
            $('#dialog').dialog('open');
            $("[id*=dialog] img").css('height', '300');
            $("[id*=dialog] img").css('width', '300');
        });


 
    });
</script>

    <script type="text/javascript">
        function confirmationDelete() {
            if (confirm('Are you sure you want to delete record ?')) {
                return true;
            } else {
                return false;
            }
        }
    </script>

   

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-stiped">


                <tr>
                    <td>
                        <b>Document Name : </b>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="TextBox1" />
                    </td>
                </tr>

                <tr>
                    <td>
                        <b>Upload Document : </b>
                    </td>
                    <td>
                        <asp:FileUpload ID="FileUpload1" runat="server" />
                    </td>
                </tr>

                <tr>
                    <td>
                        <asp:Button ID="Button1" runat="server" Text="Upload" onclick="Button1_Click"/>
                       
                    </td>
                    

                </tr>
            </table>
          
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                   

        </div>
    </div>


     <div class="row">
        <div class="col-md-12">

            <asp:GridView runat="server" ID="gdImage" HeaderStyle-BackColor="Tomato" Visible="true"  AutoGenerateColumns="false">

                <Columns>

                    <asp:BoundField DataField="DocumentId" HeaderText="ImageId" />

                    <asp:BoundField DataField="Documentname" HeaderText="ImageName" />

                    <asp:BoundField DataField="OrignalName" HeaderText="OrignalName"  Visible="false"/>
                    <asp:ImageField DataImageUrlField="DocumentPath" HeaderText="Image" ControlStyle-Width="60" ControlStyle-Height = "60" >
                    </asp:ImageField>

       <asp:TemplateField>
            <ItemTemplate>

                <asp:LinkButton ID="Download" Runat="server" Text="Ok" onclick="Download_Click" CommandArgument='<%# Eval("OrignalName") %>'>
                    Download
                </asp:LinkButton>

   
            </ItemTemplate>
        </asp:TemplateField>

                       <asp:TemplateField>
            <ItemTemplate>

                <asp:LinkButton ID="Delete" Runat="server" Text="Ok" OnClientClick="return confirmationDelete();" onclick="Delete_Click" CommandArgument='<%# Eval("DocumentId")%>'>
                   Delete
                </asp:LinkButton>

   
            </ItemTemplate>
        </asp:TemplateField>

                </Columns>

            </asp:GridView>


        </div>
          </div>

    <div id="dialog" style="display: none">
</div>
</asp:Content>

