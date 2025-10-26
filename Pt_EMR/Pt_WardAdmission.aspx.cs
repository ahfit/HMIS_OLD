using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;


public partial class Nursing_Pt_WardAdmission : System.Web.UI.Page
{
    Encryption enc = new Encryption();
    JavaScriptMenu objMenu = new JavaScriptMenu();
    string constr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();
    string reg_constr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();
    string conreg  = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ToString();
    string OP_constr = ConfigurationManager.ConnectionStrings["OperationTheaterConnectionString"].ToString();
           
    protected void Load_Dept_SubDept()
    {

    //    string qry = "SELECT SubDept_id, DeptID, PayID, RegNo, DoctorID FROM Payment WHERE (PayID = @PayID) AND (RegNo = @RegNo)";
    //SqlConnection con1 = new SqlConnection(conreg);
    //    con1.Open();
    // SqlCommand command1 = new SqlCommand(qry, con1);
    // command1.Parameters.AddWithValue("@RegNo",Request.QueryString["regno"]);
    // command1.Parameters.AddWithValue("@PayID", Request.QueryString["payid"]);
    //    SqlDataReader  reader1 = command1.ExecuteReader();
    //    if (reader1.Read())
    //    {
    //        ddlPatientDepartment.DataBind();
    //        ddlPatientDepartment.SelectedValue = Convert.ToString(reader1["DeptID"]);

    //        ddlPatientSubDepartment.DataBind();
    //                    try
    //                    {
    //                        ddlPatientSubDepartment.SelectedValue = Convert.ToString(reader1["SubDept_id"]);
    //                    }
    //                    catch (Exception ex)
    //                    {

    //                    }
    //                    //DDL_Ward.DataBind();
    //                    //try
    //                    //{
    //                    //    DDL_Ward.SelectedValue = Convert.ToString(reader1("Ward_id"));
    //                    //}
    //                    //catch (Exception ex)
    //                    //{

    //                    //}


    //                    ddlConsultant.DataBind();
    //                    try
    //                    {
    //                        ddlConsultant.SelectedValue = Convert.ToString(reader1["DoctorID"]);
    //                    }
    //                    catch (Exception ex)
    //                    {

    //                    }
                 
    //    }
    //                reader1.Close();
    //                con1.Close();
    
    }
    protected void Load_ReferBy_Addmited_Diagnosis()
    {
     //   string qry = "SELECT Consultant, Admission_Diagnosis, Order_By_Doctor,Recommended_Ward_Id FROM Pt_Operation_Recommended where (RegNo = @RegNo) and (YearlyNo = @YearlyNo)";
     //   SqlConnection con1 = new SqlConnection(OP_constr);
     //   con1.Open();
     //SqlCommand command1 = new SqlCommand(qry, con1);
     //command1.Parameters.AddWithValue("@RegNo",Request.QueryString["regno"]);
     //command1.Parameters.AddWithValue("@YearlyNo", Request.QueryString["payid"]);
     //   SqlDataReader  reader1 = command1.ExecuteReader();
     //   if (reader1.Read())
     //   {
     //       //ddlPatientDepartment.DataBind();
     //       txtAdmittedDiagnoses.Text = Convert.ToString(reader1["Admission_Diagnosis"]);

     //       ddlReferBy.DataBind();
     //       try
     //       {
     //           ddlConsultant.SelectedValue = Convert.ToString(reader1["Consultant"]);
     //           ddlReferBy.SelectedValue = Convert.ToString(reader1["Order_By_Doctor"]);
     //       }
     //       catch (Exception ex)
     //       {
     //           Response.Write(ex.Message.ToString());
     //       }
     //       DropDownListFloor.DataBind();
     //       try
     //       {
     //       DropDownListFloor.SelectedValue = Convert.ToString(reader1["Recommended_Ward_Id"]); 
     //       }
     //        catch (Exception ex)
     //       {
     //           Response.Write(ex.Message.ToString());
     //       }
     //   }
     //   con1.Close();
     //   con1.Dispose();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        loadAdmissionType();


        LabelSideMenu.Text = objMenu.SideMenu(Request.PhysicalPath);
        LabelFooter.Text = objMenu.Footer_String();
     
        if (Request.QueryString["regno"] != null)
        {
            Session.Add("RegistrationNo", Request.QueryString["regno"]);
        }
        if (Request.QueryString["payid"] != null)
        {
            Session.Add("YearlyNo", Request.QueryString["regno"]);
        }

        if (!IsPostBack)
        {
            
            DropDownListFloor.DataBind();
            if (!string.IsNullOrEmpty(Session["Ward"] as string))
            {
                DropDownListFloor.SelectedValue = Session["Ward"].ToString();
            }

            

            SetWardSetting();

            if (DropDownListFloor.SelectedItem.Text == "All")
            {
                //ds3 = Fill_Grid_All();
                //GridView2.DataSource = ds3.Tables("EmptyBeds");
                //GridView2.DataBind();
            }
            else
            {
                //ds3 = Fill_Grid(Convert.ToInt32(DropDownListFloor.SelectedValue));
                GridView2.DataSource = Fill_Grid(Convert.ToInt32(DropDownListFloor.SelectedValue));
                GridView2.DataBind();
            }
            Load_Dept_SubDept();
            Load_ReferBy_Addmited_Diagnosis();
            ddlReferBy.DataBind();
            ddlReferBy.SelectedValue = Request.QueryString["Refer_id"];
            
               
        }


    }
    protected void insertKinInfo()
    {
        try
        {
            SqlConnection con_bed = new SqlConnection(conreg);
            SqlCommand command1 = new SqlCommand("InsertKinInfo", con_bed);
            command1.CommandType = CommandType.StoredProcedure;
            command1.Parameters.AddWithValue("@KinName", txtKinName.Text);
            command1.Parameters.AddWithValue("@KinRelation", txtRelationWithPatient.Text);
            command1.Parameters.AddWithValue("@KinContact", txtKinContactNo.Text);
            command1.Parameters.AddWithValue("@KinAddress", txtKinAddress.Text);
            command1.Parameters.AddWithValue("@Reg", Session["RegistrationNo"].ToString());
            command1.Parameters.AddWithValue("@Yearlyno", Session["YearlyNo"].ToString());
            command1.Parameters.AddWithValue("@admissionType", DDLAdmissionType.SelectedItem.Text);
            
            con_bed.Open();
             command1.ExecuteNonQuery();
            con_bed.Close();
        }
        catch (Exception ex)
        {
            // Response.Write(ex.Message + "Get Bed No.")
        }

        }

