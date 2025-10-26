<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Admin_Hospital_Ward, App_Web_0xn5azrs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>



 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">



 

<script type="text/JavaScript">

function validation(){
var wardName=document.getElementById("TextBox_WardName").value;
var Beds_Allow=document.getElementById("TextBox_MaxBedAllow").value;
  if (wardName==0)
   {
    alert("Plz Enter Ward Name")
    document.getElementById("TextBox_WardName").focus();
    return false;
    }
       if (Beds_Allow==0)
         {
          alert("Plz Enter Maximum Bed Allow")
          document.getElementById("TextBox_MaxBedAllow").focus();
          return false;
         }
         }
        function ward_Beds()
        {
        var Bed_No=document.getElementById("TextBox_BedNo").value;
        var Location=document.getElementById("TextBox_Location").value;
                 if (Bed_No==0)
          {
           alert("Plz Enter Bed No.")
           document.getElementById("TextBox_BedNo").focus();
           return false;
           }
                if (Location==0)
                {
                 alert("Plz Enter Location")
                 document.getElementById("TextBox_Location").focus();
                 return false;
                }
                  
}
</script>

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                          <!--DWLayoutTable-->
                          <tr>
                            <td align="right" width="25%"     >Hospital :</td>
                            <td align="left" style="width: 229px"  ><asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>                            
                                <asp:DropDownList ID="DropDownList_Hospital" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Hospital"
                                    DataTextField="Hospital_Name" DataValueField="Hospital_ID"  >
                                </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                                    SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
                            </td>
                            <td width="25%" align="right"  ></td>
                            <td width="25%"   ></td>
                          </tr>
                          <tr>
                            <td align="right"  >Department : </td>
                            <td align="left" style="width: 229px"  ><asp:UpdatePanel ID="UpdatePanel1"
                                    runat="server">
                                    <ContentTemplate>
<asp:DropDownList id="DropDownList_Department" runat="server"  DataValueField="Dept_ID" DataTextField="Dept_Name" DataSourceID="SqlDataSource_Department" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_Department_SelectedIndexChanged">                                </asp:DropDownList> 
</ContentTemplate>
                                </asp:UpdatePanel>                            &nbsp;

                              </td>
                            <td  align="right"   >
                                  Wards Name :</td>
                              <td align="left"   >
                              
                              <ul>
                              <li style="display:inline-block;">
                              <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                      <ContentTemplate>
                              <asp:DropDownList ID="DropDownList_WardName" runat="server" 
                                      DataTextField="Ward_Name" DataValueField="Ward_id"   AutoPostBack="True">                              </asp:DropDownList>
                                      </ContentTemplate>
                                  </asp:UpdatePanel>
                                   <asp:SqlDataSource ID="SqlDataSource_Services" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                        SelectCommand="SELECT     S_ID, S_Name + '  ( RS. ' + CONVERT(varchar, S_Amount) + ' )' AS S_Name&#13;&#10;FROM         Admin_Services &#13;&#10;where S_Category=45&#13;&#10;ORDER BY S_Name">
                                    </asp:SqlDataSource>

                              </li><li style="display:inline-block;">                          <asp:DropDownList ID="DropDownList_Service" runat="server" DataSourceID="SqlDataSource_Services"
                                        DataTextField="S_Name" DataValueField="S_ID"  >
                                    </asp:DropDownList></li></td>
                          </tr>
                            <tr>
                                <td align="right"    >
                                 Sub Department :</td>
          <td align="left" style="width: 229px"   >
<asp:UpdatePanel ID="UpdatePanel2" runat="server">
                  <ContentTemplate>
