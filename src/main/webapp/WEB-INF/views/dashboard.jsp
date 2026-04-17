<%@ page import="com.shaheed.entity.*,java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="layout/navbar.jsp" %>
<%
  FamilyUser user = (FamilyUser) session.getAttribute("loggedUser");
  if(user == null){ response.sendRedirect(request.getContextPath()+"/login"); return; }
  Application app  = (Application) request.getAttribute("application");
  Shaheed  shaheed = (Shaheed)     request.getAttribute("shaheed");
  Document doc     = (Document)    request.getAttribute("document");
  List<FacilityAllocation> als  = (List<FacilityAllocation>) request.getAttribute("allocations");
  List<Facility>           facs = (List<Facility>)           request.getAttribute("facilities");
  String appStatus = (app != null) ? app.getVerificationStatus() : "NOT_SUBMITTED";
%>
<div class="page-wrap">
  <div class="flex-between mb-24">
    <div>
      <div class="page-title">Family Dashboard</div>
      <div class="page-sub">Welcome, <strong><%= user.getName() %></strong></div>
    </div>
    <div style="display:flex;gap:10px;">
      <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline btn-sm">My Profile</a>
      <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">Logout</a>
    </div>
  </div>

  <% if(request.getAttribute("success") != null){ %><div class="alert alert-success">${success}</div><% } %>
  <% if(request.getAttribute("error") != null){ %><div class="alert alert-error">${error}</div><% } %>

  <div class="stats-grid">
    <div class="stat-card">
      <span class="s-label mb-16">Application</span>
      <% if("VERIFIED".equals(appStatus)){ %><span class="badge badge-verified">VERIFIED</span>
      <% }else if("REJECTED".equals(appStatus)){ %><span class="badge badge-rejected">REJECTED</span>
      <% }else if("PENDING".equals(appStatus)){ %><span class="badge badge-pending">PENDING</span>
      <% }else{ %><span class="badge badge-pending">NOT SUBMITTED</span><% } %>
    </div>
    <div class="stat-card">
      <span class="s-label mb-16">Shaheed Details</span>
      <% if(shaheed != null){ %><span class="badge badge-verified">Added</span><% }else{ %><span class="badge badge-pending">Pending</span><% } %>
    </div>
    <div class="stat-card">
      <span class="s-label mb-16">Documents</span>
      <% if(doc != null){ %><span class="badge badge-verified">Uploaded</span><% }else{ %><span class="badge badge-pending">Pending</span><% } %>
    </div>
    <div class="stat-card">
      <div class="big-num text-success"><%= (als != null) ? als.size() : 0 %></div>
      <span class="s-label">Benefits Received</span>
    </div>
  </div>

  <div class="card">
    <div class="card-title">Application Progress</div>
    <div class="progress-steps">
      <div class="step <%= shaheed != null ? "done" : "active" %>">1. Shaheed Details</div>
      <div class="step <%= doc != null ? "done" : (shaheed != null ? "active" : "") %>">2. Upload Documents</div>
      <div class="step <%= app != null ? "done" : (doc != null ? "active" : "") %>">3. App Submitted</div>
      <div class="step <%= "VERIFIED".equals(appStatus) ? "done" : "REJECTED".equals(appStatus) ? "active" : (app != null ? "active" : "") %>">4. Admin Verify</div>
      <div class="step <%= (als != null && !als.isEmpty()) ? "done" : "" %>">5. Benefits</div>
    </div>
    <% if(app != null && app.getAdminRemarks() != null && !app.getAdminRemarks().isEmpty()){ %>
    <div class="alert alert-info mt-16"><strong>Admin Remarks:</strong> <%= app.getAdminRemarks() %></div>
    <% } %>
  </div>

  <% if(shaheed != null){ %>
  <div class="card">
    <div class="card-title">Shaheed Information</div>
    <div class="form-row">
      <div><p class="text-xs muted">Name</p><p class="bold"><%= shaheed.getName() %></p></div>
      <div><p class="text-xs muted">Rank</p><p class="bold"><%= shaheed.getRank() %></p></div>
      <div><p class="text-xs muted">Service Number</p><p class="bold"><%= shaheed.getServiceNumber() %></p></div>
      <div><p class="text-xs muted">Army Unit</p><p class="bold"><%= shaheed.getArmyUnit() %></p></div>
    </div>
  </div>
  <% } %>

  <div class="card">
    <div class="card-title">Quick Actions</div>
    <div style="display:flex;gap:12px;flex-wrap:wrap">
      <a href="${pageContext.request.contextPath}/shaheedDetails" class="btn btn-outline btn-sm"><%= shaheed == null ? "Add" : "Update" %> Shaheed Details</a>
      <a href="${pageContext.request.contextPath}/uploadDocuments" class="btn btn-outline btn-sm"><%= doc == null ? "Upload" : "Re-upload" %> Documents</a>
      <a href="${pageContext.request.contextPath}/my-status" class="btn btn-outline btn-sm">Full Status History</a>
    </div>
  </div>

  <% if(als != null && !als.isEmpty()){ %>
  <div class="card">
    <div class="card-title">Allocated Benefits</div>
    <div class="table-wrap">
      <table class="data-table">
        <thead><tr><th>#</th><th>Benefit</th><th>Start Date</th><th>Status</th><th>Remarks</th><th>Allocated On</th></tr></thead>
        <tbody>
          <% int bn = 1; for(FacilityAllocation fa : als){ String fn = "N/A"; if(facs != null) for(Facility f : facs) if(f.getId().equals(fa.getFacilityId())){ fn = f.getName(); break; } %>
          <tr>
            <td><%= bn++ %></td><td><strong><%= fn %></strong></td><td><%= fa.getStartDate()!=null?fa.getStartDate():"TBD" %></td>
            <td><span class="badge badge-active"><%= fa.getStatus() %></span></td>
            <td><%= (fa.getRemarks()!=null&&!fa.getRemarks().isEmpty())?fa.getRemarks():"—" %></td>
            <td><%= fa.getAllocatedDate()!=null?fa.getAllocatedDate().toString().substring(0,10):"" %></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
  </div>
  <% } %>
</div>
<%@ include file="layout/footer.jsp" %>