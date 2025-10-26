using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.SessionState;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI.HtmlControls;

public partial class Pathology_Sample_Slip : System.Web.UI.Page
{
    Encryption ENC = new Encryption();
    public string Hospital_Name = "";

    public string MedicalRecord_RegNo_withEnc = "";
    //------------------Bio DataInfo
    public string PatNameInfo = "";
    public string val_Age_Gender = "";
    public string PatientType = "";

    public string MedicalRecord_RegNo = "";
    public string HospitalVisit_PayID = "";
    public string ReceiptNo_SPM_ID = "";
    public string Yearly_No = "";
    public string Test_Booking_Date = "";
    public string MobilePhone = "";
    public string Dept_Name = "";
    //--------------------------
    //    Advance	Credit_Card		Party		Refund	Payment_Detail_ID	SPM_ID	Discount	Reg_No	Yearly_No

    //------------------------------Payment Detail
    public string Cash_str = "";
    public string Credit_Card_str = "";
    public string Cheque_str = "";

    public string CurrentPayment_SumofPatServAmount = "";
    public string Advance = "";
    public string Discount = "";
    public string Refund = "";
    public string Amount_paid_by_Patient = "";
    //------------------------------
    public string loginUserName = "";

    SqlConnection objconn;//= new SqlConnection();
    SqlTransaction DbTran = null;
    string strconn = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            printRptCode();
        }
    }

    void loginvalidate(string UserId, string dept)
    {
        ///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        //this function use to chck that it is a  valid user or not ' 
        ///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        try
        {
            if (((Session["emp_id"] == null) & (Session["dept_id"] == null)))
            {
                Response.Write("<script language='javascript' type='text/javascript'>window.open('../login.aspx', '_top')</script>");
                //Response.Redirect("login.aspx")
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
    void printRptCode()
    {

        try
        {



            loginvalidate(Session["emp_id"].ToString(), Session["dept_id"].ToString());


            DataTable tblrptHeader = new DataTable();
            tblrptHeader = (DataTable)Session["Rpt_Header_DT"];
            if (tblrptHeader.Rows.Count > 0)
            {

                Hospital_Name = tblrptHeader.Rows[0]["Hospital_Name"].ToString().Trim();





            }


            //
            /*Display Pat Bio*/
            // DataTable tblPatientBiodataReport = new DataTable();
            DataTable tblAllInfo = new DataTable();
            string SPMID = Request.QueryString["Main_ID"];

            {

                getAllInfo(ref tblAllInfo, SPMID); //Session["YearlyNo"].ToString(), SPMID);

                if (tblAllInfo.Rows.Count > 0)
                {

                    {


                        PatNameInfo = tblAllInfo.Rows[0]["Prefix"] + "  " + ENC.Encrypt_Main(tblAllInfo.Rows[0]["PFName"].ToString(), false) + " " + ENC.Encrypt_Main(tblAllInfo.Rows[0]["PMName"].ToString(), false) + " " + ENC.Encrypt_Main(tblAllInfo.Rows[0]["PLName"].ToString(), false);
                        //  + " " + tblAllInfo.Rows[0]["RelationName"].ToString();
                    }


                    val_Age_Gender = tblAllInfo.Rows[0]["PatientAge"].ToString() + " / " + tblAllInfo.Rows[0]["Gender"].ToString();
                    PatientType = tblAllInfo.Rows[0]["Patient_Type"].ToString();

                    MedicalRecord_RegNo_withEnc = ENC.Encrypt_Main(tblAllInfo.Rows[0]["RegNo"].ToString(), false);

                    HospitalVisit_PayID = tblAllInfo.Rows[0]["Yearly_No"].ToString();
                    ReceiptNo_SPM_ID = tblAllInfo.Rows[0]["Main_ID"].ToString();
                    Yearly_No = tblAllInfo.Rows[0]["Yearly_No"].ToString();
                    Test_Booking_Date = tblAllInfo.Rows[0]["Test_Booking_Date"].ToString();
                    MobilePhone = tblAllInfo.Rows[0]["MobilePhone"].ToString();


                    //gvPatientServicesBill.DataSource = null;
                    //gvPatientServicesBill.DataSource = tblAllInfo;
                    //gvPatientServicesBill.DataBind();

                    rptPatientServicesBill.DataSource = tblAllInfo;
                    rptPatientServicesBill.DataBind();

                    DataTable tblEmpInfo = new DataTable();
                    if (Session["Emp_ID"] != null)
                        getEmpName(ref tblEmpInfo);
                    if (tblEmpInfo.Rows.Count > 0)
                    {
                        loginUserName = tblEmpInfo.Rows[0]["EFName"].ToString();
                        Dept_Name = tblEmpInfo.Rows[0]["Dept_Name"].ToString();

                    }





                }
            }




            /*----------------------------------------*/




        }
        catch (Exception ex)
        {
            Response.Write(ex.Message + " Load ");
        }



    }

    void getEmpName(ref DataTable tbl)
    {
        string query = "";
        tbl.Rows.Clear();
        query = " SELECT     Employee.Prefix, ISNULL(Employee.EFName, '') AS EFName, ISNULL(Employee.EMName, '') AS EMName, ISNULL(Employee.ELName, '') AS ELName, Department.Dept_Name FROM         Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID where Employee.EmpID=" + Session["emp_ID"].ToString();
        selectDataReader(ref tbl, query);
    }
    public void Employee_Info(ref DataTable tbl, string empID)
    {

        string query = "";
        tbl.Rows.Clear();
        query = "exec   [GetEmpinfo]'" + empID + "'"

            ;
        selectDataReader(ref tbl, query);

    }
    public void selectDataReader(ref DataTable tbl, String query)
    {
        SqlCommand objcomm = new SqlCommand();


        creatconnection();
        objcomm.Connection = objconn;
        objcomm.CommandText = query;


        IDataReader objIDataReader = objcomm.ExecuteReader();
        DataSet ds = new DataSet();
        ds.Load(objIDataReader, LoadOption.PreserveChanges, "tbl");
        tbl = ds.Tables[0];
        objIDataReader.Close();
        objIDataReader.Dispose();
        ClosedbConnection();

    }

    public void creatconnection()
    {
        objconn = new SqlConnection(strconn);
        objconn.Open();
    }

    public void ClosedbConnection()
    {
        objconn.Close();
        objconn.Dispose();
    }
    void getAllInfo(ref DataTable tbl, string Main_Id)
    {


        string query = "";
        tbl.Rows.Clear();
        strconn = ConfigurationManager.ConnectionStrings["OT_ManagementConnectionString"].ConnectionString;
        query = "exec   [SampleSlip_Rd]'" + Main_Id + "'"
           ;
        selectDataReader(ref tbl, query);
    }
    protected void rptPatientServicesBill_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {

    }
  
}