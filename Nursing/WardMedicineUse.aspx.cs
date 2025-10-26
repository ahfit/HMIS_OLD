using System;
using System.Data;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class WardMedicineUse : System.Web.UI.Page
{
    static string connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    string connection = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    string Constr_Treatment = ConfigurationManager.ConnectionStrings["TreatmentConnectionString"].ToString();
    Int32 Stock;
    protected void validate(string url, string dept)
    {
       if (Session["emp_id"] == null || Session["dept_id"] == null)
        {
            Response.Redirect("login.aspx");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
      JavaScriptMenu obj_menu =new JavaScriptMenu();
      
      obj_menu.loginvalidate();
	 
      // Response.Write (Request.PhysicalPath); 
      //Response.Write(Request.PhysicalApplicationPath);
      //Response.Write();
      //LabelSideMenu.Text = Convert.ToString(obj_menu.SideMenu_nurse(Request.PhysicalPath.Substring((Request.PhysicalApplicationPath.Length - 1), Convert.ToInt32((Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))));
      LabelSideMenu.Text = Convert.ToString(obj_menu.SideMenu(Request.PhysicalPath.Substring((Request.PhysicalApplicationPath.Length - 1), Convert.ToInt32((Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))));
        //(Right(Convert.ToString ( Request.PhysicalPath), Convert.ToUInt32 ((Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))));
       
        // validate("MedicineStock.aspx", "1");

        //Session["YearlyNo"] = Session["YearlyNo"];//Request.QueryString["payid"];
        //Session["registrationNo"] = Session["registrationNo"];//Request.QueryString["RegNo"];
        if (Session["YearlyNo"] == null || Session["registrationNo"] == null)
        {
           // Response.Redirect("Login.aspx");
        }
        HiddenField_Emp_Id.Value =Convert.ToString(Session["emp_id"]) ;
        HiddenField_Registration_No.Value = Convert.ToString(Session["registrationNo"]);
        HiddenField_Yearly_No.Value = Convert.ToString(Session["YearlyNo"]);
        HiddenField_DAte.Value = DateTime.Now.Date.ToString();
        if (!(IsPostBack))
        {
            GridView3.DataBind();

            //get_load();
            HiddenField_Dept_ID.Value = Session["SubDeptId"].ToString();
            HiddenField_Emp_Id.Value = Session["emp_id"].ToString();
            WebDateChooser_StartDate.Value = DateTime.Now;
            Load_PUMS();
            
        }
        //036043036064043043043036092057099036036064057 100112

        //Response.Write(HiddenField_Registration_No.Value + " " + HiddenField_Yearly_No.Value);
        //GridView3.DataBind();

        
        
    }

    void Load_PUMS()
    {

        try
        {
            Nursing ds = new Nursing();
            NursingTableAdapters.DataTable_PUMS_MainTableAdapter da = new NursingTableAdapters.DataTable_PUMS_MainTableAdapter();

            //DataList_PMUS.HeaderTemplate     
            //Label_Date1.Text = "sadfsdfsad";
            //da.Fill(ds.DataTable_PUMS);
            GridView_PMUS.DataSource = da.GetData(Session["registrationNo"].ToString(), Convert.ToInt32(Session["YearlyNo"]), Convert.ToDateTime(WebDateChooser_StartDate.Value));
            GridView_PMUS.DataBind();

            //SqlConnection con = new SqlConnection(Constr_Treatment);
            //String Qry = "select @sdate AS  date1 , dateadd(dd,1,@sdate) AS  date2 , dateadd(dd,2,@sdate) AS  date3, dateadd(dd,3,@sdate) AS  date4, dateadd(dd,4,@sdate) AS  date5, dateadd(dd,5,@sdate) AS date6 , dateadd(dd,6,@sdate) AS date7 where ()";

            DateTime dte = Convert.ToDateTime(WebDateChooser_StartDate.Value);
            if (GridView_PMUS.Rows.Count > 0)
            {
                Label Label_HeaderDate1 = (Label)GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate1");
                Label_HeaderDate1.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString();

                dte = dte.AddDays(1);
                Label Label_HeaderDate2 = (Label)GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate2");
                Label_HeaderDate2.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString();

                dte = dte.AddDays(1);
                Label Label_HeaderDate3 = (Label)GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate3");
                Label_HeaderDate3.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString();

                dte = dte.AddDays(1);
                Label Label_HeaderDate4 = (Label)GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate4");
                Label_HeaderDate4.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString();

                dte = dte.AddDays(1);
                Label Label_HeaderDate5 = (Label)GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate5");
                Label_HeaderDate5.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString();

                dte = dte.AddDays(1);
                Label Label_HeaderDate6 = (Label)GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate6");
                Label_HeaderDate6.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString();

                dte = dte.AddDays(1);
                Label Label_HeaderDate7 = (Label)GridView_PMUS.HeaderRow.FindControl("Label_HeaderDate7");
                Label_HeaderDate7.Text = dte.Day.ToString() + "/" + dte.Month.ToString() + "/" + dte.Year.ToString();
            }
            //DataTable_PUMS_Main
        }
        catch (Exception ex)
        {
            Response.Write("data not show in PUMS "+ex.InnerException.ToString());
        }



    }
    protected void ImageButtonback_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("pharmacyAdmin.aspx");
    }
    protected void ButtonPrint_Click(object sender, EventArgs e)
    {
       
    }


    protected void Button1_Click(object sender, EventArgs e)
    {

        if (GridView3.Rows.Count != 0)
        {

            HiddenField_Consumption_Id.Value = "0";
            for (int i = 0; i < GridView3.Rows.Count; i++)
            {

                DropDownList route = (DropDownList)GridView3.Rows[i].FindControl("Route");
                HiddenField_Route.Value = route.SelectedValue;
                CheckBox CheckBox_HospitalMedicine = (CheckBox)GridView3.Rows[i].FindControl("CheckBox_Hospital");
                CheckBox chkdone = (CheckBox)GridView3.Rows[i].FindControl("CheckBoxDone");

                HiddenField Mcode = (HiddenField)GridView3.Rows[i].FindControl("HiddenField_Mcode");
                //HiddenField start_date = (HiddenField)GridView3.Rows[i].FindControl("HiddenField_startDate");
                //HiddenField end_date = (HiddenField)GridView3.Rows[i].FindControl("HiddenField_enddate");
                //TextBox Label_MD2 = (TextBox)GridView3.Rows[i].FindControl("Text_MD2");
                //TextBox Label_MD2_qty = (TextBox)GridView3.Rows[i].FindControl("TextBox_MD2");

                //HiddenField_Qty.Value = Label_MD2_qty.Text;
                //HiddenField_startdate.Value  =start_date.Value  ;
                //  HiddenField_enddate.Value = end_date.Value ; 
                HiddenField_mcode.Value = Mcode.Value;
                Label Label_Stock = (Label)GridView3.Rows[i].FindControl("Label_Stock");
                Stock = Convert.ToInt32( Label_Stock.Text);

                DataList DataList_Frequency = (DataList)GridView3.Rows[i].FindControl("DataList_Frequency");

                HiddenFieldStatus.Value = DateTime.Now.ToString();
                HiddenFieldSample.Value = Convert.ToString(DateTime.Today.Date.Month) + "/" + Convert.ToString(DateTime.Today.Date.Day) + "/" + Convert.ToString(DateTime.Today.Date.Year);// +" " + Label_MD2.Text;

                for (int j = 0; j < DataList_Frequency.Items.Count; j++)
                {
                    HiddenField HF_F_S_Id = (HiddenField)DataList_Frequency.Items[j].FindControl("HF_F_S_Id");
                    TextBox TextBox_dosage2 = (TextBox)DataList_Frequency.Items[j].FindControl("TextBox_dosage2");
                    CheckBox CheckBox_Insert = (CheckBox)DataList_Frequency.Items[j].FindControl("CheckBox_Insert");
                 

                    if (TextBox_dosage2.Enabled == true)
                    {
                        if (CheckBox_Insert.Checked == true)
                        {  //CheckBox_Insert
                            HiddenField_Frequency_Sub_ID.Value = HF_F_S_Id.Value;
                            HiddenField_Qty.Value = TextBox_dosage2.Text;
                           
                            
                            
                            //Response.Write(TextBox_dosage2.Text);
                            try
                            {
                                //if (Convert.ToInt32(HiddenField_Qty.Value) <= Stock)
                                //{
                                    if (CheckBox_HospitalMedicine.Checked == true)
                                    {
                                      SqlDataSource_Store_Item_Consumption_Main.Insert();
                                       SqlDataSource_Store_Item_Consumption_Sub.Insert();
                                    }
                                    
                                   
                                    SqlDataSource_Medicine.Insert();
                                    SqlDataSourceUpdatePrescription.Update();
                                //}
                                //else
                                //{ 
                                
                                //}

                            }
                            catch (Exception ex)
                            {
                                Response.Write(ex.Message.ToString());
                            }

                        }
                    }
                }


                try
                {
                    //if (chkdone.Checked == true )
                    //{
                    //    if (chkdone.Checked == true)
                    //    {
                    //        HiddenFieldStatus.Value = DateTime.Now.ToString();

                    //        HiddenFieldSample.Value = Convert.ToString(DateTime.Today.Date.Month) +"/"+ Convert.ToString(DateTime.Today.Date.Day  ) +"/"+ Convert.ToString(DateTime.Today.Date.Year ) +" "+ Label_MD2.Text;
                    //    }
                    //    else
                    //    {

                    //        HiddenFieldStatus.Value = "";
                    //        HiddenFieldSample.Value = "";
                    //    }

                    //SqlDataSource_Medicine.Insert();
                    //SqlDataSourceUpdatePrescription.Update();
                    Label_Error.Text = "";
                    //GridView3.DataBind();
                    GridView2.DataBind();

                    Load_PUMS();
                    //GridView_PMUS.DataBind();
                    //get_load();
                    //}
                    //else
                    //{
                    //    //if (HiddenField_Qty.Value != "0")
                    //    //{
                    //      //  Label_Error.Text = GridView1.Rows[i].Cells[1].Text + " Greater Than Limit";
                    //    //}
                    //}
                }
                catch (Exception ex)
                {
                    //Label_Error.Text = ex.ToString() + "Greater Than Limit";
                }
            }
        }
          GridView3.DataBind(); 

    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Label_Error.Text = "";
        GridView3.DataBind();
        GridView2.DataBind();
        //GridView_PMUS.DataBind();
        Load_PUMS();
    }

    public void Load_This_List(DropDownList List,string Drug_Category)
    {
        SqlConnection con = new SqlConnection(connection);
        con.Open();
        SqlCommand command1 = new SqlCommand("Medicine_Route_select", con);
        command1.CommandType = CommandType.StoredProcedure;
        command1.Parameters.AddWithValue("@Category", Drug_Category);
        SqlDataReader reader = command1.ExecuteReader();
        while (reader.Read())
        {  
            ListItem item = new ListItem(reader[0].ToString(), reader[1].ToString());
            List.Items.Add(item);       
        }
        reader.Close();
        con.Close();
    }


    protected void DataList_PMUS_SelectedIndexChanged(object sender, EventArgs e)
    {
        //HiddenField HiddenField_En_Dis = (HiddenField)DataList_PMUS.Items[DataList_PMUS.SelectedItem.ItemIndex].FindControl("HiddenField_En_Dis");
        //HiddenField HiddenField_DoseUseDate = (HiddenField)DataList_PMUS.Items[DataList_PMUS.SelectedItem.ItemIndex].FindControl("HiddenField_DoseUseDate");
        //HiddenField HiddenField_FrequencySubID = (HiddenField)DataList_PMUS.Items[DataList_PMUS.SelectedItem.ItemIndex].FindControl("HiddenField_FrequencySubID");
        //HiddenField HiddenField_PrescriptionID = (HiddenField)DataList_PMUS.Items[DataList_PMUS.SelectedItem.ItemIndex].FindControl("HiddenField_PrescriptionID");
        //HiddenField HiddenField_MedCode = (HiddenField)DataList_PMUS.Items[DataList_PMUS.SelectedItem.ItemIndex].FindControl("HiddenField_MedCode");
        //HiddenField_En_Dis.Value = HiddenField_En_Dis.Value;
        //HiddenField_DoseUseDate_1.Value = HiddenField_DoseUseDate.Value;
        //HiddenField_FrequencySubID_1.Value = HiddenField_FrequencySubID.Value;
        //HiddenField_PrescriptionID_1.Value = HiddenField_PrescriptionID.Value;
        //HiddenField_MedCode_1.Value = HiddenField_MedCode.Value; 
        //Panel_Description.Visible = true;
    }
    protected void Button_Save_Click(object sender, EventArgs e)
    {
        String qry = "INSERT INTO PrescriptedMedicineNotGivenDescritpion (Prescription_ID, Frequency_Sub_Id, Date, Description, MedCode) VALUES (@Prescription_ID,@Frequency_Sub_Id,@Date,@Description,@MedCode)";
        SqlConnection con = new SqlConnection(Constr_Treatment);
        SqlCommand cmd = new SqlCommand(qry,con);
        con.Open();
        cmd.Parameters.AddWithValue("@Prescription_ID",HiddenField_PrescriptionID_1.Value);
        cmd.Parameters.AddWithValue("@Frequency_Sub_Id",HiddenField_FrequencySubID_1.Value);
        cmd.Parameters.AddWithValue("@Date",HiddenField_DoseUseDate_1.Value);
        cmd.Parameters.AddWithValue("@Description",DropDownList_Reason.SelectedValue);
        cmd.Parameters.AddWithValue("@MedCode", HiddenField_MedCode_1.Value);
        
        cmd.ExecuteNonQuery();
        con.Close();
        Panel_Description.Visible = false;
        //GridView_PMUS.DataBind();
        Load_PUMS();

    }
    //protected void DataList_PMUS_ItemDataBound(object sender, DataListItemEventArgs e)
    //{
    //    if (e.Item.ItemType == ListItemType.Header)
    //    {
    //        Label Label_Date1 = (Label)e.Item.FindControl("Label_Date1");
    //        Label_Date1.Text = "DataList";
    //    }
    //}

    protected void DataList_Day1_SelectedIndexChanged(object sender, EventArgs e)
    {

        DataControlFieldCell cell = (DataControlFieldCell)(sender as Control).Parent;
        
        DataList DataList_Day1 = (DataList)cell.FindControl("DataList_Day1");
        HiddenField HF_Frequency_Sub_Id = (HiddenField)DataList_Day1.Items[DataList_Day1.SelectedItem.ItemIndex].FindControl("HF_Frequency_Sub_Id");


         GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        int index = gvRow.RowIndex;
        HiddenField HF_Prescription_id = (HiddenField)gvRow.FindControl("HF_Prescription_id");
        HiddenField HF_MedCode = (HiddenField)gvRow.FindControl("HF_MedCode");
        HiddenField HiddenField_Date1 = (HiddenField)gvRow.FindControl("HiddenField_Date1");

        HiddenField_DoseUseDate_1.Value = HiddenField_Date1.Value;
        HiddenField_FrequencySubID_1.Value = HF_Frequency_Sub_Id.Value;
        HiddenField_PrescriptionID_1.Value = HF_Prescription_id.Value;
        HiddenField_MedCode_1.Value = HF_MedCode.Value; 
        Panel_Description.Visible = true;


        //Response.Write(HiddenField_DoseUseDate_1.Value);
        //Response.Write(HiddenField_FrequencySubID_1.Value);
        //Response.Write(HiddenField_PrescriptionID_1.Value);
        //Response.Write(HiddenField_MedCode_1.Value);

    }

    protected void DataList_Day2_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataControlFieldCell cell = (DataControlFieldCell)(sender as Control).Parent;

        DataList DataList_Day2 = (DataList)cell.FindControl("DataList_Day2");
        HiddenField HF_Frequency_Sub_Id = (HiddenField)DataList_Day2.Items[DataList_Day2.SelectedItem.ItemIndex].FindControl("HF_Frequency_Sub_Id");


        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        int index = gvRow.RowIndex;
        HiddenField HF_Prescription_id = (HiddenField)gvRow.FindControl("HF_Prescription_id");
        HiddenField HF_MedCode = (HiddenField)gvRow.FindControl("HF_MedCode");
        HiddenField HiddenField_Date2 = (HiddenField)gvRow.FindControl("HiddenField_Date2");

        HiddenField_DoseUseDate_1.Value = HiddenField_Date2.Value;
        HiddenField_FrequencySubID_1.Value = HF_Frequency_Sub_Id.Value;
        HiddenField_PrescriptionID_1.Value = HF_Prescription_id.Value;
        HiddenField_MedCode_1.Value = HF_MedCode.Value;
        Panel_Description.Visible = true;
    }
    protected void DataList_Day3_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataControlFieldCell cell = (DataControlFieldCell)(sender as Control).Parent;

        DataList DataList_Day3 = (DataList)cell.FindControl("DataList_Day3");
        HiddenField HF_Frequency_Sub_Id = (HiddenField)DataList_Day3.Items[DataList_Day3.SelectedItem.ItemIndex].FindControl("HF_Frequency_Sub_Id");


        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        int index = gvRow.RowIndex;
        HiddenField HF_Prescription_id = (HiddenField)gvRow.FindControl("HF_Prescription_id");
        HiddenField HF_MedCode = (HiddenField)gvRow.FindControl("HF_MedCode");
        HiddenField HiddenField_Date3 = (HiddenField)gvRow.FindControl("HiddenField_Date3");

        HiddenField_DoseUseDate_1.Value = HiddenField_Date3.Value;
        HiddenField_FrequencySubID_1.Value = HF_Frequency_Sub_Id.Value;
        HiddenField_PrescriptionID_1.Value = HF_Prescription_id.Value;
        HiddenField_MedCode_1.Value = HF_MedCode.Value;
        Panel_Description.Visible = true;
    }
    protected void DataList_Day4_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataControlFieldCell cell = (DataControlFieldCell)(sender as Control).Parent;

        DataList DataList_Day4 = (DataList)cell.FindControl("DataList_Day4");
        HiddenField HF_Frequency_Sub_Id = (HiddenField)DataList_Day4.Items[DataList_Day4.SelectedItem.ItemIndex].FindControl("HF_Frequency_Sub_Id");


        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        int index = gvRow.RowIndex;
        HiddenField HF_Prescription_id = (HiddenField)gvRow.FindControl("HF_Prescription_id");
        HiddenField HF_MedCode = (HiddenField)gvRow.FindControl("HF_MedCode");
        HiddenField HiddenField_Date4 = (HiddenField)gvRow.FindControl("HiddenField_Date4");

        HiddenField_DoseUseDate_1.Value = HiddenField_Date4.Value;
        HiddenField_FrequencySubID_1.Value = HF_Frequency_Sub_Id.Value;
        HiddenField_PrescriptionID_1.Value = HF_Prescription_id.Value;
        HiddenField_MedCode_1.Value = HF_MedCode.Value;
        Panel_Description.Visible = true;
    }
    protected void DataList_Day5_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataControlFieldCell cell = (DataControlFieldCell)(sender as Control).Parent;

        DataList DataList_Day5 = (DataList)cell.FindControl("DataList_Day5");
        HiddenField HF_Frequency_Sub_Id = (HiddenField)DataList_Day5.Items[DataList_Day5.SelectedItem.ItemIndex].FindControl("HF_Frequency_Sub_Id");


        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        int index = gvRow.RowIndex;
        HiddenField HF_Prescription_id = (HiddenField)gvRow.FindControl("HF_Prescription_id");
        HiddenField HF_MedCode = (HiddenField)gvRow.FindControl("HF_MedCode");
        HiddenField HiddenField_Date5 = (HiddenField)gvRow.FindControl("HiddenField_Date5");

        HiddenField_DoseUseDate_1.Value = HiddenField_Date5.Value;
        HiddenField_FrequencySubID_1.Value = HF_Frequency_Sub_Id.Value;
        HiddenField_PrescriptionID_1.Value = HF_Prescription_id.Value;
        HiddenField_MedCode_1.Value = HF_MedCode.Value;
        Panel_Description.Visible = true;
    }
    protected void DataList_Day6_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataControlFieldCell cell = (DataControlFieldCell)(sender as Control).Parent;

        DataList DataList_Day6 = (DataList)cell.FindControl("DataList_Day6");
        HiddenField HF_Frequency_Sub_Id = (HiddenField)DataList_Day6.Items[DataList_Day6.SelectedItem.ItemIndex].FindControl("HF_Frequency_Sub_Id");


        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        int index = gvRow.RowIndex;
        HiddenField HF_Prescription_id = (HiddenField)gvRow.FindControl("HF_Prescription_id");
        HiddenField HF_MedCode = (HiddenField)gvRow.FindControl("HF_MedCode");
        HiddenField HiddenField_Date6 = (HiddenField)gvRow.FindControl("HiddenField_Date6");

        HiddenField_DoseUseDate_1.Value = HiddenField_Date6.Value;
        HiddenField_FrequencySubID_1.Value = HF_Frequency_Sub_Id.Value;
        HiddenField_PrescriptionID_1.Value = HF_Prescription_id.Value;
        HiddenField_MedCode_1.Value = HF_MedCode.Value;
        Panel_Description.Visible = true;
    }
    protected void DataList_Day7_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataControlFieldCell cell = (DataControlFieldCell)(sender as Control).Parent;

        DataList DataList_Day7 = (DataList)cell.FindControl("DataList_Day7");
        HiddenField HF_Frequency_Sub_Id = (HiddenField)DataList_Day7.Items[DataList_Day7.SelectedItem.ItemIndex].FindControl("HF_Frequency_Sub_Id");


        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        int index = gvRow.RowIndex;
        HiddenField HF_Prescription_id = (HiddenField)gvRow.FindControl("HF_Prescription_id");
        HiddenField HF_MedCode = (HiddenField)gvRow.FindControl("HF_MedCode");
        HiddenField HiddenField_Date7 = (HiddenField)gvRow.FindControl("HiddenField_Date7");

        HiddenField_DoseUseDate_1.Value = HiddenField_Date7.Value;
        HiddenField_FrequencySubID_1.Value = HF_Frequency_Sub_Id.Value;
        HiddenField_PrescriptionID_1.Value = HF_Prescription_id.Value;
        HiddenField_MedCode_1.Value = HF_MedCode.Value;
        Panel_Description.Visible = true;
    }
    protected void WebDateChooser_StartDate_ValueChanged(object sender, Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs e)
    {
        Load_PUMS();
    }
