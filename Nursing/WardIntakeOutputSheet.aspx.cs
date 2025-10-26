using System;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;

/*
 * MUHAMMAD JAHANGIR 
 * 06/01/2007
 * C#.NET
 */


public partial class WardIntakeOutputSheet : System.Web.UI.Page
{
    protected void validate(string url, string dept)
    {
        if (Session["emp_id"] == null || Session["dept_id"] == null)
        {
            Response.Redirect("login.aspx");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // validate("MedicineStock.aspx", "1");
        //  JavaScriptMenu obj = new JavaScriptMenu();
        //        obj.loginvalidate();
        //        LabelSideMenu.Text = Convert.ToString(obj.SideMenu_nurse(Request.PhysicalPath.Substring((Request.PhysicalApplicationPath.Length - 1), Convert.ToInt32((Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))));
        //		LabelFooter.Text = obj.Footer_String();

        JavaScriptMenu obj_menu = new JavaScriptMenu();
        obj_menu.loginvalidate();
        LabelSideMenu.Text = Convert.ToString(obj_menu.SideMenu(Request.PhysicalPath.Substring(Request.PhysicalPath.Length - ((Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))));
        LabelFooter.Text = obj_menu.Footer_String();



        if (!Page.IsPostBack)
        {
            wdcIntakeOutput.Value = DateTime.Now;
            //Load_Sub_IN_OUT("225211204029036071036050050036043043036036036057", 700773);
            Load_Sub_IN_OUT(Convert.ToString(Session["RegistrationNo"]), Convert.ToInt32(Session["YearlyNo"]));


            DateTime date_Output = (DateTime)DateTime.Now;
            
            if (date_Output.Hour >= 0 && date_Output.Hour < 8 || date_Output.Hour >= 20 && date_Output.Hour<24)
            {
                DropDownList1.SelectedValue="2";
                DDLShift.SelectedValue = "2";
            }
            else if (date_Output.Hour >= 8 && date_Output.Hour < 14)
            {
                DropDownList1.SelectedValue = "3";
                DDLShift.SelectedValue = "3";
            }
            else if (date_Output.Hour >= 14 && date_Output.Hour <= 20)
            {
                DropDownList1.SelectedValue = "1";
                DDLShift.SelectedValue = "1";
            }


            WebDateChooserOutPut.Value = DateTime.Now;
            WebDateChooserIntake.Value = DateTime.Now;
        }

        HiddenField_Emp_Id.Value = Convert.ToString(Session["Emp_ID"]);
        HiddenField_Registration_No.Value = Convert.ToString(Session["RegistrationNo"]);
        HiddenField_Yearly_No.Value = Convert.ToString(Session["YearlyNo"]);

        //Response.Write(HiddenField_Registration_No.Value + "RegNo" + HiddenField_Registration_No.Value + "YearlyNo");
        if (GridView_Intake.Rows.Count > 0)
        {
            LinkButton1.Visible = true;
        }
    }
    protected void ImageButtonback_Click(object sender, ImageClickEventArgs e)
    {
        //Response.Write(Session["RegistrationNo"] & Session["YearlyNo"]);
        //Response.Redirect("WardOtComponent.aspx?regno=" + Session["RegistrationNo"] + "&PayID=" & Session["YearlyNo"]);
    }
    protected void ButtonPrint_Click(object sender, EventArgs e)
    {

    }
    protected void Button2_Click(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Label_Error.Text = "";

    }
    int a, b;
    int intakeTotal = 0;
    int intakeTotal1 = 0;

    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        intakeTotal = 0;

        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            if (i > 0)
            {
                if (GridView1.Rows[i - 1].Cells[6].Text != "")
                {
                    try
                    {
                        a = Convert.ToInt32(GridView1.Rows[i].Cells[6].Text);
                    }
                    catch (Exception ex)
                    {
                        string str = ex.ToString();
                        a = 0;
                    }
                    b = Convert.ToInt32(GridView1.Rows[i - 1].Cells[6].Text);
                }
                if (b < a)
                {
                    GridView1.Rows[i - 1].Cells[6].Text = "";
                    GridView1.Rows[i - 1].CssClass = "GridItem";
                }
                else
                {
                    intakeTotal += b;
                }
            }
        }

        //intakeTotal += Convert.ToInt32(GridView1.Rows[GridView1.Rows.Count - 1].Cells[6].Text);
        //Label1.Text ="Total :  " + intakeTotal.ToString();

    }


