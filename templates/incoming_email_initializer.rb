require 'rubygems'
require 'rake'
require 'rufus-scheduler'

load File.join(Rails.root, 'Rakefile')

ENV['host']='{{ redmine_incoming_email_host }}'
ENV['port']='{{ redmine_incoming_email_port }}'
ENV['username']='{{ redmine_incoming_email_username }}'
ENV['password']='{{ redmine_incoming_email_password }}'
{% if redmine_incoming_email_ssl %}ENV['ssl']='true'
{% endif %}
{% if redmine_outgoing_email_starttls %}ENV['starttls']='true'
{% endif %}
ENV['project']='{{ redmine_incoming_email_default_project }}'
ENV['tracker']='{{ redmine_incoming_email_default_tracker }}'
ENV['allow_override']='{{ redmine_incoming_email_allow_override }}'
ENV['unknown_user']='{{ redmine_incoming_email_unknown_user }}'

scheduler_lab = Rufus::Scheduler.new
# Check emails every minute
scheduler_lab.interval '1m' do
  task = Rake.application['redmine:email:receive_imap']
  task.reenable
  task.invoke
end
