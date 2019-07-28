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

ActiveRecord::Schema.define(version: 2019_07_27_141244) do

  create_table "comm_code", primary_key: ["code_gubn", "code", "sta_date"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code_gubn", limit: 10, null: false, comment: "코드구분"
    t.string "code", limit: 20, null: false, comment: "코드"
    t.string "code_name", limit: 60, comment: "코드명"
    t.string "sta_date", limit: 8, null: false, comment: "시작일"
    t.string "end_date", limit: 8, null: false, comment: "종료일"
    t.string "del_yn", limit: 2, default: "N", comment: "삭제여부(Y,N)"
    t.date "reg_date"
    t.string "reg_id", limit: 45
    t.date "modi_date"
    t.string "modi_id", limit: 45
  end

  create_table "cost", primary_key: "cost_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "cost_gubn", limit: 10, comment: "비용구분"
    t.integer "amt", comment: "금액"
  end

  create_table "hospitals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
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

  create_table "like_hospitals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "hospital_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", comment: "사용자아이디"
    t.string "name", limit: 45, comment: "펫이름"
    t.string "kind", limit: 45, comment: "종류"
    t.string "breed", limit: 45, comment: "품종"
    t.string "gender", limit: 2, comment: "성별"
    t.string "birth_date", limit: 8, comment: "생년월일"
    t.integer "age", comment: "나이"
    t.integer "weight", comment: "몸무게"
    t.string "photo_file", limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "hospital_id", comment: "병원ID"
    t.bigint "user_id", comment: "사용자ID"
    t.bigint "pet_id", comment: "반려동물id"
    t.string "title", limit: 45, comment: "제목"
    t.string "medic_code", limit: 20, comment: "질병코드"
    t.string "medic_detail", limit: 20, comment: "질병코드상세"
    t.integer "period", comment: "치료기간"
    t.string "heal_yn", limit: 2, comment: "완치여부(Y/N)"
    t.integer "cost_id", comment: "비용ID"
    t.integer "tot_cost", comment: "전체비용"
    t.integer "satis1", comment: "만족도(친절도)"
    t.integer "satis2", comment: "만족도(진료만족도)"
    t.integer "satis3", comment: "만족도(가격)"
    t.integer "satis4", comment: "만족도(시설)"
    t.string "avg_satis", limit: 45, comment: "평균만족도"
    t.text "hospital_review", comment: "병원후기"
    t.text "heal_review", comment: "치료후기"
    t.string "file", limit: 30, comment: "영수증파일ID"
    t.string "photo_file", limit: 30, comment: "사진파일ID"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", limit: 45
    t.string "phone_num", limit: 20
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
