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
	public partial class StudentProgressReport : System.Web.UI.Page
	{
        private readonly DBMaster dbm = new DBMaster();
        protected void Page_Load(object sender, EventArgs e)
		{

		}

        protected void addReportBtn_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = dbm.GetSqlConnection())
            {
                SqlCommand AddProgressReport = new SqlCommand("AddProgressReport")
                {
                    Connection = connection,
                    CommandType = CommandType.StoredProcedure
                };

                Label successful = new Label();
                successful.CssClass = "success";
                try
                {
                    AddProgressReport.Parameters.Add("@thesisSerialNo", SqlDbType.Int).Value = Convert.ToInt32(ThesisSerialNo.Text);
                    AddProgressReport.Parameters.Add("@progressReportDate", SqlDbType.Date).Value = ProgressReportDate.SelectedDate.ToShortDateString();
                    AddProgressReport.Parameters.Add("@studentID", SqlDbType.Int).Value = Convert.ToInt32(Session["userID"]);
                    AddProgressReport.Parameters.Add("@progressReportNo", SqlDbType.Int).Value = Convert.ToInt32(ProgressReportNoText.Text);

                    AddProgressReport.ExecuteNonQuery();
                    successful.Text = "progress report successfully added";
                }
                catch (FormatException)
                {
                    successful.Text = "Please Fill all fields with valid values";
                    successful.CssClass = "errors";
                }
                catch (SqlException ex)
                {
                    successful.Text = ex.Message;
                    successful.CssClass = "errors";
                }
                catch (Exception ex)
                {
                    successful.Text = ex.Message;
                    successful.CssClass = "errors";
                }
                addReportSuccess.Controls.Add(successful);
            }
        }

        protected void fillReportBtn_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = dbm.GetSqlConnection())
            {
                SqlCommand FillProgressReport = new SqlCommand("FillProgressReport")
                {
                    Connection = connection,
                    CommandType = CommandType.StoredProcedure
                };
               
                Label successful = new Label();
                successful.CssClass = "success";
                try
                {
                    FillProgressReport.Parameters.Add("@thesisSerialNo", SqlDbType.Int).Value = Convert.ToInt32(SerialNumText.Text);
                    FillProgressReport.Parameters.Add("@progressReportNo", SqlDbType.Date).Value = Convert.ToInt32(ProgressReportNumText.Text);
                    FillProgressReport.Parameters.Add("@state", SqlDbType.Int).Value = Convert.ToInt32(StateText.Text);
                    FillProgressReport.Parameters.Add("@description", SqlDbType.VarChar).Value = DescriptionText.Text;
                    FillProgressReport.Parameters.Add("@studentID", SqlDbType.Int).Value = Convert.ToInt32(Session["userID"]);

                    FillProgressReport.ExecuteNonQuery();
                    successful.Text = "progress report successfully filled";
                }
                catch (FormatException)
                {
                    successful.Text = "Please Fill all fields with valid values";
                    successful.CssClass = "errors";
                }
                catch (SqlException ex)
                {
                    successful.Text = ex.Message;
                    successful.CssClass = "errors";
                }
                catch (Exception ex)
                {
                    successful.Text = ex.Message;
                    successful.CssClass = "errors";
                }
                fillReportSuccess.Controls.Add(successful);
            }
        }
    }
}