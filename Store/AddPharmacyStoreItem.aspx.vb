Imports System.Collections.Generic
Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Partial Class Store_AddPharmacyStoreItem
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            HiddenField_Drug_Category_Item.Value = dropdownlist_category.SelectedItem.Text

            If (CheckBox1.Checked) Then
                HF_Allow_Serial.Value = "True"
            Else
                HF_Allow_Serial.Value = "false"

            End If

            Dim connection As New SqlConnection
            Dim command As New SqlCommand

            connection.ConnectionString = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
            command = connection.CreateCommand
            command.CommandText = "Insert_PharmacyStore_Item"
            command.Parameters.AddWithValue("@Item_Code", txtCode.Text)
            command.Parameters.AddWithValue("@Item_Name", TextBox_Item.Text)
            command.Parameters.AddWithValue("@Item_Full_Name", txt_Item_FullName.Text)
            command.Parameters.AddWithValue("@Pneumanic", txtPneu.Text)
            command.Parameters.AddWithValue("@Drug_Category", ddlDrug.SelectedValue)
            command.Parameters.AddWithValue("@G_N_Id", ddlGeneric.SelectedValue)
            command.Parameters.AddWithValue("@Route", ddlRoute.SelectedValue)
            command.Parameters.AddWithValue("@Shelf", txtShelf.Text)
            command.Parameters.AddWithValue("@MinLevel", txtmin.Text)
            command.Parameters.AddWithValue("@MaxLevel", txtMax.Text)
            command.Parameters.AddWithValue("@ReOrder", txtReorder.Text)
            command.Parameters.AddWithValue("@LeadTime", txtLead.Text)
            command.Parameters.AddWithValue("@Disc", txtDisc.Text)
            command.Parameters.AddWithValue("@PackQty", txtPack.Text)
            command.Parameters.AddWithValue("@PackPrice", txtPrice.Text)
            command.Parameters.AddWithValue("@Packing", txtPacking.Text)
            command.Parameters.AddWithValue("@PurchasePrice", txtPurchase.Text)
            command.Parameters.AddWithValue("@TradePrice", txtTrade.Text)
            command.Parameters.AddWithValue("@SalePrice", txtSale.Text)
            command.Parameters.AddWithValue("@Unit", ddlUnit.SelectedValue)
            command.Parameters.AddWithValue("@Manufacturer", ddlManufacturer.SelectedValue)
            command.Parameters.AddWithValue("@EMP_ID", "0")
            command.Parameters.AddWithValue("@MajorPacking", txtRelMajorPacking.Text)
            command.Parameters.AddWithValue("@MinorPacking", txtRelMinorPacking.Text)
            command.Parameters.AddWithValue("@Status", rblStatus.SelectedValue)
            command.Parameters.AddWithValue("@ItemType", rblItemType.SelectedValue)
            command.Parameters.AddWithValue("@ForStore", ddlForStore.SelectedValue)

            command.Parameters.AddWithValue("@Category", dropdownlist_category.SelectedValue)
            command.Parameters.AddWithValue("@Distributor", ddlDistributor.SelectedValue)
            command.Parameters.AddWithValue("@Is_Expensive", rblexpensive.SelectedValue)
            command.Parameters.AddWithValue("@Expiry_Item", RadioButtonList_Expiry.SelectedValue)
            command.Parameters.AddWithValue("@Item_Description", txt_Description.Text)




            command.CommandType = CommandType.StoredProcedure

            connection.Open()
            command.ExecuteNonQuery()






            'SqlDataSourceSaveInfo.Insert()
            'GridViewElementValues.DataBind()
            ShowMessage("Record saved successfully.", False)
            Reset()
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

    Protected Sub btnSaveUnit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Pharmacy_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim Procedurename As String = "Add_UnitName"
            Dim mycommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(Procedurename, con)
            mycommand.CommandType = System.Data.CommandType.StoredProcedure
            mycommand.CommandText = Procedurename
            mycommand.Parameters.AddWithValue("@Remarks", System.Data.SqlDbType.Int)
            mycommand.Parameters("@Remarks").Direction = System.Data.ParameterDirection.Output
            mycommand.Parameters.AddWithValue("@UnitName", txtUnitName.Text)
            con.Open()
            mycommand.ExecuteScalar()
            Dim number As Integer = Convert.ToInt32(mycommand.Parameters("@Remarks").Value)
            If number = 11 Then
                lblText.Text = "Your Given Information has been saved successfully!"
                lblText.ForeColor = System.Drawing.Color.Green
                gvUnit.DataBind()
            Else
                lblText.Text = "Unit already Exist!"
                lblText.ForeColor = System.Drawing.Color.Red
            End If

            con.Close()
            txtUnitName.Text = String.Empty
            ' Response.Redirect(Request.RawUrl)
            ddlUnit.DataBind()


        Catch ex As Exception
        End Try
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Try

            loginvalidate(Session("emp_id"), Session("dept_id"))
            Label_message.Text = ""

            If Not Page.IsPostBack Then
                gvAllManufacturer.DataBind()
                gvUnit.DataBind()
                sdsGenericName.DataBind()
                sdsManufactureRoot.DataBind()
                sdsManu.DataBind()
                bindForStore()
                bindDistributor()
            End If
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
    End Sub

    'Protected Sub 236_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_General_Category.PreRender
    '    If Not Page.IsPostBack Then
    '        DropDownList_General_Category.Items.Insert(0, New ListItem("", ""))
    '        DropDownList_General_Category.SelectedIndex = 2
    '    End If
    'End Sub

    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        GridViewElementValues.DataBind()
    End Sub

    Protected Sub LinkButton_Unit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Unit.Click

        medUnit.Visible = True



    End Sub



    Protected Sub btnManu_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim Procedurename As String = "AddManufacturer"
            Dim mycommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(Procedurename, con)
            mycommand.CommandType = System.Data.CommandType.StoredProcedure
            mycommand.CommandText = Procedurename
            mycommand.Parameters.AddWithValue("@Remarks", System.Data.SqlDbType.Int)
            mycommand.Parameters("@Remarks").Direction = System.Data.ParameterDirection.Output
            mycommand.Parameters.AddWithValue("@ManufacturerName", txtManu.Text)
            con.Open()
            mycommand.ExecuteScalar()
            Dim number As Integer = Convert.ToInt32(mycommand.Parameters("@Remarks").Value)
            If number = 11 Then
                lblText.Text = "Manufacturer already Exist!"
                lblText.ForeColor = System.Drawing.Color.Red
            Else
                lblText.Text = "Your Given Information has been saved successfully!"
                lblText.ForeColor = System.Drawing.Color.Green
            End If

            con.Close()
            sdsManu.DataBind()
            ddlManufacturer.DataBind()
            ' Response.Redirect(Request.RawUrl)
            txtManufacturerName.Text = String.Empty
        Catch ex As Exception
        End Try
    End Sub



    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Pharmacy_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim Procedurename As String = "AddDrug"
            Dim mycommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(Procedurename, con)
            mycommand.CommandType = System.Data.CommandType.StoredProcedure
            mycommand.CommandText = Procedurename
            mycommand.Parameters.AddWithValue("@Remarks", System.Data.SqlDbType.Int)
            mycommand.Parameters("@Remarks").Direction = System.Data.ParameterDirection.Output
            mycommand.Parameters.AddWithValue("@DrugsCategory", txtManufacturerName.Text)
            con.Open()
            mycommand.ExecuteScalar()
            Dim number As Integer = Convert.ToInt32(mycommand.Parameters("@Remarks").Value)
            If number = 11 Then
                lblText.Text = "Your Given Information has been saved successfully!"
                lblText.ForeColor = System.Drawing.Color.Green
            Else
                lblText.Text = "Drug already Exist!"
                lblText.ForeColor = System.Drawing.Color.Red
            End If

            con.Close()
            gvAllManufacturer.DataBind()
            txtManufacturerName.Text = String.Empty

            'Response.Redirect(Request.RawUrl)
            ddlDrug.DataBind()


        Catch ex As Exception
            lblText.Text = ex.Message
        End Try
    End Sub


    'Protected Sub LinkButtonCategor_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonCategor.Click

    '    ItemCatagory.visible = True
    'End Sub

    Protected Sub GridViewElementValues_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridViewElementValues.RowEditing

    End Sub



    Protected Sub btnSaveGenric_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim Procedurename As String = "AddGeneric"
            Dim mycommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(Procedurename, con)
            mycommand.CommandType = System.Data.CommandType.StoredProcedure
            mycommand.CommandText = Procedurename
            mycommand.Parameters.AddWithValue("@Remarks", System.Data.SqlDbType.Int)
            mycommand.Parameters("@Remarks").Direction = System.Data.ParameterDirection.Output
            mycommand.Parameters.AddWithValue("@Generic_Name", textGeneric.Text)
            If Not String.IsNullOrEmpty(TryCast(Request.QueryString("IS_Pharmacy"), String)) Then
                mycommand.Parameters.AddWithValue("@IS_Pharmacy", TryCast(Request.QueryString("IS_Pharmacy"), String))
            Else
                mycommand.Parameters.AddWithValue("@IS_Pharmacy", "1")
            End If

            con.Open()
            mycommand.ExecuteScalar()
            Dim number As Integer = Convert.ToInt32(mycommand.Parameters("@Remarks").Value)
            If number = 11 Then
                lblText.Text = "Your Given Information has been saved successfully!"
                lblText.ForeColor = System.Drawing.Color.Green
            Else
                lblText.Text = "Already Exist!"
                lblText.ForeColor = System.Drawing.Color.Red
            End If

            con.Close()
            sdsGenericName.DataBind()
            ddlGeneric.DataBind()
            ' Response.Redirect(Request.RawUrl)
            txtManufacturerName.Text = String.Empty
        Catch ex As Exception
        End Try
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



    Protected Sub LinkButton_Category_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles linkbutton_category.Click

        ItemType.Visible = True


    End Sub

    Protected Sub GridViewElementValues_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    'Protected Sub LinkButton_GName_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_GName.Click
    '    HiddenFieldItemCatagory.Value = DropDownList_Category.SelectedValue


    '    GenericName.Visible = True
    'End Sub

    'Protected Sub Button_Generic_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Generic.Click
    '    'SqlDataSourceForGrid.Insert()
    '    SqlDataSource_GenericName.Insert()


    '    Response.Redirect(Request.RawUrl)
    '    'DropDownList_Generic_ItemName.DataBind()

    '    GridView_GenericName.DataBind()

    'End Sub

    'Protected Sub Button_SearchGeneric_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_SearchGeneric.Click
    '    If TextBox_Generic_Name.Text = "" Then
    '        HiddenField_item_GenericName.Value = "%"
    '    Else
    '        HiddenField_item_GenericName.Value = TextBox_Generic_Name.Text + "%"
    '    End If
    '    GridView_GenericName.DataBind()
    'End Sub

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



    Protected Sub btnSaveRoot_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Pharmacy_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim Procedurename As String = "AddRoot"
            Dim mycommand As System.Data.SqlClient.SqlCommand = New System.Data.SqlClient.SqlCommand(Procedurename, con)
            mycommand.CommandType = System.Data.CommandType.StoredProcedure
            mycommand.CommandText = Procedurename
            mycommand.Parameters.AddWithValue("@Remarks", System.Data.SqlDbType.Int)
            mycommand.Parameters("@Remarks").Direction = System.Data.ParameterDirection.Output
            mycommand.Parameters.AddWithValue("@ManufacturerName", textRoot.Text)
            con.Open()
            mycommand.ExecuteScalar()
            Dim number As Integer = Convert.ToInt32(mycommand.Parameters("@Remarks").Value)
            If number = 11 Then
                lblText.Text = "Your Given Information has been saved successfully!"
                lblText.ForeColor = System.Drawing.Color.Green
            Else
                lblText.Text = "Root already Exist!"
                lblText.ForeColor = System.Drawing.Color.Red
            End If

            con.Close()

            sdsManufactureRoot.DataBind()
            ddlRoute.DataBind()
            'Response.Redirect(Request.RawUrl)
            txtManufacturerName.Text = String.Empty
        Catch ex As Exception
        End Try
    End Sub



    Protected Sub ButtonSearchItemCategory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSearchItemCategory.Click
        SqlDataSourceForMedCat.SelectParameters("").DefaultValue = TextBox_Item_Category.Text
        GridView_Category.DataBind()
    End Sub

    Protected Sub Button_SaveItemCategory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_SaveItemCategory.Click
        Try
            SqlDataSourceSaveMedCat.Insert()
            GridView_Category.DataBind()
            'DropDownList_General_Category.DataBind()
            dropdownlist_category.DataBind()
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
        dropdownlist_category.DataBind()
        ' Response.Redirect(Request.RawUrl)


    End Sub

    Protected Sub imgManu_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgManu.Click
        panelManufact.Visible = False
    End Sub


    Protected Sub ImageBRoot_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageBRoot.Click
        panelRoot.Visible = False
    End Sub

    'Protected Sub btn_cls_gname_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_cls_gname.Click
    '    GenericName.Visible = False
    'End Sub

    Protected Sub btn_cls_medcat_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_cls_medcat.Click
        ItemCatagory.Visible = False
    End Sub

    Protected Sub btn_cls_medtype_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_cls_medtype.Click
        ItemType.Visible = False
    End Sub

    Protected Sub btn_drugs_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btn_drugs.Click
        panalDrugs.Visible = False
    End Sub

    Protected Sub imgGenric_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgGenric.Click
        panelGenric.Visible = False
    End Sub


    Protected Sub imageUnit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imageUnit.Click
        panelUnit.Visible = False
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
        bindDistributor()
        bindForStore()
        Dim qry As String = "usp_GetItemDetails"
        Dim con As New SqlConnection(constr)
        Dim cmd As New SqlCommand(qry, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Item_Code", Item_Code)
        con.Open()
        Dim reader As SqlDataReader = cmd.ExecuteReader
        While reader.Read

            txtCode.Text = reader.Item("Item_Code").ToString()
            TextBox_Item.Text = reader.Item("Item_Name")
            ddlUnit.DataBind()
            ddlUnit.SelectedItem.Text = reader.Item("Unit")
            txtPneu.Text = reader.Item("Potency").ToString()
            'DropDownList_General_Category.DataBind()
            'DropDownList_General_Category.SelectedValue = reader.Item("Category")
            dropdownlist_category.DataBind()
            If Not String.IsNullOrEmpty(reader.Item("Item_Type_Id")) Then
                dropdownlist_category.SelectedValue = reader.Item("Item_Type_Id")
            End If
            ddlDrug.DataBind()
            ddlDrug.SelectedItem.Text = reader.Item("Drug_Category")
            ddlGeneric.DataBind()
            ddlGeneric.SelectedValue = reader.Item("G_N_Id")
            ddlManufacturer.DataBind()
            ddlManufacturer.SelectedValue = reader.Item("Manufacturer")
            ddlRoute.DataBind()
            If Not String.IsNullOrEmpty(reader.Item("Route")) Then
                ddlRoute.SelectedValue = reader.Item("Route")
            End If
            txtShelf.Text = reader.Item("Shelf")
            txtmin.Text = reader.Item("MinLevel")
            txtMax.Text = reader.Item("MaxLevel")
            txtReorder.Text = reader.Item("ReOrder")
            txtLead.Text = reader.Item("LeadTime")
            txtDisc.Text = reader.Item("Discount")
            txtPack.Text = reader.Item("PackQty")
            txtPrice.Text = reader.Item("PackPrice")
            txtPacking.Text = reader.Item("Packing")
            txtPurchase.Text = reader.Item("PurchasePrice")
            txtTrade.Text = reader.Item("TradePrice")
            txtSale.Text = reader.Item("SalePrice")
            txtPneu.Text = reader.Item("Pneumonic")
            Try
                ddlDistributor.SelectedValue = reader.Item("Distributor")
            Catch
                ddlDistributor.SelectedIndex = 0
            End Try

            rblItemType.SelectedValue = reader.Item("Itemtype").ToString()


            rblStatus.SelectedValue = reader.Item("Status").ToString()
            txtRelMajorPacking.Text = reader.Item("MajorPackingRelation").ToString()
            txtRelMinorPacking.Text = reader.Item("MinorPackingRelation").ToString()
            txt_Description.Text = reader.Item("Item_Description").ToString()
            rblexpensive.SelectedValue = reader.Item("Is_Expensive").ToString()



            RadioButtonList_Expiry.DataBind()
            RadioButtonList_Expiry.SelectedValue = reader.Item("Expiry_Item")
            CheckBox1.Checked = Boolean.Parse(reader.Item("Allow_Serial").ToString())
            'txtPartNumber.Text = reader.Item("Part_No").ToString()
            ' txt_Description.Text = reader.Item("Item_Description").ToString()
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
        'txtPartNumber.Text = String.Empty
        'GridViewElementValues.DataBind(Save)
        dropdownlist_category.Enabled = True
        'DropDownList_Generic_ItemName.Enabled = True
        'DropDownList_General_Category.Enabled = True
    End Sub


    'Protected Sub DropDownList_Category_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
    '    DropDownList_Generic_ItemName.DataBind()
    'End Sub

    Protected Sub GridView_Category_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Category.SelectedIndexChanged

    End Sub

    'Protected Sub DropDownList_Category_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Category.SelectedIndexChanged
    '    DropDownList_Generic_ItemName.DataBind()

    'End Sub

    Protected Sub TextBox_Item_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Item.TextChanged
        TextBox_ItemCode.Enabled = True

    End Sub


    Protected Sub Button_update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_update.Click

        Try
            SqlDataSourceForGrid.UpdateParameters("Item_Code").DefaultValue = txtCode.Text.Trim()
            SqlDataSourceForGrid.UpdateParameters("Item_Name").DefaultValue = TextBox_Item.Text.Trim()
            SqlDataSourceForGrid.UpdateParameters("Item_Full_Name").DefaultValue = txt_Item_FullName.Text.Trim()
            SqlDataSourceForGrid.UpdateParameters("Manufacturer").DefaultValue = ddlManufacturer.SelectedValue
            SqlDataSourceForGrid.UpdateParameters("Unit").DefaultValue = ddlUnit.SelectedValue
            SqlDataSourceForGrid.UpdateParameters("Pneumonic").DefaultValue = txtPneu.Text
            SqlDataSourceForGrid.UpdateParameters("Item_Type_Id").DefaultValue = dropdownlist_category.SelectedValue

            SqlDataSourceForGrid.UpdateParameters("Drug_Category").DefaultValue = ddlDrug.SelectedValue
            SqlDataSourceForGrid.UpdateParameters("G_N_Id").DefaultValue = ddlGeneric.SelectedValue
            SqlDataSourceForGrid.UpdateParameters("Route").DefaultValue = ddlRoute.SelectedValue
            SqlDataSourceForGrid.UpdateParameters("Shelf").DefaultValue = txtShelf.Text
            SqlDataSourceForGrid.UpdateParameters("MinLevel").DefaultValue = txtmin.Text
            SqlDataSourceForGrid.UpdateParameters("MaxLevel").DefaultValue = txtMax.Text
            SqlDataSourceForGrid.UpdateParameters("ReOrder").DefaultValue = txtReorder.Text
            SqlDataSourceForGrid.UpdateParameters("LeadTime").DefaultValue = txtLead.Text
            SqlDataSourceForGrid.UpdateParameters("Discount").DefaultValue = txtDisc.Text
            SqlDataSourceForGrid.UpdateParameters("PackQty").DefaultValue = txtPack.Text
            SqlDataSourceForGrid.UpdateParameters("PackPrice").DefaultValue = txtPrice.Text
            SqlDataSourceForGrid.UpdateParameters("Packing").DefaultValue = txtPacking.Text
            SqlDataSourceForGrid.UpdateParameters("PurchasePrice").DefaultValue = txtPurchase.Text
            SqlDataSourceForGrid.UpdateParameters("TradePrice").DefaultValue = txtTrade.Text
            SqlDataSourceForGrid.UpdateParameters("SalePrice").DefaultValue = txtSale.Text

            SqlDataSourceForGrid.UpdateParameters("MajorPacking").DefaultValue = txtRelMajorPacking.Text
            SqlDataSourceForGrid.UpdateParameters("MinorPacking").DefaultValue = txtRelMinorPacking.Text
            SqlDataSourceForGrid.UpdateParameters("ForStore").DefaultValue = ddlForStore.SelectedValue
            SqlDataSourceForGrid.UpdateParameters("Distributor").DefaultValue = ddlDistributor.SelectedValue
            SqlDataSourceForGrid.UpdateParameters("Is_Expensive").DefaultValue = rblexpensive.SelectedValue
            SqlDataSourceForGrid.UpdateParameters("ExpiryItem").DefaultValue = RadioButtonList_Expiry.SelectedValue
            SqlDataSourceForGrid.UpdateParameters("Item_Description").DefaultValue = txt_Description.Text
            SqlDataSourceForGrid.UpdateParameters("ItemType").DefaultValue = rblItemType.SelectedValue
            SqlDataSourceForGrid.UpdateParameters("Status").DefaultValue = rblStatus.SelectedValue
            SqlDataSourceForGrid.UpdateParameters("Emp_Id").DefaultValue = Session("Emp_Id")

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
        panelManufact.Visible = True
        'Dim url As String = "Add_Manufacturer.aspx"
        'Dim sb As New StringBuilder()
        'sb.Append("<script type = 'text/javascript'>")
        'sb.Append("window.open('")
        'sb.Append(url)
        'sb.Append("');")
        'sb.Append("</script>")
        'ClientScript.RegisterStartupScript(Me.GetType(), _
        '          "script", sb.ToString())

        ' Response.Redirect("~/Store/Add_Manufacturer.aspx")
    End Sub


    Protected Sub lnkAddRoute_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAddRoute.Click
        panelRoot.Visible = True
        'Dim url As String = "Add_Root.aspx"
        'Dim sb As New StringBuilder()
        'sb.Append("<script type = 'text/javascript'>")
        'sb.Append("window.open('")
        'sb.Append(url)
        'sb.Append("');")
        'sb.Append("</script>")
        'ClientScript.RegisterStartupScript(Me.GetType(), _
        '          "script", sb.ToString())

        ' Response.Redirect("~/Store/Add_Manufacturer.aspx")
    End Sub

    Protected Sub lnkDrugClass_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkDrugClass.Click

        panalDrugs.Visible = True


        'Dim url As String = "Add_Drugs.aspx"
        'Dim sb As New StringBuilder()
        'sb.Append("<script type = 'text/javascript'>")
        'sb.Append("window.open('")
        'sb.Append(url)
        'sb.Append("');")
        'sb.Append("</script>")
        'ClientScript.RegisterStartupScript(Me.GetType(), _
        '          "script", sb.ToString())

        'Response.Redirect("~/Store/Add_Manufacturer.aspx")
    End Sub




    Protected Sub lnkbtnGeneric_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkbtnGeneric.Click
        panelGenric.Visible = True
        'Dim url As String = "Add_Generic.aspx?IS_Pharmacy=1"
        'Dim sb As New StringBuilder()
        'sb.Append("<script type = 'text/javascript'>")
        'sb.Append("window.open('")
        'sb.Append(url)
        'sb.Append("');")
        'sb.Append("</script>")
        'ClientScript.RegisterStartupScript(Me.GetType(), _
        '          "script", sb.ToString())

        ' Response.Redirect("~/Store/Add_Manufacturer.aspx")
    End Sub
    Protected Sub lnkUnit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkUnit.Click
        panelUnit.Visible = True
        'Dim url As String = "Add_Unit.aspx"
        'Dim sb As New StringBuilder()
        'sb.Append("<script type = 'text/javascript'>")
        'sb.Append("window.open('")
        'sb.Append(url)
        'sb.Append("');")
        'sb.Append("</script>")
        'ClientScript.RegisterStartupScript(Me.GetType(), _
        '          "script", sb.ToString())

        ' Response.Redirect("~/Store/Add_Manufacturer.aspx")
    End Sub
    Protected Sub bindForStore()
        Dim dbm As DbManager = New DbManager()
        Dim sp As SqlParameter() = {New SqlParameter("@SubDeptName", "Store")}
        Dim query As String = "Select SubDept_Id,SubDept_Name From SubDepartment Where SubDept_Name Like '%'+@SubDeptName+'%'"
        ddlForStore.DataSource = dbm.ExecuteDataTableWithQuery(query, "STOREConnectionString", sp)
        ddlForStore.DataBind()
        ddlForStore.SelectedValue = 83
    End Sub
    Protected Sub bindDistributor()
        Dim dbm As DbManager = New DbManager()
        Dim sp As SqlParameter() = {New SqlParameter("@SubDeptName", "%")}
        Dim query As String = "Select 0 Party_Id,'' Party_Name union Select Party_Id,Party_Name From Parties where Party_Name Like '%'+@SubDeptName+'%'"
        ddlDistributor.DataSource = dbm.ExecuteDataTableWithQuery(query, "STOREConnectionString", sp)
        ddlDistributor.DataBind()
    End Sub

End Class
