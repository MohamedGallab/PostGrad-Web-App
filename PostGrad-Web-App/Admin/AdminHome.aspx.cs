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
				SqlCommand AdminViewOnGoingThesesProc = new SqlCommand("AdminViewOnGoingTheses")
				{
					Connection = connection,
					CommandType = CommandType.StoredProcedure
				};

				SqlParameter thesisCount = AdminViewOnGoingThesesProc.Parameters.Add("@thesesCount", SqlDbType.Int);
				thesisCount.Direction = ParameterDirection.Output;

				AdminViewOnGoingThesesProc.ExecuteNonQuery();

				ThesesCountLabel.Text = "There are " + thesisCount.Value + " On-going theses";
			}
		}

		protected void ExtendThesisBtn_Click(object sender, EventArgs e)
		{
			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				SqlCommand AdminUpdateExtensionProc = new SqlCommand("AdminUpdateExtension")
				{
					Connection = connection,
					CommandType = CommandType.StoredProcedure
				};

				AdminUpdateExtensionProc.Parameters.Add("@ThesisSerialNo", SqlDbType.Int).Value = Convert.ToInt32(ExtendThesisTxt.Text);
				try
				{
					AdminUpdateExtensionProc.ExecuteNonQuery();
					ExtendThesislabel.Text = "Successfully extended thesis";
				}
				catch (Exception)
				{
					throw;
				}
			}
		}

		protected void IssueThesisPaymentBtn_Click(object sender, EventArgs e)
		{
			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				SqlCommand AdminIssueThesisPaymentProc = new SqlCommand("AdminIssueThesisPayment")
				{
					Connection = connection,
					CommandType = CommandType.StoredProcedure
				};

				AdminIssueThesisPaymentProc.Parameters.Add("@ThesisSerialNo", SqlDbType.Int).Value = Convert.ToInt32(IssueThesisPaymentThesisSerialNo.Text);
				AdminIssueThesisPaymentProc.Parameters.Add("@amount", SqlDbType.Decimal).Value = Convert.ToDecimal(IssueThesisPaymentamount.Text);
				AdminIssueThesisPaymentProc.Parameters.Add("@noOfInstallments", SqlDbType.Int).Value = Convert.ToInt32(IssueThesisPaymentnoOfInstallments.Text);
				AdminIssueThesisPaymentProc.Parameters.Add("@fundPercentage", SqlDbType.Decimal).Value = Convert.ToDecimal(IssueThesisPaymentfundPercentage.Text);

				AdminIssueThesisPaymentProc.ExecuteNonQuery();
			}
		}

		protected void IssueInstallPayment_Click(object sender, EventArgs e)
		{
			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				SqlCommand AdminIssueThesisPaymentProc = new SqlCommand("AdminIssueInstallPayment")
				{
					Connection = connection,
					CommandType = CommandType.StoredProcedure
				};

				AdminIssueThesisPaymentProc.Parameters.Add("@paymentID", SqlDbType.Int).Value = Convert.ToInt32(IssueThesisPaymentThesisSerialNo.Text);
				AdminIssueThesisPaymentProc.Parameters.Add("@InstallStartDate", SqlDbType.Date).Value = Convert.ToDecimal(IssueThesisPaymentamount.Text);

				AdminIssueThesisPaymentProc.ExecuteNonQuery();
			}
		}
	}
}