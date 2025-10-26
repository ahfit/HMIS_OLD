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
 
public partial class BloodRequestForm : System.Web.UI.Page
{
    Encryption ENC = new Encryption();
    string connection = ConfigurationManager.ConnectionStrings["BloodBank_ConnectionString"].ToString();
  
    protected void validate(string url, string dept)
    {
       if (Session["emp_id"] == null || Session["dept_id"] == null)
        {
            Response.Redirect("../login.aspx");
           
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {   
       // validate("MedicineStock.aspx", "1");
	    JavaScriptMenu obj = new JavaScriptMenu();
        obj.loginvalidate();
        String url = Request.PhysicalPath;
        String FinalUrl = url.Substring(Request.PhysicalApplicationPath.Length);
        //Obj.pnl = Panel1;
        LabelSideMenu.Text= obj.SideMenu(FinalUrl);
		LabelFooter.Text = obj.Footer_String();
        Session.Remove("Page_Path");
        Session.Add("Page_Path", "Pt_EMR/BloodRequestForm.aspx");
        if (Session["YearlyNo"] == null || Session["registrationNo"] == null || Session["emp_id"] == null || Session["SubDeptID"] == null)
        {
            Response.Redirect("../login.aspx");
        }
        HiddenField_Emp_Id.Value = Session["emp_id"].ToString();
        HiddenField_Registration_No.Value = Session["registrationno"].ToString();
        HiddenField_Yearly_No.Value = Session["YearlyNo"].ToString();
        HiddenField_Dept_Id.Value = Session["SubDeptID"].ToString();
        Label_sample_No.Text ="B-" + HiddenField_Yearly_No.Value;
        if (!IsPostBack)
        {
        select_Date();
        TextBox_bags.Text = "0";
            }
			
			
			
			
			
			
    }
    protected void ImageButtonback_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("pharmacyAdmin.aspx");
    }
    protected void ButtonPrint_Click(object sender, EventArgs e)
    {
       
    }
    protected void Button2_Click(object sender, EventArgs e)
    {

    }

    public void select_Date()
    {

        try
        {
            String opconstr = ConfigurationManager.ConnectionStrings["OperationTheaterConnectionString"].ToString();
            SqlConnection con = new SqlConnection(opconstr);

            //        string qry = "SELECT isnull(ExpectedOPDate,'') as ExpectedOPDate, FROM Pt_Operation_Recommended WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) and (isnull(Bloodrequired,0) = 1)";
            //string qry = "SELECT isnull(ExpectedOPDate,'') as ExpectedOPDate,isnull(BloodGroup,'') as BloodGroup FROM Pt_Operation_Recommended WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) and (isnull(Bloodrequired,0) = 1)";
            string qry = "SELECT isnull(ExpectedOPDate,'') as ExpectedOPDate,isnull(BloodGroup,'') as BloodGroup FROM Pt_Operation_Recommended WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) and (isnull(Bloodrequired,0) = 1)";
            SqlCommand command = new SqlCommand(qry, con);
            command.CommandType = CommandType.Text;
            con.Open();


            command.Parameters.AddWithValue("@RegNo", Session["registrationno"]);
            command.Parameters.AddWithValue("@YearlyNo", Session["YearlyNo"]);
            //Response.Write(Convert.ToString(Session["registrationno"]));
             
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = command;
            da.Fill(dt);
            DataList_DateWhen.DataSource = dt;
            //.Columns["ExpectedOPDate"];
            DataList_DateWhen.DataBind();
            con.Close();
            Label_BloodGroup.Text = dt.Rows[dt.Rows.Count - 1]["BloodGroup"].ToString();

    
        }
        catch (Exception ex)
        { }
    }

    public string Blood_Insert_Request()
    {
        
        try
        {
          //  string[] str;
            
            
            char[] ch= new char[1] ;
            ch[0]=Convert.ToChar ("/");
            SqlConnection con = new SqlConnection(connection);
            con.Open();
            SqlCommand insert_Blood = new SqlCommand("BloodBank_Request", con);
            insert_Blood.CommandType = CommandType.StoredProcedure;

            //insert_Blood.Parameters.AddWithValue("@Registration_No", HiddenField_Registration_No.Value);
               // insert_Blood.Parameters.AddWithValue("@Yearly_No", HiddenField_Yearly_No.Value);
            insert_Blood.Parameters.AddWithValue("@Yearly_No", HiddenField_Yearly_No.Value);
            insert_Blood.Parameters.AddWithValue("@Doctor_Id", HiddenField_Emp_Id.Value);
            insert_Blood.Parameters.AddWithValue("@Sample_No", Label_sample_No.Text);
            insert_Blood.Parameters.AddWithValue("@Dept_Id", HiddenField_Dept_Id.Value);
            insert_Blood.Parameters.AddWithValue("@Bag_Qty", TextBox_bags.Text);
            insert_Blood.Parameters.AddWithValue("@Remarks", TextBox_Remarks.Text);
            insert_Blood.Parameters.AddWithValue("@OP_Id", 0);
            
            //str=TextBox_when_Need.Text.Split(ch);
                      
           // insert_Blood.Parameters.AddWithValue("@When_Need", Convert.ToDateTime(Convert.ToString(str[1]) + "/" + Convert.ToString(str[0]) + "/" + Convert.ToString(str[2])));

            insert_Blood.Parameters.AddWithValue("@When_Need", Convert.ToDateTime(WebDateChooser_WhenNeeded.Value));
            
            //insert_Blood.Parameters.AddWithValue("@When_Need", (TextBox_when_Need.Text));
            insert_Blood.Parameters.AddWithValue("@Registration_No",HiddenField_Registration_No.Value);
            //insert_Blood.Parameters.AddWithValue("@Registration_No", HiddenField_Registration_No.Value);
            insert_Blood.Parameters.Add("@Blood_Request_Id", SqlDbType.Int);
            insert_Blood.Parameters["@Blood_Request_Id"].Direction = ParameterDirection.Output;
            
            insert_Blood.ExecuteNonQuery();
            HiddenField_BloodRequest_Id.Value = insert_Blood.Parameters["@Blood_Request_Id"].Value.ToString();
            con.Close();
        }
        catch (Exception ex)
        {
            //string str = ex.ToString();
          //  Response.Write(Convert.ToString (ex.Message) ); 
            return "0";
        }
        return HiddenField_BloodRequest_Id.Value;
    }

    protected void insert_Request()
    {
        HiddenField_Blood_Request_Id.Value = Blood_Insert_Request();

        if (HiddenField_Blood_Request_Id.Value != "0")
        {
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                TextBox potency = (TextBox)GridView2.Rows[i].FindControl("TextBox_potency");
                TextBox potencyML = (TextBox)GridView2.Rows[i].FindControl("TextBox1");
                HiddenField id = (HiddenField)GridView2.Rows[i].FindControl("HiddenField_id");
                if (potency.Text.Trim() != "" || potencyML.Text.Trim() != "")
                {
                    HiddenField_Comp_Id.Value = id.Value;
                    HiddenField_Comp_Potency.Value = potency.Text+" PINTS";
                    HiddenField_Qty.Value = potency.Text;
                    HiddenField_Unit.Value = "PINTS";
                    HiddenField_Comp_PotencyML.Value = potencyML.Text + " ML";

                    try
                    {
                        SqlDataSource_Component_Insert.Insert();
                    }
                    catch (Exception ex)
                    {
                       // Response.Write(ex.ToString());
                    }

                }
            }

            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                RadioButton No = (RadioButton)GridView1.Rows[i].FindControl("RadioButton_No");
                RadioButton Yes = (RadioButton)GridView1.Rows[i].FindControl("RadioButton_Yes");
                HiddenField id = (HiddenField)GridView1.Rows[i].FindControl("HiddenField_id");

                if (No.Checked)
                {
                    HiddenField_Question_Id.Value = id.Value;
                    HiddenField_Question_Ans.Value = "false";
                    try
                    {
                        SqlDataSource_Question_Insert.Insert();
                    }
                    catch (Exception ex)
                    {
                        //Response.Write(ex.ToString());
                    }
                }

                if (Yes.Checked)
                {
                    HiddenField_Question_Id.Value = id.Value;
                    HiddenField_Question_Ans.Value = "true";
                    try
                    {
                        SqlDataSource_Question_Insert.Insert();
                    }
                    catch (Exception ex)
                    {
                     //   Response.Write(ex.ToString());
                    }
                }

            }
            try
            {
                SqlDataSource_forward.Insert();
            }
            catch (Exception ex)
            {
                string str = ex.ToString();
            }
            // Response.Redirect("login.aspx");
            TextBox_bags.Text = "";
          //  TextBox_when_Need.Text = "";
            GridView1.DataBind();
            GridView2.DataBind();
        }
        else
        {
            //Response.Write("Already Requested");
            Button1.Enabled = false;

        }
        GridView3.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //HiddenField_WhenNeeded.Value = WebDateChooser_WhenNeeded.Value;
        try
        {
            if (WebDateChooser_WhenNeeded.Value != "")
            {
                if (checkDate())
                {
        
                    insert_Request();
                }
            }
            else
            {
        
                insert_Request();
            }
        }
        catch (Exception ex)
            {
               // Response.Write(ex.Message);
            }
      }
    protected bool checkDate()
    {
        string[] str;

        bool myreturn;
        char[] ch = new char[1];
        ch[0] = Convert.ToChar("/");
      //  str = TextBox_when_Need.Text.Split(ch);

        DateTime date = Convert.ToDateTime(WebDateChooser_WhenNeeded.Value);

        TimeSpan ts = Convert.ToDateTime(WebDateChooser_WhenNeeded.Value).Subtract(DateTime.Now);
        if (ts.TotalHours > 0)
        {
            Label5.Text = "";
            myreturn = true; 
        }
        else
        {
            Label5.Text = "Date & Time must be grater than current date & time";
            myreturn = false;
        }
        return myreturn;
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        
        Label_Error.Text = "";
        TextBox_bags.Text = "";
        Label5.Text = "";
     //   TextBox_when_Need.Text = "";
        GridView1.DataBind();
        GridView2.DataBind();
        Button1.Enabled = true;
      
    }

    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
          //  GridView1.Rows[i].Cells[4].Attributes.Add("onClick", "doit(this)");
        }
    }

    protected void GridView2_PreRender(object sender, EventArgs e)
    {

    }
    protected void SqlDataSource_Component_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void TextBox_bags_TextChanged(object sender, EventArgs e)
    {

    }


    protected void GridView3_PreRender(object sender, EventArgs e)
    {
       // if (!IsPostBack)
        //{
            if (GridView3.Rows.Count != 0)
            {
                for (int i = 0; i < GridView3.Rows.Count; i++)
                {
                    GridView3.Rows[i].Cells[3].Text = GridView3.Rows[i].Cells[3].Text + ' ' + ENC.Encrypt_Main(GridView3.Rows[i].Cells[4].Text, false) + ' ' + ENC.Encrypt_Main(GridView3.Rows[i].Cells[5].Text, false);
                    GridView3.Rows[i].Cells[4].Visible = false;
                    GridView3.Rows[i].Cells[5].Visible = false;
                    GridView3.Rows[i].Cells[6].Visible = false;

                }
                GridView3.HeaderRow.Cells[4].Visible = false;
                GridView3.HeaderRow.Cells[5].Visible = false;
                GridView3.HeaderRow.Cells[6].Visible = false;
            }
      //  }
    }

    public void calculate_bag()
    {
        Int64 bags = 0;

    for(int i=0;i<GridView2.Rows.Count;i++)
    {
        if (((TextBox)GridView2.Rows[i].FindControl("TextBox_potency")).Text == "")
        {
            bags = bags + 0;
        }
        else
        { bags = bags + Convert.ToInt64(((TextBox)GridView2.Rows[i].FindControl("TextBox_potency")).Text); }
        
        }

    TextBox_bags.Text = Convert.ToString(bags); 
    }


    protected void TextBox_potency_TextChanged(object sender, EventArgs e)
    {
        GridViewRow gv = (GridViewRow)(sender as Control).Parent.Parent;
        int index = gv.RowIndex;
        HiddenField HiddenField_Comp_Qty = (HiddenField)GridView2.Rows[index].FindControl("HiddenField_Comp_Qty");
        TextBox TextBox_potency = (TextBox)GridView2.Rows[index].FindControl("TextBox_potency");
        TextBox TextBox1 = (TextBox)GridView2.Rows[index].FindControl("TextBox1");
        if (TextBox_potency.Text != "")
        {
            TextBox1.Text = Convert.ToString(Convert.ToInt32(HiddenField_Comp_Qty.Value) * Convert.ToInt32(TextBox_potency.Text));
        }
        calculate_bag();
    }

    protected void DataList_DateWhen_SelectedIndexChanged(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)DataList_DateWhen.Items[DataList_DateWhen.SelectedItem.ItemIndex].FindControl("LinkButton_Date");
       // TextBox_when_Need.Text = lb.Text;
      
    }
    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {
        GridViewRow gv = (GridViewRow)(sender as Control).Parent.Parent;
        int index = gv.RowIndex;
        HiddenField HiddenField_Comp_Qty = (HiddenField)GridView2.Rows[index].FindControl("HiddenField_Comp_Qty");
        TextBox TextBox_potency = (TextBox)GridView2.Rows[index].FindControl("TextBox_potency");
        TextBox TextBox1 = (TextBox)GridView2.Rows[index].FindControl("TextBox1");
        if (TextBox1.Text != "")
        {
            TextBox_potency.Text = Convert.ToString(Convert.ToInt32(Math.Ceiling(Convert.ToDecimal(TextBox1.Text) / Convert.ToDecimal(HiddenField_Comp_Qty.Value))));
        }
        calculate_bag();
    }
}
