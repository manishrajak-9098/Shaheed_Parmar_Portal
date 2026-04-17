<%@ page import="com.shaheed.entity.*,java.util.*" %>
<%@ include file="layout/navbar.jsp" %>
<%
  FamilyUser user = (FamilyUser) session.getAttribute("loggedUser");
  if(user==null){ response.sendRedirect(request.getContextPath()+"/login"); return; }
  Application app  = (Application) request.getAttribute("application");
  List<FacilityAllocation> als = (List<FacilityAllocation>) request.getAttribute("allocations");
  List<Facility> facs = (List<Facility>) request.getAttribute("facilities");
  Shaheed shaheed = (Shaheed) request.getAttribute("shaheed");
%>
<div class="page-wrap">
  <a href="${pageContext.request.contextPath}/dashboard" class="back-btn">
    <i class="fas fa-arrow-left"></i> Back to Dashboard
  </a>
  <div class="page-header">
    <div class="page-title">My Status &amp; History</div>
    <div class="page-sub">Complete record of your application, verification, and benefits</div>
  </div>

  <div class="card">
    <div class="card-title">Application Status</div>
    <% if(app==null){ %>
    <div class="alert alert-warning">No application submitted yet. Please add Shaheed details and upload documents first.</div>
    <div style="margin-top:12px"><a href="${pageContext.request.contextPath}/shaheedDetails" class="btn btn-gold btn-sm">Start Application</a></div>
    <% }else{ %>
    <div class="form-row">
      <div><p class="text-xs muted">Application ID</p><p class="bold">#APP-<%= String.format("%05d",app.getId()) %></p></div>
      <div><p class="text-xs muted">Submitted On</p><p class="bold"><%= app.getSubmissionDate()!=null?app.getSubmissionDate().toString().substring(0,10):"N/A" %></p></div>
      <div><p class="text-xs muted">Status</p><span class="badge badge-<%= app.getVerificationStatus().toLowerCase() %>"><%= app.getVerificationStatus() %></span></div>
      <div><p class="text-xs muted">Verified On</p><p class="bold"><%= app.getVerifiedDate()!=null?app.getVerifiedDate().toString().substring(0,10):"Awaiting" %></p></div>
    </div>
    <% if(app.getAdminRemarks()!=null&&!app.getAdminRemarks().isEmpty()){ %>
    <div class="alert alert-info mt-16"><strong>Admin Remarks:</strong> <%= app.getAdminRemarks() %></div>
    <% } %>
    <% } %>
  </div>

  <% if(shaheed!=null){ %>
  <div class="card">
    <div class="card-title">Shaheed Record</div>
    <div class="form-row">
      <div><p class="text-xs muted">Name</p><p class="bold"><%= shaheed.getName() %></p></div>
      <div><p class="text-xs muted">Rank</p><p class="bold"><%= shaheed.getRank()!=null?shaheed.getRank():"-" %></p></div>
      <div><p class="text-xs muted">Service No.</p><p class="bold"><%= shaheed.getServiceNumber() %></p></div>
      <div><p class="text-xs muted">Regiment</p><p class="bold"><%= shaheed.getRegiment()!=null?shaheed.getRegiment():"-" %></p></div>
      <div><p class="text-xs muted">Martyrdom Date</p><p class="bold"><%= shaheed.getMartyrdomDate()!=null?shaheed.getMartyrdomDate():"-" %></p></div>
      <div><p class="text-xs muted">Place</p><p class="bold"><%= shaheed.getPlaceOfMartyrdom()!=null?shaheed.getPlaceOfMartyrdom():"-" %></p></div>
    </div>
  </div>
  <% } %>

  <div class="card">
    <div class="card-title">Benefits History</div>
    <% if(als==null||als.isEmpty()){ %>
    <div class="alert alert-info">No benefits allocated yet. Benefits are assigned after your application is verified by admin.</div>
    <% }else{ %>
    <div class="table-wrap">
      <table class="data-table">
        <thead><tr><th>#</th><th>Benefit</th><th>Type</th><th>Start Date</th><th>Status</th><th>Remarks</th><th>Allocated On</th></tr></thead>
        <tbody>
          <% int bn=1; for(FacilityAllocation fa:als){ String fn="N/A", ft=""; if(facs!=null) for(Facility f:facs){ if(f.getId().equals(fa.getFacilityId())){ fn=f.getName(); ft=f.getFacilityType()!=null?f.getFacilityType():""; break; } } %>
          <tr>
            <td><%= bn++ %></td><td><strong><%= fn %></strong></td><td><span class="badge badge-gold"><%= ft %></span></td>
            <td><%= fa.getStartDate()!=null?fa.getStartDate():"TBD" %></td><td><span class="badge badge-active"><%= fa.getStatus() %></span></td>
            <td><%= fa.getRemarks()!=null&&!fa.getRemarks().isEmpty()?fa.getRemarks():"—" %></td>
            <td><%= fa.getAllocatedDate()!=null?fa.getAllocatedDate().toString().substring(0,10):"" %></td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div>
    <% } %>
  </div>

  <div class="card">
    <div class="card-title">Your Profile</div>
    <div class="form-row">
      <div><p class="text-xs muted">Name</p><p class="bold"><%= user.getName() %></p></div>
      <div><p class="text-xs muted">Email</p><p class="bold"><%= user.getEmail() %></p></div>
      <div><p class="text-xs muted">Mobile</p><p class="bold"><%= user.getMobile()!=null?user.getMobile():"-" %></p></div>
      <div><p class="text-xs muted">Relation</p><p class="bold"><%= user.getRelationWithShaheed()!=null?user.getRelationWithShaheed():"-" %></p></div>
      <div><p class="text-xs muted">City / State</p><p class="bold"><%= (user.getCity()!=null?user.getCity():"-") %> / <%= (user.getState()!=null?user.getState():"-") %></p></div>
      <div><p class="text-xs muted">Account Status</p><span class="badge badge-<%= user.getStatus()!=null?user.getStatus().toLowerCase():"pending" %>"><%= user.getStatus()!=null?user.getStatus():"PENDING" %></span></div>
    </div>
    <div style="margin-top:16px"><a href="${pageContext.request.contextPath}/profile" class="btn btn-outline btn-sm">Edit Profile</a></div>
  </div>
</div>
<%@ include file="layout/footer.jsp" %>