<asp:DropDownList id="DropDownList_SubDepartment" runat="server"   DataValueField="SubDept_Id" DataTextField="SubDept_Name" DataSourceID="SqlDataSource_SubDepartment" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_SubDepartment_SelectedIndexChanged">                                    </asp:DropDownList> 
</ContentTemplate>
              </asp:UpdatePanel>          </td>
                                <td  align="right"    >
                                    Bed No. :</td>
                                <td align="left"  >
                              <asp:TextBox ID="TextBox_BedNo" runat="server"  ></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right"  >
                                 Ward Name :                                </td>
              <td align="left" style="width: 229px" >
                                    <asp:TextBox ID="TextBox_WardName" runat="server"  ></asp:TextBox></td>
                                <td  align="right"   >
                                    Location :                                 </td>
                                <td align="left" >
                              <asp:TextBox ID="TextBox_Location" runat="server"  ></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td  align="right"   >
                                Category :                                </td>
              <td align="left" style="width: 229px"  >
<asp:UpdatePanel ID="UpdatePanel8" runat="server">
                      <ContentTemplate>
<asp:DropDownList id="DropDownList_Category" runat="server"   OnSelectedIndexChanged="DropDownList_Category_SelectedIndexChanged">                                    
                                        <asp:ListItem>Bed</asp:ListItem>
                                        <asp:ListItem>Room</asp:ListItem>
                                    </asp:DropDownList> 
</ContentTemplate>
                  </asp:UpdatePanel>              </td>
                                <td  align="right"   >
                                    
                                        Fee (Rs) :                                 </td>
                              <td align="left"  >
                              <asp:TextBox ID="TextBox_Fee" runat="server"  ></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td height="24" align="right"  >
                                    Maximum Bed Allow :</td>
                      <td align="left" style="width: 229px" >
                                    <asp:TextBox ID="TextBox_MaxBedAllow" runat="server"  ></asp:TextBox></td>
                                <td   align="left" >                                </td>
                                <td align="left" >
                                    

                              <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                <ContentTemplate>
                                  <asp:LinkButton ID="LinkButton_Category" Visible="false"  runat="server" >Add Category</asp:LinkButton>
                                </ContentTemplate>
                              </asp:UpdatePanel></td>
                            </tr>
                            <tr>
                                <td  align="right"  >                                </td>
                                <td align="left" style="width: 229px"  >
                                    <asp:Button ID="Button_Save" runat="server"  Text="Save" OnClientClick="return validation()" /></td>
                                <td  align="left"  >                                </td>
                                <td align="left" >                                
                              <asp:Button ID="Button_SaveWardBeds" runat="server"  Text="Save" OnClientClick="return  ward_Beds()" /></td>
                            </tr>
                            <tr>
                                <td  colspan="5" align="left"  valign="top">
<br />

<div style="width:49%; float:left; clear:right;">
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <asp:GridView ID="GridView_Ward" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                                DataSourceID="SqlDataSourceGrid" Width="100%" DataKeyNames="Ward_id">
                                  <Columns>
                                  <asp:CommandField ShowDeleteButton="True" />
                                  <asp:TemplateField HeaderText="Department" SortExpression="Dept_Name">
                                    <EditItemTemplate>
                                      <asp:DropDownList ID="DropDownList_Department2" runat="server" DataSourceID="SqlDataSource_Department"
                                    DataTextField="Dept_Name" DataValueField="Dept_ID" Width="225px" SelectedValue='<%# Bind("Dept_ID", "{0}") %>'> </asp:DropDownList>
                                      <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                SelectCommand="SELECT [Dept_ID], [Dept_Name] FROM [Department]"></asp:SqlDataSource>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                      <asp:Label ID="Label1" runat="server" Text='<%# Bind("Dept_Name") %>'></asp:Label>
                                    </ItemTemplate>
                                  </asp:TemplateField>
                                  <asp:TemplateField HeaderText="Sub Department" SortExpression="SubDept_Name">
                                    <EditItemTemplate>
                                      <asp:DropDownList ID="DropDownList_SubDepartment2" runat="server" DataSourceID="SqlDataSource_SubDepartment"
                                        DataTextField="SubDept_Name" DataValueField="SubDept_Id" Width="225px" SelectedValue='<%# Bind("SubDept_Id", "{0}") %>'> </asp:DropDownList>
                                      <asp:SqlDataSource ID="SqlDataSource_SubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                SelectCommand="SELECT [SubDept_Id], [SubDept_Name], [Dept_Id] FROM [SubDepartment] WHERE ([Dept_Id] = @Dept_Id)">
                                        <SelectParameters>
                                          <asp:ControlParameter ControlID="DropDownList_Department" Name="Dept_Id" PropertyName="SelectedValue"
                                        Type="Int32" />
                                        </SelectParameters>
                                      </asp:SqlDataSource>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                      <asp:Label ID="Label2" runat="server" Text='<%# Bind("SubDept_Name") %>'></asp:Label>
                                    </ItemTemplate>
                                  </asp:TemplateField>
                                  <asp:BoundField DataField="Ward_Name" HeaderText="Ward Name" SortExpression="Ward_Name" />
                                  <asp:BoundField DataField="Max_Beds" HeaderText="Maximum Beds" SortExpression="Max_Beds" />
                                  <asp:BoundField DataField="Ward_id" HeaderText="Ward_id" InsertVisible="False" ReadOnly="True"
                                         SortExpression="Ward_id" Visible="False" />
                                  </Columns>
                                  <HeaderStyle CssClass="GridHeader2" />                                
                                  <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>                                
                           </div>     
                                
