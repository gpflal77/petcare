class HospitalsController < ApplicationController
    def list
        #병원항목 코드조회
        @medc_code = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='MEDIC'
                                            and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code")
        #병원 특이사항 코드조회                             
        @attr_code = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='ATTR'
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
       
       
        Selenium::WebDriver::Chrome.driver_path = `which chromedriver-helper`.chomp # Selenium이 크롬으로 동작하도록 선언
        options = Selenium::WebDriver::Chrome::Options.new # Selenium 동작 시 필요한 설정을 위하여
        options.add_argument('--disable-gpu') # 크롬 헤드리스 모드 사용 위해 disable-gpu setting
        options.add_argument('--headless') # 크롬 헤드리스 모드 사용 위해 headless setting
        browser = Selenium::WebDriver.for :chrome, options: options # 위 조건들을 만족하는 셀레니움 객체 생성
        
        #browser.get 'http://m.cafe.daum.net/ASMONACOFC/gAWF?boardType=' # 목표 URL 로드
        browser.get 'https://m.map.naver.com/search2/search.nhn?query=%EB%8F%99%EB%AC%BC%EB%B3%91%EC%9B%90'
        #/html/body/div[4]/div[2]/ul/li[1]/div[1]/a[1]
        #/html/body/div[4]/div[2]/ul/li[3]/div[1]/a[1]
        @content = browser.find_elements(xpath: "/html/body/div[4]/div[2]/ul/li")
        #@content = browser.find_elements(xpath: "/html/body/div[1]/div[1]/article/div[1]/div/ul/li") # 찾고자하는 대상 xpath방식으로 찾기
      
        @size = @content.size
        
       # @entry = Array.new # 데이터를 저장할 배열 선언
        
       
        @content.each do |c| # 찾은 대상 순회 
             name = c.find_element(class: "data-title")
        
            if @hospital.name = name
              @img_url = c.find_element(tag_name: "img").attribute("src")
            end
    
        end 
        
        browser.quit # Selenium 객체 종료

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
        String x           = params[:tm_x]             #x좌표(TM중부원점좌표)
        String y           = params[:tm_y]             #y좌표(TM중부원점좌표)
        String search_txt  = params[:search_txt]       #병원명 검색어
        String hair_yn      = params[:hair_yn]
        String allday_yn    = params[:allday_yn]
        String parking_yn   = params[:parking_yn]
        String emergency_yn = params[:emergency_yn]
        String weekend_yn   = params[:weekend_yn]
    
        
        @hospital_location = Hospital.find_by_sql("select *
                                                   from hospitals  
                                                   where status_cd ='01' 
                                                   and hair_yn like '#{params[:hair_yn]}%'
                                                   and allday_yn like '#{params[:allday_yn]}%'
                                                   and parking_yn like '#{params[:parking_yn]}%'
                                                   and emergency_yn like '#{params[:emergency_yn]}%'
                                                   and weekend_yn like '#{params[:weekend_yn]}%'
                                                   and name like '%#{params[:search_txt]}%'
                                                   order by  abs(#{params[:tm_x]} - loca_x) + abs(#{params[:tm_y]} - loca_y) 
                                                   limit 0, 10;")
         respond_to do |format|
         format.json { render json: @hospital_location } #routes.rb 에도 json 설정 
         end
    end
    
    #리뷰 검색
    def get_nearby_hospital_reviews
        String x           = params[:tm_x]             #x좌표(TM중부원점좌표)
        String y           = params[:tm_y]             #y좌표(TM중부원점좌표)
        String search_txt  = params[:search_txt]       #병원명 검색어
        String medc_code      = params[:medc_code]
        String medc_detail    = params[:medc_detail]
    
        printf(">>>"+ medc_code.to_s);
        @reviews = Review.find_by_sql("select a.*  from reviews a join hospitals b on a.hospital_id = b.id  
                                                   where status_cd ='01' 
                                                   and medic_code  like '#{params[:medc_code]}%'
                                                   and medic_detail  like '#{params[:medc_detail]}%'
                                                   and hair_yn like '#{params[:hair_yn]}%'
                                                   and allday_yn like '#{params[:allday_yn]}%'
                                                   and parking_yn like '#{params[:parking_yn]}%'
                                                   and emergency_yn like '#{params[:emergency_yn]}%'
                                                   and weekend_yn like '#{params[:weekend_yn]}%'
                                                   and name like '%#{params[:search_txt]}%'
                                                   order by  abs(#{params[:tm_x]} - loca_x) + abs(#{params[:tm_y]} - loca_y) 
                                                   limit 0, 10;")
         respond_to do |format|
         format.json { render json: @reviews } #routes.rb 에도 json 설정 
         end
    end
    
     
    #리뷰 평점 검색
    def get_nearby_hospital_satis
        String x           = params[:tm_x]             #x좌표(TM중부원점좌표)
        String y           = params[:tm_y]             #y좌표(TM중부원점좌표)
        String search_txt  = params[:search_txt]       #병원명 검색어
        String medc_code      = params[:medc_code]
        String medc_detail    = params[:medc_detail]
    
        
        @hospital_location = Hospital.find_by_sql("select * from hospitals a join (select hospital_id, sum((ifnull(satis1,0)+ifnull(satis2,0)+ifnull(satis3,0)+ifnull(satis4,0))/4)/count(*) as satis From reviews
                                                    					where medic_code like '#{params[:medc_code]}%'
                                                    					and medic_detail like '#{params[:medc_detail]}%'
                                                    					group by hospital_id) b
                                                                   on a.id = b.hospital_id
                                         where  status_cd ='01' 
                                           and hair_yn like '#{params[:hair_yn]}%'
                                           and allday_yn like '#{params[:allday_yn]}%'
                                           and parking_yn like '#{params[:parking_yn]}%'
                                           and emergency_yn like '#{params[:emergency_yn]}%'
                                           and weekend_yn like '#{params[:weekend_yn]}%'
                                           and name like '%#{params[:search_txt]}%'
                                           order by  abs(#{params[:tm_x]} - loca_x) + abs(#{params[:tm_y]} - loca_y)
                                           limit 0, 10;")
         respond_to do |format|
         format.json { render json: @hospital_location } #routes.rb 에도 json 설정 
         end
    end
    
    
    
    #추천수 검색
    def get_nearby_hospital_like
        String x           = params[:tm_x]             #x좌표(TM중부원점좌표)
        String y           = params[:tm_y]             #y좌표(TM중부원점좌표)
        String search_txt  = params[:search_txt]       #병원명 검색어
        String medc_code      = params[:medc_code]
        String medc_detail    = params[:medc_detail]
    
        
        @reviews = Review.find_by_sql("select b.like_cnt, a.*
                                       from hospitals a join (select hospital_id, count(*) like_cnt from like_hospitals group by hospital_id) b
                                             on a.id = b.hospital_id
                                       where status_cd ='01' 
                                       and medic_code  like '#{params[:medc_code]}%'
                                       and medic_detail  like '#{params[:medc_detail]}%'
                                       and hair_yn like '#{params[:hair_yn]}%'
                                       and allday_yn like '#{params[:allday_yn]}%'
                                       and parking_yn like '#{params[:parking_yn]}%'
                                       and emergency_yn like '#{params[:emergency_yn]}%'
                                       and weekend_yn like '#{params[:weekend_yn]}%'
                                       and name like '%#{params[:search_txt]}%'
                                       order by  abs(#{params[:tm_x]} - loca_x) + abs(#{params[:tm_y]} - loca_y) 
                                       limit 0, 10;")
         respond_to do |format|
         format.json { render json: @reviews } #routes.rb 에도 json 설정 
         end
    end
    
    
    
end
