using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PostGrad_Web_App
{
	public partial class ExaminerHome : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{

		}


        protected System.Void EditInfo_Click(System.Object sender, System.EventArgs e)
        {
            Response.Redirect("ExaminerEditInfo.aspx");
        }

        protected System.Void ViewInfo_Click(System.Object sender, System.EventArgs e)
        {
            Response.Redirect("ExaminerViewInfo.aspx");
        }

        protected System.Void evaluate_Click(System.Object sender, System.EventArgs e)
        {
            Response.Redirect("ExaminerEvaluate.aspx");
        }

        protected System.Void lookUpThesis_Click(System.Object sender, System.EventArgs e)
        {
            Response.Redirect("ExaminerLookUp.aspx");
        }
    }
}