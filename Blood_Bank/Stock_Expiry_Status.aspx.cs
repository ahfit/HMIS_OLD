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
using Microsoft.Reporting.WebForms;

public partial class Blood_Bank_Stock_Expiry_Status : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BloodBank_ConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            
        {
            ReportViewer1.Visible =true;
            DropDownList_BG.DataBind();
            DropDownList_BG.Items.Insert(0, "-ALL BLOOD GROUPS-");
            DropDownList_BG.Items[0].Value = "0";

            DropDownList_COMP.DataBind();
            DropDownList_COMP.Items.Insert(0, "-ALL COMPONENT-");
            DropDownList_COMP.Items[0].Value = "0";
            string Component_Id="";
            string BGID = "";
            Component_Id =Convert.ToString(Request.QueryString["Component_Id"]);
            BGID = Convert.ToString(Request.QueryString["BGID"]);
            if (BGID != "")
            {
                DropDownList_BG.SelectedValue = BGID;
            }
            if (Component_Id != "")
            {
                DropDownList_COMP.SelectedValue = Component_Id;
            }
           
        }
    }

  
    protected void GridView_ExpiryStatus_PreRender(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView_ExpiryStatus.Rows.Count; i++)
        {
            HiddenField HiddenField_WL = (HiddenField)GridView_ExpiryStatus.Rows[i].FindControl("HiddenField_WL");
            Label Label1 = (Label)GridView_ExpiryStatus.Rows[i].FindControl("Label1");
            HiddenField HiddenField_CL = (HiddenField)GridView_ExpiryStatus.Rows[i].FindControl("HiddenField_CL");
            Label Label2 = (Label)GridView_ExpiryStatus.Rows[i].FindControl("Label2");
            Label Label_NA1 = (Label)GridView_ExpiryStatus.Rows[i].FindControl("Label_NA1");
            Label Label_NA2 = (Label)GridView_ExpiryStatus.Rows[i].FindControl("Label_NA2");

            Label Label_WHL = (Label)GridView_ExpiryStatus.Rows[i].FindControl("Label_WHL");
            Label Label_CHL = (Label)GridView_ExpiryStatus.Rows[i].FindControl("Label_CHL");
            HiddenField HiddenField_ExpDate = (HiddenField)GridView_ExpiryStatus.Rows[i].FindControl("HiddenField_ExpDate");
            if (HiddenField_WL.Value == "-1")
            {
                Label1.Text = "No Warning Level Set";
                Label_NA1.Visible = false;
                Label_WHL.Visible = false;
                //GridView_ExpiryStatus.Rows[i].ForeColor = System.Drawing.Color.LightSlateGray;
               // GridView_ExpiryStatus.Rows[i].Cells[10].ForeColor = System.Drawing.Color.Red;

            }
            else
            {

                double Hour = HoursLeft(HiddenField_ExpDate.Value);
                Label_WHL.Text = "Remaining Hour(s):" + Convert.ToString(Hour);
              if (Hour <= Convert.ToDouble(HiddenField_WL.Value))
              {
                 
                  GridView_ExpiryStatus.Rows[i].BackColor = System.Drawing.Color.Brown;

              }
              else
              {
                 // GridView_ExpiryStatus.Rows[i].BackColor = System.Drawing.Color.Pink;
              }
            }
            if (HiddenField_CL.Value == "-1")
            {
                Label2.Text = "No Critical Level Set";
                Label_NA2.Visible = false;
                Label_CHL.Visible = false;
                
                //GridView_ExpiryStatus.Rows[i].ForeColor = System.Drawing.Color.LightSlateGray;
                //GridView_ExpiryStatus.Rows[i].Cells[11].ForeColor = System.Drawing.Color.Red;
            }
            else
            {

                double Hour = HoursLeft(HiddenField_ExpDate.Value);
                Label_CHL.Text = "Remaining Hour(s):" + Convert.ToString(Hour);
                if (Hour <= Convert.ToDouble(HiddenField_CL.Value))
                {
                    
                    GridView_ExpiryStatus.Rows[i].BackColor = System.Drawing.Color.Red;

                }
                else
                {
                    //GridView_ExpiryStatus.Rows[i].ForeColor = System.Drawing.Color.Pink;
                }
            }

        }
    }

    private double HoursLeft(string LastDate)
    {
        DateTime L = Convert.ToDateTime(LastDate);
        TimeSpan T = L.Subtract(DateTime.Now);
        double _Hours = Convert.ToDouble(T.TotalHours);
        return _Hours;
    }
    protected void btnreport_Click(object sender, EventArgs e)
    {
        loadreport();
    }

    protected void loadreport()
    {

       con.Open();

        SqlCommand cmd = new SqlCommand("Stock_Expiry_Status_Optimize", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@BG",DropDownList_BG.Text);
        cmd.Parameters.AddWithValue("@Component_Name",DropDownList_COMP.Text);
        cmd.Parameters.AddWithValue("@Status", Request.QueryString["Status"].ToString());
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        da.Fill(dt);

        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = dt;
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("Blood_Stock_Expiry_Report.rdlc");
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
        ReportViewer1.LocalReport.Refresh();
        con.Close();
        if (Request.Browser.Browser == "Chrome")
        {
            Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            Response.ContentType = "application/pdf";
            Response.BinaryWrite(bytes);
            Response.End();
        }

        else
            ReportViewer1.Visible = true;

        GridView_ExpiryStatus.Visible = false;
    }

     public void subReports(object sender, SubreportProcessingEventArgs e)
    {
        try
        {
            e.DataSources.Clear();
            DataTable dt = (DataTable)Session["DynamicHeader"];
            e.DataSources.Add(new ReportDataSource("DataSet1", dt));
            e.DataSources.Add(new ReportDataSource("DataSetFooter", dt));
        }
        catch (Exception)
        {

        }


       

    }



    protected void lnkbtn_Dispose_Click(object sender, EventArgs e)
    {

        LinkButton btnDistpose = (LinkButton)sender;
        hfdDisposeID.Value = btnDistpose.CommandArgument;
        panelRemarks.Visible = true;
        

      //  btnSave.CommandArgument = btnConvert.CommandArgument;

      //  bindBloodComponent();
      //  LinkButton btnDistpose = (LinkButton)sender;
      //  con.Open();

      //  SqlCommand cmd = new SqlCommand("UPDATE Donor_Product_Formation SET Is_Disposed=1,Product_Formation_Status='Disposed' where Product_Formation_Id=@Product_Formation_Id", con);
      // /// cmd.CommandType = CommandType.StoredProcedure;
      //  cmd.Parameters.AddWithValue("@Product_Formation_Id", btnDistpose.CommandArgument);
      ////  con.Open();
      //  cmd.ExecuteNonQuery();
      //  con.Close();
      //  GridView_ExpiryStatus.DataBind();


    }
    protected void btnclose_Click(object sender, EventArgs e)
    {
        panel.Visible = false;
        lblsaveReason.Visible = false;
       

    }
  
    protected void lnkbtn_Conversion_Click(object sender, EventArgs e)
    {
        panel.Visible = true;
        LinkButton btnConvert = (LinkButton)sender;

        btnSave.CommandArgument = btnConvert.CommandArgument;

        bindBloodComponent();
    }

    private void bindBloodComponent()
    {
        string Component_Id = "";
        Component_Id = Convert.ToString(Request.QueryString["Component_Id"]);
        con.Open();
        try
        {
            SqlCommand command = new SqlCommand("Usp_GetConversion", con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@componentID", Component_Id);

            SqlDataAdapter dadapter = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            dadapter.Fill(dt);
            ddl_Component.DataSource = dt;
            ddl_Component.DataTextField = "Component_Name";
            ddl_Component.DataValueField = "Component_id";
            ddl_Component.DataBind();
            con.Close();
        }
        catch (Exception ex)
        {

            con.Close();
        }
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string Component_Id = "";
        Component_Id = Convert.ToString(Request.QueryString["Component_Id"]);
      
        con.Open();

        SqlCommand cmd = new SqlCommand("Usp_Update_BloodConversion", con);
         cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Product_Formation_Id", btnSave.CommandArgument);
        cmd.Parameters.AddWithValue("@Component_Id", ddl_Component.SelectedValue);
        cmd.Parameters.AddWithValue("@old_component_id", Component_Id);
        cmd.Parameters.AddWithValue("@new_component_id", ddl_Component.SelectedValue);
      //  cmd.Parameters.AddWithValue("@empid", );
        //  con.Open();
        cmd.ExecuteNonQuery();
        lblsaveReason.Visible = true;
        con.Close();
        GridView_ExpiryStatus.DataBind();


    }
    protected void Button1_Click(object sender, EventArgs e)
    {
         
         


        //  btnSave.CommandArgument = btnConvert.CommandArgument;

        //  bindBloodComponent();
        //  LinkButton btnDistpose = (LinkButton)sender;
        //  con.Open();

        SqlCommand cmd = new SqlCommand("UPDATE Donor_Product_Formation SET DisposedDate=GetDate(),DisposedBY=@empid, Is_Disposed=1,Product_Formation_Status='Disposed',DisposedReason=@reason where Product_Formation_Id=@Product_Formation_Id", con);
         /// cmd.CommandType = CommandType.StoredProcedure;
          cmd.Parameters.AddWithValue("@Product_Formation_Id", hfdDisposeID.Value);
          cmd.Parameters.AddWithValue("@reason", txtRemarks.Text);
          cmd.Parameters.AddWithValue("@empid", Session["Emp_ID"]);
         con.Open();
          cmd.ExecuteNonQuery();
          con.Close();
          GridView_ExpiryStatus.DataBind();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        panelRemarks.Visible = false;

    }
}
