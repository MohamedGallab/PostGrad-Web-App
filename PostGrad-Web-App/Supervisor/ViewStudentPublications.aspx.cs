using PostGrad_Web_App.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace PostGrad_Web_App.Supervisor
{
    public partial class ViewStudentPublications : System.Web.UI.Page
    {
        DBMaster dbm = new DBMaster();
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlCommand viewAStudentPublications = new SqlCommand("ViewAStudentPublications");
            viewAStudentPublications.Parameters.Add(new SqlParameter("@StudentID", SqlDbType.Int)).Value = Session["StudentIDPublications"];
            System.Diagnostics.Debug.WriteLine(Session["StudentIDPublications"]);
            
            dbm.DisplayTable(viewAStudentPublications, PublicationsGrid);
        }
    }
}