using Microsoft.AspNet.FriendlyUrls;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using static WebApplication1._Default;

namespace WebApplication1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void logOut_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("Default.aspx");
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (!FileUpload1.HasFile)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Please select a file to upload.');", true);
                return;
            }

            try
            {
                string fileName = FileUpload1.FileName;
                string fileExtension = Path.GetExtension(fileName).ToLower();

                if (fileExtension != ".json")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('Please upload only JSON files.');", true);
                    return;
                }

                string uploadFolder = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(uploadFolder))
                    Directory.CreateDirectory(uploadFolder);

                string savePath = Path.Combine(uploadFolder, fileName);
                FileUpload1.SaveAs(savePath);

                string jsoncontents = File.ReadAllText(savePath);
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                var newsContainer = serializer.Deserialize<NewsContainer>(jsoncontents);

                if (newsContainer?.news == null || newsContainer.news.Count == 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "alert('No news items found in JSON file.');", true);
                    return;
                }

                int successCount = 0;
                foreach (var newsItem in newsContainer.news)
                {
                    try
                    {
                        SaveNewsToDatabase(newsItem);
                        successCount++;
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine("Error saving news: " + ex.Message);
                    }
                }

                File.Delete(savePath);

                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('{successCount} news items uploaded successfully!'); window.location='Default.aspx';", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Error uploading file: " + ex.Message.Replace("'", "\\'") + "');", true);
            }
        }

        private void SaveNewsToDatabase(NewsItem newsItem)
        {
            string imageName = null;

            if (!string.IsNullOrEmpty(newsItem.imgurl) &&
                (newsItem.imgurl.StartsWith("http://") || newsItem.imgurl.StartsWith("https://")))
            {
                imageName = DownloadAndSaveImage(newsItem.imgurl);
            }

            string connectionString = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO News (title, contents, imgurl) VALUES (@title, @contents, @imgurl)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@title", newsItem.title ?? "");
                    cmd.Parameters.AddWithValue("@contents", newsItem.contents ?? "");
                    cmd.Parameters.AddWithValue("@imgurl", imageName != null ? "/images/" + imageName : (object)DBNull.Value);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private string DownloadAndSaveImage(string imageUrl)
        {
            try
            {
                string imagesFolder = Server.MapPath("~/images/");
                if (!Directory.Exists(imagesFolder))
                    Directory.CreateDirectory(imagesFolder);

                string extension = Path.GetExtension(imageUrl);
                if (string.IsNullOrEmpty(extension) || extension.Length > 5)
                    extension = ".jpg";

                string uniqueFileName = Guid.NewGuid().ToString() + extension;
                string savePath = Path.Combine(imagesFolder, uniqueFileName);

                using (WebClient client = new WebClient())
                {
                    client.DownloadFile(imageUrl, savePath);
                }

                return uniqueFileName;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error downloading image: " + ex.Message);
                return null;
            }
        }

    }

    public class NewsItem
    {
        public string title { get; set; }
        public string contents { get; set; }
        public string imgurl { get; set; }
    }

    public class NewsContainer
    {
        public List<NewsItem> news { get; set; }
    }
}