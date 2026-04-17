<%@ page import="com.shaheed.entity.*" %>
<%@ include file="layout/navbar.jsp" %>
<%
  FamilyUser user = (FamilyUser) session.getAttribute("loggedUser");
  if(user == null){ response.sendRedirect(request.getContextPath()+"/login"); return; }
  Shaheed s = (Shaheed) request.getAttribute("shaheed");
%>
<div class="page-wrap" style="max-width:760px">
  <a href="${pageContext.request.contextPath}/dashboard" class="back-btn">
    <i class="fas fa-arrow-left"></i> Back to Dashboard
  </a>
  <div class="page-header">
    <div class="page-title">Shaheed Details</div>
    <div class="page-sub"><%= s!=null ? "Update details of the martyr" : "Enter details of the martyr" %></div>
  </div>

  <% if(request.getAttribute("error") != null){ %>
  <div class="alert alert-error">${error}</div>
  <% } %>

  <div class="card">
    <div class="alert alert-info">Please fill accurate details as per Army records. Name and Service Number are mandatory.</div>

    <form action="${pageContext.request.contextPath}/saveShaheed" method="post">
      <% if(s != null && s.getId() != null){ %>
      <input type="hidden" name="id" value="<%= s.getId() %>">
      <% } %>

      <div class="form-section-title">Identity Details</div>
      <div class="form-row">
        <div class="form-group">
          <label>Full Name *</label>
          <input type="text" name="name" placeholder="Shaheed's full name" value="<%= s!=null&&s.getName()!=null?s.getName():"" %>" required>
        </div>
        <div class="form-group">
          <label>Rank</label>
          <select name="rank">
            <option value="">-- Select Rank --</option>
            <%
              String[] ranks = {
                "Sepoy","Lance Naik","Naik","Havildar",
                "Naib Subedar","Subedar","Subedar Major",
                "2nd Lieutenant","Lieutenant","Captain","Major",
                "Lt. Colonel","Colonel","Brigadier",
                "Major General","Lt. General","General","Field Marshal"
              };
              for(String r : ranks){
                String sel = (s!=null && r.equals(s.getRank())) ? "selected" : "";
            %>
            <option value="<%= r %>" <%= sel %>><%= r %></option>
            <% } %>
          </select>
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>Service Number *</label>
          <input type="text" name="serviceNumber" placeholder="e.g. 15472839P" value="<%= s!=null&&s.getServiceNumber()!=null?s.getServiceNumber():"" %>" required>
        </div>
        <div class="form-group">
          <label>Regiment</label>
          <input type="text" name="regiment" placeholder="e.g. Rajputana Rifles" value="<%= s!=null&&s.getRegiment()!=null?s.getRegiment():"" %>">
        </div>
      </div>
      <div class="form-group">
        <label>Army Unit</label>
        <input type="text" name="armyUnit" placeholder="e.g. 7 RAJRIF" value="<%= s!=null&&s.getArmyUnit()!=null?s.getArmyUnit():"" %>">
      </div>

      <div class="form-section-title">Dates &amp; Place</div>
      <div class="form-row">
        <div class="form-group">
          <label>Date of Birth</label>
          <input type="date" name="dateOfBirth" value="<%= s!=null&&s.getDateOfBirth()!=null?s.getDateOfBirth():"" %>">
        </div>
        <div class="form-group">
          <label>Date of Martyrdom</label>
          <input type="date" name="martyrdomDate" value="<%= s!=null&&s.getMartyrdomDate()!=null?s.getMartyrdomDate():"" %>">
        </div>
      </div>
      <div class="form-group">
        <label>Place of Martyrdom</label>
        <input type="text" name="placeOfMartyrdom" placeholder="e.g. Galwan Valley, Ladakh" value="<%= s!=null&&s.getPlaceOfMartyrdom()!=null?s.getPlaceOfMartyrdom():"" %>">
      </div>

      <div style="display:flex;gap:12px;margin-top:24px;">
        <button type="submit" class="btn btn-gold"><%= s!=null ? "Update & Continue" : "Save & Continue to Documents" %></button>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline">Cancel</a>
      </div>
    </form>
  </div>
</div>
<%@ include file="layout/footer.jsp" %>