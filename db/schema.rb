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

ActiveRecord::Schema.define(version: 2019_08_16_052557) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "comm_codes", primary_key: ["code_gubn", "code", "sta_date"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code_gubn", limit: 10, null: false, comment: "코드구분"
    t.string "code", limit: 20, null: false, comment: "코드"
    t.string "parent_gubn", limit: 10, comment: "상위코드구분"
    t.string "code_name", limit: 60, comment: "코드명"
    t.string "sta_date", limit: 8, null: false, comment: "시작일"
    t.string "end_date", limit: 8, null: false, comment: "종료일"
    t.string "del_yn", limit: 2, default: "N", comment: "삭제여부(Y,N)"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cost", primary_key: "cost_id", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "cost_gubn", limit: 10, comment: "비용구분"
    t.integer "amt", comment: "금액"
  end

  create_table "hospitals", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 100, comment: "병원명"
    t.string "sigu_cd", limit: 10, comment: "시군구코드(병원DATA I/F)"
    t.string "manage_no", limit: 20, comment: "관리번호(병원DATA I/F)"
    t.string "busi_in_date", limit: 8, comment: "인허가일(병원DATA I/F)"
    t.string "status_cd", limit: 2, comment: "상태코드(병원DATA I/F)"
    t.string "status_cd_nm", limit: 45
    t.string "busi_end_date", limit: 8, comment: "폐업일(병원DATA I/F)"
    t.string "tel_no", limit: 30, comment: "전화번호(병원DATA I/F)"
    t.string "jibun_addr", limit: 300, comment: "지번주소(병원DATA I/F)"
    t.string "addr", limit: 300, comment: "도로명주소(병원DATA I/F)"
    t.string "zip_code", limit: 10, comment: "우편번호(병원DATA I/F)"
    t.string "loca_x", limit: 45, comment: "위치좌표x(병원DATA I/F)"
    t.string "loca_y", limit: 45, comment: "위치좌표y(병원DATA I/F)"
    t.string "open_time", limit: 10, comment: "오픈시간"
    t.string "close_time", limit: 10, comment: "종료시간"
    t.string "bigo", limit: 45, comment: "비고"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "test", limit: 45
  end

  create_table "hospitals_raw", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "service_name", limit: 100, comment: "병원명"
    t.string "service_id", limit: 10, comment: "개방서비스ID(병원DATA I/F)"
    t.string "sigu_cd", limit: 10, comment: "시군구코드(병원DATA I/F)"
    t.string "manage_no", limit: 20, comment: "관리번호(병원DATA I/F)"
    t.string "busi_in_date", limit: 8, comment: "인허가일(병원DATA I/F)"
    t.string "busi_out_date", limit: 8, collation: "latin1_swedish_ci"
    t.string "status_cd", limit: 2, comment: "상태코드(병원DATA I/F)"
    t.string "status_cd_nm", limit: 45
    t.string "status_detail_cd", limit: 4, comment: "상태세부코드(병원DATA I/F)"
    t.string "status_detail_cd_nm", limit: 45
    t.string "busi_end_date", limit: 8, comment: "폐업일(병원DATA I/F)"
    t.string "hu_sta_date", limit: 8
    t.string "hu_end_date", limit: 8
    t.string "re_sta_date", limit: 8
    t.string "tel_no", limit: 30, comment: "전화번호(병원DATA I/F)"
    t.integer "space"
    t.string "jibun_zip_code", limit: 10
    t.string "jibun_addr", limit: 300, comment: "지번주소(병원DATA I/F)"
    t.string "addr", limit: 300, comment: "도로명주소(병원DATA I/F)"
    t.string "zip_code", limit: 10, comment: "우편번호(병원DATA I/F)"
    t.string "name", limit: 45
    t.string "update_time", limit: 45, collation: "latin1_swedish_ci"
    t.string "update_gubn", limit: 2, collation: "latin1_swedish_ci"
    t.string "renew_date", limit: 45, comment: "병원DATA I/F 업데이트일"
    t.string "type_gubn", limit: 45, collation: "latin1_swedish_ci"
    t.string "loca_x", limit: 45, comment: "위치좌표x(병원DATA I/F)"
    t.string "loca_y", limit: 45, comment: "위치좌표y(병원DATA I/F)"
    t.string "gubn_1", limit: 45, comment: "비고"
    t.string "gubn_2", limit: 10, comment: "삭제여부"
    t.string "gubn_3", limit: 45, collation: "latin1_swedish_ci", comment: "삭제일"
    t.string "gubn_4", limit: 45, collation: "latin1_swedish_ci"
    t.integer "emp_cnt"
    t.datetime "updated_at"
    t.datetime "created_at"
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
    t.string "cost_id", limit: 20, comment: "비용ID"
    t.integer "tot_cost", comment: "전체비용"
    t.integer "satis1", comment: "만족도(친절도)"
    t.integer "satis2", comment: "만족도(진료만족도)"
    t.integer "satis3", comment: "만족도(가격)"
    t.integer "satis4", comment: "만족도(시설)"
    t.string "avg_satis", limit: 45, comment: "평균만족도"
    t.text "hospital_review", comment: "병원후기"
    t.text "heal_review", comment: "치료후기"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end
