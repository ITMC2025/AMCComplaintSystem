<%@ Page Title="Create Complaint" Language="C#" MasterPageFile="~/SiteMaster/Custormer.Master" AutoEventWireup="true" CodeBehind="ForwardComplain.aspx.cs" Inherits="AMCComplaintSystem.CustormerPages.ForwardComplain" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dashboard-container">
        <h2>Create New Complaint</h2>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

       <div class="form-group">
    <label for="ddlCategory">Category:</label>
    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
        <asp:ListItem Text="--Select--" Value="-1" Selected="True" Disabled="True"></asp:ListItem>
        <asp:ListItem>Hardware</asp:ListItem>
        <asp:ListItem>Software</asp:ListItem>
    </asp:DropDownList>
    <asp:RequiredFieldValidator
        ID="rfvCategory"
        runat="server"
        ControlToValidate="ddlCategory"
        InitialValue="-1"
        ErrorMessage="Please select a category!"
        ForeColor="Red" />
</div>

<div class="form-group">
    <label for="txtDescription">Description:</label>
    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Describe your issue..."></asp:TextBox>
    <asp:RequiredFieldValidator
        ID="rfvDescription"
        runat="server"
        ControlToValidate="txtDescription"
        ErrorMessage="Description is required!"
        ForeColor="Red" />
</div>

<div class="form-group">
    <label for="fileAttachment">Attachment (optional):</label>
    <asp:FileUpload ID="fileAttachment" runat="server" CssClass="form-control" />
</div>

<asp:Button ID="btnSubmit" runat="server" Text="Submit Complaint" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />

<asp:ValidationSummary
    ID="ValidationSummary1"
    runat="server"
    HeaderText="Please fix the following errors:"
    ForeColor="Red" />


    <!-- Custom CSS -->
    <style>
        .dashboard-container {
           
            width: 100%;
            max-width: unset; 
            margin: 0 auto;
            height: auto; /* Let it expand dynamically */
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 20px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            align-items: stretch;
            gap: 15px;



        }

        

        .dashboard-container h2 {
            color: #4a76a8;
            margin-bottom: 10px;
            text-align: center;
        }

        label {
            font-weight: 500;
            color: #555;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .form-control {
            border-radius: 5px;
            border: 1px solid #ccc;
            transition: 0.3s ease;
            padding: 8px;
        }

        .form-control:focus {
            border-color: #4a76a8;
            box-shadow: 0 0 5px rgba(74, 118, 168, 0.8);
        }

        .btn-primary {
    background-color: #4a76a8;
    border-color: #4a76a8;
    color: white;
    padding: 10px 15px;
    transition: 0.3s ease;
    margin-top: 10px;
    width: 35%;
    max-width: 35%;
    border-radius: 5px;

}

.btn-primary:hover {
    background-color: #365b85;
    border-color: #365b85;
}

        #lblMessage {
            display: block;
            margin-bottom: 15px;
            font-size: 14px;
            font-weight: bold;
        }

        #fileAttachment {
            padding: 5px;
        }
    </style>
</asp:Content>

