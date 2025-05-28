<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaster/Custormer.Master" AutoEventWireup="true" CodeBehind="CustormerSendFeedbackHardware.aspx.cs" Inherits="AMCComplaintSystem.CustormerPages.CustormerSendFeedbackHardware" %>
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
      </style>

  <div class="recent-complaints" style="margin-top: 20px; width: 100%;">
      <h3 style="text-align: center; color: #333;">Feedback</h3>

       <asp:GridView ID="gvPendingComplaints" runat="server" 
     AutoGenerateColumns="False" 
     CssClass="report-table" 
     GridLines="None" 
     CellPadding="8"
     AllowPaging="true" 
     PageSize="10"
           style="width: 100%; margin-top: 10px; border: 1px solid #ddd; border-collapse: collapse;" OnRowCommand="gvPendingComplaints_RowCommand">
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
      <asp:BoundField DataField="CompletedAt" HeaderText="Completed Date" DataFormatString="{0:yyyy-MM-dd}" />
  </Columns>
       </asp:GridView>
       <asp:Label ID="lblStatus" runat="server" ForeColor="#006600" Text="Label" Visible="False"></asp:Label>
       <asp:Panel ID="pnlUserDetails" runat="server" Visible="false" CssClass="panel-box">
      <%--<h4 style="text-align: center; color: #333;">Complaint Details</h4>--%>
     <table class="form-table">
        
<tr>
    <td>
        <label>
        Complaint Id:</label></td>
    <td class="auto-style1">
        <asp:TextBox ID="txtComplainId" runat="server" CssClass="textbox" ReadOnly="true"></asp:TextBox>
    </td>
</tr>

          <tr>
    <td><label>Rating:</label></td>
    <td>
        <asp:RadioButtonList 
            ID="rblRating" 
            runat="server" 
            RepeatDirection="Horizontal" 
            CssClass="rating-list">
            <asp:ListItem Text="😄 Excellent" Value="5" />
            <asp:ListItem Text="🙂 Good" Value="4" />
            <asp:ListItem Text="😐 Average" Value="3" />
            <asp:ListItem Text="😕 Poor" Value="2" />
            <asp:ListItem Text="😡 Bad" Value="1" />
        </asp:RadioButtonList>
        <asp:RequiredFieldValidator 
            ID="rfvRating" 
            runat="server" 
            ControlToValidate="rblRating" 
            InitialValue=""
            ErrorMessage="Please select a rating." 
            Display="Dynamic" 
            ForeColor="Red" />
    </td>
</tr>




<tr>
    <td><label>Remarks:</label></td>
    <td class="auto-style1"><asp:TextBox ID="txtRemarks" runat="server" CssClass="textbox" Height="76px" TextMode="MultiLine" Width="421px"></asp:TextBox></td>
</tr>
                          <tr>
    <td> 
        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary btn-lg" Text="Save" Visible="False" OnClick="btnSave_Click" />
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
