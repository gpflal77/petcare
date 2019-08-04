class ApplicationController < ActionController::Base
     
    ####공통코드 가져오기 code_gubn에 값 셋팅 후 호출#####
    def get_code 
        String code_gubn     = params[:code_gubn]        #검색할 code_gubn 명
        String redirect_path = params[:redirect_path]    #path
        @code =     CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='"+code_gubn+
                                            "' and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code")
        respond_to do |format|
      #  format.js   { render json: @code }
      #  format.html { redirect_to hospitals_list_path}
      #  format.xml  { render xml: @code }
         format.json { render json: @code } #routes.rb 에도 json 설정 
        end
    end
end
