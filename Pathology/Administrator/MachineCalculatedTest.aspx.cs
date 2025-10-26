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

    String Midwareconnstr = ConfigurationManager.ConnectionStrings["MidwareCloud_LISConnectionString"].ToString();
    String connstr = ConfigurationManager.ConnectionStrings["Admin_Path_ConnStr"].ToString();
    string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    SqlCommand cmd = new SqlCommand();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadMachine();
            //loadTestComponent();
   
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
    private void loadParentComponent()
    {
        //int MachineID = Convert.ToInt32(ddlMachine.SelectedValue); 
        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {

            cmd = new SqlCommand("Sp_GetComponentMachineWise", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MachineID", SqlDbType.Int).Value = ddlMachine.SelectedItem.Value;
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddParentComponent.DataSource = dt;
            ddParentComponent.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }
    private void loadChildComponent()
    {
        //int MachineID = Convert.ToInt32(ddlMachine.SelectedValue); 
        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {

            cmd = new SqlCommand("Sp_GetComponentMachineWise", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@MachineID", SqlDbType.Int).Value = ddlMachine.SelectedItem.Value;
            con.Open();
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
    private void loadTestComponent()
    {

        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("Select 0 TCID,'----- Select Test Component -----'ComponentName UNION Select TCID,ComponentName From TestComponent where ComponentName != '' Order By ComponentName", con);
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
        loadParentComponent();
        loadChildComponent();
        FillGrid();
    }
    protected void FillGrid()
    {
        //ddlEmployee.Items.Clear();

        SqlConnection con = new SqlConnection(Midwareconnstr);

        cmd = new SqlCommand("GetAllCalculatedComponentData", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@MachineID", SqlDbType.Int).Value = ddlMachine.SelectedItem.Value;
        cmd.Parameters.Add("@IsActive", SqlDbType.Bit).Value = true;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet dt = new DataSet();
        da.Fill(dt);
        //DataTable dt = new DataTable();
        //da.Fill(dt);
        grdcode.DataSource = dt;
        grdcode.DataBind();
 


        con.Close();
    }
    protected void SaveData()
    {
        try
        {

            bool isActive = true;
            int MachineID = Convert.ToInt32(ddlMachine.SelectedValue);
            int ParentTCID = Convert.ToInt32(ddParentComponent.SelectedValue);
            int ChildTCID = Convert.ToInt32(ddTestComponent.SelectedValue);

            SqlConnection connections = new SqlConnection(Midwareconnstr);
            string query = "INSERT INTO MachineCalculatedTest(MachineID,ParentComponent, ChildComponent, IsActive) VALUES (@Machine_Id,@ParentTCID,@ChildTCID,@IsActive)";
            using (SqlCommand command = new SqlCommand(query, connections))
            {
                command.Parameters.Add("@Machine_Id", SqlDbType.Int).Value = MachineID;
                command.Parameters.Add("@ParentTCID", SqlDbType.Int).Value = ParentTCID;
                command.Parameters.Add("@ChildTCID", SqlDbType.Int).Value = ChildTCID;
                command.Parameters.Add("@IsActive", SqlDbType.Int).Value = isActive;

                connections.Open();
                int rowAffected = command.ExecuteNonQuery();
                if (rowAffected != 0)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Inserted Successfully')", true);
                    //this.grdcode.SelectedRow.Visible = false;
                }
             
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
            int MachineID = Convert.ToInt32(grdcode.Rows[row].Cells[1].Text);
            string PC = grdcode.Rows[row].Cells[2].Text;
            int Parent_Component = Convert.ToInt32(grdcode.Rows[row].Cells[3].Text);
            string ChildC = grdcode.Rows[row].Cells[4].Text;
            int ChildCID = Convert.ToInt32(grdcode.Rows[row].Cells[5].Text);
            bool IsActive = true;
  


            //int MachineID = Convert.ToInt32(ddlMachine.SelectedValue);
            //int TCID = Convert.ToInt32(ddTestComponent.SelectedValue);

            SqlConnection conn = new SqlConnection(Midwareconnstr);
            string sql = "Update [MachineCalculatedTest] Set IsActive = '" + 0 + "' Where ParentComponent='" + Parent_Component + "'AND MachineID='" + MachineID + "'AND ChildComponent='" + ChildCID + "'AND IsActive='" + IsActive + "'";

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
       
        bool isActive = true;
        int MachineID = Convert.ToInt32(ddlMachine.SelectedValue);
        int ParentTCID = Convert.ToInt32(ddParentComponent.SelectedValue);
        int ChildTCID = Convert.ToInt32(ddTestComponent.SelectedValue);

        SqlConnection conn = new SqlConnection(Midwareconnstr);
        SqlCommand check_Component = new SqlCommand("SELECT COUNT(*) FROM [MachineCalculatedTest] Where ([MachineID]=@MachineID AND [ParentComponent]=@ParentComponent AND [ChildComponent] = @ChildComponent AND [IsActive] = @IsActive)", conn);
        check_Component.Parameters.AddWithValue("@MachineID", MachineID);
        check_Component.Parameters.AddWithValue("@ParentComponent", ParentTCID);
        check_Component.Parameters.AddWithValue("@ChildComponent", ChildTCID);
        check_Component.Parameters.AddWithValue("@IsActive", isActive);
        conn.Open();
        int UserExist = (int)check_Component.ExecuteScalar();

        if (UserExist > 0)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Already Exists')", true);
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