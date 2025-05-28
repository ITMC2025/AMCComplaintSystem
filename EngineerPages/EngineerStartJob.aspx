<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/Engineer.Master" AutoEventWireup="true" CodeBehind="EngineerStartJob.aspx.cs" Inherits="AMCComplaintSystem.EngineerPages.EngineerStartJob" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .panel-box {
            border: 1px solid #ccc;
            padding: 20px;
            background-color: #fafafa;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
            margin-top: 20px;
            width: 100%;
        }

        .form-table td {
            padding: 6px 10px;
            vertical-align: middle;
        }

        .form-table label {
            font-weight: bold;
        }

        .report-table th, .report-table td {
            text-align: center !important;
        }

        .filter {
            margin-bottom: 10px;
        }
        .textbox {}
        .auto-style1 {
            width: 453px;
        }
    </style>

    <div class="recent-complaints" style="margin-top: 20px; width: 100%;">
        <h3 style="text-align: center; color: #333;">Assigned Complaints</h3>

        <!-- Filter Dropdown -->
        <div class="filter">
            <asp:Label runat="server" Text="Filter by Job Category:" />
            <asp:DropDownList ID="ddlJobFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlJobFilter_SelectedIndexChanged">
                <asp:ListItem Value="All" Selected="True">All</asp:ListItem>
                <asp:ListItem Value="Hardware">Hardware</asp:ListItem>
                <asp:ListItem Value="Software">Software</asp:ListItem>
            </asp:DropDownList>
        </div>

        <!-- GridView -->
        <asp:GridView ID="gvPendingComplaints" runat="server" 
            AutoGenerateColumns="False" 
            CssClass="report-table" 
            GridLines="None" 
            CellPadding="8"
            AllowPaging="true" 
            PageSize="10"
            OnRowCommand="gvPendingComplaints_RowCommand"
            style="width: 100%; margin-top: 10px; border: 1px solid #ddd; border-collapse: collapse;" OnPageIndexChanging="gvPendingComplaints_PageIndexChanging1" >
            
            <HeaderStyle BackColor="#4CAF50" ForeColor="White" Font-Bold="True" />
            <AlternatingRowStyle BackColor="#f2f2f2" />
            <RowStyle BorderColor="#ddd" HorizontalAlign="Center" />
            <Columns>
                <asp:TemplateField HeaderText="Select">
                    <ItemTemplate>
                        <asp:Button ID="btnSelect" runat="server" Text="Select" CommandName="SelectComplaint" CommandArgument='<%# Eval("ComplaintID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ComplaintID" HeaderText="Complaint ID" />
                <asp:BoundField DataField="Category" HeaderText="Category" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" DataFormatString="{0:yyyy-MM-dd}" />
            </Columns>
        </asp:GridView>

      
        <asp:Panel ID="pnlUserDetails" runat="server" Visible="false" CssClass="panel-box">
             <h4 style="text-align: center; color: #333;">Complaint Details</h4>
            <table class="form-table">
                <tr>
                    <td>
                        <asp:Label ID="lblStatus" runat="server" ForeColor="#006600" Text="Label" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style1">&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <label>
                        Complaint Id:</label></td>
                    <td class="auto-style1">
                        <asp:TextBox ID="txtComplainId" runat="server" CssClass="textbox" ReadOnly="true"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td><label>Type:</label></td>
                    <td class="auto-style1"><asp:TextBox ID="txtType" runat="server" ReadOnly="true" CssClass="textbox"></asp:TextBox></td>
                </tr>
                <tr>
                    <td><label>Description:</label></td>
                    <td class="auto-style1"><asp:TextBox ID="txtDescription" runat="server" ReadOnly="true" CssClass="textbox"></asp:TextBox></td>
                </tr>
                <tr>
                    <td><label> &nbsp;Complaint Created Date:</label></td>
                    <td class="auto-style1"><asp:TextBox ID="txtCreatedDate" runat="server" ReadOnly="true" CssClass="textbox"></asp:TextBox></td>
                </tr>
                <tr>
                    <td><label>Complaint Assigned Date:</label></td>
                    <td class="auto-style1"><asp:TextBox ID="txtAssignedDate" runat="server" ReadOnly="true" CssClass="textbox"></asp:TextBox></td>
                </tr>
                 <tr>
                    <td><label>Remarks:</label></td>
                    <td class="auto-style1"><asp:TextBox ID="txtRemarks" runat="server" CssClass="textbox" Height="76px" TextMode="MultiLine" Width="421px"></asp:TextBox></td>
                </tr>
                <tr>
                  
                        <td><label>Status:</label></td>
                   
                    <td class="auto-style1">
                        <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlJobFilter_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Value="Pending">Pending</asp:ListItem>
                            <asp:ListItem Value="InProgress">Inprogress</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                  <tr>
     <td> 
         <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary btn-lg" Text="Save" OnClick="btnSave_Click" Visible="False" />
                      </td>
     <td class="auto-style1">
         &nbsp;</td>
 </tr>
                <tr>
                    <td colspan="2" style="text-align: center; padding-top: 10px;">
                        <asp:HiddenField ID="hfUserID" runat="server" />
                    </td>
                </tr>

            </table>
        </asp:Panel>
       
    </div>

</asp:Content>

