using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.IO;
public partial class DashBoards_Lab_DB_Category_Collection_Summary : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);

    double totalservices = 0;
    double totalAmount = 0;
    double totalDiscount = 0;
    double totalRFAmount = 0;
    double totalservicesrefund = 0;
    double totalNetIncome = 0;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            FillHospital();
            
            ddl_Hospital.SelectedValue = Session["HospitalId"].ToString();
            txtDateFrom.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtDateTo.Text = DateTime.Now.ToString("yyyy-MM-dd");

            txtTimeFrom.Text = DateTime.Now.AddHours(-1).ToString("hh:mm");
            txtTimeTo.Text = DateTime.Now.ToString("hh:mm");
            LoadCategoryWiseCollection();
            
        }
    }
    protected void LoadCategoryWiseCollection()
    {


        DateTime sDate = Convert.ToDateTime(txtDateFrom.Text);
        DateTime eDate = Convert.ToDateTime(txtDateTo.Text);
        con.Open();
        SqlCommand cmd = new SqlCommand("usp_get_Category_ColSummary_By_Cat", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@startDate",sDate);
        cmd.Parameters.AddWithValue("@endDate", eDate);
        cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);
        cmd.Parameters.AddWithValue("@HospitalID", ddl_Hospital.SelectedValue);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable ds = new DataTable();
        da.Fill(ds);
        DataView dv = new DataView(ds);
        dv.Sort="Category asc";
        ds = dv.ToTable();
        gvCategoryCollection.DataSource = ds;
        gvCategoryCollection.DataBind();
        con.Close();
        if (gvCategoryCollection.Rows.Count > 0)
        {
            btnExportToExcel.Visible = true;
        }
        else
        {
            btnExportToExcel.Visible = false;
        }
        
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        LoadCategoryWiseCollection();
       
    }
    protected void gvCategoryCollection_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Control ctrl = e.CommandSource as Control;
        if (ctrl != null)
        {
            GridViewRow gvRow = ctrl.Parent.NamingContainer as GridViewRow;
            

            if (e.CommandName == "ViewDetails")
            {
                HiddenField hdnServiceCategoryId = (HiddenField)gvRow.FindControl("hdnServiceCategoryId"); 
                LinkButton lb = (LinkButton)gvRow.FindControl("lnkViewDetails");
                string dateFrom = Convert.ToDateTime(txtDateFrom.Text).ToString("MM/dd/yyyy");
                string dateTo = Convert.ToDateTime(txtDateTo.Text).ToString("MM/dd/yyyy");
                DateTime sDate = Convert.ToDateTime(txtDateFrom.Text) + TimeSpan.Parse(txtTimeFrom.Text);
                DateTime eDate = Convert.ToDateTime(txtDateTo.Text) + TimeSpan.Parse(txtTimeTo.Text);
            

                Response.Redirect("~/Patient Billing/ServiceCategoryWiseCashDetail.aspx?CId=" + hdnServiceCategoryId.Value + "&DateFrom=" + sDate + "&DateTo=" + eDate + "&CatName=" + lb.Text + "&Type=" + ddlType.SelectedValue +"&HospitalID="+ ddl_Hospital.SelectedValue);
            }
        }           
    }
    protected void FillHospital()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))
        {
            SqlCommand command = new SqlCommand("SELECT    Hospital_ID, Hospital_Name FROM  Hospital ", con);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddl_Hospital.DataValueField = "Hospital_ID";
            ddl_Hospital.DataTextField = "Hospital_Name";
            ddl_Hospital.DataSource = dt;
            ddl_Hospital.DataBind();
        }
    }

    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        try
        {
            //gvCategoryCollection.Columns[6].Visible = false;
            gvCategoryCollection.Enabled = false;
            HtmlForm form = new HtmlForm();
            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.AddHeader("content-disposition", string.Format("attachment;filename={0}", "Doctor Wise Revenue.xls"));
            Response.ContentType = "application/ms-excel";
            StringWriter sw = new StringWriter();

            gvCategoryCollection.AllowPaging = false;

            HtmlTextWriter hw = new HtmlTextWriter(sw);
            hw.Write("Doctor Wise Revenue");
            hw.Write("<br>");
            form.Attributes["runat"] = "server";
            form.Controls.Add(gvCategoryCollection);
            this.Controls.Add(form);
            form.RenderControl(hw);
            string style = "<!--mce:2-->";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
            // gvStudents.Columns[1].Visible = true;


        }
        catch (Exception ex)
        {
        }
    }
    protected void gvCategoryCollection_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblServiceCategory = (Label)e.Row.FindControl("lblServiceCategory");
            Label lblTotalServices = (Label)e.Row.FindControl("lblTotalServices");
            Label lblDsicount = (Label)e.Row.FindControl("lblDsicount");
            Label lblRefundAmount = (Label)e.Row.FindControl("lblRefundAmount");
            Label lblTotalServiesRefund = (Label)e.Row.FindControl("lblTotalServiesRefund");
            Label lblPaid = (Label)e.Row.FindControl("lblPaid");

            totalAmount += Convert.ToDouble(lblServiceCategory.Text);
            if (lblDsicount.Text != "")
            {
                totalDiscount += Convert.ToDouble(lblDsicount.Text);
            }
            
                totalservices += Convert.ToDouble(lblTotalServices.Text);
                
                totalRFAmount += Convert.ToDouble(lblRefundAmount.Text);
                totalservicesrefund += Convert.ToDouble(lblTotalServiesRefund.Text);
                totalNetIncome += Convert.ToDouble(lblPaid.Text);
            
        }

        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotalServices = (Label)e.Row.FindControl("lblTotalServices_Footer");
            Label lblTotalAmount = (Label)e.Row.FindControl("lblTotalAmount");
            Label lblDis = (Label)e.Row.FindControl("lblDis");
            Label lblRfdAmount = (Label)e.Row.FindControl("lblRfdAmount_Footer");
            Label lblTotalServiesRefund = (Label)e.Row.FindControl("lblTotalServiesRefund_Footer");
            Label lblNetIncome = (Label)e.Row.FindControl("lblNetIncome");

            lblTotalServices.Text = totalservices.ToString();
            lblTotalAmount.Text= totalAmount.ToString();
            lblDis.Text= totalDiscount.ToString();
            lblRfdAmount.Text=totalRFAmount.ToString();
            lblTotalServiesRefund.Text = totalservicesrefund.ToString();
            lblNetIncome.Text = totalNetIncome.ToString();
            e.Row.BackColor = System.Drawing.Color.FromName("#80ff80"); 
        }
    }
}