// ========================================================================================
  //================================== Imran Naqvi Works(06/20/2013)=======================
// ========================================================================================
    //+++++++++++++++++++ Both Functions are not use Anywhere++++++++++++++++++++++++++++++
//_________________________________________________________________________________________


    //public void Check_IB_ID()
    //{
    //    //Response.Write((int)Session["Dept_Id"]);
    //    //if ((int)Session["Dept_Id"] == )
    //    //{

    //    SqlConnection con = new SqlConnection(connection1);
    //    con.Open();
    //    SqlCommand command_IB_ID = new SqlCommand("SELECT IB_ID FROM Store_Indent_Book_Main WHERE (ShiftID = @ShiftID) AND (IB_ID NOT IN (SELECT IB_ID FROM Medicine_Request_Track WHERE (By_Dept_ID = @bysubdept))) AND (From_Dept_ID = @DeptID) AND (From_Sub_Dept_ID = @SubDeptID)", con);

    //    command_IB_ID.Parameters.AddWithValue("@DeptID", Session["dept_id"]);
    //    command_IB_ID.Parameters.AddWithValue("@bysubdept", HiddenField_Dept_ID.Value);

    //    command_IB_ID.Parameters.AddWithValue("@SubDeptID", Session["SubDeptID"]);
    //    command_IB_ID.Parameters.AddWithValue("@ShiftID", Session["ShiftID"]);

    //    SqlDataReader reader = command_IB_ID.ExecuteReader();
    //    if (reader.HasRows)
    //    {
    //        reader.Read();
    //        HiddenField_counter.Value = reader.GetString(0).ToString();
    //        //Labeb_Requisition_No.Text = HiddenField_counter.Value;
    //    }
    //    //Response.Write(HiddenField_counter.Value);
    //    reader.Close();
    //    con.Close();
    //    //}
    //}
