using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetNoStore();
            //fire on initial load - load the news and check if the user is logged in 
            if (!IsPostBack)
            {
                LoadAllNewsData();
                UpdateAdminLinkText();
            }
        }

        private void UpdateAdminLinkText()
        {
            if (User.Identity.IsAuthenticated)
            {
                AdminLinkButton.Text = "Admin";
            }
            else
            {
                AdminLinkButton.Text = "Login";
            }
        }

        public class NewsItem
        {
            public string title { get; set; }
            public string contents { get; set; }
            public string imgurl { get; set; }
        }

        public List<NewsItem> SlideNews { get; set; }
        public List<NewsItem> ListNews { get; set; }
        public NewsItem HoverNews { get; set; }
        public NewsItem MidBoxNews { get; set; }
        public NewsItem Row3WideNews { get; set; }

        protected void AdminLink_Click(object sender, EventArgs e)
        {
            // Check if user is authenticated
            if (User.Identity.IsAuthenticated)
            {
                Response.Redirect("Admin.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        private void LoadAllNewsData()
        {
            try
            {
                // Load news from database
                List<NewsItem> allNews = LoadNewsFromDatabase();

                if (allNews != null && allNews.Count > 0)
                {
                    //rotating slides
                    SlideNews = allNews.Take(3).ToList();
                    rptSlides.DataSource = SlideNews;
                    rptSlides.DataBind();
                    rptIndicators.DataSource = SlideNews;
                    rptIndicators.DataBind();

                    //bulleted lists
                    ListNews = allNews.Skip(3).Take(6).ToList();

                    //last three
                    HoverNews = allNews[9 % allNews.Count];
                    MidBoxNews = allNews[10 % allNews.Count];
                    Row3WideNews = allNews[11 % allNews.Count];
                }
                else
                {
                    // If database is empty, set default values
                    SetDefaultNews();
                }
            }
            catch (Exception ex)
            {
                //if that fails, set error messages
                SetDefaultNews();
            }
        }

        private List<NewsItem> LoadNewsFromDatabase()
        {
            List<NewsItem> newsList = new List<NewsItem>();

            string connectionString = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT title, contents, imgurl FROM News ORDER BY ID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string imageFileName = reader["imgurl"] != DBNull.Value ? reader["imgurl"].ToString() : "";

                            newsList.Add(new NewsItem
                            {
                                title = reader["title"].ToString(),
                                contents = reader["contents"].ToString(),
                                imgurl = imageFileName
                            });
                        }
                    }
                }
            }

            return newsList;
        }

        private void SetDefaultNews()
        {
            SlideNews = new List<NewsItem>();
            ListNews = new List<NewsItem>();
            HoverNews = new NewsItem { title = "No News", contents = "No news available", imgurl = "" };
            MidBoxNews = new NewsItem { title = "No News", contents = "No news available", imgurl = "" };
            Row3WideNews = new NewsItem { title = "No News", contents = "No news available", imgurl = "" };
        }
    }
}