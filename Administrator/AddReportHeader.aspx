<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Basic_Data_Management_AddReportHeader, App_Web_hbh2gz45" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">




    <div class="bxmain 
        " style="width: 100%;">

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <h2><span>Add Report Header</span></h2>

        <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
            <tr>
                <td width="25%" align="right">Hospital Name: </td>
                <td>
                    <asp:DropDownList ID="ddlHospital" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>

   
            <tr>
                <td width="25%" align="right">Heading 1:  </td>
                <td>
                    <asp:TextBox runat="server" ID="txtHeadingOne"></asp:TextBox>

                </td>
            </tr>

            <tr>
                <td width="25%" align="right">Heading 2:  </td>
                <td>
                    <asp:TextBox runat="server" ID="txtHeadingTwo"></asp:TextBox>

                </td>
            </tr>

            <tr>
                <td width="25%" align="right">Heading 3:  </td>
                <td>
                    <asp:TextBox runat="server" ID="txtHeadingThree"></asp:TextBox>

                </td>
            </tr>

            <tr>
                <td width="25%" align="right">Footer Heading :  </td>
                <td>
                    <asp:TextBox runat="server" ID="txtHeadingFour"></asp:TextBox>

                </td>
            </tr>

            <tr>
                <td width="25%" align="right">Image Left:  </td>
                <td>
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                    <asp:Image Visible="false" ID="imgLeft" runat="server" Height="50px" Width="50px" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Display="Dynamic" ValidationGroup="validate" ValidationExpression="(.*png$)|(.*PNG$)|(.*jpg$)|(.*JPG$)|(.*jpeg$)|(.*JPEG$)"
                        ControlToValidate="FileUpload1" runat="server" ForeColor="Red" ErrorMessage="Select Only JPEG or PNG file." />
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="FileUpload1" ErrorMessage="Required" Display="Dynamic" ValidationGroup="validate"></asp:RequiredFieldValidator>
                </td>
              
            </tr>


            <tr>
                <td width="25%" align="right">Image Right:  </td>
                <td>
                    <asp:FileUpload ID="FileUpload2" runat="server" />
                    <asp:Image Visible="false" ID="Image1" runat="server" Height="50px" Width="50px" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="Dynamic" ValidationGroup="validate" ValidationExpression="(.*png$)|(.*PNG$)|(.*jpg$)|(.*JPG$)|(.*jpeg$)|(.*JPEG$)"
                        ControlToValidate="FileUpload2" runat="server" ForeColor="Red" ErrorMessage="Select Only JPEG or PNG file." />
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" Display="Dynamic" ControlToValidate="FileUpload2" ErrorMessage="Required" ValidationGroup="validate"></asp:RequiredFieldValidator>
                </td>

                <td></td>
            </tr>


            <tr>
                <td width="25%" colspan="4" align="center">
                    <asp:Button ID="saveBtn" ValidationGroup="validate" runat="server" Text="Save" OnClick="BtnSave_Click" />
                    <asp:Button CausesValidation="false"  ID="btnUpdate" Visible="false" ValidationGroup="validate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
                </td>
            </tr>
           


        </table>

    </div>
 <div class="bxmain inner_content" style="width: 100%; padding:4px; padding-top:4px">
        <table>
             <tr>
                <td>
                    <asp:GridView ID="gridviewReport" runat="server" AutoGenerateColumns="false" OnRowDataBound="gridviewReport_RowDataBound" >
                        <Columns>
                            <asp:TemplateField HeaderText="Hospital Name">
                                 <ItemTemplate>
                                    <asp:Label ID="hospitalLabel" Text='<%# Bind("Hospital_Name") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Heading One">
                                 <ItemTemplate>
                                    <asp:Label ID="headingOneLabel" Text='<%# Bind("Heading_One") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Heading Two">
                                 <ItemTemplate>
                                    <asp:Label ID="headingTwoLabel" Text='<%# Bind("Heading_Two") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Heading Three">
                                 <ItemTemplate>
                                    <asp:Label ID="headingThreeLabel" Text='<%# Bind("Heading_Three") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>


                             <asp:TemplateField HeaderText="Footer Heading">
                                 <ItemTemplate>
                                    <asp:Label ID="headingFourLabel" Text='<%# Bind("Footer_Heading") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Image Left">
                                 <ItemTemplate>

                                     <asp:Image ID="imageOneLabel" Width="50px" Height="50px"  ImageUrl='<%# Bind("Left_Image") %>' runat="server" />
                                     <asp:HiddenField ID="hfvalue" runat="server" Value='<%# Bind("Report_ID") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>

                         

                             <asp:TemplateField HeaderText="Image Right">
                                 <ItemTemplate>
                                    <asp:Image ID="imageTwoLabel" Width="50px" Height="50px" ImageUrl='<%# Bind("Right_Image") %>' runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                 <asp:TemplateField HeaderText="Delete Record">
                  <ItemTemplate>
                    <asp:LinkButton ID="del" CausesValidation="false" Text="Delete" CommandName='<%# Bind("Report_ID") %>' runat="server" OnClick="deleteHeaderRecord" > </asp:LinkButton>
                </ItemTemplate>
           
                 </asp:TemplateField>
                             <asp:TemplateField HeaderText="Edit">
                  <ItemTemplate>
                    <asp:LinkButton CausesValidation="false" ID="lnkbtnedit" Text="Edit" CommandName='<%# Bind("Report_ID") %>' runat="server" OnClick="lnkbtnedit_Click" > </asp:LinkButton>
                </ItemTemplate>
           
                 </asp:TemplateField>


                        </Columns>
                    </asp:GridView>
                </td>
            </tr>

          

        </table>

    </div>
    <asp:HiddenField ID="hdID" runat="server" />
 </asp:Content>