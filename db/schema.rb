# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111130054623) do

  create_table "contracts", :force => true do |t|
    t.string   "uuid"
    t.string   "email_1"
    t.string   "email_2"
    t.text     "responses"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "review_session_1"
    t.string   "review_session_2"
    t.string   "slaw_uuid"
    t.text     "body"
    t.string   "title"
    t.string   "signer_1"
    t.string   "signer_2"
  end

  create_table "interested_people", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "signatures", :force => true do |t|
    t.integer  "contract_id"
    t.string   "contract_uuid"
    t.string   "signature_uuid"
    t.string   "identity_verification_method"
    t.string   "identity_verification_value"
    t.string   "callback_signature_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "signer_uuid"
  end

end
