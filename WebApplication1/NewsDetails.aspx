<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsDetails.aspx.cs" Inherits="WebApplication1.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>News Details</title>
    <link rel="stylesheet" href="Content/NewsDetails.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="news-container">
            <asp:Label ID="lblTitle" runat="server" CssClass="news-title"></asp:Label>
            <br />
            <asp:Image ID="imgNews" runat="server" CssClass="news-image" />
            <br />
            <asp:Label ID="lblContent" runat="server" CssClass="news-contents"></asp:Label>
            <br />
            <asp:Button ID="btnBack" runat="server" Text="Back to News List" CssClass="back-button" OnClick="btnBack_Click" />
        </div>
    </form>
</body>
</html>