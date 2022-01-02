using PostGrad_Web_App.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad_Web_App.Student
{
	public partial class studentTheses : System.Web.UI.Page
	{
		private readonly DBMaster dbm = new DBMaster();
		protected void Page_Load(object sender, EventArgs e)
		{
			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				SqlCommand ViewAllTheses = new SqlCommand("ViewAllTheses");
				ViewAllTheses.Parameters.Add(new SqlParameter("@studentID", SqlDbType.Int)).Value = Convert.ToInt32(Session["userID"]);
				dbm.DisplayTable(ViewAllTheses, StudentViewThesesGridview);

			}
		}
	}
}