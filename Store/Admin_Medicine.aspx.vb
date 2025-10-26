Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Partial Class Administrator_Admin_Item
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            HiddenField_Drug_Category_Item.Value = DropDownList_Category.SelectedItem.Text

            If (CheckBox1.Checked) Then
                HF_Allow_Serial.Value = "True"
            Else
                HF_Allow_Serial.Value = "false"

            End If
            SqlDataSourceSaveInfo.Insert()
            GridViewElementValues.DataBind()
            ShowMessage("Record saved successfully.", False)
        Catch ex As Exception
            'If ex.Message = "Cannot insert duplicate key row in object 'dbo.Store_Items' with unique index 'IX_Store_Items'. The statement has been terminated." Then
            ShowMessage("Cannot Insert Duplicate Record", True)
            'Else
            'ShowMessage(ex.Message, True)
            'End If

        End Try
    End Sub

    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("~/login.aspx")

            End If
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try

            loginvalidate(Session("emp_id"), Session("dept_id"))
            Label_message.Text = ""
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
    End Sub

    Protected Sub DropDownList_General_Category_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_General_Category.PreRender
        If Not Page.IsPostBack Then
            'DropDownList_General_Category.Items.Insert(0, New ListItem("", ""))
            'DropDownList_General_Category.SelectedIndex = 2
        End If
    End Sub

    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        GridViewElementValues.DataBind()
    End Sub

    Protected Sub LinkButton_Unit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Unit.Click

        medUnit.Visible = True



    End Sub

    Protected Sub LinkButtonCategor_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonCategor.Click

        ItemCatagory.visible = True
    End Sub

    Protected Sub GridViewElementValues_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridViewElementValues.RowEditing

    End Sub

    Protected Sub GridViewElementValues_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridViewElementValues.RowUpdating

        Try
            Dim HiddenField_Expiry As HiddenField = (GridViewElementValues.Rows(e.RowIndex).FindControl("Checkbox_Edit_Expiry"))
            HiddenField_Expiry.Value = HiddenField_Expiry.Value
        Catch ex As Exception

        End Try


        Try
            Dim drop_cat As DropDownList = GridViewElementValues.Rows(e.RowIndex).FindControl("DropDownList_Cat")
            Dim drop_unit As DropDownList = GridViewElementValues.Rows(e.RowIndex).FindControl("DropDownList_Unit")
            'Dim drop_Drug_Cat As DropDownList = GridViewElementValues.Rows(e.RowIndex).FindControl("DropDownListCat")
            Dim DropDownList_Category_Grid As DropDownList = GridViewElementValues.Rows(e.RowIndex).FindControl("DropDownList_Category_Grid")
            HiddenFieldCategory.Value = drop_cat.SelectedValue
            HiddenField_Unit.Value = drop_unit.SelectedValue
            'HiddenFieldDrugCategory.Value = drop_Drug_Cat.SelectedValue
            HiddenFieldItem_code.Value = GridViewElementValues.Rows(e.RowIndex).Cells(1).Text
            HiddenFieldItem_Name.Value = GridViewElementValues.Rows(e.RowIndex).Cells(3).Text
            HiddenField_Potency.Value = GridViewElementValues.Rows(e.RowIndex).Cells(4).Text
            HiddenField_Manufacturer.Value = GridViewElementValues.Rows(e.RowIndex).Cells(7).Text
            HiddenField_Drug_Category.Value = DropDownList_Category_Grid.SelectedValue

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub



    Protected Sub LinkButton_Category_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Category.Click

        ItemType.visible = True


    End Sub

    Protected Sub GridViewElementValues_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub LinkButton_GName_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_GName.Click
        HiddenFieldItemCatagory.Value = DropDownList_Category.SelectedValue


        GenericName.Visible = True
    End Sub

    Protected Sub Button_Generic_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Generic.Click
        'SqlDataSourceForGrid.Insert()
        SqlDataSource_GenericName.Insert()
        DropDownList_Generic_ItemName.DataBind()

        GridView_GenericName.DataBind()
    End Sub

    Protected Sub Button_SearchGeneric_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_SearchGeneric.Click
        If TextBox_Generic_Name.Text = "" Then
            HiddenField_item_GenericName.Value = "%"
        Else
            HiddenField_item_GenericName.Value = TextBox_Generic_Name.Text + "%"
        End If
        GridView_GenericName.DataBind()
    End Sub

    Protected Sub Button_SaveUnit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_SaveUnit.Click


        SqlDataSource_Unit.Insert()

        GridView_Unit.DataBind()
    End Sub

    Protected Sub Button_SearchUnit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_SearchUnit.Click
        If TextBox_Unit.Text = "" Then
            HiddenField_ItemUnit.Value = "%"
        Else
            HiddenField_ItemUnit.Value = TextBox_Unit.Text + "%"
        End If

        GridView_Unit.DataBind()
    End Sub

    Protected Sub ButtonSearchItemCategory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSearchItemCategory.Click
        SqlDataSourceForMedCat.SelectParameters("").DefaultValue = TextBox_Item_Category.Text
        GridView_Category.DataBind()
    End Sub

    Protected Sub Button_SaveItemCategory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_SaveItemCategory.Click
        Try
            SqlDataSourceSaveMedCat.Insert()
            GridView_Category.DataBind()
            DropDownList_General_Category.DataBind()
            DropDownList_Category.DataBind()
            GridView_Category.Visible = True

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub Button_SearchMedType_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_SearchMedType.Click
        If TextBox_ItemType.Text = "" Then
            HiddenField_itemType.Value = "%"
        Else
            HiddenField_itemType.Value = TextBox_ItemType.Text + "%"
        End If
    End Sub

    Protected Sub Button_SaveMedType_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_SaveMedType.Click
        SqlDataSourceForItemTypeGrid.Insert()
        GridView_ItemType.DataBind()
    End Sub

    Protected Sub btn_cls_gname_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_cls_gname.Click
        GenericName.Visible = False
    End Sub

    Protected Sub btn_cls_medcat_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_cls_medcat.Click
        ItemCatagory.Visible = False
    End Sub

    Protected Sub btn_cls_medtype_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_cls_medtype.Click
        ItemType.Visible = False
    End Sub

    Protected Sub btn_cls_unit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_cls_unit.Click
        medUnit.Visible = False
    End Sub

    Protected Sub GridViewElementValues_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridViewElementValues.RowCommand
        If e.CommandName = "ChangeCode" Then
            Dim HiddenField_IC As HiddenField = GridViewElementValues.Rows(e.CommandArgument).FindControl("HiddenField_IC")
            'Response.Write(HiddenField_IC.Value)
            'Response.Redirect("Change_Item_Code.aspx?Item_Code=" + HiddenField_IC.Value)
            'Set_Control_For_Update(HiddenField_IC.Value)
            Set_Control_For_Update(GridViewElementValues.DataKeys(e.CommandArgument).Value)
        End If
    End Sub
    Protected Sub Set_Control_For_Update(ByVal Item_Code As String)
        Dim qry As String = "SELECT Item_Code, Item_Name, isnull(Unit,'') As Unit, isnull(Potency,'') as Potency, isnull(Category,1) as Category, Item_Type_Id, G_N_Id, isnull(Manufacturer,'') as Manufacturer, isnull(Expiry_Item,0) as Expiry_Item,IsNull(Allow_Serial,0) Allow_Serial,IsNull(Part_No,'') Part_No,Item_Description,Isnull(ReOrder,'') ReOrder ,isnull(MinLevel,'') MinLevel,isnull(MaxLevel,'') MaxLevel FROM Store_Items where (Item_Code = @Item_Code)"
        Dim con As New SqlConnection(constr)
        Dim cmd As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("@Item_Code", Item_Code)
        con.Open()
        Dim reader As SqlDataReader = cmd.ExecuteReader
        While reader.Read


            TextBox_ItemCode.Text = reader.Item("Item_Code").ToString()
            TextBox_Item.Text = reader.Item("Item_Name")
            DropDownListUnit.DataBind()
            DropDownListUnit.SelectedItem.Text = reader.Item("Unit")
            'TextBoxPotency.Text = reader.Item("Potency")
            DropDownList_General_Category.DataBind()
            DropDownList_General_Category.SelectedValue = reader.Item("Category")
            DropDownList_Category.DataBind()
            DropDownList_Category.SelectedValue = reader.Item("Item_Type_Id")
            DropDownList_Generic_ItemName.DataBind()
            DropDownList_Generic_ItemName.SelectedValue = reader.Item("G_N_Id")
            ddlManufacturer.DataBind()
            ddlManufacturer.SelectedValue = reader.Item("Manufacturer")
            RadioButtonList_Expiry.DataBind()
            RadioButtonList_Expiry.SelectedValue = reader.Item("Expiry_Item")
            CheckBox1.Checked = Boolean.Parse(reader.Item("Allow_Serial").ToString())
            txtPartNumber.Text = reader.Item("Part_No").ToString()
            txt_Description.Text = reader.Item("Item_Description").ToString()
            txtmin.Text = reader.Item("MinLevel").ToString()
            txtMax.Text = reader.Item("MaxLevel").ToString()
            txtReorder.Text = reader.Item("ReOrder").ToString()

            ButtonSave.Visible = False
            Button_update.Visible = True
            Button_Cancel.Visible = True
            'DropDownList_Category.Enabled = False
            'DropDownList_Generic_ItemName.Enabled = False
            'DropDownList_General_Category.Enabled = False
        End While
        con.Close()

    End Sub

    Protected Sub Button_Cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Cancel.Click
        Reset()
        ButtonSave.Visible = True
        Button_update.Visible = False
        Button_Cancel.Visible = False
    End Sub
    Protected Sub Reset()
        TextBox_ItemCode.Text = String.Empty
        TextBox_Item.Text = String.Empty
        TextBoxPotency.Text = String.Empty
        ddlManufacturer.DataBind()
        CheckBox1.Checked = False
        txtPartNumber.Text = String.Empty
        GridViewElementValues.DataBind()
        DropDownList_Category.Enabled = True
        DropDownList_Generic_ItemName.Enabled = True
        DropDownList_General_Category.Enabled = True
    End Sub

   
    Protected Sub DropDownList_Category_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        DropDownList_Generic_ItemName.DataBind()
    End Sub

    Protected Sub GridView_Category_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Category.SelectedIndexChanged

    End Sub

    Protected Sub DropDownList_Category_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Category.SelectedIndexChanged
        DropDownList_Generic_ItemName.DataBind()

    End Sub

    Protected Sub TextBox_Item_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Item.TextChanged
        TextBox_ItemCode.Enabled = True

    End Sub

 
    Protected Sub Button_update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_update.Click

        Try
            SqlDataSourceForGrid.UpdateParameters("ItemCode").DefaultValue = TextBox_ItemCode.Text.Trim()
            SqlDataSourceForGrid.UpdateParameters("ItemName").DefaultValue = TextBox_Item.Text.Trim()
            SqlDataSourceForGrid.UpdateParameters("Manufacturer").DefaultValue = ddlManufacturer.SelectedValue
            SqlDataSourceForGrid.UpdateParameters("Is_Serial").DefaultValue = CheckBox1.Checked.ToString()
            SqlDataSourceForGrid.UpdateParameters("Is_Expiry").DefaultValue = RadioButtonList_Expiry.SelectedValue
            SqlDataSourceForGrid.UpdateParameters("Part_No").DefaultValue = txtPartNumber.Text.Trim()
            SqlDataSourceForGrid.UpdateParameters("Long_Description").DefaultValue = txt_Description.Text.Trim()
            SqlDataSourceForGrid.Update()
            'SqlDataSourceSaveInfo.Insert()
            GridViewElementValues.DataBind()
            ShowMessage("Record saved successfully.", False)
        Catch ex As Exception
            ShowMessage(ex.Message, True)
            'Response.Write(ex.Message)
        End Try

        Reset()

        ButtonSave.Visible = True
        Button_update.Visible = False
        Button_Cancel.Visible = False
    End Sub

    Private Sub ShowMessage(ByVal msg As String, ByVal isError As Boolean)
        lblMessage.Text = msg

        If isError Then
            pnlMsg.CssClass = "errorMessage"
            pnlMsg.ForeColor = Drawing.Color.Red

        Else
            pnlMsg.CssClass = "successMessage"
        End If
    End Sub

    Protected Sub lnkAddManufacturer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAddManufacturer.Click

        Dim url As String = "Add_Manufacturer.aspx"
        Dim sb As New StringBuilder()
        sb.Append("<script type = 'text/javascript'>")
        sb.Append("window.open('")
        sb.Append(url)
        sb.Append("');")
        sb.Append("</script>")
        ClientScript.RegisterStartupScript(Me.GetType(), _
                  "script", sb.ToString())

        ' Response.Redirect("~/Store/Add_Manufacturer.aspx")
    End Sub
    Protected Sub lnkUnit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkUnit.Click

        Dim url As String = "Add_Unit.aspx"
        Dim sb As New StringBuilder()
        sb.Append("<script type = 'text/javascript'>")
        sb.Append("window.open('")
        sb.Append(url)
        sb.Append("');")
        sb.Append("</script>")
        ClientScript.RegisterStartupScript(Me.GetType(), _
                  "script", sb.ToString())

        ' Response.Redirect("~/Store/Add_Manufacturer.aspx")
    End Sub
End Class
