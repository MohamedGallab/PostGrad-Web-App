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

				try
				{
					AdminUpdateExtensionProc.Parameters.Add("@ThesisSerialNo", SqlDbType.Int).Value = Convert.ToInt32(ExtendThesisTxt.Text);
					if(AdminUpdateExtensionProc.ExecuteNonQuery() == -1)
					{
						throw new Exception("This Thesis Serial Number does not exist");
					}
					ExtendThesislabel.Text = "Successfully extended thesis";
				}
				catch (FormatException)
				{
					ExtendThesislabel.Text = "Please Enter A Number";
				}
				catch (Exception ex)
				{
					ExtendThesislabel.Text = ex.Message;
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
				try
				{
					AdminIssueThesisPaymentProc.Parameters.Add("@ThesisSerialNo", SqlDbType.Int).Value = Convert.ToInt32(IssueThesisPaymentThesisSerialNo.Text);
					AdminIssueThesisPaymentProc.Parameters.Add("@amount", SqlDbType.Decimal).Value = Convert.ToDecimal(IssueThesisPaymentamount.Text);
					AdminIssueThesisPaymentProc.Parameters.Add("@noOfInstallments", SqlDbType.Int).Value = Convert.ToInt32(IssueThesisPaymentnoOfInstallments.Text);
					AdminIssueThesisPaymentProc.Parameters.Add("@fundPercentage", SqlDbType.Decimal).Value = Convert.ToDecimal(IssueThesisPaymentfundPercentage.Text);
					
					if(AdminIssueThesisPaymentProc.ExecuteNonQuery() == -1)
					{
						throw new Exception("This Thesis Serial Number does not exist");
					}
					IssueThesisPaymentLabel.Text = "payment successfully issued";
				}
				catch (FormatException)
				{
					IssueThesisPaymentLabel.Text = "Please Fill all fields with valid numbers";
				}
				catch (Exception ex)
				{
					IssueThesisPaymentLabel.Text = ex.Message;
				}
			}
		}

		protected void IssueInstallPayment_Click(object sender, EventArgs e)
		{
			using (SqlConnection connection = dbm.GetSqlConnection())
			{
				SqlCommand AdminIssueInstallPaymentProc = new SqlCommand("AdminIssueInstallPaymentMine")
				{
					Connection = connection,
					CommandType = CommandType.StoredProcedure
				};
				try
				{
					AdminIssueInstallPaymentProc.Parameters.Add("@paymentID", SqlDbType.Int).Value = Convert.ToInt32(IssueInstallPaymentpaymentID.Text);
					AdminIssueInstallPaymentProc.Parameters.Add("@InstallStartDate", SqlDbType.Date).Value = IssueInstallPaymentInstallStartDate.SelectedDate.ToShortDateString();

					if(IssueInstallPaymentInstallStartDate.SelectedDate.ToShortDateString().ToString().Equals("01/01/0001"))
					{
						throw new FormatException();
					}


					AdminIssueInstallPaymentProc.ExecuteNonQuery();

					IssueInstallPaymentMessage.Text = "Successfully issued Installments";
				}
				catch (FormatException)
				{
					IssueInstallPaymentMessage.Text = "You have to enter a payment id and choose a start date";
				}
				catch(SqlException ex)
				{
					IssueInstallPaymentMessage.Text = ex.Message;
				}
				catch (Exception ex)
				{
					IssueInstallPaymentMessage.Text = ex.Message;
				}
			}
		}

	}
}