using PostGrad_Web_App.App_Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad_Web_App
{
	public partial class MainMaster : System.Web.UI.MasterPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["userID"] == null)
			{
				Response.Redirect("~/Login.aspx");
			}
		}
		protected void SignOut_Click(object sender, EventArgs e)
		{
			Session.Clear();
			Session.Abandon();
			Response.Redirect("~/Login.aspx");
		}

		protected void HomeBtn_Click(object sender, EventArgs e)
		{
			DBMaster dbm = new DBMaster();

			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				SqlCommand postGradUserTypeProc = new SqlCommand("postGradUserType")
				{
					Connection = connection,
					CommandType = CommandType.StoredProcedure
				};

				postGradUserTypeProc.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(Session["userID"]);

				SqlParameter type = postGradUserTypeProc.Parameters.Add("@type", SqlDbType.Int);
				type.Direction = System.Data.ParameterDirection.Output;

				postGradUserTypeProc.ExecuteNonQuery();

				switch (type.Value)
				{
					case 0:
						Response.Redirect("~/Student/StudentHome.aspx");
						break;
					case 1:
						Response.Redirect("~/Admin/AdminHome.aspx");
						break;
					case 2:
						Response.Redirect("~/Supervisor/SupervisorHome.aspx");
						break;
					case 3:
						Response.Redirect("~/Examiner/ExaminerHome.aspx");
						break;
				}
			}
		}
	}
}