    protected void loadAdmissionType()
    {
        try
        {
            SqlConnection con_bed = new SqlConnection(constr);
            SqlCommand command1 = new SqlCommand("SELECT   Id, AdmissionType FROM  [Registration].[dbo].[AdmissionType]", con_bed);
            SqlDataAdapter sda = new SqlDataAdapter(command1);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            DDLAdmissionType.DataSource = dt;
            DDLAdmissionType.DataValueField = "Id";
            DDLAdmissionType.DataTextField = "AdmissionType";
            DDLAdmissionType.DataBind();
        }
        catch (Exception ex)
        {
            // Response.Write(ex.Message + "Get Bed No.")
        }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            insertKinInfo();
            dsWardAdmission.Insert();
            grdWardAdmission.DataBind();
            txtAdmittedDiagnoses.Text = "";
            txtDescription.Text = "";
            txtReferByInstitute.Text = "";
            Response.Redirect("~/patient registration/IPD_Regisration_Report.aspx");
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }


    protected void grdWardAdmission_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        Patient_RegistrationTableAdapters.PT_WardAdmissionTableAdapter daWardAdmition = new Patient_RegistrationTableAdapters.PT_WardAdmissionTableAdapter();
        try
        {
            dt = daWardAdmition.GetDataBy_AdmitID(Convert.ToDecimal(grdWardAdmission.SelectedDataKey.Value));
            DataRow dr = dt.Rows[0];
            ddlReferBy.SelectedValue = dr["Refer_By"].ToString();
            ddlConsultant.SelectedValue = dr["Consultant_ID"].ToString();
            ddlPatientCondition.SelectedValue = dr["Patient_Condition"].ToString();
            ddlPatientSubDepartment.SelectedValue = dr["Patient_SubDept_ID"].ToString();
            ddlArrivalStatus.SelectedValue = dr["Arrival_Status_ID"].ToString();
            ddlActivityLevel.SelectedValue = dr["Activity_Level"].ToString();
            txtAdmittedDiagnoses.Text = dr["Admitted_Diagnosis"].ToString();
            txtDescription.Text = dr["Description"].ToString();
            txtReferByInstitute.Text = dr["ReferBy_Institute"].ToString();

            
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            dsWardAdmission.Update();
            grdWardAdmission.DataBind();
            txtReferByInstitute.Text = "";
            txtDescription.Text = "";
            txtAdmittedDiagnoses.Text = "";

        }
        catch (Exception ex)
        { }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Insert_Assign_Bed();
        DataTable dt3 = Fill_Grid(Convert.ToInt32(DropDownListFloor.SelectedValue));
        GridView2.DataSource = dt3;//.Tables["EmptyBeds"];
        GridView2.DataBind();
        CheckBoxListRoom.DataBind();
        RadioButtonListBeds.DataBind();
        

    }
    public void Javascript(string msg)
    {
        Label_script.Text = "<script language ='Javascript'>alert('" + msg + "');</script>";
    }
    public int Get_Bed_Id(string Bed_No, int ward_id)
    {
        int bed_id = 0;
        try
        {
            SqlConnection con_bed = new SqlConnection(constr);
            SqlCommand command1 = new SqlCommand("SELECT Bed_id FROM Ward_Beds where Bed_No=@Bed_No and ward_Id=@ward_Id", con_bed);
            command1.CommandType = CommandType.Text;
            command1.Parameters.AddWithValue("@Bed_No", Bed_No);
            command1.Parameters.AddWithValue("@ward_Id", ward_id);
            con_bed.Open();
            SqlDataReader reader = command1.ExecuteReader();
            while (reader.Read())
            {
                bed_id = reader.GetInt32(0);
            }
        }
        catch (Exception ex)
        {
            // Response.Write(ex.Message + "Get Bed No.")
        }
        return bed_id;
    }
    protected void Insert_Assign_Bed()
    {
        try
        {
            if (DropDownListFloor.SelectedItem.Text == "All")
            {
                Javascript("Must Select Floor");
                return;
            }
            else
            {
                if (CheckBoxListRoom.Visible == true)
                {
                    if (CheckBoxListRoom.Items.Count > 0)
                    {
                        bool Flag_room = false;
                        for (int i = 0; i < CheckBoxListRoom.Items.Count; i++)
                        {
                            if (CheckBoxListRoom.Items[i].Selected == true)
                            {
                                Flag_room = true;
                            }
                        }
                        if (Flag_room == false)
                        {
                            Javascript("Must Select Room");
                            return;
                        }
                    }
                }
                else
                {
                    bool flag = false;
                    for (int i = 0; i < RadioButtonListBeds.Items.Count; i++)
                    {
                        if (RadioButtonListBeds.Items[i].Selected == true)
                        {
                            flag = true;
                        }
                    }
                    if (flag == false)
                    {

                        Javascript("Must Select Bed");
                        return;
                    }
                }

            }
        }
        catch (Exception ex)
        {

        }

        try
        {

            if (Label1.Text == "Room")
            {
                for (int i = 0; i < CheckBoxListRoom.Items.Count; i++)
                {
                    if (CheckBoxListRoom.Items[i].Selected == true)
                    {
                        HiddenFieldBedID.Value = Get_Bed_Id(Convert.ToString(CheckBoxListRoom.Items[i].Text), Convert.ToInt32(CheckBoxListRoom.Items[i].Value)).ToString();

                        HiddenFieldWard_Id.Value = CheckBoxListRoom.Items[i].Value;
                        insert_bed(Convert.ToInt32(HiddenFieldWard_Id.Value), Convert.ToInt32(HiddenFieldBedID.Value));
                        SqlDataSource_Update.Update();
                        SqlDataSource_Insert.Update();
                        int bed_roomSharges = bed_room_Charges(Convert.ToInt32(HiddenFieldBedID.Value), Convert.ToInt32(CheckBoxListRoom.Items[i].Value));
                        HiddenFieldBedRoomCharges.Value = bed_roomSharges.ToString();
                        get_subdept_id();
                        get_subdept_id_Ward();

                    }
                }
                SqlDataSource_Insert.Insert();
                SqlDataSourceUpdatePayment.Update();
            }
            else if (Label1.Text == "Bed")
            {
                if (Check_Bed_Assigned() > 0)
                {
                    Javascript("Only Single Bed Can Assigned");
                }
                else
                {

                    HiddenFieldBedID.Value = Get_Bed_Id(Convert.ToString(RadioButtonListBeds.SelectedItem.Text), Convert.ToInt32(DropDownListFloor.SelectedValue)).ToString();
                    HiddenFieldWard_Id.Value = DropDownListFloor.SelectedValue;
                    insert_bed(Convert.ToInt32(HiddenFieldWard_Id.Value), Convert.ToInt32(HiddenFieldBedID.Value));
                    SqlDataSource_Update.Update();
                    SqlDataSource_Insert.Update();
                    int bed_roomSharges = bed_room_Charges(Convert.ToInt32(HiddenFieldBedID.Value), Convert.ToInt32(DropDownListFloor.SelectedValue));
                    HiddenFieldBedRoomCharges.Value = bed_roomSharges.ToString();
                    get_subdept_id();
                    get_subdept_id_Ward();
                    SqlDataSourceUpdatePayment.Update();
                    SqlDataSource_Insert.Insert();
                }
            }
            DataTable dt3 = Fill_Grid(Convert.ToInt32(DropDownListFloor.SelectedValue));
            GridView2.DataSource = dt3;//.Tables["EmptyBeds"];
            GridView2.DataBind();
            CheckBoxListRoom.DataBind();
            RadioButtonListBeds.DataBind();
            Label_script.Text = "<script language ='javascript' type ='text/javascript'>if(window.confirm('Do You Want To assign more Room ?  \\n Press OK for continue and Cancel for stop'));</script>";
        }
        catch (Exception ex)
        {

        }
    
    }
    
