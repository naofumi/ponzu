# Single migration copied from schema.rb on the parent app
class CreatePonzuTables < ActiveRecord::Migration
	def change
		create_table "authors", :force => true do |t|
		  t.string   "jp_name"
		  t.string   "en_name"
		  t.datetime "created_at",                        :null => false
		  t.datetime "updated_at",                        :null => false
		  t.string   "jp_name_clean"
		  t.string   "en_name_clean"
		  t.boolean  "whitelisted",    :default => false
		  t.string   "whitelisted_by"
		  t.datetime "whitelisted_at"
		end

		create_table "authorships", :force => true do |t|
		  t.datetime "created_at",                              :null => false
		  t.datetime "updated_at",                              :null => false
		  t.integer  "position"
		  t.boolean  "is_presenting_author", :default => false
		  t.string   "en_name"
		  t.string   "jp_name"
		  t.string   "affiliations"
		  t.integer  "author_id",                               :null => false
		  t.integer  "submission_id",                           :null => false
		end

		add_index "authorships", ["author_id"], :name => "index_authorships_on_author_id"
		add_index "authorships", ["submission_id", "author_id"], :name => "index_authorships_on_submission_id_and_author_id"

		create_table "chairs", :force => true do |t|
		  t.integer  "user_id"
		  t.integer  "session_id"
		  t.datetime "created_at", :null => false
		  t.datetime "updated_at", :null => false
		end

		create_table "comments", :force => true do |t|
		  t.integer  "presentation_id"
		  t.text     "text"
		  t.integer  "user_id"
		  t.datetime "created_at",      :null => false
		  t.datetime "updated_at",      :null => false
		end

		create_table "conversations", :force => true do |t|
		  t.string   "subject",    :default => ""
		  t.datetime "created_at",                 :null => false
		  t.datetime "updated_at",                 :null => false
		end

		create_table "global_messages", :force => true do |t|
		  t.text     "jp_text"
		  t.datetime "created_at", :null => false
		  t.datetime "updated_at", :null => false
		  t.text     "en_text"
		end

		create_table "likes", :force => true do |t|
		  t.integer  "presentation_id"
		  t.integer  "user_id"
		  t.datetime "created_at",                         :null => false
		  t.datetime "updated_at",                         :null => false
		  t.boolean  "scheduled",       :default => false, :null => false
		  t.string   "type"
		  t.integer  "score",           :default => 0
		end

		create_table "meet_up_comments", :force => true do |t|
		  t.integer  "meet_up_id"
		  t.integer  "user_id"
		  t.text     "content"
		  t.datetime "created_at", :null => false
		  t.datetime "updated_at", :null => false
		end

		create_table "meet_ups", :force => true do |t|
		  t.datetime "starts_at"
		  t.string   "venue"
		  t.string   "venue_url"
		  t.text     "description"
		  t.text     "meet_at"
		  t.integer  "owner_id"
		  t.datetime "created_at",  :null => false
		  t.datetime "updated_at",  :null => false
		  t.string   "title"
		  t.string   "interest"
		  t.string   "venue_phone"
		  t.string   "owner_phone"
		end

		create_table "messages", :force => true do |t|
		  t.integer  "sender_id"
		  t.string   "sender_type", :default => ""
		  t.text     "body"
		  t.string   "subject"
		  t.datetime "created_at",                  :null => false
		  t.datetime "updated_at",                  :null => false
		end

		add_index "messages", ["id"], :name => "id_test"
		add_index "messages", ["id"], :name => "index_messages_on_id"

		create_table "notifications", :force => true do |t|
		  t.string   "type"
		  t.text     "body"
		  t.string   "subject",              :default => ""
		  t.integer  "sender_id"
		  t.string   "sender_type"
		  t.integer  "conversation_id"
		  t.boolean  "draft",                :default => false
		  t.datetime "updated_at",                              :null => false
		  t.datetime "created_at",                              :null => false
		  t.integer  "notified_object_id"
		  t.string   "notified_object_type"
		  t.string   "notification_code"
		  t.string   "attachment"
		end

		add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

		create_table "pages", :force => true do |t|
		  t.string   "url"
		  t.text     "body"
		  t.datetime "created_at", :null => false
		  t.datetime "updated_at", :null => false
		end

		create_table "participations", :force => true do |t|
		  t.integer  "user_id"
		  t.integer  "meet_up_id"
		  t.datetime "created_at", :null => false
		  t.datetime "updated_at", :null => false
		end

		create_table "presentation_groups", :force => true do |t|
		  t.string   "name"
		  t.datetime "created_at", :null => false
		  t.datetime "updated_at", :null => false
		end

		create_table "presentations", :force => true do |t|
		  t.datetime "starts_at"
		  t.datetime "ends_at"
		  t.integer  "session_id"
		  t.string   "number"
		  t.string   "en_title",          :limit => 1000
		  t.string   "jp_title",          :limit => 1000
		  t.text     "jp_abstract"
		  t.datetime "created_at",                                           :null => false
		  t.datetime "updated_at",                                           :null => false
		  t.string   "submission_number"
		  t.text     "en_abstract"
		  t.integer  "position"
		  t.integer  "submission_id"
		  t.integer  "submitter_id"
		  t.string   "type"
		  t.boolean  "cancel",                            :default => false
		end

		add_index "presentations", ["position"], :name => "index_presentations_on_position"
		add_index "presentations", ["session_id"], :name => "index_presentations_on_session_id"

		create_table "receipts", :force => true do |t|
		  t.integer  "receiver_id"
		  t.string   "receiver_type"
		  t.integer  "message_id"
		  t.boolean  "read",          :default => false, :null => false
		  t.datetime "created_at",                       :null => false
		  t.datetime "updated_at",                       :null => false
		end

		add_index "receipts", ["message_id"], :name => "index_receipts_on_message_id"
		add_index "receipts", ["message_id"], :name => "message_id_test"
		add_index "receipts", ["receiver_id"], :name => "index_receipts_on_receiver_id"
		add_index "receipts", ["receiver_id"], :name => "receiver_id_test"

		create_table "registrants", :force => true do |t|
		  t.string   "registration_id",  :null => false
		  t.string   "password",         :null => false
		  t.string   "first_name",       :null => false
		  t.string   "middle_name"
		  t.string   "last_name",        :null => false
		  t.string   "phon_first_name"
		  t.string   "phon_middle_name"
		  t.string   "phon_last_name"
		  t.string   "salutation"
		  t.string   "affiliation"
		  t.datetime "created_at",       :null => false
		  t.datetime "updated_at",       :null => false
		end

		create_table "rooms", :force => true do |t|
		  t.datetime "created_at",  :null => false
		  t.datetime "updated_at",  :null => false
		  t.string   "jp_name"
		  t.string   "en_name"
		  t.string   "jp_location"
		  t.string   "en_location"
		  t.string   "map_url"
		  t.integer  "pin_top"
		  t.integer  "pin_left"
		  t.integer  "position"
		end

		create_table "sessions", :force => true do |t|
		  t.datetime "starts_at"
		  t.datetime "ends_at"
		  t.integer  "room_id"
		  t.string   "number"
		  t.string   "en_title",             :limit => 1000
		  t.string   "jp_title",             :limit => 1000
		  t.datetime "created_at",                           :null => false
		  t.datetime "updated_at",                           :null => false
		  t.string   "organizers_string_en"
		  t.string   "organizers_string_jp"
		  t.string   "type"
		end

		create_table "submissions", :force => true do |t|
		  t.string   "en_title",             :limit => 1000
		  t.string   "jp_title",             :limit => 1000
		  t.integer  "main_author_id"
		  t.text     "jp_abstract"
		  t.text     "en_abstract"
		  t.integer  "presenting_author_id"
		  t.string   "submission_number"
		  t.string   "keywords"
		  t.datetime "disclose_at",                                             :null => false
		  t.datetime "created_at",                                              :null => false
		  t.datetime "updated_at",                                              :null => false
		  t.string   "corresponding_email"
		  t.boolean  "show_email",                           :default => false
		  t.binary   "institutions"
		end

		create_table "umin_rows", :force => true do |t|
		  t.string   "format_type"
		  t.text     "csv"
		  t.datetime "created_at",  :null => false
		  t.datetime "updated_at",  :null => false
		end

		create_table "users", :force => true do |t|
		  t.string   "jp_name"
		  t.string   "en_name"
		  t.datetime "created_at",                                     :null => false
		  t.datetime "updated_at",                                     :null => false
		  t.string   "twitter_id"
		  t.string   "facebook_id"
		  t.string   "linkedin_id"
		  t.string   "email",                       :default => "",    :null => false
		  t.string   "crypted_password"
		  t.string   "password_salt"
		  t.string   "persistence_token"
		  t.integer  "roles_mask"
		  t.string   "perishable_token",            :default => ""
		  t.integer  "login_count",                 :default => 0,     :null => false
		  t.integer  "failed_login_count",          :default => 0,     :null => false
		  t.string   "login"
		  t.string   "registration_id_in_umin"
		  t.string   "email_in_umin"
		  t.boolean  "whitelisted",                 :default => false
		  t.string   "whitelisted_by"
		  t.datetime "whitelisted_at"
		  t.string   "read_research_map_id"
		  t.text     "other_links"
		  t.boolean  "blacklisted",                 :default => false
		  t.string   "blacklisted_by"
		  t.datetime "blacklisted_at"
		  t.integer  "registrant_whitelist_status", :default => 0,     :null => false
		  t.datetime "login_activated_at"
		  t.string   "registrant_whitelisted_by"
		  t.integer  "author_id"
		  t.string   "en_affiliation"
		  t.string   "jp_affiliation"
		end

		add_index "users", ["en_name"], :name => "index_users_on_en_name"
		add_index "users", ["jp_name"], :name => "index_users_on_jp_name"
		add_index "users", ["login", "en_name"], :name => "index_users_on_login_and_en_name"
		add_index "users", ["login", "jp_name"], :name => "index_users_on_login_and_jp_name"
		add_index "users", ["login"], :name => "index_users_on_login"

	end
end
