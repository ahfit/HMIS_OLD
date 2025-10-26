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


public partial class Budget_Detail : CSharpClass
{

    string constr = ConfigurationManager.ConnectionStrings["FinanceConnectionString"].ConnectionString;
    protected void DropDownList_Sub_ESH_name_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DropDownList_Sub_EH_Name.DataBind();
       // DropDownList_Sub_ESH_name.DataBind();
        SqlDataSource_Budget_Detail.DataBind();
        GridView2.DataBind();
        load_grid();
        //GridView2.DataBound();
    }

     protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string year;
        string dat;
        dat = Request.QueryString["Date_End"];
        year = dat.Substring(dat.LastIndexOf("/"),5);
        year = year.TrimStart('/'); 
        
        HiddenField_date.Value = year;

        if (!Page.IsPostBack)
        {
            DropDownList_Em_Name.DataBind();
            DropDownList_Sub_EH_Name.DataBind();
            DropDownList_Sub_ESH_name.DataBind();
            SqlDataSource_Budget_Detail.DataBind();
            GridView2.DataBind();
            load_grid();
        }



    }
    
    void load_grid()
    {
        string qry = "SELECT isnull(BD.E_Code,BE.E_Code) E_code,  isnull (Estimated_Amount,BE.TotalYearly) as Estimated_Amount, isnull(Revise_Amount,BE.TotalYearly) as Revise_Amount,"+
            "isnull(Actual_Amount, BE.TotalYearly) as Actual_Amount,BD.Description,isnull(MonthlyLimit, BE.TotalMonthly) as MonthlyLimit ,BD.BD_ID"+
            " FROM Budget B Left outer join Budget_Detail BD on B.B_ID = BD.B_ID Left outer join "+
             "budgetEstimateTotal BE on b.B_ID = BE.b_ID WHERE (B.B_ID = @B_ID) and (BD.E_Code like @E_code + '%' or BE.E_Code like  @E_code + '%') order by isnull(BD.E_Code,BE.E_Code) ";
        SqlConnection con = new SqlConnection(constr);
        SqlCommand command = new SqlCommand(qry, con);
        command.CommandType = CommandType.Text;
        command.Parameters.AddWithValue("@B_ID", Request.QueryString["B_ID"].ToString());
        command.Parameters.AddWithValue("@e_code", DropDownList_Sub_ESH_name.SelectedValue);
        con.Open();
            SqlDataReader reader = command.ExecuteReader();
            while(reader.Read())
            {

                for (int i = 0; i <= GridView2.Rows.Count - 1; i++)
                {
                    if (GridView2.Rows[i].Cells[0].Text == reader.GetSqlString(0))
                    {
                                TextBox estimated_amount = (TextBox)GridView2.Rows[i].FindControl("TextBox_Estimated_Amount");
                                TextBox Revise_Amount =(TextBox)GridView2.Rows[i].FindControl("TextBox_Revise_Amount");
                                TextBox Actual_Amount =(TextBox)GridView2.Rows[i].FindControl("TextBox_Actual_Amount");
                                TextBox MonthlyLimit = (TextBox)GridView2.Rows[i].FindControl("txtMonthlyLimit");
                                TextBox Description=(TextBox)GridView2.Rows[i].FindControl("TextBox_Description");
                                Label Lbl_Actual_Amount = (Label)GridView2.Rows[i].FindControl("Label_Final_Budget");
                                LinkButton lnkAdd = (LinkButton)GridView2.Rows[i].FindControl("lnkAddDepartmentTal");
                        estimated_amount.Text = Convert.ToString(reader.GetSqlValue(1));
                        if (estimated_amount.Text == "Null") { estimated_amount.Text = string.Empty; }
                        Revise_Amount.Text = Convert.ToString(reader.GetSqlValue(2));
                        if (Revise_Amount.Text == "Null") { Revise_Amount.Text = string.Empty; }
                        Actual_Amount.Text = Convert.ToString(reader.GetSqlValue(3));
                        if (Actual_Amount.Text == "Null") { Actual_Amount.Text = string.Empty; }
                        Description.Text = Convert.ToString(reader.GetSqlValue(4));
                        if (Description.Text == "Null") { Description.Text = string.Empty; }
                        Lbl_Actual_Amount.Text = Convert.ToString(reader.GetSqlValue(3));
                        if (Lbl_Actual_Amount.Text == "Null") { Lbl_Actual_Amount.Text = string.Empty; }
                        MonthlyLimit.Text = Convert.ToString(reader.GetSqlValue(5));
                        if (MonthlyLimit.Text == "Null") { MonthlyLimit.Text = string.Empty; }
                    //if(estimated_amount.Text==string.Empty)
                    //{
                    //    lnkAdd.Visible = false;
                    //}
                    //else
                    //{
                    //lnkAdd.Visible = true;
                    lnkAdd.CommandArgument = Convert.ToString(reader.GetSqlValue(6));
                    //}
                }
                
                }


            }
        }

    protected void DropDownList_Sub_EH_Name_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DropDownList_Sub_EH_Name.DataBind();
        DropDownList_Sub_ESH_name.DataBind();
        SqlDataSource_Budget_Detail.DataBind();
        GridView2.DataBind();
        load_grid();
        
        
        //DropDownList_Sub_ESH_name.DataBind();
        //GridView2.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        TextBox Estimated_Amount;
        TextBox Revise_Amount;
        TextBox Actual_Amount;
        
        TextBox Description,MonthlyLimit;
        HiddenField E_Code,E_Name;

        for (int i = 0; i < GridView2.Rows.Count; i++)
        {
            Estimated_Amount = (TextBox)GridView2.Rows[i].FindControl("TextBox_Estimated_Amount");
            Revise_Amount = (TextBox)GridView2.Rows[i].FindControl("TextBox_Revise_Amount");
            Actual_Amount = (TextBox)GridView2.Rows[i].FindControl("TextBox_Actual_Amount");
            Description = (TextBox)GridView2.Rows[i].FindControl("TextBox_Description");
            E_Code = (HiddenField)GridView2.Rows[i].FindControl("HiddenField_E_Code");
            E_Name = (HiddenField)GridView2.Rows[i].FindControl("HiddenField_E_Name");
            MonthlyLimit = (TextBox)GridView2.Rows[i].FindControl("txtMonthlyLimit");
            HiddenField_Estimated_Amount.Value = Estimated_Amount.Text;
            HiddenField_Revise_Amount.Value = Revise_Amount.Text;
            HiddenField_Actual_Amount.Value = Revise_Amount.Text;
            //HiddenField_Actual_Amount.Value = Actual_Amount.Text;
            HiddenField_Description.Value = Description.Text;
            HiddenField_E_Code.Value = GridView2.Rows[i].Cells[1].Text;
            HiddenField_E_ID.Value = E_Code.Value;
            if(HiddenField_Estimated_Amount.Value != "" )
            {
                SqlDataSource_Budget_Detail.InsertParameters["MonthlyLimit"].DefaultValue = MonthlyLimit.Text;
                SqlDataSource_Budget_Detail.InsertParameters["E_Name"].DefaultValue = E_Name.Value;
                SqlDataSource_Budget_Detail.Insert();
            }
        }
        
    }
    protected void GridView2_PreRender(object sender, EventArgs e)
    {

        if (GridView2.Rows.Count != 0)
        {
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                GridView2.Rows[i].Cells[0].Visible = false;


            }
            GridView2.HeaderRow.Cells[0].Visible = false;

        }
    
    
    }
    protected void TextBox_Revise_Amount_TextChanged(object sender, EventArgs e)
    {
        GridViewRow grv = (GridViewRow)(sender as Control).Parent.Parent;
        Label Label_Final_Budget = (Label)grv.FindControl("Label_Final_Budget");
        TextBox TextBox_Revise_Amount = (TextBox)grv.FindControl("TextBox_Revise_Amount");
        Label_Final_Budget.Text = TextBox_Revise_Amount.Text;
        
    }
    protected void lnkAddDepartmentTal_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;

        string B_ID = "";
        if (!string.IsNullOrEmpty(Request.QueryString["B_ID"]))
        {
            B_ID = Request.QueryString["B_ID"].ToString();
        }

        string E_date = "";
        if (!string.IsNullOrEmpty(Request.QueryString["Date_End"]))
        {
            E_date = Request.QueryString["Date_End"].ToString();
        }
        Response.Redirect("BudgetHead_distribution.aspx?BD_ID=" + lnk.CommandArgument+"&E_code="+lnk.ToolTip + "&B_ID=" +B_ID + "&Date_End=" + E_date);
    }
}
