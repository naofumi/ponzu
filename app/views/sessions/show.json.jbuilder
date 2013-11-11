json.renderer do
  json.template "templates/dot/show_sessions"
  json.expiry (@expiry || Kamishibai::Cache::DEFAULT_EXPIRY)
end
json.id @session.id
json.number @session.number
json.title sanitize(@session.title)
json.head_title strip_tags(@session.title)
json.poster_timetable_path @session.path(controller)
json.starts_at l(@session.starts_at, :format => :month_day_time)
json.ends_at (@session.starts_at.beginning_of_day == @session.ends_at.beginning_of_day ? 
              @session.ends_at.strftime("%H:%M") : 
              l(@session.ends_at, :format => :month_day_time))
json.organizers (@session.organizers_string ? @session.organizers_string.split('|') : [])
json.paginator ks_will_paginate(@presentations)

json.room do
  json.id @session.room.id
  json.name @session.room.name
end

json.presentations @presentations.order("presentations.position ASC, presentations.number ASC").map{|p| p.id}