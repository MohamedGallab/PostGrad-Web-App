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
			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				SqlCommand thesisLookupProc = new SqlCommand("ExaminerSearch")
				{
					Connection = connection,
					CommandType = CommandType.StoredProcedure
				};
				try
				{
					string word = lookUpB.Text;
					thesisLookupProc.Parameters.Add(new SqlParameter("@word", SqlDbType.VarChar)).Value = word;

					if (IssueInstallPaymentInstallStartDate.SelectedDate.ToShortDateString().ToString().Equals("01/01/0001"))
					{
						throw new FormatException();
					}


					dbm.DisplayTable(thesisLookupProc, ThesisView);

					responseL.Text = "Successfully issued Installments";
				}
				catch (FormatException)
				{
					responseL.Text = "You have to enter a payment id and choose a start date";
				}
				catch (SqlException ex)
				{
					responseL.Text = ex.Message;
				}
				catch (Exception ex)
				{
					responseL.Text = ex.Message;
				}
			}
			
        }

        protected void backBB_Click(object sender, EventArgs e)
        {
            Response.Redirect("ExaminerHome.aspx");
        }
    }
}