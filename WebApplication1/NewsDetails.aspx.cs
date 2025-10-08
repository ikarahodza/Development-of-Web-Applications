using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["ID"] != null)
                {
                    int ID = Convert.ToInt32(Request.QueryString["ID"]);
                    LoadNewsDetails(ID);
                }
                else
                {
                    // Handle case where no ID is provided
                    lblTitle.Text = "News not found";
                    lblContent.Text = "The requested news article could not be found.";
                    imgNews.Visible = false;
                }
            }

        }

        private void LoadNewsDetails(int ID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT title, contents, imgurl FROM News WHERE ID = @ID";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ID", ID);

                    try
                    {
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                            lblTitle.Text = reader["title"].ToString();
                            lblContent.Text = reader["contents"].ToString();

                            string imgurl = reader["imgurl"].ToString();
                            if (!string.IsNullOrEmpty(imgurl))
                            {
                                imgNews.ImageUrl = imgurl;
                                imgNews.AlternateText = reader["title"].ToString();
                            }
                            else
                            {
                                imgNews.Visible = false;
                            }
                        }
                        else
                        {
                            lblTitle.Text = "News not found";
                            lblContent.Text = "The requested news article could not be found.";
                            imgNews.Visible = false;
                        }

                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions
                        lblTitle.Text = "Error";
                        lblContent.Text = "An error occurred while loading the news article.";
                        imgNews.Visible = false;
                        // Log the exception
                    }
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx"); // Update with your main page URL
        }
    }
}