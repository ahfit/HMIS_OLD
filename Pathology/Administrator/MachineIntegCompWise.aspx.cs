using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Windows.Forms;

public partial class Pathology_LabTestSummaryReport : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["Admin_Path_ConnStr"].ToString();
    string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    SqlCommand cmd = new SqlCommand();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadMachine();
            loadTestComponent();
   
        }
    }
    private void loadMachine()
    {

        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("Select 0 Machine_Id, '----- Select Machine -----' Machine_Name UNION Select Machine_Id,Machine_Name From Lab_Machines  Order By Machine_Name", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlMachine.DataSource = dt;
            ddlMachine.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }
    private void loadTestComponent()
    {

        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("Select 0 TCID,'-- Select Test Component --'ComponentName UNION Select DISTINCT TCID, ComponentName + '-' + CAST(tcid AS VARCHAR)  From TestComponent where ComponentName != '' Order By ComponentName", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddTestComponent.DataSource = dt;
            ddTestComponent.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }

    protected void ddlMachine_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGrid();
    }
    protected void FillGrid()
    {
        //ddlEmployee.Items.Clear();

        SqlConnection con = new SqlConnection(connstr);

        cmd = new SqlCommand("Sp_GetTestComponentMachineWise", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@MachineID", SqlDbType.Int).Value = ddlMachine.SelectedItem.Value;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet dt = new DataSet();
        da.Fill(dt);
        //DataTable dt = new DataTable();
        //da.Fill(dt);
        grdcode.DataSource = dt;
        grdcode.DataBind();
        //if (dt.Rows.Count > 0)
        //{

        //    foreach (GridViewRow row in grdcode.Rows)
        //    {
        //        for (int i = 0; i < grdcode.Rows.Count -1; i++)
        //        {

        //            System.Web.UI.WebControls.TextBox txtQty = row.FindControl("testComponent") as System.Web.UI.WebControls.TextBox;
        //            txtQty.ID = "testComponent" + (i).ToString();
        //            //System.Web.UI.WebControls.TextBox txtQty = grdcode.Rows[0].FindControl("ProductDetail");
        //            //dt.Rows[0]["FullName"].ToString();
        //            //txtQty.Text = row.FindControl("testComponent") as System.Web.UI.WebControls.TextBox;
        //            txtQty.Text = dt.Rows[i]["ComponentName"].ToString();
        //        }
        //        //txtQty.Text = dt.Rows[i]["ComponentName"].ToString();
        //    }
        //}


        con.Close();
    }
    protected void SaveData()
    {
        try
        {

            //int row = grdcode.SelectedRow.RowIndex;

            //System.Web.UI.WebControls.TextBox MCode = grdcode.Rows[row].FindControl("machineCode") as System.Web.UI.WebControls.TextBox;
            //System.Web.UI.WebControls.TextBox ANum = grdcode.Rows[row].FindControl("assayNum") as System.Web.UI.WebControls.TextBox;
            //string TestComponent = grdcode.Rows[row].Cells[0].Text;
            //string MachineCode = MCode.Text;
            //string AssayNo = ANum.Text;
            string MachineCode = machineCode.Text;
            string AssayNo = assayNumber.Text;
            int Active_Status = 1;
            //bool isActive = true;


            int MachineID = Convert.ToInt32(ddlMachine.SelectedValue);
            int TCID = Convert.ToInt32(ddTestComponent.SelectedValue);

            SqlConnection connections = new SqlConnection(connstr);
            string query = "INSERT INTO Lab_Machine_Tests (Component_Id,Machine_Id, Machine_Test_Code, Machine_Comp_Name,Active_Status) VALUES (@Component_Id, @Machine_Id, @AssayNo, @MachineCode,@Acive)";
            using (SqlCommand command = new SqlCommand(query, connections))
            {
                command.Parameters.Add("@Component_Id", SqlDbType.VarChar, 500).Value = TCID;
                command.Parameters.Add("@Machine_Id", SqlDbType.VarChar, 100).Value = MachineID;
                command.Parameters.Add("@AssayNo", SqlDbType.VarChar, 300).Value = AssayNo;
                command.Parameters.Add("@MachineCode", SqlDbType.VarChar, 300).Value = MachineCode;
                command.Parameters.Add("@Acive", SqlDbType.Int).Value = Active_Status;

                connections.Open();
                int rowAffected = command.ExecuteNonQuery();
                if (rowAffected != 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Inserted Successfully')", true);
                    //this.grdcode.SelectedRow.Visible = false;
                }
                machineCode.Text = "";
                assayNumber.Text = "";
                //this.grdcode.SelectedRow.Enabled = false;
                //int row2 = grdcode.SelectedRow.RowIndex;

                //grdcode.Rows.Remove(row2);
                //gvLoad.DataSource = dt;
                //gvLoad.DataBind();

            }



        }
        catch (Exception ex)
        {

        }
    }
    protected void grdcode_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            int row = grdcode.SelectedRow.RowIndex;

            //System.Web.UI.WebControls.TextBox MCode = grdcode.Rows[row].FindControl("machineCode") as System.Web.UI.WebControls.TextBox;
            //System.Web.UI.WebControls.TextBox ANum = grdcode.Rows[row].FindControl("assayNum") as System.Web.UI.WebControls.TextBox;
            string LabMachineID = grdcode.Rows[row].Cells[0].Text;
            int LMID = Convert.ToInt32(LabMachineID);
  


            int MachineID = Convert.ToInt32(ddlMachine.SelectedValue);
            int TCID = Convert.ToInt32(ddTestComponent.SelectedValue);

            SqlConnection conn = new SqlConnection(connstr);
            string sql = "Update [Lab_Machine_Tests] Set Active_Status = '" + 0 + "' Where Lab_M_Id='" + LMID + "'";

            conn.Open();
            SqlCommand cmd = new SqlCommand(sql, conn);
            int rowAffected = cmd.ExecuteNonQuery();
            if (rowAffected != 0)
            {
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Deleted Successfully')", true);
            }
            conn.Close();
            conn.Dispose();
          
            FillGrid();

        }
        catch (Exception ex)
        {

        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string MachineCode = machineCode.Text;
        string AssayNo = assayNumber.Text;
        int Active_Status = 1;
        //bool isActive = true;
        int MachineID = Convert.ToInt32(ddlMachine.SelectedValue);
        int TCID = Convert.ToInt32(ddTestComponent.SelectedValue);

        SqlConnection conn = new SqlConnection(connstr);
        SqlCommand check_Component = new SqlCommand("SELECT COUNT(*) FROM [Lab_Machine_Tests] Where ([Component_Id]=@TCID AND [Machine_Id]=@MachineID AND [Active_Status]=@status)", conn);
        check_Component.Parameters.AddWithValue("@TCID", TCID);
        check_Component.Parameters.AddWithValue("@MachineID", MachineID);
        check_Component.Parameters.AddWithValue("@status", Active_Status);
        conn.Open();
        int UserExist = (int)check_Component.ExecuteScalar();

        if (UserExist > 0)
        {
            //SaveData();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Component Already Exists')", true);
        }
        else
        {
            SaveData();
            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record not Exists')", true);
        }
        conn.Close();
        conn.Dispose();
        FillGrid();
    }
}