<div style="width:49%; float:left; clear:both;">
<asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                  <ContentTemplate>
                                      <asp:GridView ID="GridView_WardBeds" runat="server" AutoGenerateColumns="False" CssClass="Grid_1"
                                        DataSourceID="SqlDataSource_BedGrid" DataKeyNames="Bed_id" Width="100%">
                            <Columns>
                            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                            <asp:TemplateField HeaderText="Ward Name" SortExpression="Ward_Name">
                              <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList_WardName2" runat="server" DataSourceID="SqlDataSource_WardName"
                                      DataTextField="Ward_Name" DataValueField="Ward_id" Width="109px" SelectedValue='<%# Bind("Ward_id", "{0}") %>'> </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_WardName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                SelectCommand="SELECT [Ward_id], [Ward_Name] FROM [admin_Hospital_Wards]"></asp:SqlDataSource>
                              </EditItemTemplate>
                              <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("Ward_Name") %>'></asp:Label>
                              </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Bed_No" HeaderText="Bed No." SortExpression="Bed_No" />
                            <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location" />
                            <asp:BoundField DataField="Bed_Fee" HeaderText="Bed Fee" SortExpression="Bed_Fee" />
                            </Columns>
                            <HeaderStyle CssClass="GridHeader2" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                          </asp:GridView>
                                  </ContentTemplate>
                                    </asp:UpdatePanel> </div>                         <br />
</td>
                          </tr>
                        </table></div>
<br />
<div align="center"><asp:Button CssClass="btn2"
                          ID="Button_Pt_Services" runat="server" Text="Patient Service" /></div><br />
<asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                <ContentTemplate>
                            <asp:Panel ID="Panel1" runat="server" Visible="False">
                                <table>
                                    <tr>
                                        <td >
                                            Category Name :</td>
                                        <td >
                                            <asp:TextBox ID="TextBox_Category"  runat="server"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td >
                                        </td>
                                        <td >
                                            <asp:Button ID="Button_Category" runat="server"  Text="Save" /></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                                </ContentTemplate>
    </asp:UpdatePanel>
                            <br />                          
                                <asp:SqlDataSource ID="SqlDataSourceCatName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                    InsertCommand="INSERT INTO Ward_Category(Wc_Name) VALUES (@Wc_Name)" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                                    <InsertParameters>
                                        <asp:ControlParameter ControlID="TextBox_Category" Name="Wc_Name" PropertyName="Text" />
                                    </InsertParameters>
                                </asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                SelectCommand="Select_Hospital_Dept" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="DropDownList_Hospital" Name="Hospital_Id" PropertyName="SelectedValue"
            Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>                        
