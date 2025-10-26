using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

public partial class RequisitionWaitingList : System.Web.UI.Page
{
    String constr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
    protected void validate(string url, string dept)
    {

        if (Session["emp_id"] == null || Session["SubDeptid"] == null)
        {
            Response.Redirect("../login.aspx");
        }
    }
        
    protected void Page_Load(object sender, EventArgs e)
    {
        //validate("", "");
        if (!Page.IsPostBack)
        {
            WebDateChooser_date_From.Value = DateTime.Today.AddDays(-30);
            WebDateChooser_date_To.Value = DateTime.Today;
            ddlFromDepartment.DataBind();
            ddlToDepartment.DataBind();
            ddlFromDepartment.SelectedValue = Session["SubDeptid"].ToString();
            ddlToDepartment.SelectedValue = "0";
            hfld_From_Date.Value = WebDateChooser_date_From.Value.ToString();
            hfld_FromSubDept_Id.Value = ddlFromDepartment.SelectedValue;
            hfld_IndentBookNo.Value = "%" + txtIdentBookNo.Text + "%";
            hfld_To_Date.Value = WebDateChooser_date_To.Value.ToString();
            hfld_ToSubDept_Id.Value = ddlToDepartment.SelectedValue;
            //GridView2.DataBind();
        }
        HiddenField_dept_ID.Value = Session["SubDeptid"].ToString();
       
    }
    protected void GridView2_PreRender(object sender, EventArgs e)
    {
        lblRecords.Text = GridView2.Rows.Count.ToString();
        //int count;
        //SqlConnection con = new SqlConnection(constr);
        //con.Open();
        //for (int i = 0; i < GridView2.Rows.Count; i++)
        //{
        //    SqlCommand command = new SqlCommand("Select_IB_Alert", con);
        //    command.CommandType = CommandType.StoredProcedure;
        //    command.Parameters.AddWithValue("@IB_ID", GridView2.Rows[i].Cells[0].Text);
        //    command.Parameters.Add("@count", SqlDbType.Int);
        //    command.Parameters["@count"].Direction = ParameterDirection.Output;
        //    command.ExecuteNonQuery();
        //    count = (int)command.Parameters["@count"].Value;
        //    if (count > 0)
        //    {
        //        GridView2.Rows[i].BackColor = System.Drawing.ColorTranslator.FromHtml("#f6e1c5");//Color.RosyBrown;
        //    }
        //}
    }

    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        
       // Response.Write(GridView2.SelectedValue.ToString());
        Response.Redirect("Requsition_Report.aspx?RequsitionNo=" + GridView2.SelectedValue.ToString());
    }

    protected void SqlDataSource_List_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }

    protected void Lb_Remarks_Click(object sender, EventArgs e)
    {
        LinkButton lbl = (LinkButton)sender;
        HF_Re_ID.Value = lbl.CommandArgument;
        Lbl_Requisition_No.Text = HF_Re_ID.Value;
        TextBox_Remarks.Text = string.Empty;
        Label.Text = string.Empty;
        DataView remarks = Sql_Remarks.Select(DataSourceSelectArguments.Empty) as DataView;
        if(remarks.Table.Rows[0][0] != DBNull.Value)
        {
            TextBox_Remarks.Text = remarks.Table.Rows[0][0].ToString();
        }
        Panel_Remarks.Visible = true;
            
    }

    protected void btn_Save_Click(object sender, EventArgs e)
    {
        
            Lbl_Requisition_No.Text = HF_Re_ID.Value;
            Sql_Remarks.Update();
            Label.Text = "Remarks Add successfully";
            TextBox_Remarks.Text = "";
            Panel_Remarks.Visible = false;
    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Panel_Remarks.Visible = false;
    }

    protected void btnSearchRequisitions_Click(object sender, EventArgs e)
    {
        hfld_From_Date.Value = WebDateChooser_date_From.Value.ToString();
        hfld_FromSubDept_Id.Value = ddlFromDepartment.SelectedValue;
        hfld_IndentBookNo.Value = "%" + txtIdentBookNo.Text + "%";
        hfld_To_Date.Value = WebDateChooser_date_To.Value.ToString();
        hfld_ToSubDept_Id.Value = ddlToDepartment.SelectedValue;
        GridView2.DataBind();
    }
}
