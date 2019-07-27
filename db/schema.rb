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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_22_142850) do

  create_table "comm_code", primary_key: ["code_gubn", "code", "sta_date"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code_gubn", limit: 20, null: false, comment: "코드구분"
    t.string "code", limit: 20, null: false, comment: "코드"
    t.string "code_name", limit: 60, comment: "코드명"
    t.string "sta_date", limit: 8, null: false, comment: "시작일"
    t.string "end_date", limit: 8, null: false, comment: "종료일"
    t.string "del_yn", limit: 2, default: "N", comment: "삭제여부(Y,N)"
    t.date "reg_date"
    t.string "reg_id", limit: 45, collation: "latin1_swedish_ci"
    t.date "modi_date"
    t.string "modi_id", limit: 45, collation: "latin1_swedish_ci"
  end

  create_table "cost", primary_key: ["cost_id", "cost_gubn"], options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "cost_id", null: false
    t.string "cost_gubn", limit: 10, null: false
    t.integer "amt"
  end

  create_table "hospital", id: :string, limit: 10, comment: "'병원ID'", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", comment: "동물병원DB", force: :cascade do |t|
    t.string "name", limit: 100, comment: "병원명"
    t.string "service_id", limit: 10, comment: "개방서비스ID(병원DATA I/F)"
    t.string "sigu_cd", limit: 10, comment: "시군구코드(병원DATA I/F)"
    t.string "manage_no", limit: 20, comment: "관리번호(병원DATA I/F)"
    t.string "busi_in_date", limit: 8, comment: "인허가일(병원DATA I/F)"
    t.string "status_cd", limit: 2, comment: "상태코드(병원DATA I/F)"
    t.string "status_detail_cd", limit: 4, comment: "상태세부코드(병원DATA I/F)"
    t.string "busi_end_date", limit: 8, comment: "폐업일(병원DATA I/F)"
    t.string "tel_no", limit: 30, comment: "전화번호(병원DATA I/F)"
    t.string "jibun_addr", limit: 300, comment: "지번주소(병원DATA I/F)"
    t.string "addr", limit: 300, comment: "도로명주소(병원DATA I/F)"
    t.string "zip_code", limit: 10, comment: "우편번호(병원DATA I/F)"
    t.string "renew_date", limit: 45, comment: "병원DATA I/F 업데이트일"
    t.string "loca_x", limit: 10, comment: "위치좌표x(병원DATA I/F)"
    t.string "loca_y", limit: 45, comment: "위치좌표y(병원DATA I/F)"
    t.string "open_time", limit: 10, comment: "오픈시간"
    t.string "close_time", limit: 10, comment: "종료시간"
    t.string "bigo", limit: 45, comment: "비고"
    t.date "reg_date", comment: "등록일"
    t.string "reg_id", limit: 30, comment: "등록자"
    t.date "modi_date", comment: "수정일"
    t.string "modi_id", limit: 45, comment: "수정자"
    t.string "del_yn", limit: 2, comment: "삭제여부"
    t.date "del_date", comment: "삭제일"
    t.string "del_id", limit: 45, comment: "삭제자"
  end

  create_table "like_hospital", primary_key: ["id", "user_id", "hospital_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "id", null: false
    t.bigint "user_id", null: false
    t.string "hospital_id", limit: 10, null: false
    t.date "reg_date"
    t.string "reg_id", limit: 45
    t.date "modi_date"
    t.string "modi_id", limit: 45
  end

  create_table "pet", primary_key: ["id", "user_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "id", null: false, comment: "아이디"
    t.string "user_id", limit: 45, null: false, comment: "사용자아이디"
    t.string "name", limit: 45, comment: "이름"
    t.string "kind", limit: 45, comment: "종류"
    t.string "breed", limit: 45, comment: "품종"
    t.string "gender", limit: 45, comment: "성별"
    t.string "birth_date", limit: 45
    t.string "age", limit: 45, comment: "나이"
    t.integer "weight", comment: "몸무게"
    t.date "reg_date"
    t.string "reg_id", limit: 45
    t.date "modi_date"
    t.string "modi_id", limit: 45
  end

  create_table "review", id: :integer, default: nil, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "hospital_id", limit: 10
    t.bigint "user_id"
    t.integer "pet_id"
    t.string "medic_code", limit: 20
    t.string "medic_detail", limit: 20
    t.integer "period"
    t.string "heal_yn", limit: 2
    t.integer "cost_id"
    t.integer "tot_cost"
    t.string "satis1", limit: 45
    t.string "satis2", limit: 45
    t.string "satis3", limit: 45
    t.string "satis4", limit: 45
    t.string "avg_satis", limit: 45
    t.string "like", limit: 45
    t.text "reviewcol"
    t.string "hospital_review", limit: 45
    t.text "heal_review"
    t.string "file", limit: 30
    t.string "photo_file", limit: 30
    t.date "reg_date"
    t.string "reg_id", limit: 45
    t.date "modi_date"
    t.string "modi_id", limit: 45
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false, collation: "latin1_swedish_ci"
    t.string "name", limit: 45, collation: "latin1_swedish_ci"
    t.string "phone_num", limit: 20, collation: "latin1_swedish_ci"
    t.string "encrypted_password", default: "", null: false, collation: "latin1_swedish_ci"
    t.string "reset_password_token", collation: "latin1_swedish_ci"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
