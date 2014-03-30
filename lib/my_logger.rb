class MyLogger 
  def project_activity_log project, author, text
    activity_log = ActivityLog.new
    activity_log.name = text
    activity_log.author = author
    activity_log.project = project
    activity_log.save
  end
end