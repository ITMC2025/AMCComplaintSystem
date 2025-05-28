<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="AMCComplaintSystem.LoginForm" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Login - AMC Complaint System</title>
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="Styles/custom.css" />
</head>
<body class="bg-gradient">

    <div class="container vh-100 d-flex align-items-center">
        <div class="row w-100">
            <!-- Left: Welcome Text -->
            <div class="col-md-6 d-flex flex-column justify-content-center px-4">
                <h1 class="fw-bold text-primary">AMC Complaint / Feedback Portal - IT Services</h1>
                <p class="mt-3 fs-5 text-muted">Smarter life, smoother support — just a little help to get more done!</p>
            </div>

            <!-- Right: Login Form -->
            <div class="col-md-6 d-flex justify-content-center align-items-center">
                <div class="card login-card">
                    <div class="card-body">
                        <h2 class="text-center mb-4">🔧 AMC Complaint System</h2>
                        <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-danger d-none" EnableViewState="false"></asp:Label>

                        <form id="form1" runat="server">
                            <div class="mb-3">
                                <label for="txtEmail" class="form-label">📧 Email:</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email"></asp:TextBox>
                                <asp:RequiredFieldValidator 
                                    ID="rfvEmail" 
                                    runat="server" 
                                    ControlToValidate="txtEmail" 
                                    ErrorMessage="Email is required." 
                                    Display="Dynamic" 
                                    ForeColor="Red" />
                            </div>

                            <div class="mb-3">
                                <label for="txtPassword" class="form-label">🔑 Password:</label>
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                                <asp:RequiredFieldValidator 
                                    ID="rfvPassword" 
                                    runat="server" 
                                    ControlToValidate="txtPassword" 
                                    ErrorMessage="Password is required." 
                                    Display="Dynamic" 
                                    ForeColor="Red" />
                            </div>

                            <div class="d-grid">
                                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary btn-lg" OnClick="btnLogin_Click" />
                            </div>

                            <p class="text-center mt-3">
                                <a href="ForgotPassword.aspx" class="text-decoration-none" hidden>Forgot Password?</a>
                            </p>

                            <div class="text-center mt-3">
                                <span>Don't have an account?</span>
                                <a href="Register.aspx" class="text-decoration-none text-danger">Sign Up</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
