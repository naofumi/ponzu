json.user_id current_user && current_user.id

json.cache! ['v2', current_conference, I18n.locale, "/comments/", @presentation] do
  json.renderer do
    json.template "templates/dot/comments_presentation"
    json.expiry (@expiry || Kamishibai::Cache::DEFAULT_EXPIRY)
  end
  json.presentation_id @presentation.id
  authors = @presentation.authors.compact
  json.comments @presentation.comments.order("rgt DESC") do |comment|
    json.id comment.id
    json.is_author authors.include?(comment.user.author)
    json.depth comment.ancestors.size
    json.is_leaf comment.leaf?
    json.created_at l(comment.created_at, :format => :month_day_time)
    json.user_name comment.user.name
    json.user_id comment.user.id
    json.text sanitize(auto_link(comment.text))
  end
end