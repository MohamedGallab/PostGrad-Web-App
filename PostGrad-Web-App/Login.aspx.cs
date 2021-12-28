using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad_Web_App
{
	public partial class Login : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void LoginBtn_Click(object sender, EventArgs e)
		{
			String ConnectionString = WebConfigurationManager.ConnectionStrings["PostGradConnectionString"].ToString();

			SqlConnection Connection = new SqlConnection(ConnectionString);


			String email = Email.Text;
			String password = Password.Text;

			SqlCommand userLoginSimpleProc = new SqlCommand("userLoginSimple", Connection);
			userLoginSimpleProc.CommandType = CommandType.StoredProcedure;

			userLoginSimpleProc.Parameters.Add(new SqlParameter("@email", SqlDbType.VarChar)).Value = email;
			userLoginSimpleProc.Parameters.Add(new SqlParameter("@password", SqlDbType.VarChar)).Value = password;

			SqlParameter success = userLoginSimpleProc.Parameters.Add("@success", SqlDbType.Bit);
			success.Direction = System.Data.ParameterDirection.Output;

			SqlParameter type = userLoginSimpleProc.Parameters.Add("@type", SqlDbType.Int);
			type.Direction = System.Data.ParameterDirection.Output;

			Connection.Open();
			userLoginSimpleProc.ExecuteNonQuery();
			Connection.Close();
			System.Diagnostics.Debug.WriteLine(success.Value + " " + type.Value);
			Session["user"] = email;
			System.Diagnostics.Debug.WriteLine(Session["user"]);
			//--check user type 0-- > Student,1-- > Admin,2-- > Supervisor ,3-- > Examiner
			if (Convert.ToBoolean(success.Value))
			{
				switch (type.Value)
				{
					case 0:
						Response.Redirect("StudentHome.aspx");
						break;
					case 1:
						Response.Redirect("AdminHome.aspx");
						break;
					case 2:
						Response.Redirect("SupervisorHome.aspx");
						break;
					case 3:
						Response.Redirect("ExaminerHome.aspx");
						break;
				} }
			else
			{
				Response.Write("Wrong Email or Password, Please Try again");
			}
		}
	}
}