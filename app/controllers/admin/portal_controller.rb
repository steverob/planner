class Admin::PortalController < Admin::ApplicationController

  def index
    redirect_to root_path, notice: "You can't be here" unless logged_in? and current_user.has_role?(:admin)

    @jobs_pending_approval = Job.where(approved: false, submitted: true).count
    @sponsors = Sponsor.last(5)
    @chapters = Chapter.all
    @workshops = Sessions.upcoming
    @groups = Group.all
    @subscribers = Member.subscribers.limit(10)
  end
end
