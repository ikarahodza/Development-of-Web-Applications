<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication1.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login page</title>
    <link rel="stylesheet" href="Content/login.css" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="login-box">
            <h2>Login</h2>
            <div class="user-box">
                <asp:Label ID="lblUsername" runat="server" Text="Username:"></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
            </div>
            
            <div class="user-box">
                <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
            </div>

            <asp:Button ID="Button1" runat="server" Text="Login" OnClick="LoginButton_Click" CssClass="loginbutton" />
            
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>

        </div>
    </form>
</body>
</html>
