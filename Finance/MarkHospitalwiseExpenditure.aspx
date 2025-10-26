<%@ page language="C#" autoeventwireup="true" inherits="MarkHospitalwiseExpenditure" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="MarkHospitalwiseExpenditure.aspx.cs" %>

 
 

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

 

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div  >
    
 <div class="bxmain inner_content" style="width:100%;">
<h2><span>Set Hospital wise Expenditure</span></h2>


                                <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
                                    <tr>
                                        <td align="right" width="40%" >
                                            Level 1 Name :</td>
                                      <td width="60%">
                                          <asp:DropDownList ID="DropDownList_level1" runat="server" AutoPostBack="True" Width="212px" DataSourceID="SqlDataSource_Main_Level"
                                              DataTextField="EM_Name" DataValueField="EM_Code" OnSelectedIndexChanged="DropDownList_level1_SelectedIndexChanged"
                                                OnDataBinding="DropDownList_level1_DataBinding" OnDataBound="DropDownList_level1_DataBound">
                                          </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td align="right" >
                                            Level 2 Name :</td>
                                      <td >
                                        <asp:DropDownList ID="DropDownList_Sub_EH_Name" runat="server" AutoPostBack="True"  Width="212px" 
                                                DataSourceID="SqlDataSource_EH" DataTextField="EH_Name" DataValueField="EH_Code" OnSelectedIndexChanged="DropDownList_Sub_EH_Name_SelectedIndexChanged" OnDataBinding="DropDownList_Sub_EH_Name_DataBinding" OnDataBound="DropDownList_Sub_EH_Name_DataBound"
                                                >
                                      </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td align="right" >
                                            Level 3 Name :</td>
                                      <td >
                                        <asp:DropDownList ID="DropDownList_Sub_ESH_name" runat="server" Width="212px" DataSourceID="SqlDataSource_sub_ESH"
                                                DataTextField="ESH_Name" DataValueField="ESH_Code"  AutoPostBack="True"   OnSelectedIndexChanged="DropDownList_Sub_ESH_name_SelectedIndexChanged" OnDataBinding="DropDownList_Sub_ESH_name_DataBinding" OnDataBound="DropDownList_Sub_ESH_name_DataBound">
                                      </asp:DropDownList>
                                          

                                      </td>
                                    </tr>

                                        <tr>
                                        <td align="right" >
                                           Hospital :</td>
                                      <td >
                                        <asp:DropDownList ID="ddl_Hospital" runat="server" Width="212px" DataSourceID="SqlDataSource_Hospital"
                                                DataTextField="Hospital_Name" DataValueField="Hospital_ID" >
                                      </asp:DropDownList>
                                              <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    SelectCommand="select Hospital_ID, Hospital_Name from Hospital">
                                    
                                </asp:SqlDataSource>


                                      </td>
                                    </tr>





                                 <%--   <tr>
                                        <td align="right" >
                                            Level 4 Code :</td>
                                      <td >
                                      <asp:TextBox ID="TextBox_E_Code" runat="server"  Width="211px" ></asp:TextBox>
                                          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox_E_Code"
                                              Display="Dynamic" ErrorMessage="Enter Level 4 Code"></asp:RequiredFieldValidator></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Level 4 Old Code :</td>
                                        <td>
                                            <asp:TextBox ID="TextBox_old_Code" runat="server" Width="211px" ></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            Level 4 Name :</td>
                                        <td>
                                      <asp:TextBox ID="TextBox_E_Name" runat="server"  Width="211px" ></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox_E_Name"
                                                Display="Dynamic" ErrorMessage="Enter Level 4 Name"></asp:RequiredFieldValidator></td>
                                    </tr>--%>
                                    <tr>
                                      <td align="center" colspan="2">
                                      <asp:Button ID="Button3" runat="server"  OnClick="btnExpenditure_Click" Text="Mark Expenditure"  />
                                         
                                       <asp:Label ID="lblMsg" runat="server" Font-Bold="true" Visible="false"></asp:Label>
                                      </td>
                                    </tr>
    </table>
             </div>                   <br />
                              
    <asp:SqlDataSource ID="SqlDataSource_Main_Level" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
        SelectCommand="SELECT [EM_Code], [EM_Name] FROM [Expenditure_Main]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_EH" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
        DeleteCommand="DELETE FROM [Expenditure_Heading] WHERE [EH_Code] = @EH_Code"
        InsertCommand="INSERT INTO Expenditure_Heading(EH_Code, EH_Name, EM_Code) VALUES (@EH_Code, @EH_Name, @EM_Code)"
        SelectCommand="SELECT EH_Code, EH_Name FROM Expenditure_Heading WHERE (EM_Code = @EM_Code)"
        UpdateCommand="UPDATE [Expenditure_Heading] SET [EH_Name] = @EH_Name WHERE [EH_Code] = @EH_Code">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_level1" Name="EM_Code" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="EH_Code" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="EH_Name" Type="String" />
            <asp:Parameter Name="EH_Code" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_EH_Code" Name="EH_Code" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_EH_Name" Name="EH_Name" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList_level1" Name="EM_Code" PropertyName="SelectedValue" />
        </InsertParameters>
    </asp:SqlDataSource>
   

                                <asp:SqlDataSource ID="SqlDataSource_sub_ESH" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    SelectCommand="SELECT [ESH_Code], [ESH_Name], [EH_Code] FROM [Expenditure_Sub_Heading] WHERE ([EH_Code] = @EH_Code)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_Sub_EH_Name" Name="EH_Code" PropertyName="SelectedValue"
                                            Type="String" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
    
                             
                                <asp:SqlDataSource ID="SqlDataSource_expenditure" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                    SelectCommand="SELECT E_Code, E_Name, ESH_Code, E_Old_Code FROM Expenditure WHERE (ESH_Code = @ESH_Code)" DeleteCommand="DELETE FROM [Expenditure] WHERE [E_Code] = @E_Code" InsertCommand="INSERT INTO Expenditure(E_Code, E_Name, ESH_Code, E_Old_Code) VALUES (@E_Code, @E_Name, @ESH_Code, @E_Old_Code)" UpdateCommand="UPDATE [Expenditure] SET [E_Name] = @E_Name  WHERE [E_Code] = @E_Code">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownList_Sub_ESH_name" Name="ESH_Code" PropertyName="SelectedValue"
                                            Type="String" />
                                    </SelectParameters>
                                    <DeleteParameters>
                                        <asp:Parameter Name="E_Code" Type="String" />
                                    </DeleteParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="E_Name" Type="String" />
                                        <asp:Parameter Name="E_Code" Type="String" />
                                    </UpdateParameters>
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="TextBox_E_Code" Name="E_Code" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="TextBox_E_Name" Name="E_Name" PropertyName="Text"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="DropDownList_Sub_ESH_name" Name="ESH_Code" PropertyName="SelectedValue"
                                            Type="String" />
                                        <asp:ControlParameter ControlID="TextBox_old_Code" Name="E_Old_Code" PropertyName="Text" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                        DataKeyNames="E_Code" DataSourceID="SqlDataSource_expenditure" Width="100%">
                                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                    <Columns>
                                        <asp:BoundField DataField="E_Code" HeaderText="Level 4 Code" ReadOnly="True" SortExpression="E_Code" />
                                        <asp:BoundField DataField="E_Old_Code" HeaderText="Level 4 Old Code" SortExpression="E_Old_Code" />
                                        <asp:BoundField DataField="E_Name" HeaderText="Level 4 Name" SortExpression="E_Name" />



                                        <asp:TemplateField ShowHeader="False" Visible="False">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                                    OnClientClick="return confirm('are you sure you want To delete ?');" Text="Delete"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                          <asp:TemplateField HeaderText="Mark">
                      <ItemTemplate>
                           <asp:HiddenField ID="hf_Ecode" runat="server" Value='<%# Eval("E_Code") %>' />
                          <asp:CheckBox ID="chkbox"  runat="server" />                          
                      </ItemTemplate>

                  </asp:TemplateField>



                                    </Columns>
                                    <RowStyle CssClass="GridItem" />
                                    <HeaderStyle CssClass="GridHeader" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView><br />

   

    <br />

   



</div>



</asp:Content>