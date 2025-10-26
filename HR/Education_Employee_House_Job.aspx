<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_Education_Employee_House_Job, App_Web_ah1wcbj4" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<style type="text/css">
 

.myeducation {border:#CCCCCC solid 1px; font-family:tahoma; font-size:11px; border-collapse:collapse; }

.myeducation th{ font-weight:bold; height:30px;}

.myeducation tr{ border:#CCCCCC solid 1px; font-family:tahoma; font-size:11px; border-collapse:collapse; height:25px;  }

.myeducation td{ border:#CCCCCC solid 1px; font-family:tahoma; font-size:11px; border-collapse:collapse; padding-left:3px; }

.textbox_1{ border:none; background-color:none;}


</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <br />
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>

  
  
  
  
  
  
  
            <table width="100%" border="0" class="myeducation">
              <tr>
                <td height="27" colspan="2" bgcolor="#CAD9F0"><strong>Degree/Certificate</strong></td>
                <td bgcolor="#CAD9F0" style="width: 210px"><strong>Institution</strong></td>
                <td bgcolor="#CAD9F0" style="width: 46px"><strong>Date</strong></td>
                <td bgcolor="#CAD9F0" style="width: 198px"><strong>Marks</strong></td>
                <td width="9%" bgcolor="#CAD9F0"><strong>%age</strong></td>
                <td width="15%" bgcolor="#CAD9F0"><strong>No. of Attempts</strong></td>
              </tr>
              <tr>
                <td colspan="2">1. Secondary School Certificate</td>
                <td style="width: 210px">
                    <asp:TextBox ID="TextBox_sec_Institution" runat="server" CssClass="textbox_1" Width="200px"></asp:TextBox></td>
                <td style="width: 46px">
                    <asp:TextBox ID="TextBox_sec_date" runat="server" CssClass="textbox_1" Width="49px"></asp:TextBox></td>
                <td style="width: 198px">
                    <asp:TextBox ID="TextBox_sec_obt_marks" runat="server" CssClass="textbox_1" Width="30px"></asp:TextBox>
                    /
                    <asp:TextBox ID="TextBox_total_sec" runat="server" CssClass="textbox_1" Width="40px"></asp:TextBox></td>
                <td>
                    <asp:TextBox ID="TextBox_sec_age" runat="server" CssClass="textbox_1" Width="49px"></asp:TextBox></td>
                <td>
                    <asp:DropDownList ID="DropDownList_att_sec" runat="server" Width="91px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                    </asp:DropDownList></td>
              </tr>
              <tr>
                <td colspan="2">2. Higher Secondary Certificate</td>
                <td style="width: 210px">
                    <asp:TextBox ID="TextBox_High_Institution" runat="server" CssClass="textbox_1" Width="200px"></asp:TextBox></td>
                <td style="width: 46px">
                    <asp:TextBox ID="TextBox_high_date" runat="server" CssClass="textbox_1" Width="49px"></asp:TextBox></td>
                <td style="width: 198px">
                    <asp:TextBox ID="TextBox_high_obt_" runat="server" CssClass="textbox_1" Width="30px"></asp:TextBox>
                    /
                    <asp:TextBox ID="TextBox_total_high" runat="server" CssClass="textbox_1" Width="40px"></asp:TextBox></td>
                <td>
                    <asp:TextBox ID="TextBox_high_age" runat="server" CssClass="textbox_1" Width="49px"></asp:TextBox></td>
                <td>
                    <asp:DropDownList ID="DropDownList_att_high" runat="server" Width="91px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                    </asp:DropDownList></td>
              </tr>
              <tr>
                <td width="10%" style="height: 25px">3. MBBS</td>
                <td width="14%" style="height: 25px">1st Prof.</td>
                <td style="width: 210px; height: 25px">
                    <asp:TextBox ID="TextBox_mbbs_1_institution" runat="server" AutoPostBack="True" CssClass="textbox_1"
                        Width="200px"></asp:TextBox></td>
                <td style="width: 46px; height: 25px">
                    <asp:TextBox ID="TextBox_mbbs_1_date" runat="server" CssClass="textbox_1" Width="49px"></asp:TextBox></td>
                <td style="width: 198px; height: 25px">
                    <asp:TextBox ID="TextBox_obt_mbbs_1" runat="server" CssClass="textbox_1" Width="30px"></asp:TextBox>
                    /
                    <asp:TextBox ID="TextBox_total_mbbs_1" runat="server" CssClass="textbox_1" Width="40px"></asp:TextBox></td>
                <td style="height: 25px">
                    <asp:TextBox ID="TextBox_mbbs_age_1" runat="server" CssClass="textbox_1" Width="49px"></asp:TextBox></td>
                <td style="height: 25px">
                    <asp:DropDownList ID="DropDownList_att_mbbs_1" runat="server" Width="91px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                    </asp:DropDownList></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>
                    2nd Prof.</td>
                <td style="width: 210px">
                    <asp:TextBox ID="TextBox_mbbs_2_institution" runat="server" CssClass="textbox_1"
                        Width="200px"></asp:TextBox></td>
                <td style="width: 46px">
                    <asp:TextBox ID="TextBox_mbbs_2_date" runat="server" CssClass="textbox_1" Width="49px"></asp:TextBox></td>
                <td style="width: 198px">
                    <asp:TextBox ID="TextBox_obt_mbbs_2" runat="server" CssClass="textbox_1" Width="30px"></asp:TextBox>
                    /
                    <asp:TextBox ID="TextBox_total_mbbs_2" runat="server" CssClass="textbox_1" Width="40px"></asp:TextBox></td>
                <td>
                    <asp:TextBox ID="TextBox_mbbs_age_2" runat="server" CssClass="textbox_1" Width="49px"></asp:TextBox></td>
                <td>
                    <asp:DropDownList ID="DropDownList_att_mbbs_2" runat="server" Width="91px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                    </asp:DropDownList></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>
                    3rd Prof.</td>
                <td style="width: 210px">
                    <asp:TextBox ID="TextBox_mbbs_3_institution" runat="server" CssClass="textbox_1"
                        Width="200px"></asp:TextBox></td>
                <td style="width: 46px">
                    <asp:TextBox ID="TextBox_mbbs_3_date" runat="server" CssClass="textbox_1" Width="49px"></asp:TextBox></td>
                <td style="width: 198px">
                    <asp:TextBox ID="TextBox_obt_mbbs_3" runat="server" CssClass="textbox_1" Width="30px"></asp:TextBox>
                    /
                    <asp:TextBox ID="TextBox_total_mbbs_3" runat="server" CssClass="textbox_1" Width="40px"></asp:TextBox></td>
                <td>
                    <asp:TextBox ID="TextBox_mbbs_age_3" runat="server" CssClass="textbox_1" Width="49px"></asp:TextBox></td>
                <td>
                    <asp:DropDownList ID="DropDownList_att_mbbs_3" runat="server" Width="91px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                    </asp:DropDownList></td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>
                    4th Prof.</td>
                <td style="width: 210px">
                    <asp:TextBox ID="TextBox_mbbs_4_institution" runat="server" CssClass="textbox_1"
                        Width="200px"></asp:TextBox></td>
                <td style="width: 46px">
                    <asp:TextBox ID="TextBox_mbbs_4_date" runat="server" CssClass="textbox_1" Width="49px"></asp:TextBox></td>
                <td style="width: 198px">
                    <asp:TextBox ID="TextBox_obt_mbbs_4" runat="server" CssClass="textbox_1" Width="30px"></asp:TextBox>
                    /
                    <asp:TextBox ID="TextBox_total_mbbs_4" runat="server" CssClass="textbox_1" Width="40px"></asp:TextBox></td>
                <td>
                    <asp:TextBox ID="TextBox_mbbs_age_4" runat="server" CssClass="textbox_1" Width="49px"></asp:TextBox></td>
                <td>
                    <asp:DropDownList ID="DropDownList_att_mbbs_4" runat="server" Width="91px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                    </asp:DropDownList></td>
              </tr>
            </table>
                        <asp:Label ID="Label1" runat="server" Width="733px"></asp:Label><br />
                        <asp:SqlDataSource ID="SqlDataSource_insert_Education" runat="server" ConnectionString="<%$ ConnectionStrings:job ApplicationConnectionString %>"
                    InsertCommand="insert_Education" InsertCommandType="StoredProcedure" SelectCommand="SELECT Employee_ID, Degree, Recognized_Institute, To_Date, number, total, Percentage, No_of_Attempts, Degree_Program_ID FROM Education WHERE (Employee_ID = @Employee_ID)" UpdateCommand="UPDATE Education SET  Degree =@Degree, Recognized_Institute =@Recognized_Institute, To_Date =@To_Date, number =@number, total =@total, Percentage =@Percentage, No_of_Attempts =@No_of_Attempts&#13;&#10;where Employee_ID =@Employee_ID and Degree_Program_ID =@Degree_Program_ID">
                    <SelectParameters>
                        <asp:SessionParameter Name="Employee_ID" SessionField="Enter_Emp_ID" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="Employee_ID" SessionField="enter_emp_ID" Type="Int32" />
                        <asp:Parameter DefaultValue="Secondary School Certificate" Name="Degree" Type="String" />
                        <asp:ControlParameter ControlID="TextBox_sec_date" Name="To_Date" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_sec_obt_marks" Name="number" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_total_sec" Name="total" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_sec_age" Name="Percentage" PropertyName="Text"
                            Type="String" />
                        <asp:ControlParameter ControlID="DropDownList_att_sec" Name="No_of_Attempts" PropertyName="SelectedValue"
                            Type="Int32" />
                        <asp:Parameter DefaultValue="Higher Secondary Certificate" Name="Degree1" Type="String" />
                        <asp:ControlParameter ControlID="TextBox_high_date" Name="To_Date1" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_high_obt_" Name="number1" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_total_high" Name="total1" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_high_age" Name="Percentage1" PropertyName="Text"
                            Type="String" />
                        <asp:ControlParameter ControlID="DropDownList_att_high" Name="No_of_Attempts1" PropertyName="SelectedValue"
                            Type="Int32" />
                        <asp:Parameter DefaultValue="MBBS 1st Prof." Name="Degree2" Type="String" />
                        <asp:ControlParameter ControlID="TextBox_mbbs_1_date" Name="To_Date2" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_obt_mbbs_1" Name="number2" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_total_mbbs_1" Name="total2" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_mbbs_age_1" Name="Percentage2" PropertyName="Text"
                            Type="String" />
                        <asp:ControlParameter ControlID="DropDownList_att_mbbs_1" Name="No_of_Attempts2"
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter DefaultValue="MBBS 2nd Prof." Name="Degree3" Type="String" />
                        <asp:ControlParameter ControlID="TextBox_mbbs_2_date" Name="To_Date3" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_obt_mbbs_2" Name="number3" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_total_mbbs_2" Name="total3" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_mbbs_age_2" Name="Percentage3" PropertyName="Text"
                            Type="String" />
                        <asp:ControlParameter ControlID="DropDownList_att_mbbs_2" Name="No_of_Attempts3"
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter DefaultValue="MBBS 3rd Prof." Name="Degree4" Type="String" />
                        <asp:ControlParameter ControlID="TextBox_mbbs_3_date" Name="To_Date4" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_obt_mbbs_3" Name="number4" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_total_mbbs_3" Name="total4" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_mbbs_age_3" Name="Percentage4" PropertyName="Text"
                            Type="String" />
                        <asp:ControlParameter ControlID="DropDownList_att_mbbs_3" Name="No_of_Attempts4"
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter DefaultValue="MBBS 4th Prof." Name="Degree5" Type="String" />
                        <asp:ControlParameter ControlID="TextBox_mbbs_4_date" Name="To_Date5" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_obt_mbbs_4" Name="number5" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_total_mbbs_4" Name="total5" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_mbbs_age_4" Name="Percentage5" PropertyName="Text"
                            Type="String" />
                        <asp:ControlParameter ControlID="DropDownList_att_mbbs_4" Name="No_of_Attempts5"
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="TextBox_sec_Institution" Name="Recognized_Institute"
                            PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="TextBox_High_Institution" Name="Recognized_Institute1"
                            PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="TextBox_mbbs_1_institution" Name="Recognized_Institute2"
                            PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="TextBox_mbbs_2_institution" Name="Recognized_Institut3"
                            PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="TextBox_mbbs_3_institution" Name="Recognized_Institute4"
                            PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="TextBox_mbbs_4_institution" Name="Recognized_Institute5"
                            PropertyName="Text" Type="String" />
                        <asp:Parameter DefaultValue="1" Name="Degree_Program_ID" Type="Int32" />
                        <asp:Parameter DefaultValue="2" Name="Degree_Program_ID1" Type="Int32" />
                        <asp:Parameter DefaultValue="5" Name="Degree_Program_ID2" Type="Int32" />
                        <asp:Parameter DefaultValue="6" Name="Degree_Program_ID3" Type="Int32" />
                        <asp:Parameter DefaultValue="7" Name="Degree_Program_ID4" Type="Int32" />
                        <asp:Parameter DefaultValue="8" Name="Degree_Program_ID5" Type="Int32" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Degree" />
                        <asp:Parameter Name="Recognized_Institute" />
                        <asp:Parameter Name="To_Date" />
                        <asp:Parameter Name="number" />
                        <asp:Parameter Name="total" />
                        <asp:Parameter Name="Percentage" />
                        <asp:Parameter Name="No_of_Attempts" />
                        <asp:Parameter Name="Employee_ID" />
                        <asp:Parameter Name="Degree_Program_ID" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                
                <br />
                <div align="center"><asp:Button ID="Button_Save" runat="server" CssClass="btn1" Text="Save" /></div><br />
                <br />
                <asp:SqlDataSource ID="SqlDataSource_Medical_Colleges" runat="server"></asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                    DataSourceID="SqlDataSource_insert_Education" Width="98%" DataKeyNames="Employee_ID,Degree_Program_ID">
                    <Columns>
                        <asp:BoundField DataField="Degree" HeaderText="Degree" SortExpression="Degree" >
                            <ControlStyle Width="125px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Recognized_Institute" HeaderText="Recognized Institute"
                            SortExpression="Recognized_Institute" >
                            <ControlStyle Width="125px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="To_Date" HeaderText="Date" SortExpression="To_Date" >
                            <ControlStyle Width="50px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="number" HeaderText="Number" SortExpression="number" >
                            <ControlStyle Width="50px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="total" HeaderText="Total" SortExpression="total" >
                            <ControlStyle Width="50px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Percentage" HeaderText="%age" SortExpression="Percentage" >
                            <ControlStyle Width="40px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="No_of_Attempts" HeaderText="Attempts" SortExpression="No_of_Attempts" >
                            <ControlStyle Width="40px" />
                        </asp:BoundField>
                        <asp:CommandField ShowEditButton="True" />
                    </Columns>
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                  <br />

  </asp:Content>