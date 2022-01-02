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
	public partial class StudentPublication : System.Web.UI.Page
	{
        private readonly DBMaster dbm = new DBMaster();
        protected void Page_Load(object sender, EventArgs e)
		{

		}

        protected void addPublicationBtn_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = dbm.GetSqlConnection())
            {
                SqlCommand addLinkPub = new SqlCommand("addLinkPub")
                {
                    Connection = connection,
                    CommandType = CommandType.StoredProcedure
                };
                

                


                Label successful = new Label();
                successful.CssClass = "success";
                try
                {
                    addLinkPub.Parameters.Add("@thesisSerialNo", SqlDbType.Int).Value = ThesisSerialNumberText.Text;
                    addLinkPub.Parameters.Add("@studentID", SqlDbType.Int).Value = Convert.ToInt32(Session["userID"]);
                    addLinkPub.Parameters.Add("@title", SqlDbType.VarChar).Value = TitleText.Text;
                    addLinkPub.Parameters.Add("@pubDate", SqlDbType.Date).Value = PublicationDateValue.SelectedDate.ToShortDateString();
                    addLinkPub.Parameters.Add("@host", SqlDbType.VarChar).Value = HostText.Text;
                    addLinkPub.Parameters.Add("@place", SqlDbType.VarChar).Value = placeText.Text;
                    addLinkPub.Parameters.Add("@accepted", SqlDbType.Bit).Value = isAccepted.Checked;

                    addLinkPub.ExecuteNonQuery();
                    successful.Text = "publication added and linked to your thesis succesfully";
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
                addLinkPubSuccess.Controls.Add(successful);
            }
        }

    }
}