# News Portal – ASP.NET Web Forms

A database-driven news portal built with **ASP.NET Web Forms (C#, .NET Framework 4.7.2)** and **SQL Server**. The home page shows the latest news in a rotating slideshow, a list, and several featured cards. It has live search. Logged-in admins can import news by uploading a JSON file.

> Project for the course **Development of Web Applications**.

---

## Features

- **Home page with dynamic layout.** News is loaded from SQL Server and placed into different sections:
  - an auto-rotating slideshow with the 3 newest stories (changes every 5 seconds, with clickable indicators)
  - a "Latest News" list with the next 6 stories
  - a hover card, an image + text card, and a wide banner for featured stories
  - an embedded video and an external RSS feed widget
- **Live search.** Results appear as you type (debounced at 300 ms). They come from a custom `SearchHandler.ashx` endpoint that returns JSON and searches both titles and content.
- **News details page.** Clicking a search result opens `NewsDetails.aspx?ID=…` with the full article and its image.
- **Admin login.** Forms Authentication, with users checked against a `Users` table.
- **JSON import.** Admins upload a `.json` file of news items. Each item is saved to the database, and remote images are downloaded and stored locally under `/images` with a unique (GUID) file name.
- **Parameterized SQL queries** throughout, to protect against SQL injection.

---

## Tech stack

| Layer | Technology |
|---|---|
| Framework | ASP.NET Web Forms, .NET Framework 4.7.2 |
| Language | C#, JavaScript |
| Database | Microsoft SQL Server Express (ADO.NET / `SqlClient`) |
| Front end | HTML, CSS, Bootstrap 5.2.3, jQuery 3.7.0 |
| Other | Newtonsoft.Json, ASP.NET FriendlyUrls, Web Optimization (bundling) |

---

## Pages

| Page | Description |
|---|---|
| `Default.aspx` | Home page with the slideshow, news list, featured cards, video and search |
| `NewsDetails.aspx` | Full view of a single news article |
| `Login.aspx` | Admin login form |
| `Admin.aspx` | Admin panel: JSON news import and log out |
| `SearchHandler.ashx` | HTTP handler that returns up to 5 search results as JSON |

---

## Project structure

```
WebApplication1/
├── Default.aspx(.cs)        # Home page
├── NewsDetails.aspx(.cs)    # Article page
├── Login.aspx(.cs)          # Login
├── Admin.aspx(.cs)          # Admin panel + JSON import
├── SearchHandler.ashx(.cs)  # Search API
├── Site.Master              # Master page layout
├── App_Start/               # Bundle and route config
├── Content/                 # Site.css, Admin.css, Login.css, NewsDetails.css
├── images/                  # Static images + downloaded news images
├── videos/                  # Home page video
├── Uploads/                 # Sample JSON files
├── news.json                # Sample news data
└── Web.config               # Connection string + authentication settings
```

---

## Database setup

The app expects a SQL Server database called **`WebAssignment`** with two tables:

```sql
CREATE DATABASE WebAssignment;
GO
USE WebAssignment;
GO

CREATE TABLE News (
    ID       INT IDENTITY(1,1) PRIMARY KEY,
    title    NVARCHAR(255) NOT NULL,
    contents NVARCHAR(MAX) NOT NULL,
    imgurl   NVARCHAR(500) NULL
);

CREATE TABLE Users (
    ID       INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(100) NOT NULL UNIQUE,
    password NVARCHAR(100) NOT NULL
);

-- Create an admin account
INSERT INTO Users (username, password) VALUES ('admin', 'admin123');
```

The connection string is in `Web.config`:

```xml
<connectionStrings>
  <add name="MyConnection"
       connectionString="Data Source=.\SQLEXPRESS;Initial Catalog=WebAssignment;Integrated Security=True;TrustServerCertificate=True" />
</connectionStrings>
```

Change `Data Source` if your SQL Server instance has a different name.

---

## Getting started

### Requirements
- Windows with **Visual Studio 2019/2022** and the *ASP.NET and web development* workload
- **.NET Framework 4.7.2** developer pack
- **SQL Server Express** (or any SQL Server instance) + SQL Server Management Studio

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/ikarahodza/Development-of-Web-Applications.git
   ```
2. Open `WebApplication1/WebApplication1.sln` in Visual Studio.
3. Restore NuGet packages (right-click the solution → **Restore NuGet Packages**).
4. Create the database with the SQL script above and update the connection string if needed.
5. Press **F5** to run the site on IIS Express.

---

## Importing news (JSON format)

Log in, open the admin panel, choose a `.json` file and click **Apply**. The file must look like this:

```json
{
  "news": [
    {
      "title": "NASA's Juno Mission Checks Out Eclipse on Jupiter",
      "contents": "NASA's Juno spacecraft just managed to spot the shadow of Jupiter's moon, Io...",
      "imgurl": "https://example.com/image.jpg"
    }
  ]
}
```

- `title`: headline
- `contents`: article text
- `imgurl`: an `http(s)` image URL. The image is downloaded to `/images/` and the local path is saved in the database. Other values are ignored.

After the import, the home page shows the newest items first.
