<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RadialogyImageControl.ascx.cs" Inherits="Pt_EMR_ForRadialogyImageControl" %>



<link href="css/imgzoom.css" rel="stylesheet" />


<%--<asp:UpdatePanel ID="updatePanel" runat="server">
    <ContentTemplate>--%>
      
            

            <div runat="server" class="bxmain inner_content" style="width: 51%; max-height: 300px; overflow-y: auto; margin-top: 10px; float: left; display: inline">
                <asp:Button ID ="btn_Show_Image" runat="server" OnClick="btn_Show_Image_Click" Text="Show Saved Images" />

                <asp:DataList ID="ddlImages" runat="server" OnItemDataBound="ddlImages_ItemDataBound" RepeatColumns="3" RepeatDirection="Horizontal">
                    <ItemTemplate>
                        <div style="margin-left: 15px; border: solid 1px #ccc; border-radius: 10px; text-align: center; width: 100px; height: 100px; padding: 5px; background-color: aliceblue;">
                            <a id="anchorImg" runat="server" href="~/images/main_figure2.jpg">
                            <asp:Image ID="RadImage" runat="server" CssClass="thumbnail" Height="100%" Width="100%" />
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
                
            </div>
       

       
    


<style type="text/css">
    .lnkbtn {
        text-decoration: none;
        font-size: 15px;
        color: #7000ff;
        font-family: 'Iskoola Pota';
        padding-left: 10px;
    }
</style>
<script type="text/javascript">
    function enlargeImage() {

        $('img.thumbnail').imgZoom();
    }

</script>
