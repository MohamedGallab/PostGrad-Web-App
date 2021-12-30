using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad_Web_App
{
	public partial class Register : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void StudentRegister_Click(object sender, EventArgs e)
		{
			Response.Redirect("Student/StudentRegister.aspx");
		}

		protected void SupervisorRegister_Click(object sender, EventArgs e)
		{
			Response.Redirect("Supervisor/SupervisorRegister.aspx");
		}

		protected void ExaminerRegister_Click(object sender, EventArgs e)
		{
			Response.Redirect("Examiner/ExaminerRegister.aspx");
		}
	}
}