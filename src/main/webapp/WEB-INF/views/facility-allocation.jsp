<%@ page import="com.shaheed.entity.*,java.util.*" %>
<%@ include file="layout/navbar.jsp" %>
<%
  Admin admin = (Admin) session.getAttribute("loggedAdmin");
  if(admin==null){ response.sendRedirect(request.getContextPath()+"/admin/login"); return; }
  Application     app      = (Application)            request.getAttribute("application");
  FamilyUser      family   = (FamilyUser)             request.getAttribute("family");
  Shaheed         shaheed  = (Shaheed)                request.getAttribute("shaheed");
  List<Facility>  facs     = (List<Facility>)         request.getAttribute("facilities");
  List<FacilityAllocation> existing = (List<FacilityAllocation>) request.getAttribute("existingAllocations");
  String successParam = request.getParameter("success");
%>
<div class="admin-layout">
  <aside class="admin-sidebar">
    <div class="sidebar-section"><div class="sidebar-label">Main</div><a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">Dashboard</a></div>
    <div class="sidebar-section"><div class="sidebar-label">Applications</div><a href="${pageContext.request.contextPath}/admin/verification" class="sidebar-link">Pending Verification</a><a href="${pageContext.request.contextPath}/admin/applications" class="sidebar-link active">All Applications</a></div>
    <div class="sidebar-section"><div class="sidebar-label">Records</div><a href="${pageContext.request.contextPath}/admin/shaheeds" class="sidebar-link">Shaheed Records</a><a href="${pageContext.request.contextPath}/admin/allocations" class="sidebar-link">Benefit Allocations</a></div>
     <div>
    <a href="${pageContext.request.contextPath}/admin/families" class="sidebar-link">
   <i class="fas fa-users"></i> Registered Families
</a>
</div>
    <div class="sidebar-section"><a href="${pageContext.request.contextPath}/admin/logout" class="sidebar-link">Logout</a></div>
  </aside>

  <main class="admin-main">
    <a href="${pageContext.request.contextPath}/admin/applications" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Applications</a>
    <div class="page-header">
      <div class="page-title">Allocate Benefit</div>
      <div class="page-sub">Assign welfare benefits to this verified family</div>
    </div>

    <% if("true".equals(successParam)){ %><div class="alert alert-success">Benefit allocated successfully! Family can now see it in their dashboard.</div><% } %>

    <div class="form-row" style="margin-bottom:0">
      <div class="card">
        <div class="card-title">Application</div>
        <p class="text-xs muted">Application ID</p>
        <p class="bold mb-16" style="font-size:20px;">#APP-<%= String.format("%05d",app.getId()) %></p>
        <span class="badge badge-verified">VERIFIED</span>
        <p class="text-xs muted mt-16">Verified on: <%= app.getVerifiedDate()!=null?app.getVerifiedDate().toString().substring(0,10):"N/A" %></p>
        <% if(app.getAdminRemarks()!=null&&!app.getAdminRemarks().isEmpty()){ %><p class="text-xs muted mt-16">Remarks: <%= app.getAdminRemarks() %></p><% } %>
      </div>

      <div class="card">
        <div class="card-title">Family Member</div>
        <% if(family!=null){ %>
        <p class="bold mb-16" style="font-size:16px;"><%= family.getName() %></p>
        <p class="text-xs muted"><%= family.getRelationWithShaheed()!=null?family.getRelationWithShaheed():"" %> of Shaheed</p>
        <p class="text-xs muted"><%= family.getEmail() %></p>
        <p class="text-xs muted"><%= family.getMobile()!=null?family.getMobile():"-" %></p>
        <p class="text-xs muted"><%= family.getCity()!=null?family.getCity():"" %> <%= family.getState()!=null?", "+family.getState():"" %></p>
        <% } %>
      </div>

      <% if(shaheed!=null){ %>
      <div class="card">
        <div class="card-title">Shaheed</div>
        <p class="bold mb-16" style="font-size:16px;"><%= shaheed.getName() %></p>
        <p class="text-xs muted">Rank: <%= shaheed.getRank()!=null?shaheed.getRank():"-" %></p>
        <p class="text-xs muted">Service No: <%= shaheed.getServiceNumber()!=null?shaheed.getServiceNumber():"-" %></p>
        <p class="text-xs muted">Unit: <%= shaheed.getArmyUnit()!=null?shaheed.getArmyUnit():"-" %></p>
        <% if(shaheed.getMartyrdomDate()!=null){ %><p class="text-xs muted">Martyred: <%= shaheed.getMartyrdomDate() %></p><% } %>
      </div>
      <% } %>
    </div>

    <% if(existing!=null&&!existing.isEmpty()){ %>
    <div class="card">
      <div class="card-title">Already Allocated (<%= existing.size() %>)</div>
      <div class="table-wrap">
        <table class="data-table">
          <thead><tr><th>#</th><th>Benefit</th><th>Start Date</th><th>Status</th><th>Remarks</th><th>Allocated On</th></tr></thead>
          <tbody>
            <% int bn=1; for(FacilityAllocation fa:existing){ String fn="N/A"; if(facs!=null) for(Facility f:facs){ if(f.getId().equals(fa.getFacilityId())){fn=f.getName();break;} } %>
            <tr>
              <td><%= bn++ %></td><td><strong><%= fn %></strong></td><td><%= fa.getStartDate()!=null?fa.getStartDate():"TBD" %></td>
              <td><span class="badge badge-active"><%= fa.getStatus() %></span></td>
              <td><%= fa.getRemarks()!=null&&!fa.getRemarks().isEmpty()?fa.getRemarks():"—" %></td>
              <td><%= fa.getAllocatedDate()!=null?fa.getAllocatedDate().toString().substring(0,10):"" %></td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>
    <% } %>

    <div class="card">
      <div class="card-title">Allocate New Benefit</div>
      <form action="${pageContext.request.contextPath}/admin/allocate" method="post">
        <input type="hidden" name="appId" value="<%= app.getId() %>">
        <div class="form-row">
          <div class="form-group">
            <label>Select Welfare Benefit *</label>
            <select name="facilityId" required>
              <option value="">-- Choose a benefit --</option>
              <% if(facs!=null) for(Facility f:facs){ %>
              <option value="<%= f.getId() %>"><%= f.getName() %> <%= f.getFacilityType()!=null?" ("+f.getFacilityType()+")":"" %></option>
              <% } %>
            </select>
          </div>
          <div class="form-group"><label>Start Date</label><input type="date" name="startDate"></div>
        </div>
        <div class="form-group">
          <label>Remarks / Additional Notes</label>
          <input type="text" name="remarks" placeholder="e.g. Pension approved at Rs.15,000/month">
        </div>
        <div style="display:flex;gap:12px;margin-top:8px">
          <button type="submit" class="btn btn-gold">Allocate Benefit</button>
          <a href="${pageContext.request.contextPath}/admin/applications" class="btn btn-outline">Cancel</a>
        </div>
      </form>
    </div>
  </main>
</div>
<%@ include file="layout/footer.jsp" %>