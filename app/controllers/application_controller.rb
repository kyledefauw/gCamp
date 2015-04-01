class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :current_user, :owner_count

  def current_user
    if session[:user_id].present?
      User.find(session[:user_id])
    end
  end

  def ensure_signed_in
    unless current_user
      session[:save_session] ||= request.fullpath
      flash[:error] = "You must sign in"
      redirect_to sign_in_path
    end
  end

  def verify_member_of_project_or_admin
    unless current_user.projects.include?(@project) || current_user.admin
      flash[:error] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def verify_project_owner_or_admin
    unless Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(project_id: @project.id, role: 1)) || current_user.admin
      flash[:error] = "You do not have access to that project"
      redirect_to projects_path
    end
  end

  def owner_count(project)
    project.memberships.where(role:1).count
  end

end
