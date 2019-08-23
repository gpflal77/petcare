class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  #before_action :authenticate_user!
  #protect_from_forgery with: :null_session
  
  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    
      @review = Review.find(params[:id])
    
     ##병원정보가져오기
      @hospital = Hospital.where("id = (select hospital_id from reviews where id ='#{params[:id]}')")
      
     ##반려동물 정보 가져오기 
      @pet      = Pet.where("id = (select pet_id from reviews where id ='#{params[:id]}')")
      
      #치료항목 코드조회
      @medc_code = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='MEDIC'
                                            and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code")
      #병원비항목 코드조회                             
      @cost_code = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='COST'
                                            and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code")
      #치료 세부항목 코드조회                             
      @medic_detail = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='#{@review.medic_code}'
                                            and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code")
     
    # 파일 별도로 가져오므로 파일명 조인 불필요 (has_one_attached로 연계)
    # @review = Review.find_by_sql("select 
    #                                 a.id id,
    #                                 a.hospital_id hospital_id,
    #                                 a.user_id user_id,
    #                                 a.pet_id pet_id,
    #                                 a.title title,
    #                                 a.medic_code medic_code,
    #                                 a.medic_detail medic_detail,
    #                                 a.period period,
    #                                 a.heal_yn heal_yn,
    #                                 a.cost_id cost_id,
    #                                 a.tot_cost tot_cost,
    #                                 a.satis1 satis1,
    #                                 a.satis2 satis2,
    #                                 a.satis3 satis3,
    #                                 a.satis4 satis4,
    #                                 a.avg_satis avg_satis,
    #                                 a.hospital_review hospital_review,
    #                                 a.heal_review heal_review,
    #                                 (select filename from active_storage_blobs where id = b.blob_id) as file, 
    #                                 (select filename from active_storage_blobs where id = c.blob_id) as photo_file,
    #                                 a.created_at created_at,
    #                                 a.updated_at updated_at
    #                                 from  reviews a left outer join active_storage_attachments b
    #                                 on a.id = b.record_id and b.record_type='Review' and b.name='photo_file'
    #                                 left outer join active_storage_attachments c
    #                                 on a.id = c.record_id and c.record_type='Review' and c.name='file'
    #                                 where a.id="+params[:id]);
    # print(">>>>>>>"+@review.size.to_s)
  end

  # GET /reviews/new
  def new
    @review = Review.new
    @review.hospital_id = params[:hospital_id]; # 병원 뷰페이지에서 파라미터로 병원 아이디 받아옴
    
    
    @medc_code = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='MEDIC'
                                            and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code")
    @cost_code = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='COST'
                                            and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code")
                                            
    @pet = Pet.find_by_sql("select * from pets where user_id="+ current_user.id.to_s)
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
    @hospital = Hospital.where("id = (select hospital_id from reviews where id ='#{params[:id]}')")
    @pet      = Pet.where("id = (select pet_id from reviews where id ='#{params[:id]}')")
    @medc_code = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='MEDIC'
                                            and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code")
    @cost_code = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='COST'
                                            and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code")
    @medic_detail = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='#{@review.medic_code}'
                                            and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code")
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.permit( :hospital_id, :user_id, :pet_id, :title, :medic_code, :medic_detail, :birth_date, :period, :heal_yn, :cost_id, :tot_cost, 
                              :satis1, :satis2, :satis3, :satis4, :avg_satis, :hospital_review, :heal_review, :file, :photo_file)
    end
end
