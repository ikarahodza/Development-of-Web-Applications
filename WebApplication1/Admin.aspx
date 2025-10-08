<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="WebApplication1.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Page</title>
    <link rel="stylesheet" href="Content/admin.css">
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="header">
            <img src="images/admin.png" class="profile-pic">
            <h2>Welcome Admin</h2>
        </div>

        <div class="upload-box">
            <h3>Import File</h3>
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Button ID="btnUpload" runat="server" Text="Apply" OnClick="btnUpload_Click"/>
        </div>
        <asp:Button ID="btnBack" runat="server" Text="Back to Home Page" OnClick="btnBack_Click"/>
        <asp:Button ID="btnLogOut" runat="server" Text="Log out" OnClick="logOut_Click"/>
    </form>

</body>
</html>
