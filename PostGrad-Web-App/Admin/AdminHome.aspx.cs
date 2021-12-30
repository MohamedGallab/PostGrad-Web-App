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
	public partial class AdminHome : System.Web.UI.Page
	{
		private readonly DBMaster dbm = new DBMaster();

		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void ListSupBtn_Click(object sender, EventArgs e)
		{
			SqlCommand AdminListSupProc = new SqlCommand("AdminListSup");

			dbm.DisplayTable(AdminListSupProc, ListSupGridView);
		}

		protected void ListTheses_Click(object sender, EventArgs e)
		{
			SqlCommand AdminViewAllThesesProc = new SqlCommand("AdminViewAllTheses");
			dbm.DisplayTable(AdminViewAllThesesProc, ListThesesGridView);

			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				SqlCommand AdminViewOnGoingThesesProc = new SqlCommand("AdminViewOnGoingTheses", connection)
				{
					CommandType = CommandType.StoredProcedure
				};

				SqlParameter thesisCount = AdminViewOnGoingThesesProc.Parameters.Add("@thesesCount", SqlDbType.Int);
				thesisCount.Direction = ParameterDirection.Output;

				AdminViewOnGoingThesesProc.ExecuteNonQuery();

				ThesesCountLabel.Text = "There are " + thesisCount.Value + " On-going theses";
			}
		}
	}
}