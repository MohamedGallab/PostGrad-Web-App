using PostGrad_Web_App.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad_Web_App
{
    public partial class ExaminerViewInfo : System.Web.UI.Page
    {
        private readonly DBMaster dbm = new DBMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlCommand viewProc = new SqlCommand("ExaminerViewGucian");

            viewProc.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]); ;
            dbm.DisplayTable(viewProc, gucianView);

            SqlCommand viewProcNon = new SqlCommand("ExaminerViewNonGucian");

            viewProcNon.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]); ;
            dbm.DisplayTable(viewProcNon, nonGucianView);
        }

        protected void backB_Click(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerHome.aspx");
        }
    }
}