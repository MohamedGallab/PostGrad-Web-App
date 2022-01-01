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
    public partial class ExaminerLookUp : System.Web.UI.Page
    {
        private readonly DBMaster dbm = new DBMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void lookUpConfirm_Click(object sender, EventArgs e)
        {
            SqlCommand thesisLookupProc = new SqlCommand("ExaminerSearch");
            string word = lookUpB.Text;
            thesisLookupProc.Parameters.Add(new SqlParameter("@word", SqlDbType.VarChar)).Value = word;
            dbm.DisplayTable(thesisLookupProc, ThesisView);
        }

        protected void backBB_Click(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerHome.aspx");
        }
    }
}