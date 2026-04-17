<%@ page import="com.shaheed.entity.*" %>
<%@ include file="layout/navbar.jsp" %>
<%
  FamilyUser user = (FamilyUser) request.getAttribute("user");
  if(user==null) user = (FamilyUser) session.getAttribute("loggedUser");
  if(user==null){ response.sendRedirect(request.getContextPath()+"/login"); return; }
%>
<div class="page-wrap" style="max-width:760px">
  <a href="${pageContext.request.contextPath}/dashboard" class="back-btn">
    <i class="fas fa-arrow-left"></i> Back to Dashboard
  </a>
  <div class="page-header">
    <div class="page-title">Edit Profile</div>
    <div class="page-sub">Update your personal details. Email cannot be changed.</div>
  </div>

  <% if(request.getAttribute("success")!=null){ %>
  <div class="alert alert-success">${success}</div>
  <% } %>
  <% if(request.getAttribute("error")!=null){ %>
  <div class="alert alert-error">${error}</div>
  <% } %>

  <div class="card">
    <form action="${pageContext.request.contextPath}/profile/update" method="post">
      <div class="form-section-title">Personal Information</div>
      <div class="form-row">
        <div class="form-group">
          <label>Full Name *</label>
          <input type="text" name="name" value="<%= user.getName()!=null?user.getName():"" %>" required>
        </div>
        <div class="form-group">
          <label>Email (Cannot Change)</label>
          <input type="email" value="<%= user.getEmail() %>" disabled style="background:#eee; cursor:not-allowed">
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Date of Birth</label>
          <input type="date" name="dob" value="<%= user.getDob()!=null?user.getDob():"" %>">
        </div>
        <div class="form-group">
          <label>Gender</label>
          <select name="gender">
            <option value="">Select</option>
            <option value="Male"   <%= "Male".equals(user.getGender())?"selected":"" %>>Male</option>
            <option value="Female" <%= "Female".equals(user.getGender())?"selected":"" %>>Female</option>
            <option value="Other"  <%= "Other".equals(user.getGender())?"selected":"" %>>Other</option>
          </select>
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Mobile *</label>
          <input type="text" name="mobile" value="<%= user.getMobile()!=null?user.getMobile():"" %>" maxlength="10">
        </div>
        <div class="form-group">
          <label>Aadhaar Number</label>
          <input type="text" name="aadhaarNumber" value="<%= user.getAadhaarNumber()!=null?user.getAadhaarNumber():"" %>" maxlength="12">
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Relation With Shaheed</label>
          <select name="relationWithShaheed">
            <% String[] rels={"Wife","Son","Daughter","Father","Mother","Brother","Sister"};
               for(String r:rels){ %>
            <option value="<%= r %>" <%= r.equals(user.getRelationWithShaheed())?"selected":"" %>><%= r %></option>
            <% } %>
          </select>
        </div>
        <div class="form-group">
          <label>Marital Status</label>
          <select name="maritalStatus">
            <% String[] ms={"Married","Unmarried","Widowed","Divorced"};
               for(String m:ms){ %>
            <option value="<%= m %>" <%= m.equals(user.getMaritalStatus())?"selected":"" %>><%= m %></option>
            <% } %>
          </select>
        </div>
      </div>
      <div class="form-group">
        <label>Occupation</label>
        <input type="text" name="occupation" value="<%= user.getOccupation()!=null?user.getOccupation():"" %>">
      </div>

      <div class="form-section-title">Address</div>
      <div class="form-group">
        <label>Address Line</label>
        <input type="text" name="addressLine" value="<%= user.getAddressLine()!=null?user.getAddressLine():"" %>">
      </div>
      <div class="form-row-3">
        <div class="form-group">
          <label>City</label>
          <input type="text" name="city" value="<%= user.getCity()!=null?user.getCity():"" %>">
        </div>
        <div class="form-group">
          <label>State</label>
          <input type="text" name="state" value="<%= user.getState()!=null?user.getState():"" %>">
        </div>
        <div class="form-group">
          <label>Pincode</label>
          <input type="text" name="pincode" value="<%= user.getPincode()!=null?user.getPincode():"" %>" maxlength="6">
        </div>
      </div>

      <div style="display:flex;gap:12px;margin-top:24px;">
        <button type="submit" class="btn btn-gold">Save Changes</button>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline">Cancel</a>
      </div>
    </form>
  </div>
</div>
<%@ include file="layout/footer.jsp" %>