    protected void GridView2_PreRender(object sender, EventArgs e)
    {
        intakeTotal1 = 0;

        for (int i = 0; i < GridView2.Rows.Count; i++)
        {
            if (i > 0)
            {
                if (GridView2.Rows[i - 1].Cells[6].Text != "")
                {
                    try
                    {
                        a = Convert.ToInt32(GridView2.Rows[i].Cells[6].Text);
                    }
                    catch (Exception ex)
                    {
                        string str = ex.ToString();
                        a = 0;
                    }
                    b = Convert.ToInt32(GridView2.Rows[i - 1].Cells[6].Text);
                }
                if (b < a)
                {
                    GridView2.Rows[i - 1].Cells[6].Text = "";
                    GridView2.Rows[i - 1].CssClass = "GridItem";
                }
                else
                {
                    intakeTotal1 += b;
                }
            }
        }

        //intakeTotal1 += Convert.ToInt32(GridView2.Rows[GridView2.Rows.Count - 1].Cells[6].Text);
        // Label2.Text = "Total :  " + intakeTotal1.ToString();

    }
    protected void Button2_Click1(object sender, EventArgs e)
    {
        try
        {
            SqlDataSource_intake_Component.Insert();
            DropDownList_insert_Component.DataBind();
        }
        catch (Exception ex)
        {
            string str = ex.ToString();
            //Response.Write(str);
        }
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        try
        {
            HiddenFieldIntake_DateTime.Value = Convert.ToString(WebDateChooserIntake.Value);
            //Response.Write(HiddenFieldIntake_DateTime.Value);
            //Response.End();
            DateTime date_Intake = (DateTime)WebDateChooserIntake.Value;
            hf_Remarks.Value = txtIntake_Remarks.Text;
            SqlDataSource_intake_Remarks.Insert();
            if (date_Intake.Hour >= 0 && date_Intake.Hour < 8)
            {
                HiddenFieldWhen_Take.Value = "Night";

            }
            else if (date_Intake.Hour >= 8 && date_Intake.Hour < 21)
            {
                HiddenFieldWhen_Take.Value = "Day";
            }
            else if (date_Intake.Hour >= 21 && date_Intake.Hour <= 23)
            {
                HiddenFieldWhen_Take.Value = "Night";
            }
            SqlDataSource_intake.Insert();
            TextBox_amount.Text = "";
            TextBox_output_amount.Text = "";
            txtIntake_Remarks.Text = "";

            //Load_Sub_IN_OUT("225211204029036071036050050036043043036036036057", 700773);
            Load_Sub_IN_OUT(Convert.ToString(Session["RegistrationNo"]), Convert.ToInt32(Session["YearlyNo"]));



        }
        catch (Exception ex)
        {
            string str = ex.ToString();
            Response.Write(ex.ToString());
        }
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        TextBox_amount.Text = "";
    }

