
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="AMCComplaintSystem.Register" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register - AMC Complaint System</title>
    <%--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">--%>
   <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css" />
    <style>
         .register-card {
    width: 550px; /* Slightly wider for better spacing */
    min-height: 550px; /* Increased minimum height */
    max-height: 85vh; /* Adjusted to avoid overflow issues */
    padding: 20px; /* Added padding for better spacing */
    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2); /* Slightly stronger shadow */
    border-radius: 12px; /* Slightly rounded corners */
    background-color: #ffffff; /* Ensure a clean background */
    overflow-y: auto; /* Allow scrolling if content exceeds height */
    scrollbar-width: thin; /* Firefox */
    scrollbar-color: rgba(0, 0, 0, 0.2) transparent; /* Custom scrollbar */
}

/* Custom Scrollbar for WebKit (Chrome, Edge, Safari) */
.register-card::-webkit-scrollbar {
    width: 6px;
}
.register-card::-webkit-scrollbar-thumb {
    background: rgba(0, 0, 0, 0.3);
    border-radius: 6px;
}

/* Centering the card in the viewport */
.container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh; /* Full screen height */
}

/* Style for "Create an Account" heading */
.register-card h5 {
    color: red !important; /* Ensure red color applies */
    font-weight: 300;
}

/* Responsive Design for Smaller Screens */
@media (max-width: 600px) {
    .register-card {
        width: 90%; /* Adjust for smaller screens */
        min-height: auto; /* Avoid excessive height */
    }
}
    </style>


</head>
<body>
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card register-card">
            <div class="card-body">
                <h3 class="text-center mb-3">🔧 AMC Complaint System</h3>
                <h5 class="text-center">Create an Account</h5>

                <form id="form1" runat="server">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" EnableViewState="false"></asp:Label>

                    <!-- Full Name -->
                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtFullName">Full Name:</asp:Label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                            ControlToValidate="txtFullName" ErrorMessage="Full Name is required"
                            ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Email -->
                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtEmail">Email:</asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                            ControlToValidate="txtEmail" ErrorMessage="Email is required"
                            ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEmail" runat="server"
                            ControlToValidate="txtEmail"
                            ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                            ErrorMessage="Enter a valid email address"
                            ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>

                    <!-- Mobile Number -->
                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtMobileNo">Mobile Number:</asp:Label>
                        <asp:TextBox ID="txtMobileNo" runat="server" CssClass="form-control" TextMode="Phone"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvMobile" runat="server"
                            ControlToValidate="txtMobileNo" ErrorMessage="Mobile Number is required"
                            ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revMobile" runat="server"
                            ControlToValidate="txtMobileNo"
                            ValidationExpression="^\d{10}$"
                            ErrorMessage="Enter a valid 10-digit mobile number"
                            ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>

                    <!-- Address -->
                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtAddress">Address:</asp:Label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                            ControlToValidate="txtAddress" ErrorMessage="Address is required"
                            ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Password -->
                    <div class="mb-3">
                        <asp:Label runat="server" AssociatedControlID="txtPassword">Password:</asp:Label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                            ControlToValidate="txtPassword" ErrorMessage="Password is required"
                            ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                      <%--  <asp:RegularExpressionValidator ID="revPassword" runat="server"
                            ControlToValidate="txtPassword"
                            ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$"
                            ErrorMessage="Password must be at least 8 characters long and include 1 uppercase, 1 lowercase, and 1 number."
                            ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                    </div>

                    <!-- Register Button -->
                    <div class="mb-3">
                        <asp:Button ID="btnRegister" runat="server" Text="Register"
                            CssClass="btn btn-primary w-100" OnClick="btnRegister_Click" />
                    </div>

                    <p class="text-center">
                        <a href="LoginForm.aspx" class="text-danger">Already have an account? Login</a>
                    </p>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