public int bed_room_Charges(int bed_id, int ward_id)
{
		int charges = 0;
		SqlConnection con = new SqlConnection(constr);
		try
		{
			SqlCommand command = new SqlCommand("SELECT Bed_Fee FROM Ward_Beds where Bed_id=@Bed_id and ward_Id=@ward_Id", con);
			command.CommandType = CommandType.Text;
			command.Parameters.AddWithValue("@Bed_id", bed_id);
			command.Parameters.AddWithValue("@ward_Id", ward_id);
			con.Open();
			SqlDataReader reader = command.ExecuteReader();
			while (reader.Read())
			{
				charges = Convert.ToInt32(reader[0].ToString());
			}
		}
		catch (Exception ex)
		{
			//  Response.Write(ex.Message)
		}
		finally
		{
			con.Close();
		}
		//Response.Write(CStr(charges) & " dsfdsffsd  ")
		return charges;
	}
    public void get_subdept_id()
   {
		try
		{
			string constr = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ToString();
			SqlConnection con = new SqlConnection(constr);
			con.Open();
			SqlCommand command = new SqlCommand("SELECT TOP (1) to_sub_Dept FROM  Forward_To_Sub_Dept WHERE (Reg_No = @reg_no) AND (yearly_no = @Yearly_no) order by forward_date desc", con);
			command.CommandType = CommandType.Text;
			command.Parameters.AddWithValue("@reg_no", Session["RegistrationNo"]);
			command.Parameters.AddWithValue("@Yearly_no", Session["YearlyNo"]);
			SqlDataReader reader = command.ExecuteReader();
			if (reader.Read())
			{
				HiddenFieldSubDepartment.Value = reader[0].ToString();
			}
			con.Close();
		}
		catch (Exception ex)
		{
			//Response.Write(ex.Message)
		}
	}

	public void get_subdept_id_Ward()
	{
		try
		{
			//Dim constr As String = ConfigurationManager.ConnectionStrings(constr).ConnectionString
			SqlConnection con = new SqlConnection(constr);
			con.Open();
			SqlCommand command = new SqlCommand("SELECT distinct SubDept_Id FROM admin_Hospital_Wards WHERE (Ward_id = @Ward_id)", con);
			command.CommandType = CommandType.Text;
			command.Parameters.AddWithValue("@Ward_id", DropDownListFloor.SelectedValue);
			SqlDataReader reader = command.ExecuteReader();
			if (reader.Read())
			{
				HiddenFieldWard_SubDept_ID.Value = reader[0].ToString();
			}
			con.Close();
		}
		catch (Exception ex)
		{
			// Response.Write(ex.Message)
		}
	}

    public void InsertBedCharges(Int32 bed_Id)
    {
        Insert_patient_Billing pt_bill = new Insert_patient_Billing();
        long S_Id = 0;
        S_Id = pt_bill.get_BedService_Id(bed_Id);
        if (S_Id!=0 )
        {
            pt_bill.Insert_Service(Convert.ToString(Session["registrationNo"]), Convert.ToInt64(Session["YearlyNo"]), Convert.ToInt32(Session["Emp_Id"]),Convert.ToInt32( S_Id), 1, Convert.ToInt32(ddlPatientSubDepartment.SelectedValue), Convert.ToInt32(ddlPatientDepartment.SelectedValue));
        }
            	
       
    }



    public int Check_Bed_Assigned()
	{
		int count = 0;
		SqlConnection con = new SqlConnection(constr);
		SqlCommand Command = new SqlCommand("select Count(*) from Pt_Assign_Bed where FloorID in(SELECT  distinct SubDepartment.SubDept_Id FROM SubDepartment INNER JOIN admin_Hospital_Wards ON SubDepartment.SubDept_Id = admin_Hospital_Wards.SubDept_Id where admin_Hospital_Wards.Category='Bed' and SubDepartment.SubDept_Id not in (85,87)) and Reg_No=@Reg_No and Yearly_No=@Yearly_No and PT_Status=0", con);
		Command.CommandType = CommandType.Text;
		Command.Parameters.AddWithValue("@Reg_No", Session["registrationNo"]);
		Command.Parameters.AddWithValue("@Yearly_No", Convert.ToInt32(Session["YearlyNo"]));
		con.Open();
		SqlDataReader reader = Command.ExecuteReader();
		while (reader.Read())
		{
			count = Convert.ToInt32(reader[0]);
		}
		return count;
	}
    
    public void insert_bed(int ward_id, int bed_id)
{
		try
		{
			try
			{


				SqlConnection con_ins = new SqlConnection(constr);
				SqlCommand command_inser = new SqlCommand("insert_Patient_Assign_Bed", con_ins);
				command_inser.CommandType = CommandType.StoredProcedure;
				con_ins.Open();
				command_inser.Parameters.AddWithValue("@Ward_id", ward_id);
				command_inser.Parameters.AddWithValue("@Bed_id", bed_id);
				command_inser.Parameters.AddWithValue("@admission_By", Convert.ToInt32(Session["Emp_Id"]));
				command_inser.Parameters.AddWithValue("@Reg_No", Session["registrationNo"]);
                command_inser.Parameters.AddWithValue("@Patient_type", Request.QueryString["PType"]);
				command_inser.Parameters.AddWithValue("@Yearly_No", Convert.ToInt32(Session["YearlyNo"]));
				command_inser.Parameters.AddWithValue("@FloorID", Convert.ToInt32(DropDownListFloor.SelectedValue));
				command_inser.ExecuteNonQuery();
				con_ins.Close();
                //=================================

                //===Bed Charges ==========
                InsertBedCharges(bed_id);
			}
			catch (Exception ex)
			{

			}

		}
		catch (Exception ex)
		{

		}
	}
       public DataTable Fill_Grid(int SubDept_id)
   {
		DataTable dt2 = new DataTable();
		try
		{
			Patient_Bed_AssignedTableAdapters.FillBedsTableAdapter da = new Patient_Bed_AssignedTableAdapters.FillBedsTableAdapter();
			Patient_Bed_Assigned ds = new Patient_Bed_Assigned();
			da.Fill(ds.FillBeds, Convert.ToInt32(SubDept_id));
			Patient_Bed_AssignedTableAdapters.EmptyBedsTableAdapter da1 = new Patient_Bed_AssignedTableAdapters.EmptyBedsTableAdapter();
            da1.Fill(ds.EmptyBeds, Convert.ToInt32(SubDept_id));
            for (int i = 0; i < ds.EmptyBeds.Rows.Count; i++)
			{
                for (int j = 0; j < ds.FillBeds.Rows.Count; j++)
				{
					if (ds.FillBeds.Rows[j]["Ward_id"].ToString() == ds.EmptyBeds.Rows[i]["Ward_id"].ToString() && ds.FillBeds.Rows[j]["Bed_id"].ToString() == ds.EmptyBeds.Rows[i]["Bed_id"].ToString())
					{
						ds.EmptyBeds.Rows[i]["Prefix"] = ds.FillBeds.Rows[j]["Prefix"];
						ds.EmptyBeds.Rows[i]["PFName"] = ds.FillBeds.Rows[j]["PFName"];
						ds.EmptyBeds.Rows[i]["PMName"] = ds.FillBeds.Rows[j]["PMName"];
                        ds.EmptyBeds.Rows[i]["PLName"] = ds.FillBeds.Rows[j]["PLName"];
						ds.EmptyBeds.Rows[i]["SubDept_Name"] = ds.FillBeds.Rows[j]["SubDept_Name"];
                        ds.EmptyBeds.Rows[i]["Addmission_Date"] = ds.FillBeds.Rows[j]["Addmission Date"];
                        ds.EmptyBeds.Rows[i]["Age"] = ds.FillBeds.Rows[j]["Age"];
                        ds.EmptyBeds.Rows[i]["Relation_Name"] = ds.FillBeds.Rows[j]["Relation Name"];
                        ds.EmptyBeds.Rows[i]["Bed_Status"] = ds.FillBeds.Rows[j]["Bed_Status"];
                        ds.EmptyBeds.Rows[i]["Datedifference"] = ds.FillBeds.Rows[j]["Datedifference"];
                        ds.EmptyBeds.Rows[i]["Gender"] = ds.FillBeds.Rows[j]["Gender"];
                        ds.EmptyBeds.Rows[i]["Consultant_Name"] = ds.FillBeds.Rows[j]["Consultant Name"];
                        ds.EmptyBeds.Rows[i]["Indoor_No"] = ds.FillBeds.Rows[j]["Indoor_No"];
					}
				}
			}
            dt2 = ds.EmptyBeds;
		}
		catch (Exception ex)
		{
			//Response.Write(ex.Message)
		}
		return dt2;
	}
    //public DataSet Fill_Grid_All()
    //{
    //    //DataSet ds2 = new DataSet();
    //    //try
    //    //{
    //    //    Patient_Bed_AssignedTableAdapters.FillBedsTableAdapter da = new Patient_Bed_AssignedTableAdapters.FillBedsTableAdapter();
    //    //    Patient_Bed_Assigned ds = new Patient_Bed_Assigned();
    //    //    da.FillBySubDept(dsFillBeds, Session("dept_id"));
    //    //    Patient_Bed_AssignedTableAdapters.EmptyBedsTableAdapter da1 = new Patient_Bed_AssignedTableAdapters.EmptyBedsTableAdapter();
    //    //    da1.FillBySubDept(ds.EmptyBeds, Session("dept_id"));
    //    //    for (int i = 0; i < ds.Tables("EmptyBeds").Rows.Count; i++)
    //    //    {
    //    //        for (int j = 0; j < ds.Tables("FillBeds").Rows.Count; j++)
    //    //        {
    //    //            if (ds.Tables("FillBeds").Rows[j]["Ward_id"] == ds.Tables("EmptyBeds").Rows[i]["Ward_id"] && ds.Tables("FillBeds").Rows[j]["Bed_id"] == ds.Tables("EmptyBeds").Rows[i]["Bed_id"])
    //    //            {
    //    //                ds.Tables("EmptyBeds").Rows[i]["Prefix"] = ds.Tables("FillBeds").Rows[j]["Prefix"];
    //    //                ds.Tables("EmptyBeds").Rows[i]["PFName"] = ds.Tables("FillBeds").Rows[j]["PFName"];
    //    //                ds.Tables("EmptyBeds").Rows[i]["PMName"] = ds.Tables("FillBeds").Rows[j]["PMName"];
    //    //                ds.Tables("EmptyBeds").Rows[i]["PLName"] = ds.Tables("FillBeds").Rows[j]["PLName"];
    //    //                ds.Tables("EmptyBeds").Rows[i]["SubDept_Name"] = ds.Tables("FillBeds").Rows[j]["SubDept_Name"];
    //    //                ds.Tables("EmptyBeds").Rows[i].Item("Addmission Date") = ds.Tables("FillBeds").Rows[j].Item("Addmission Date");
    //    //                ds.Tables("EmptyBeds").Rows[i]["Age"] = ds.Tables("FillBeds").Rows[j]["Age"];
    //    //                ds.Tables("EmptyBeds").Rows[i].Item("Relation Name") = ds.Tables("FillBeds").Rows[j].Item("Relation Name");
    //    //                ds.Tables("EmptyBeds").Rows[i]["Bed_Status"] = ds.Tables("FillBeds").Rows[j]["Bed_Status"];
    //    //                ds.Tables("EmptyBeds").Rows[i]["Datedifference"] = ds.Tables("FillBeds").Rows[j]["Datedifference"];
    //    //                ds.Tables("EmptyBeds").Rows[i]["Gender"] = ds.Tables("FillBeds").Rows[j]["Gender"];
    //    //                ds.Tables("EmptyBeds").Rows[i].Item("Consultant Name") = ds.Tables("FillBeds").Rows[j].Item("Consultant Name");
    //    //                ds.Tables("EmptyBeds").Rows[i]["Indoor_No"] = ds.Tables("FillBeds").Rows[j]["Indoor_No"];
    //    //            }
    //    //        }
    //    //    }
    //    //    ds2 = ds;
    //    //}
    //    //catch (Exception ex)
    //    //{
    //    //    //Response.Write(ex.Message)
    //    //}
    //    //return ds2;
    //}
    protected void GridView2_PreRender(object sender, EventArgs e)
    {
        try
        {
            if (GridView2.Rows.Count != 0)
            {
                GridView2.HeaderRow.Cells[5].Text = "Patient Name";
                GridView2.HeaderRow.Cells[6].Visible = false;
                GridView2.HeaderRow.Cells[7].Visible = false;
                GridView2.HeaderRow.Cells[8].Visible = false;
                for (int i = 0; i < GridView2.Rows.Count; i++)
                {
                    GridView2.Rows[i].Cells[5].Text = GridView2.Rows[i].Cells[5].Text + " " + enc.Encrypt_Main(GridView2.Rows[i].Cells[6].Text, false) + " " + enc.Encrypt_Main(GridView2.Rows[i].Cells[7].Text, false); // & " " & GridView2.Rows(i).Cells(7).Text
                    GridView2.Rows[i].Cells[6].Visible = false;
                    GridView2.Rows[i].Cells[7].Visible = false;
                    GridView2.Rows[i].Cells[8].Visible = false;
                }
                for (int i = 0; i < GridView2.Rows.Count; i++)
                {
                    if (GridView2.Rows[i].Cells[5].Text.Trim().Length > 6)
                    {
                        GridView2.Rows[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#f4efd0");
                        //GridView2.Rows(i).BackColor = Drawing.Color.GreenYellow
                    }
                    else
                    {
                        GridView2.Rows[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#ffe4fc");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Response.Write(ex.Message)
        }
    }



    protected void DropDownListFloor_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dt3 = Fill_Grid(Convert.ToInt32(DropDownListFloor.SelectedValue));
        GridView2.DataSource = dt3;//.Tables["EmptyBeds"];
        GridView2.DataBind();
    }
    protected void SetWardSetting() {
        SqlConnection con = new SqlConnection(constr);
        SqlCommand command = new SqlCommand("SELECT distinct Category FROM admin_Hospital_Wards where Ward_id=@Ward_id", con);
        command.CommandType = CommandType.Text;
        command.Parameters.AddWithValue("@Ward_id", DropDownListFloor.SelectedValue);
        con.Open();
        SqlDataReader reader = command.ExecuteReader();
        while (reader.Read())
        {
            Label1.Text = reader[0].ToString();
        }
        //floor = Label1.Text + " :";
        con.Close();
        if (Label1.Text == "Room")
        {
            RadioButtonListBeds.Visible = false;
            CheckBoxListRoom.Visible = true;
            CheckBoxListRoom.DataBind();
        }
        else if (Label1.Text == "Bed")
        {
            CheckBoxListRoom.Visible = false;
            RadioButtonListBeds.Visible = true;
            RadioButtonListBeds.DataBind();
            // Response.Write(RadioButtonListBeds.SelectedValue)
        }
    
    }
}