    string str = "";
    string str1 = "";
    string str2 = "";
    int total = 0;


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {


        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (str == "")
            {
                str = e.Row.Cells[0].Text;

            }
            else if (str == e.Row.Cells[0].Text)
            {
                e.Row.Cells[0].Text = "";
            }
            else
            {
                str = e.Row.Cells[0].Text;
                e.Row.Cells[0].Text = str;
            }
            //////////////////////////////////////////////////////////////////////////////////////////
            if (str1 == "")
            {
                str1 = e.Row.Cells[3].Text;

            }
            else if (str1 == e.Row.Cells[3].Text)
            {
                e.Row.Cells[3].Text = "";

            }
            else
            {
                str1 = e.Row.Cells[3].Text;
                e.Row.Cells[3].Text = str1;

            }
            //////////////////////////////////////////////////////////////////////////////////////////
            if (str2 == "")
            {
                str2 = e.Row.Cells[5].Text;
                total = Convert.ToInt32(e.Row.Cells[4].Text);
                e.Row.Cells[6].Text = total.ToString();
            }
            else if (str2 == e.Row.Cells[5].Text)
            {
                e.Row.Cells[5].Text = "";
                total += Convert.ToInt32(e.Row.Cells[4].Text);
                e.Row.Cells[6].Text = total.ToString();

            }
            else
            {
                str2 = e.Row.Cells[5].Text;
                e.Row.Cells[5].Text = str2;
                total = Convert.ToInt32(e.Row.Cells[4].Text);
                e.Row.Cells[6].Text = total.ToString();
            }

        }

    }

    /////////////////////////////////////////////////////////////////////////////////////////

    string astr = "";
    string astr1 = "";
    string astr2 = "";
    int total1 = 0;
    protected void GridView1_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (astr == "")
            {
                astr = e.Row.Cells[0].Text;
            }
            else if (astr == e.Row.Cells[0].Text)
            {
                e.Row.Cells[0].Text = "";
            }
            else
            {
                astr = e.Row.Cells[0].Text;
                e.Row.Cells[0].Text = astr;
            }
            /////////////////////////////////////////////////////////////////////////////////////////////
            if (astr1 == "")
            {
                astr1 = e.Row.Cells[3].Text;
            }
            else if (astr1 == e.Row.Cells[3].Text)
            {
                e.Row.Cells[3].Text = "";
            }
            else
            {
                astr1 = e.Row.Cells[3].Text;
                e.Row.Cells[3].Text = astr1;
            }
            //////////////////////////////////////////////////////////////////////////////////////////////
            if (astr2 == "")
            {
                astr2 = e.Row.Cells[5].Text;
                total1 = Convert.ToInt32(e.Row.Cells[4].Text);
                e.Row.Cells[6].Text = total1.ToString();
            }
            else if (astr2 == e.Row.Cells[5].Text)
            {
                e.Row.Cells[5].Text = "";
                total1 += Convert.ToInt32(e.Row.Cells[4].Text);
                e.Row.Cells[6].Text = total1.ToString();
            }
            else
            {
                astr2 = e.Row.Cells[5].Text;
                e.Row.Cells[5].Text = astr2;
                total1 = Convert.ToInt32(e.Row.Cells[4].Text);
                e.Row.Cells[6].Text = total1.ToString();
            }

        }
    }

    protected void Button3_Click1(object sender, EventArgs e)
    {
        try
        {
            SqlDataSource_output_Component.Insert();
        }
        catch (Exception ex)
        {
            string str = ex.ToString();
            // Response.Write(ex.ToString());
        }
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        try
        {
            HiddenFieldOutput_DateTime.Value = Convert.ToString(WebDateChooserOutPut.Value);
            DateTime date_Output = (DateTime)WebDateChooserOutPut.Value;
            hf_Remarks.Value = txtOutput_Remarks.Text;
            SqlDataSource_intake_Remarks.Insert();
            if (date_Output.Hour >= 0 && date_Output.Hour < 8)
            {
                HiddenFieldWhen_Take_Output.Value = "Night";
            }
            else if (date_Output.Hour >= 8 && date_Output.Hour < 21)
            {
                HiddenFieldWhen_Take_Output.Value = "Day";
            }
            else if (date_Output.Hour >= 21 && date_Output.Hour <= 23)
            {
                HiddenFieldWhen_Take_Output.Value = "Night";
            }

            SqlDataSource_output.Insert();

            TextBox_amount.Text = "";
            TextBox_output_amount.Text = "";
            txtOutput_Remarks.Text = "";
            Load_Sub_IN_OUT(Convert.ToString(Session["RegistrationNo"]), Convert.ToInt32(Session["YearlyNo"]));
        }
        catch (Exception ex)
        {
            string str = ex.ToString();
            // Response.Write(ex.ToString());
        }
    }
    protected void Button6_Click(object sender, EventArgs e)
    {
        TextBox_output_amount.Text = "";
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    //protected void ImageButtonhome_Click(object sender, ImageClickEventArgs e)
    //{
    //    Response.Redirect("Nurse_Reception.aspx");
    //}
    //protected void ImageButtonlogin_Click(object sender, ImageClickEventArgs e)
    //{
    //    Session.RemoveAll();
    //    Response.Redirect("Login.aspx");
    //}
    protected void Button7_Click(object sender, EventArgs e)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        String Yearlyno = (String)Session["YearlyNo"];
        String RegNo = (String)Session["registrationNo"];
        sb.Append("<Script language='javascript' type='text/javascript'>window.open('../LGH_Reports/Patient_IntakeOutput.aspx?regno=" + RegNo.ToString() + "&yearlyNo=" + Yearlyno.ToString() + "&Type=1');</Script>");
        Type t = this.GetType();
        if (!ClientScript.IsClientScriptBlockRegistered(t, "PopUp"))
        {
            ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString());
        }
    }
    protected void Button8_Click(object sender, EventArgs e)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        String Yearlyno = (String)Session["YearlyNo"];
        String RegNo = (String)Session["registrationNo"];
        sb.Append("<Script language='javascript' type='text/javascript'>window.open('../LGH_Reports/Patient_IntakeOutput.aspx?regno=" + RegNo.ToString() + "&yearlyNo=" + Yearlyno.ToString() + "&Type=0');</Script>");
        Type t = this.GetType();
        if (!ClientScript.IsClientScriptBlockRegistered(t, "PopUp"))
        {
            ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString());
        }
    }





    protected void Load_Sub_IN_OUT(string RegNo, int YearlyNo)
    {

        Nursing ds = new Nursing();
        NursingTableAdapters.Select_Patient_Intake_Output_ReportTableAdapter da = new NursingTableAdapters.Select_Patient_Intake_Output_ReportTableAdapter();

        da.Fill(ds.Select_Patient_Intake_Output_Report, YearlyNo, RegNo, Convert.ToString(wdcIntakeOutput.Value));
        Int32 pos = 0;
        Boolean isaddrow = false;
        if (ds.Select_Patient_Intake_Output_Report.Rows.Count != 0)
        {
            Int32 time;
            for (Int32 i = 0; i < 24; i++)
            {


                if (i > 16)
                {
                    time = i - 17;
                }
                else
                {
                    time = 7 + i;
                }

                for (Int32 j = 0; j < ds.Select_Patient_Intake_Output_Report.Rows.Count; j++)
                {
                    if (Convert.ToString(time) + ":00" == ds.Select_Patient_Intake_Output_Report[j]["Time"].ToString())
                    {
                        isaddrow = true;
                        //  Response.Write(Convert.ToString(time) + ":00 ");
                        pos = pos + 1;
                    }

                }

                if ((Convert.ToString(time) + ":00" == "14:00") || (Convert.ToString(time) + ":00" == "22:00") || (Convert.ToString(time) + ":00" == "6:00"))
                {
                    if (isaddrow == true)
                    {
                        DataRow dr = ds.Tables["Select_Patient_Intake_Output_Report"].NewRow();
                        //dr[""] = 
                        dr["date"] = "Total";
                        dr["Time"] = "";
                        dr["Oral"] = 0;
                        dr["PARENTERAL"] = 0;
                        dr["N/G"] = 0;
                        dr["Urine"] = 0;
                        dr["Drainage"] = 0;
                        dr["NG_Aspiration"] = 0;
                        dr["Vomitus"] = 0;
                        dr["Stool"] = 0;
                        dr["PH"] = 0;
                        dr["Bld"] = 0;
                        dr["Sug"] = 0;
                        dr["Ket"] = 0;
                        dr["ALB"] = 0;
                        dr["VomitColor"] = "";
                        dr["Cvp_Line"] = 0;
                        dr["In_Other"] = 0;
                        dr["Out_Other"] = 0;
                        //dr[""] = 
                        //dr[""] = 
                        //dr[""] = 

                        // dr[""] =
                        DataRow dr1 = ds.Tables["Select_Patient_Intake_Output_Report"].NewRow();
                        //dr[""] = 
                        dr1["date"] = "Doctor On Duty:";
                        dr1["Time"] = "";
                        dr1["Oral"] = 0;
                        dr1["PARENTERAL"] = 0;
                        dr1["N/G"] = 0;
                        dr1["Urine"] = 0;
                        dr1["Drainage"] = 0;
                        dr1["NG_Aspiration"] = 0;
                        dr1["Vomitus"] = 0;
                        dr1["Stool"] = 0;
                        dr1["PH"] = 0;
                        dr1["Bld"] = 0;
                        dr1["Sug"] = 0;
                        dr1["Ket"] = 0;
                        dr1["ALB"] = 0;
                        dr1["VomitColor"] = "";
                        dr1["Cvp_Line"] = 0;
                        dr1["In_Other"] = 0;
                        dr1["Out_Other"] = 0;

                        ds.Select_Patient_Intake_Output_Report.Rows.InsertAt(dr, pos);
                      
                        pos = pos + 1;
                        isaddrow = false;
                          ds.Select_Patient_Intake_Output_Report.Rows.InsertAt(dr1, pos);
                    }
                }



            }
            //}

            //}
        }
        GridView_Intake.DataSource = ds.Select_Patient_Intake_Output_Report;
        GridView_Intake.DataBind();
    }







    protected void GridView_Intake_PreRender(object sender, EventArgs e)
    {
        Int32 Oral_Total = 0;
        Int32 CVPLine_Total = 0;
        Int32 Parenteral_Total = 0;
        //Int32 NG_Total = 0;
        Int32 InOther_Total = 0;
        Int32 In_total = 0;

        // output
        Int32 Out_Total = 0;
        Int32 Drainage_Total = 0;
        Int32 NG_Aspiration_Total = 0;
        Int32 Vomit_Total = 0;
        Int32 Stool_Total = 0;
        Int32 Urine_Total = 0;
        Int32 OutOther_Total = 0;

        Int32 PH = 0;
        Int32 Bld = 0;
        Int32 Sug = 0;
        Int32 Ket = 0;
        Int32 ALB = 0;

        Int32 G_Oral_Total = 0;
        Int32 G_CVPLine_Total = 0;
        Int32 G_Parenteral_Total = 0;
       // Int32 G_NG_Total = 0;
        Int32 G_InOther_Total = 0;
        Int32 G_In_total = 0;

        // output
        Int32 G_Out_Total = 0;
        Int32 G_Drainage_Total = 0;
        Int32 G_NG_Aspiration_Total = 0;
        Int32 G_Vomit_Total = 0;
        Int32 G_Stool_Total = 0;
        Int32 G_Urine_Total = 0;
        Int32 G_OutOther_Total = 0;

        Int32 G_PH = 0;
        Int32 G_Bld = 0;
        Int32 G_Sug = 0;
        Int32 G_Ket = 0;
        Int32 G_ALB = 0;




        if (GridView_Intake.Rows.Count != 0)
        {
            for (Int32 i = 0; i < GridView_Intake.Rows.Count; i++)
            {
                if (GridView_Intake.Rows[i].Cells[0].Text != "Total")
                {
                    Label Label_O_Qty = (Label)GridView_Intake.Rows[i].FindControl("Label_O_Qty");
                    Oral_Total = Oral_Total + Convert.ToInt32(Label_O_Qty.Text);

                    Label Label_CVPLine = (Label)GridView_Intake.Rows[i].FindControl("Label_CVPLine");
                    CVPLine_Total = CVPLine_Total + Convert.ToInt32(Label_CVPLine.Text);

                    Label Label_Parenteral_Qty = (Label)GridView_Intake.Rows[i].FindControl("Label_Parenteral_Qty");
                    Parenteral_Total = Parenteral_Total + Convert.ToInt32(Label_Parenteral_Qty.Text);

                    //Label Label_N_Qty = (Label)GridView_Intake.Rows[i].FindControl("Label_N_Qty");
                    //NG_Total = NG_Total + Convert.ToInt32(Label_N_Qty.Text);

                    Label Label_InOther = (Label)GridView_Intake.Rows[i].FindControl("Label_InOther");
                    InOther_Total = InOther_Total + Convert.ToInt32(Label_InOther.Text);

                    Label Label_IN_Total = (Label)GridView_Intake.Rows[i].FindControl("Label_IN_Total");
                    Label_IN_Total.Text = Convert.ToString(Convert.ToInt32(Label_O_Qty.Text) + Convert.ToInt32(Label_CVPLine.Text) + Convert.ToInt32(Label_Parenteral_Qty.Text) + Convert.ToInt32(Label_InOther.Text));

                    In_total += Convert.ToInt32(Label_IN_Total.Text);


                    //       Label_Out_Total                

                    Label Label_Drainage = (Label)GridView_Intake.Rows[i].FindControl("Label_Drainage");
                    Drainage_Total += Convert.ToInt32(Label_Drainage.Text);

                    Label Label_NG_Aspiration = (Label)GridView_Intake.Rows[i].FindControl("Label_NG_Aspiration");
                    NG_Aspiration_Total += Convert.ToInt32(Label_NG_Aspiration.Text);

                    Label Label_Vomit = (Label)GridView_Intake.Rows[i].FindControl("Label_Vomit");
                    Vomit_Total += Convert.ToInt32(Label_Vomit.Text);

                    Label Label_Stool = (Label)GridView_Intake.Rows[i].FindControl("Label_Stool");
                    Stool_Total += Convert.ToInt32(Label_Stool.Text);

                    Label Label_Urine = (Label)GridView_Intake.Rows[i].FindControl("Label_Urine");
                    Urine_Total += Convert.ToInt32(Label_Urine.Text);

                    Label Label_Out_Other = (Label)GridView_Intake.Rows[i].FindControl("Label_Out_Other");
                    OutOther_Total += Convert.ToInt32(Label_Out_Other.Text);

                    Label Label_Out_Total = (Label)GridView_Intake.Rows[i].FindControl("Label_Out_Total");
                    Label_Out_Total.Text = Convert.ToString(Convert.ToInt32(Label_Drainage.Text) + Convert.ToInt32(Label_NG_Aspiration.Text) + Convert.ToInt32(Label_Vomit.Text) + Convert.ToInt32(Label_Stool.Text) + Convert.ToInt32(Label_Urine.Text) + Convert.ToInt32(Label_Out_Other.Text));

                    Out_Total += Convert.ToInt32(Label_Out_Total.Text);



                    Label Label_PH = (Label)GridView_Intake.Rows[i].FindControl("Label_PH");

                    if (Label_PH.Text != "")
                    {
                        PH += Convert.ToInt32(Label_PH.Text);
                    }



                    Label Label_Bld = (Label)GridView_Intake.Rows[i].FindControl("Label_Bld");
                    if (Label_Bld.Text != "")
                    {
                        Bld += Convert.ToInt32(Label_Bld.Text);
                    }


                    Label Label_Sug = (Label)GridView_Intake.Rows[i].FindControl("Label_Sug");
                    if (Label_Sug.Text != "")
                    {
                        Sug += Convert.ToInt32(Label_Sug.Text);
                    }

                    Label Label_Ket = (Label)GridView_Intake.Rows[i].FindControl("Label_Ket");
                    if (Label_Ket.Text != "")
                    {
                        Ket += Convert.ToInt32(Label_Ket.Text);
                    }


                    Label Label_ALB = (Label)GridView_Intake.Rows[i].FindControl("Label_ALB");
                    if (Label_ALB.Text != "")
                    {
                        ALB += Convert.ToInt32(Label_ALB.Text);
                    }


                }
                else
                {

                    Label Label_O_Qty = (Label)GridView_Intake.Rows[i].FindControl("Label_O_Qty");
                    Label_O_Qty.Text = Convert.ToString(Oral_Total);

                    Label Label_CVPLine = (Label)GridView_Intake.Rows[i].FindControl("Label_CVPLine");
                    Label_CVPLine.Text = Convert.ToString(CVPLine_Total);

                    Label Label_Parenteral_Qty = (Label)GridView_Intake.Rows[i].FindControl("Label_Parenteral_Qty");
                    Label_Parenteral_Qty.Text = Convert.ToString(Parenteral_Total);

                    //Label Label_N_Qty = (Label)GridView_Intake.Rows[i].FindControl("Label_N_Qty");
                    //Label_N_Qty.Text = Convert.ToString(NG_Total);

                    Label Label_InOther = (Label)GridView_Intake.Rows[i].FindControl("Label_InOther");
                    Label_InOther.Text = Convert.ToString(InOther_Total);

                    Label Label_IN_Total = (Label)GridView_Intake.Rows[i].FindControl("Label_IN_Total");
                    //    Label_IN_Total.Text = Convert.ToString(Convert.ToInt32(Label_O_Qty.Text) + Convert.ToInt32(Label_CVPLine.Text) + Convert.ToInt32(Label_Parenteral_Qty.Text) + Convert.ToInt32(Label_N_Qty.Text) + Convert.ToInt32(Label_InOther.Text));

                    Label_IN_Total.Text = Convert.ToString(In_total);


                    //       Label_Out_Total                

                    Label Label_Drainage = (Label)GridView_Intake.Rows[i].FindControl("Label_Drainage");
                    Label_Drainage.Text = Convert.ToString(Drainage_Total);

                    Label Label_NG_Aspiration = (Label)GridView_Intake.Rows[i].FindControl("Label_NG_Aspiration");
                    Label_NG_Aspiration.Text = Convert.ToString(NG_Aspiration_Total);

                    Label Label_Vomit = (Label)GridView_Intake.Rows[i].FindControl("Label_Vomit");
                    Label_Vomit.Text = Convert.ToString(Vomit_Total);

                    Label Label_Stool = (Label)GridView_Intake.Rows[i].FindControl("Label_Stool");
                    Label_Stool.Text = Convert.ToString(Stool_Total);

                    Label Label_Urine = (Label)GridView_Intake.Rows[i].FindControl("Label_Urine");
                    Label_Urine.Text = Convert.ToString(Urine_Total);

                    Label Label_Out_Other = (Label)GridView_Intake.Rows[i].FindControl("Label_Out_Other");
                    Label_Out_Other.Text = Convert.ToString(OutOther_Total);

                    Label Label_Out_Total = (Label)GridView_Intake.Rows[i].FindControl("Label_Out_Total");
                    //Label_Out_Total.Text = Convert.ToString(Convert.ToInt32(Label_Drainage.Text) + Convert.ToInt32(Label_NG_Aspiration.Text) + Convert.ToInt32(Label_Vomit.Text) + Convert.ToInt32(Label_Stool.Text) + Convert.ToInt32(Label_Urine.Text) + Convert.ToInt32(Label_Out_Other.Text));

                    Label_Out_Total.Text = Convert.ToString(Out_Total);

                    Label Label_PH = (Label)GridView_Intake.Rows[i].FindControl("Label_PH");
                    Label_PH.Text = Convert.ToString(PH);

                    Label Label_Bld = (Label)GridView_Intake.Rows[i].FindControl("Label_Bld");
                    Label_Bld.Text = Convert.ToString(Bld);

                    Label Label_Sug = (Label)GridView_Intake.Rows[i].FindControl("Label_Sug");
                    Label_Sug.Text = Convert.ToString(Sug);

                    Label Label_Ket = (Label)GridView_Intake.Rows[i].FindControl("Label_Ket");
                    Label_Ket.Text = Convert.ToString(Ket);

                    Label Label_ALB = (Label)GridView_Intake.Rows[i].FindControl("Label_ALB");
                    Label_ALB.Text = Convert.ToString(ALB);




                    G_Oral_Total += Oral_Total;
                    G_CVPLine_Total += CVPLine_Total;
                    G_Parenteral_Total += Parenteral_Total;
                    //G_NG_Total += NG_Total;
                    G_InOther_Total += InOther_Total;
                    G_In_total += In_total;

                    // output
                    G_Out_Total += Out_Total;
                    G_Drainage_Total += Drainage_Total;
                    G_NG_Aspiration_Total += NG_Aspiration_Total;
                    G_Vomit_Total += Vomit_Total;
                    G_Stool_Total += Stool_Total;
                    G_Urine_Total += Urine_Total;
                    G_OutOther_Total += OutOther_Total;

                    G_PH += PH;
                    G_Bld += Bld;
                    G_Sug += Sug;
                    G_Ket += Ket;
                    G_ALB += ALB;

                    Oral_Total = 0;
                    CVPLine_Total = 0;
                    Parenteral_Total = 0;
                   // NG_Total = 0;
                    InOther_Total = 0;
                    In_total = 0;

                    // output
                    Out_Total = 0;
                    Drainage_Total = 0;
                    NG_Aspiration_Total = 0;
                    Vomit_Total = 0;
                    Stool_Total = 0;
                    Urine_Total = 0;
                    OutOther_Total = 0;

                    PH = 0;
                    Bld = 0;
                    Sug = 0;
                    Ket = 0;
                    ALB = 0;


                    GridView_Intake.Rows[i].CssClass = "totalrow";
                }


            }

            Label Label_Total_Oral = (Label)GridView_Intake.FooterRow.FindControl("Label_Total_Oral");
            Label_Total_Oral.Text = G_Oral_Total.ToString();


            Label Label_CvpLine = (Label)GridView_Intake.FooterRow.FindControl("Label_CvpLine");
            Label_CvpLine.Text = G_CVPLine_Total.ToString();

            Label Label_Total_IV = (Label)GridView_Intake.FooterRow.FindControl("Label_Total_IV");
            Label_Total_IV.Text = G_Parenteral_Total.ToString();

            //Label Label_Total_NG = (Label)GridView_Intake.FooterRow.FindControl("Label_Total_NG");
            //Label_Total_NG.Text = G_NG_Total.ToString();

            Label Label_Other = (Label)GridView_Intake.FooterRow.FindControl("Label_Other");
            Label_Other.Text = G_InOther_Total.ToString();

            Label Label_G_Total = (Label)GridView_Intake.FooterRow.FindControl("Label_G_Total");
            Label_G_Total.Text = G_In_total.ToString();
            Label_G_Total.Font.Bold = true;
            // Output

            Label Label_Tot_Drainage = (Label)GridView_Intake.FooterRow.FindControl("Label_Tot_Drainage");
            Label_Tot_Drainage.Text = G_Drainage_Total.ToString();

            Label Label_Tot_NGAspiration = (Label)GridView_Intake.FooterRow.FindControl("Label_Tot_NGAspiration");
            Label_Tot_NGAspiration.Text = G_NG_Aspiration_Total.ToString();

            Label Label_Tot_Vomit = (Label)GridView_Intake.FooterRow.FindControl("Label_Tot_Vomit");
            Label_Tot_Vomit.Text = G_Vomit_Total.ToString();


            Label Label_Tot_Stool = (Label)GridView_Intake.FooterRow.FindControl("Label_Tot_Stool");
            Label_Tot_Stool.Text = G_Stool_Total.ToString();

            Label Label_Tot_Urine = (Label)GridView_Intake.FooterRow.FindControl("Label_Tot_Urine");
            Label_Tot_Urine.Text = G_Urine_Total.ToString();

            Label Label_Tot_Out_Other = (Label)GridView_Intake.FooterRow.FindControl("Label_Tot_Out_Other");
            Label_Tot_Out_Other.Text = G_OutOther_Total.ToString();

            Label Label_G_Out_Total = (Label)GridView_Intake.FooterRow.FindControl("Label_G_Out_Total");
            Label_G_Out_Total.Text = G_Out_Total.ToString();
            Label_G_Out_Total.Font.Bold = true;

            Label Label_Tot_PH = (Label)GridView_Intake.FooterRow.FindControl("Label_Tot_PH");
            Label_Tot_PH.Text = G_PH.ToString();

            Label Label_Tot_Bld = (Label)GridView_Intake.FooterRow.FindControl("Label_Tot_Bld");
            Label_Tot_Bld.Text = G_Bld.ToString();

            Label Label_Tot_Sug = (Label)GridView_Intake.FooterRow.FindControl("Label_Tot_Sug");
            Label_Tot_Sug.Text = G_Sug.ToString();

            Label Label_Tot_Ket = (Label)GridView_Intake.FooterRow.FindControl("Label_Tot_Ket");
            Label_Tot_Ket.Text = G_Ket.ToString();

            Label Label_Tot_ALB = (Label)GridView_Intake.FooterRow.FindControl("Label_Tot_ALB");
            Label_Tot_ALB.Text = G_ALB.ToString();

        }

    }
    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Response.Write(GridView2.SelectedDataKey.Values[0]); 
        Panel_Enter_Detail.Visible = true;

        HiddenField_patient_intake_output_ID.Value = Convert.ToString(GridView2.SelectedDataKey.Values[0]);
        HiddenField_Component_ID.Value = Convert.ToString(GridView2.SelectedDataKey.Values[1]);

        // Response.Write(HiddenField_patient_intake_output_ID.Value + " " + HiddenField_Component_ID.Value);

        //        DataList_SubComponent.DataBind();


    }
    protected void Button_Sub_Value_Cancel_Click(object sender, EventArgs e)
    {
        Panel_Enter_Detail.Visible = false;

    }
    protected void Button_Sub_Value_Save_Click(object sender, EventArgs e)
    {
        for (int i = 0; i <= DataList_SubComponent.Items.Count - 1; i++)
        {
            HiddenField hid_sub_component_ID = (HiddenField)DataList_SubComponent.Items[i].FindControl("HiddenField_SubComponent_ID");
            TextBox hid_Value = (TextBox)DataList_SubComponent.Items[i].FindControl("TextBox1");
            HiddenField_subComponent.Value = hid_sub_component_ID.Value;
            HiddenField_Sub_Component_Value.Value = hid_Value.Text;
            try
            {
                SqlDataSource_sub_component.Insert();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message.ToString());
            }
        }

        Panel_Enter_Detail.Visible = false;
    }
    protected void wdcIntakeOutput_ValueChanged(object sender, Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs e)
    {
        try
        {
            Load_Sub_IN_OUT(Session["RegistrationNo"].ToString(), Convert.ToInt32(Session["YearlyNo"]));
            // Response.Write(wdcIntakeOutput.Value.ToString());
        }
        catch (Exception ex)
        {
            // Response.Write(ex.Message);
        }
        if (GridView_Intake.Rows.Count > 0)
        {
            LinkButton1.Visible = true;
        }
        else
        {
            LinkButton1.Visible = false;
        }
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Response.Redirect("WardIntakeOutputSheetRpt.aspx?dt=" + wdcIntakeOutput.Value);
        //Response.Redirect("~/Patient Billing/intake_output.aspx?dt=" + wdcIntakeOutput.Value);

    }
    protected void SqlDataSource_intake_Remarks_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        hf_Remarks_ID.Value = e.Command.Parameters["@Identity"].Value.ToString();
    }

    //protected void LinkButton2_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("~/Patient Billing/intake_output.aspx?dt=" + wdcIntakeOutput.Value);
    //}
    protected void Buttonreport_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Patient Billing/intake_output.aspx?dt=" + wdcIntakeOutput.Value);
    }
}
