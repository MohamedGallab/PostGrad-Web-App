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
			//< asp:GridView ID = "ListSupGridView" runat = "server" ></ asp:GridView >
			SqlCommand AdminListSupProc = new SqlCommand("AdminListSup");
			GridView gridView = new GridView();
			gridView.ID = "ListSupGridView";
			
			dbm.DisplayTable(AdminListSupProc, gridView);
			ListSupGridViewPanel.Controls.Add(gridView);

		}

		protected void ListTheses_Click(object sender, EventArgs e)
		{
			SqlCommand AdminViewAllThesesProc = new SqlCommand("AdminViewAllTheses");
			
			GridView gridView = new GridView();
			gridView.ID = "ListThesesGridView";
			dbm.DisplayTable(AdminViewAllThesesProc, gridView);

			Label ThesesCountLabel = new Label();
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
			ThesesCountPanel.Controls.Add(ThesesCountLabel);
			ListThesesGridPanel.CssClass = "table table-borderless";
			ListThesesGridPanel.Controls.Add(gridView);
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

				Label successful = new Label();
				successful.CssClass = "success";

				try
				{
					AdminUpdateExtensionProc.Parameters.Add("@ThesisSerialNo", SqlDbType.Int).Value = Convert.ToInt32(ExtendThesisTxt.Text);
					if(AdminUpdateExtensionProc.ExecuteNonQuery() == -1)
					{
						throw new Exception("This Thesis Serial Number does not exist");
					}
					successful.Text = "Successfully extended thesis";
				}
				catch (FormatException)
				{
					successful.Text = "Please Enter A Number";
					successful.CssClass = "errors";
				}
				catch (Exception ex)
				{
					successful.Text = ex.Message;
					successful.CssClass = "errors";
				}
				ExtendThesisSuccess.Controls.Add(successful);
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

				Label successful = new Label();
				successful.CssClass = "success";
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
					successful.Text = "payment successfully issued";
				}
				catch (FormatException)
				{
					successful.Text = "Please Fill all fields with valid numbers";
					successful.CssClass = "errors";
				}
				catch (Exception ex)
				{	
					successful.Text = ex.Message;
					successful.CssClass = "errors";
				}
				IssueThesisPaymentSuccess.Controls.Add(successful);
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

				Label successful = new Label();
				successful.CssClass = "success";

				try
				{
					AdminIssueInstallPaymentProc.Parameters.Add("@paymentID", SqlDbType.Int).Value = Convert.ToInt32(IssueInstallPaymentpaymentID.Text);
					AdminIssueInstallPaymentProc.Parameters.Add("@InstallStartDate", SqlDbType.Date).Value = IssueInstallPaymentInstallStartDate.SelectedDate.ToShortDateString();

					if(IssueInstallPaymentInstallStartDate.SelectedDate.ToShortDateString().ToString().Equals("01/01/0001"))
					{
						throw new FormatException();
					}


					AdminIssueInstallPaymentProc.ExecuteNonQuery();

					successful.Text = "Successfully issued Installments";
				}
				catch (FormatException)
				{
					successful.Text = "You have to enter a payment id and choose a start date";
					successful.CssClass = "errors";
				}
				catch(SqlException ex)
				{
					successful.Text = ex.Message;
					successful.CssClass = "errors";
				}
				catch (Exception ex)
				{
					successful.Text = ex.Message;
					successful.CssClass = "errors";
				}
				IssueInstallPaymentSuccess.Controls.Add(successful);
			}
		}

	}
}