//_________________________________________________________________________________________
    public void getCounter()
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command1 = new SqlCommand("SELECT ISNULL(MAX(Yearly_Counter), 0) + 1 AS NextID FROM Store_Indent_Book_Main WHERE (DATEPART(yyyy, Date_Time) = DATEPART(yyyy, GETDATE())) AND (From_Dept_ID = @From_Dept_ID) AND (From_Sub_Dept_ID = @From_Sub_Dept_ID)", con);
        command1.Parameters.AddWithValue("@From_Dept_ID", Session["dept_id"]);
        command1.Parameters.AddWithValue("@From_Sub_Dept_ID", Session["SubDeptID"]);
        int count;

        try
        {
            count = (int)command1.ExecuteScalar();
            HiddenField_YearlyCounter.Value = count.ToString();
        }
        catch (Exception ex)
        {
            count = 1;
            HiddenField_YearlyCounter.Value = "1";

        }
        con.Close();
        int len = count.ToString().Length;
        HiddenField_counter.Value = "R" + DateTime.Today.Year + "-";
        while (len < 5)
        {
            HiddenField_counter.Value += "0";
            len++;
        }
        HiddenField_counter.Value += count.ToString() + "-" + Session["dept_id"].ToString() + "-" + Session["SubDeptID"].ToString();
        // HiddenField_counter.Value = Labeb_Requisition_No.Text;

    }

    protected void Button_GenerateOrder_Click(object sender, EventArgs e)
    {
        HiddenField_counter.Value = "";
        HiddenField_Reg_no.Value = Convert.ToString(Session["registrationno"]);
        HiddenField_YearlyNo.Value = Convert.ToString(Session["YearlyNo"]);
        
//        Check_IB_ID();


        //GridView3
        //DataList_Frequency
        
        //
        //TextBox_dosage2
        //CheckBox_Insert
        for (int i = 0; i < GridView3.Rows.Count; i++)
        {

            HiddenField HiddenField_Mcode = (HiddenField)GridView3.Rows[i].FindControl("HiddenField_Mcode");
            HiddenField_Med_Code.Value = HiddenField_Mcode.Value;
            DataList DataList_Frequency = (DataList)GridView3.Rows[i].FindControl("DataList_Frequency");
        //DataList_Frequency.DataBin
            double total_Indent_Qty = 0;
            for (int j = 0; j < DataList_Frequency.Items.Count; j++)
            {
                TextBox TextBox_dosage2 = (TextBox)DataList_Frequency.Items[j].FindControl("TextBox_dosage2");
                CheckBox CheckBox_Insert = (CheckBox)DataList_Frequency.Items[j].FindControl("CheckBox_Insert");
                //if ((CheckBox_Insert.Checked == true) && (CheckBox_Insert.Enabled == true))
                {
                    total_Indent_Qty = total_Indent_Qty + Convert.ToDouble(TextBox_dosage2.Text);
                }
             }

             HiddenField_RO_Qty.Value = total_Indent_Qty.ToString();
                    if (HiddenField_counter.Value == "")
                    {
                        getCounter();
                        try
                        {
                            SqlDataSource_Medicine_Main.Insert();
                        }
                        catch (Exception ex)
                        {
                            string str = ex.ToString();
                            HiddenField_counter.Value = "";
                        }
                        
                        SqlDataSource_Medicine_Sub.Insert();

                    }
                    else
                    {
                        SqlDataSource_Medicine_Sub.Insert();
                    }
        
        }

        SqlDataSource_Submit.Insert();
        SqlDataSourceApprove.Insert();
        GridView3.DataBind();
    }

    protected void SqlDataSource_Store_Item_Consumption_Main_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
      HiddenField_Consumption_Id.Value =  e.Command.Parameters["@Consumption_Id"].Value.ToString();
    }

    protected void GridView3_PreRender(object sender, EventArgs e)
    {
        if (GridView3.Rows.Count != 0)
        {
            bool GeneraterOrder = false;
            bool UpdateStock = false;
            HiddenField_Qty.Value = "0";
            for (int i = 0; i < GridView3.Rows.Count; i++)
            {
                CheckBox chkdone = (CheckBox)GridView3.Rows[i].FindControl("CheckBoxDone");
                HiddenField Mcode = (HiddenField)GridView3.Rows[i].FindControl("HiddenField_Mcode");

                HiddenField_mcode.Value = Mcode.Value;
                Label Label_Stock = (Label)GridView3.Rows[i].FindControl("Label_Stock");
                Stock = Convert.ToInt32(Label_Stock.Text);
                Label Label_ReceivedQty = (Label)GridView3.Rows[i].FindControl("Label_ReceivedQty");
                Label Label_RequestedQty = (Label)GridView3.Rows[i].FindControl("Label_RequestedQty");



                DataList DataList_Frequency = (DataList)GridView3.Rows[i].FindControl("DataList_Frequency");
                DataList_Frequency.DataBind();
                for (int j = 0; j < DataList_Frequency.Items.Count; j++)
                {
                    HiddenField HF_F_S_Id = (HiddenField)DataList_Frequency.Items[j].FindControl("HF_F_S_Id");
                    TextBox TextBox_dosage2 = (TextBox)DataList_Frequency.Items[j].FindControl("TextBox_dosage2");
                    CheckBox CheckBox_Insert = (CheckBox)DataList_Frequency.Items[j].FindControl("CheckBox_Insert");

                    if (TextBox_dosage2.Enabled == true)
                    {
                        if (CheckBox_Insert.Checked == true)
                        {  //CheckBox_Insert

                            HiddenField_Frequency_Sub_ID.Value = HF_F_S_Id.Value;
                            HiddenField_Qty.Value = TextBox_dosage2.Text;

                        }
                    }
                }//end of data list for loop

               // Response.Write((HiddenField_Qty.Value));
                if (Convert.ToDouble(HiddenField_Qty.Value) > (Stock + Convert.ToInt32(Label_RequestedQty.Text) + Convert.ToInt32(Label_ReceivedQty.Text)))
                {
                    GeneraterOrder = true;
                }
                if (Convert.ToInt32(Label_ReceivedQty.Text) != 0)
                {
                    UpdateStock = true;
                }


            }//end of grid for loop

            if (GeneraterOrder == true)
                Button_GenerateOrder.Visible = true;
            else
                Button_GenerateOrder.Visible = false;

            if (UpdateStock == true)
                Button_UpdateStock.Visible = true;
            else
                Button_UpdateStock.Visible = false;



        } // end of main if
        else
        {
            Button_GenerateOrder.Visible = false;
            Button_Save.Visible = false;
            Button_UpdateStock.Visible = false;
        }
    }//End of function
    protected void Button_UpdateStock_Click(object sender, EventArgs e)
    {
        SqlDataSource_UpdateStock.Insert();

        GridView3.DataBind();
    }
    protected void Button_Cancel_Click(object sender, EventArgs e)
    {
        Panel_Description.Visible = false;
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        Response.Redirect("WardMedicineUseRpt.aspx?dt=" + WebDateChooser_StartDate.Value);
    }

    protected void GridView_PMUS_PreRender(object sender, EventArgs e)
    {
        //Response.Write(" All Para for Day1 :" + Session["registrationNo"] + "  " + Session["YearlyNo"] );
        foreach (GridViewRow Row in GridView_PMUS.Rows)
        {
            DataList DL1 = (DataList)Row.FindControl("DataList_Day1");

            DL1.DataBind();
            HiddenField m_Day = (HiddenField)Row.FindControl("HiddenField_Date1");
            HiddenField Pre = (HiddenField)Row.FindControl("HF_Prescription_id");
            HiddenField m_code = (HiddenField)Row.FindControl("HF_MedCode");
                //TextBox m_qty = (TextBox)Row.FindControl("TextBox_dosage2");
                //TextBox Issue_Qty = (TextBox)Row.FindControl("TXT_item_qty");
                //if (String.IsNullOrEmpty(m_qty.Text.Trim()))
                //{
                //    Issue_Qty.Text = "0";
                //}
                //else
                //{
                //    Issue_Qty.Text = m_qty.Text;
                //}
           // Response.Write(" All Para for Day1 :" + m_Day.Value + " " + Pre.Value + "  " + m_code.Value);
        }

    }
    protected void btn_doctorview_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Pt_EMR/Pt_plan.aspx");
    }
    protected void Btn_Requisition_Click(object sender, EventArgs e)
    {

        try
        {
            if (GridView3.Rows.Count > 0)
            {
                string strItemData = GetItemData();
                SDS_Gen_Requisition.InsertParameters["Issue_Item"].DefaultValue = strItemData;
                SDS_Gen_Requisition.Insert();
            }
        }
        catch (Exception ex)
        {
            lbl_Req_MSG.Text = "Error in requisition" + ex.Message;
        }
    }
    private string GetItemData()
    {
        string strData = "<IssuedItems>";
        HiddenField Item_Code = new HiddenField();
        TextBox Item_Qty  = new TextBox();
        CheckBox CH = new CheckBox();
         foreach (GridViewRow row in GridView3.Rows)
         {
             Item_Code = (HiddenField)row.FindControl("HF_Item_Code");
             Item_Qty = (TextBox)row.FindControl("TXT_item_qty");
             CH = (CheckBox)row.FindControl("CheckBox_Hospital");
             if (CH.Checked || !(string.IsNullOrEmpty(Item_Qty.Text.Trim())))
             {
                 strData += String.Format("<Item><iCode>{0}</iCode><totalIssued>{1}</totalIssued></Item>", Item_Code.Value.Trim(), Item_Qty.Text.Trim());
             }
             
         }
         strData += "</IssuedItems>";

        return strData;
    }
}