<asp:SqlDataSource ID="SqlDataSource_SubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                SelectCommand="Select_SubDept" SelectCommandType="StoredProcedure">
                          <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_Department" Name="Dept_Id" PropertyName="SelectedValue"
                                        Type="Int32" />
                          </SelectParameters>
    </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource_Category" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                SelectCommand="SELECT [Wc_id], [Wc_Name] FROM [Ward_Category]"></asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDataSource_Save" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                InsertCommand="INSERT INTO admin_Hospital_Wards(Ward_Name, Category, Max_Beds, Dept_Id, SubDept_Id) VALUES (@Ward_Name, @Category, @Max_Beds, @Dept_Id, @SubDept_Id)"
                                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
  <InsertParameters>
    <asp:ControlParameter ControlID="TextBox_WardName" Name="Ward_Name" PropertyName="Text" />
    <asp:ControlParameter ControlID="DropDownList_Category" Name="Category" PropertyName="SelectedValue" />
    <asp:ControlParameter ControlID="TextBox_MaxBedAllow" Name="Max_Beds" PropertyName="Text" />
    <asp:ControlParameter ControlID="DropDownList_Department" Name="Dept_Id" PropertyName="SelectedValue" />
    <asp:ControlParameter ControlID="DropDownList_SubDepartment" Name="SubDept_Id" PropertyName="SelectedValue" />
  </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource_WardName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                SelectCommand="SELECT Ward_id, Ward_Name FROM admin_Hospital_Wards WHERE (Dept_Id = @Dept_Id) AND (SubDept_Id = @SubDept_Id)">
  <SelectParameters>
    <asp:ControlParameter ControlID="DropDownList_Department" Name="Dept_Id" PropertyName="SelectedValue" />
    <asp:ControlParameter ControlID="DropDownList_SubDepartment" Name="SubDept_Id" PropertyName="SelectedValue" />
  </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource_WardBeds" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                InsertCommand="INSERT INTO Ward_Beds(Bed_No, Location, Bed_Fee, ward_Id, Bed_Status, S_ID) VALUES (@Bed_No, @Location, @Bed_Fee, @ward_Id, @Bed_Status, @S_ID)"
                                ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
  <InsertParameters>
    <asp:ControlParameter ControlID="TextBox_BedNo" Name="Bed_No" PropertyName="Text" />
    <asp:ControlParameter ControlID="TextBox_Location" Name="Location" PropertyName="Text" />
    <asp:ControlParameter ControlID="TextBox_Fee" Name="Bed_Fee" PropertyName="Text" />
    <asp:ControlParameter ControlID="DropDownList_WardName" Name="ward_Id" PropertyName="SelectedValue" />
      <asp:Parameter DefaultValue="false" Name="Bed_Status" />
      <asp:ControlParameter ControlID="DropDownList_Service" Name="S_ID" PropertyName="SelectedValue" />
  </InsertParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSourceGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                SelectCommand="SELECT SubDepartment.SubDept_Name, Department.Dept_Name, admin_Hospital_Wards.Ward_Name, admin_Hospital_Wards.Max_Beds, admin_Hospital_Wards.Ward_id, Department.Dept_ID, SubDepartment.SubDept_Id, admin_Hospital_Wards.Dept_Id AS Expr1, admin_Hospital_Wards.SubDept_Id AS Expr2 FROM admin_Hospital_Wards INNER JOIN Department ON admin_Hospital_Wards.Dept_Id = Department.Dept_ID INNER JOIN SubDepartment ON admin_Hospital_Wards.SubDept_Id = SubDepartment.SubDept_Id WHERE (admin_Hospital_Wards.Dept_Id = @Dept_Id) AND (admin_Hospital_Wards.SubDept_Id = @SubDept_Id) ORDER BY admin_Hospital_Wards.Ward_id DESC" UpdateCommand="UPDATE admin_Hospital_Wards SET Ward_Name = @Ward_Name, Category = @Category, Max_Beds = @Max_Beds, Dept_Id = @Dept_Id, SubDept_Id = @SubDept_Id WHERE (Ward_id = @WardID)" DeleteCommand="DELETE FROM admin_Hospital_Wards WHERE (Ward_id = @Ward_id)">
  <UpdateParameters>
    <asp:ControlParameter ControlID="TextBox_WardName" Name="Ward_Name" PropertyName="Text" />
    <asp:ControlParameter ControlID="DropDownList_Category" Name="Category" PropertyName="SelectedValue" />
    <asp:ControlParameter ControlID="TextBox_MaxBedAllow" Name="Max_Beds" PropertyName="Text" />
    <asp:ControlParameter ControlID="DropDownList_Department" Name="Dept_Id" PropertyName="SelectedValue" />
    <asp:ControlParameter ControlID="DropDownList_SubDepartment" Name="SubDept_Id" PropertyName="SelectedValue" />
    <asp:ControlParameter ControlID="GridView_Ward" Name="WardID" PropertyName="SelectedValue" />
  </UpdateParameters>
  <DeleteParameters>
    <asp:ControlParameter ControlID="GridView_Ward" Name="Ward_id" PropertyName="SelectedValue" />
  </DeleteParameters>
  <SelectParameters>
    <asp:ControlParameter ControlID="DropDownList_Department" Name="Dept_Id" PropertyName="SelectedValue" />
    <asp:ControlParameter ControlID="DropDownList_SubDepartment" Name="SubDept_Id" PropertyName="SelectedValue" />
  </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource_BedGrid" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                SelectCommand="SELECT Ward_Beds.Bed_Fee, Ward_Beds.Location, Ward_Beds.Bed_No, admin_Hospital_Wards.Ward_Name, Ward_Beds.Bed_id, admin_Hospital_Wards.Ward_id FROM Ward_Beds INNER JOIN admin_Hospital_Wards ON Ward_Beds.ward_Id = admin_Hospital_Wards.Ward_id WHERE (admin_Hospital_Wards.Ward_id = @Ward_id) ORDER BY Ward_Beds.Bed_id DESC" DeleteCommand="DELETE FROM Ward_Beds WHERE (Bed_id = @Bed_id)" UpdateCommand="UPDATE Ward_Beds SET Bed_No = @Bed_No, Location = @Location, ward_Id = @ward_Id, Bed_Fee = @Bed_Fee WHERE (Bed_id = @Bed_Id)">
  <DeleteParameters>
    <asp:ControlParameter ControlID="GridView_WardBeds" Name="Bed_id" PropertyName="SelectedValue" />
  </DeleteParameters>
  <UpdateParameters>
    <asp:ControlParameter ControlID="TextBox_BedNo" Name="Bed_No" PropertyName="Text" />
    <asp:ControlParameter ControlID="TextBox_Location" Name="Location" PropertyName="Text" />
    <asp:ControlParameter ControlID="DropDownList_WardName" Name="ward_Id" PropertyName="SelectedValue" />
    <asp:ControlParameter ControlID="TextBox_Fee" Name="Bed_Fee" PropertyName="Text" />
    <asp:ControlParameter ControlID="GridView_WardBeds" Name="Bed_Id" PropertyName="SelectedValue" />
  </UpdateParameters>
  <SelectParameters>
    <asp:ControlParameter ControlID="DropDownList_WardName" Name="Ward_id" PropertyName="SelectedValue" />
  </SelectParameters>
</asp:SqlDataSource>
<asp:HiddenField ID="HiddenField_Department" runat="server" />
<asp:HiddenField ID="HiddenField_SubDept" runat="server" />
<asp:HiddenField ID="HiddenField_Category" runat="server" />
<asp:HiddenField ID="HiddenField_WardName" runat="server" />
<asp:HiddenField ID="HiddenField_Beds" runat="server" />
<br />
<br />

  </asp:Content>