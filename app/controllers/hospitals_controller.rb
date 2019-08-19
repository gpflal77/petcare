class HospitalsController < ApplicationController
    def list
        #병원항목 코드조회
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
    end
    
    
    def view
       # @hospital = Hospital.find_by(hospital_id: params[:hospital_id]) 
       @hospital = Hospital.find(params[:hospital_id]) 
       @reviews = Review.where(hospital_id: params[:hospital_id]) 
       @pets = Pet.all
       @commcodes = CommCode.all
       
    end
    
    def like
  
    	#like = Like_Hospital.find_by(hospital_id: params[:hospital_id], user_id: current_user.id)
    	like = LikeHospital.find_by(hospital_id: params[:hospital_id], user_id: current_user.id)
    	if like.present?
    		like.destroy
    	else
    	#	Like_Hospital.create(hospital_id: params[:hospital_id], user_id: current_user.id)
    	LikeHospital.create(hospital_id: params[:hospital_id], user_id: current_user.id)
    	end
    	redirect_back(fallback_location: root_path)

    end
    
    # 병원검색
    def get_nearby_hospital
        String x           = params[:tm_x]        #x좌표(TM중부원점좌표)
        String y           = params[:tm_y]        #y좌표(TM중부원점좌표)
        String search_txt  = params[:search_txt]       #병원명 검색어
        @hospital_location = Hospital.find_by_sql("select *
                                                   from hospitals  
                                                   where status_cd ='01' 
                                                   order by  abs(#{params[:tm_x]} - loca_x) + abs(#{params[:tm_y]} - loca_y) 
                                                   limit 0, 5;")
         respond_to do |format|
         format.json { render json: @hospital_location } #routes.rb 에도 json 설정 
         end
    end
    
end
