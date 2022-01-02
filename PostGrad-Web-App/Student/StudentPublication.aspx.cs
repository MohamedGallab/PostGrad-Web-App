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
                SqlCommand addPublication = new SqlCommand("addPublication")
                {
                    Connection = connection,
                    CommandType = CommandType.StoredProcedure
                };
                addPublication.Parameters.Add("@title", SqlDbType.VarChar).Value = TitleText.Text;
                addPublication.Parameters.Add("@pubDate", SqlDbType.Date).Value = PublicationDateValue.SelectedDate.ToShortDateString();
                addPublication.Parameters.Add("@host", SqlDbType.VarChar).Value = HostText.Text;
                addPublication.Parameters.Add("@place", SqlDbType.VarChar).Value = placeText.Text;
                addPublication.Parameters.Add("@accepted", SqlDbType.Bit).Value = isAccepted.Checked;

                addPublication.ExecuteNonQuery();
            }
        }

        protected void LinkPubBtn_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = dbm.GetSqlConnection())
            {
                SqlCommand linkPubThesis = new SqlCommand("linkPubThesis")
                {
                    Connection = connection,
                    CommandType = CommandType.StoredProcedure
                };
                linkPubThesis.Parameters.Add("@PubID", SqlDbType.Int).Value = Convert.ToInt32(pubIdText.Text);
                linkPubThesis.Parameters.Add("@thesisSerialNo", SqlDbType.Int).Value = Convert.ToInt32(ThesisSerialNumText.Text);


                linkPubThesis.ExecuteNonQuery();
            }
        }
    }
}