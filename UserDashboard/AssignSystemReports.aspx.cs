using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;

public partial class DashBoards_AssignSystemReports : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BasicDataInfoConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            loadData();
            bindEmployees();
            bindGride();
            
        }
    }
    private void loadData()
    {
        con.Open();
        SqlCommand cmd = new SqlCommand("select SubDept_Name,SubDept_Id from SubDepartment Where SubDept_Name Not like '%Library%' and SubDept_Name Not like '%Damage%' and SubDept_Name Not like '%Expired%'", con);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddle1.DataSource = ds;
        ddle1.DataValueField = "SubDept_Id";
        ddle1.DataTextField = "SubDept_Name";
        ddle1.DataBind();
        con.Close();
    }




    protected void bindGride()
    {
        SqlCommand cmd = new SqlCommand("select distinct  Module_Name from System_Reports  ", con);

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataTable dt = new DataTable();

        da.Fill(dt);

        DataList1.DataSource = dt;
        DataList1.DataBind();

    }

    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        //if (e.Item.ItemType==ListItemType.Item)
        //{

        string ModuleID = ((HiddenField)e.Item.FindControl("hfModuleID")).Value;
        DataList dlist = (DataList)e.Item.FindControl("data");

        SqlCommand cmd = new SqlCommand("uspGetSystemReportstoAssign", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Module_Name", ModuleID);
        cmd.Parameters.AddWithValue("@Emp_ID", ddle2.SelectedValue);
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataTable dt = new DataTable();

        da.Fill(dt);

        dlist.DataSource = dt;
        dlist.DataBind();
        //}
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

        // CheckBox chkbox = sender as CheckBox;

        //  CheckBox chkbox_All = FindControl("chkboxOne") as CheckBox;

        foreach (DataListItem item in DataList1.Items)
        {
            DataList dataItems = (DataList)item.FindControl("data");
            foreach (DataListItem inItem in dataItems.Items)
            {
                CheckBox chk = (CheckBox)inItem.FindControl("chkboxOne");
                HiddenField hdfRole = inItem.FindControl("hfRoleID") as HiddenField;
                HiddenField status = inItem.FindControl("hfStatus") as HiddenField;
                if (chk.Checked && status.Value=="false")
                {
                    insertData(Convert.ToInt32(hdfRole.Value));
                }
            }
        }
        lblMsg.Visible = true;
        bindGride();
        loadData();
        bindEmployees();

    }


    protected void bindEmployees()
    {
        con.Open();

        string query = "select isnull(EFName,'')+' '+ISNULL(EMName,'')+' '+ISNULL(ELName,'') as name,EmpID ID from Employee WHERE  SubDeptId='" + ddle1.SelectedValue.ToString() + "'";

        SqlCommand cmd = new SqlCommand(query, con);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddle2.DataSource = ds;
        ddle2.DataValueField = "ID";
        ddle2.DataTextField = "name";
        ddle2.DataBind();
        con.Close();
    }

  
    protected void ddle1_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindEmployees();
        bindGride();
    }
    protected void insertData(int roleId)
    {
        con.Open();

        SqlCommand cmd = new SqlCommand("uspAssignReports", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Emp_ID", ddle2.SelectedValue);
        cmd.Parameters.AddWithValue("@Role_ID", roleId);
        cmd.ExecuteNonQuery();
        con.Close();
    }

    protected void data_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        foreach (DataListItem item in DataList1.Items)
        {
            DataList dataItems = (DataList)item.FindControl("data");
            foreach (DataListItem inItem in dataItems.Items)
            {
                CheckBox chk = (CheckBox)inItem.FindControl("chkboxOne");
                HiddenField status = inItem.FindControl("hfStatus") as HiddenField;
                if (status.Value=="true")
                {
                    chk.Checked = true;
                }
                else
                {
                    chk.Checked = false;
                }
            }
        }
    }

    protected void ddle2_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        bindGride();
    }
}