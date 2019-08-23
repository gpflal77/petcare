class DiseasesController < ApplicationController
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
        @pet = Pet.find_by_sql("select * from pets where user_id="+ current_user.id.to_s)
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
    
    # 질병검색
    def get_search_cost
        String medic_code             = params[:medic_code]       # 
        String medic_detail           = params[:medic_detail]     #
        String kind                   = params[:kind]             #
        String breed                  = params[:breed]            #
        String search_txt             = params[:search_txt]       #질병명 검색어
        @search_cost = Cost.find_by_sql("select   sum(ifnull(tot_cost, 0))/count(*) avg, 
                                                            sum(ifnull(tot_cost,0)) tot_cost, count(*) tot_cnt, 
                                                            sum(if(cost_id ='C01', ifnull(tot_cost,0), 0)) c01,
                                                            sum(if(cost_id ='C01', 1, 0)) c01_cnt,
                                                            (select max(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id
                                                                 where aa.medic_code like '#{params[:medic_code]}%' and aa.medic_detail like '#{params[:medic_detail]}%' and bb.kind like '#{params[:kind]}%' and bb.breed like '#{params[:breed]}%' and aa.cost_id='C01') max_c01,
                                                            (select min(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id 
                                                            	 where aa.medic_code like '#{params[:medic_code]}%' and aa.medic_detail like '#{params[:medic_detail]}%' and bb.kind like '#{params[:kind]}%' and bb.breed like '#{params[:breed]}%' and aa.cost_id='C01') min_c01,
                                                            sum(if(cost_id ='C03', ifnull(tot_cost,0), 0)) c03,
                                                            sum(if(cost_id ='C03', 1, 0)) c03_cnt,
                                                            (select max(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id
                                                                 where aa.medic_code like '#{params[:medic_code]}%' and aa.medic_detail like '#{params[:medic_detail]}%' and bb.kind like '#{params[:kind]}%' and bb.breed like '#{params[:breed]}%' and aa.cost_id='C03') max_c03,
                                                            (select min(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id 
                                                            	 where aa.medic_code like '#{params[:medic_code]}%' and aa.medic_detail like '#{params[:medic_detail]}%' and bb.kind like '#{params[:kind]}%' and bb.breed like '#{params[:breed]}%' and aa.cost_id='C03') min_c03,
                                                            sum(if(cost_id ='C04', ifnull(tot_cost,0), 0)) c04,
                                                            sum(if(cost_id ='C04', 1, 0)) c04_cnt,
                                                            (select max(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id
                                                                 where aa.medic_code like '#{params[:medic_code]}%' and aa.medic_detail like '#{params[:medic_detail]}%' and bb.kind like '#{params[:kind]}%' and bb.breed like '#{params[:breed]}%' and aa.cost_id='C04') max_c04,
                                                            (select min(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id 
                                                            	 where aa.medic_code like '#{params[:medic_code]}%' and aa.medic_detail like '#{params[:medic_detail]}%' and bb.kind like '#{params[:kind]}%' and bb.breed like '#{params[:breed]}%' and aa.cost_id='C04') min_c04,
                                                            sum(if(cost_id ='C05', ifnull(tot_cost,0), 0)) c05,
                                                            sum(if(cost_id ='C05', 1, 0)) c05_cnt,
                                                            (select max(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id
                                                                 where aa.medic_code like '#{params[:medic_code]}%' and aa.medic_detail like '#{params[:medic_detail]}%' and bb.kind like '#{params[:kind]}%' and bb.breed like '#{params[:breed]}%' and aa.cost_id='C05') max_c05,
                                                            (select min(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id 
                                                            	 where aa.medic_code like '#{params[:medic_code]}%' and aa.medic_detail like '#{params[:medic_detail]}%' and bb.kind like '#{params[:kind]}%' and bb.breed like '#{params[:breed]}%' and aa.cost_id='C05') min_c05,
                                                            sum(if(cost_id ='C06', ifnull(tot_cost,0), 0)) c06,
                                                            sum(if(cost_id ='C06', 1, 0)) c06_cnt,
                                                            (select max(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id
                                                                 where aa.medic_code like '#{params[:medic_code]}%' and aa.medic_detail like '#{params[:medic_detail]}%' and bb.kind like '#{params[:kind]}%' and bb.breed like '#{params[:breed]}%' and aa.cost_id='C06') max_c06,
                                                            (select min(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id 
                                                            	 where aa.medic_code like '#{params[:medic_code]}%' and aa.medic_detail like '#{params[:medic_detail]}%' and bb.kind like '#{params[:kind]}%' and bb.breed like '#{params[:breed]}%' and aa.cost_id='C06') min_c06,
                                                            sum(if(cost_id ='C99', ifnull(tot_cost,0), 0)) c99,
                                                            sum(if(cost_id ='C99', 1, 0)) c99_cnt,
                                                            (select max(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id
                                                                 where aa.medic_code like '#{params[:medic_code]}%' and aa.medic_detail like '#{params[:medic_detail]}%' and bb.kind like '#{params[:kind]}%' and bb.breed like '#{params[:breed]}%' and aa.cost_id='C99') max_c99,
                                                            (select min(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id 
                                                            	 where aa.medic_code like '#{params[:medic_code]}%' and aa.medic_detail like '#{params[:medic_detail]}%' and bb.kind like '#{params[:kind]}%' and bb.breed like '#{params[:breed]}%' and aa.cost_id='C99') min_c99,
                                                             sum(if(ifnull(heal_yn,'n') = 'y', 1, 0)) heal_y,     
                                                             sum(if(ifnull(heal_yn,'n') = 'n', 1, 0)) heal_n ,
                                                             sum(if(ifnull(heal_yn,'n') = 'y', 1, 0)) / count(*) * 100 heal_state
                                                    from reviews a left outer join pets b
                                                        on a.pet_id = b.id
                                                    where a.medic_code like'#{params[:medic_code]}%' and medic_detail like'#{params[:medic_detail]}%' 
                                                      and b.kind like'#{params[:kind]}%' and b.breed like'#{params[:breed]}%'");
         respond_to do |format|
         format.json { render json: @search_cost } #routes.rb 에도 json 설정 
         end
    end
    
    #병원추천 (리뷰순)
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
    
    #리뷰 검색(최신순)
    def get_medic_reviews
      # String x           = params[:tm_x]             #x좌표(TM중부원점좌표)
      #  String y           = params[:tm_y]             #y좌표(TM중부원점좌표)
        String search_txt  = params[:search_txt]       #병원명 검색어
        String medc_code      = params[:medc_code]
        String medc_detail    = params[:medc_detail]
    
        printf(">>>"+ medc_code.to_s);
        @reviews = Review.find_by_sql("select a.*  from reviews
                                                   where status_cd ='01' 
                                                   and medic_code  like '#{params[:medc_code]}%'
                                                   and medic_detail  like '#{params[:medc_detail]}%'
                                                   limit 0, 10;")
         respond_to do |format|
         format.json { render json: @reviews } #routes.rb 에도 json 설정 
         end
    end
    
       
    # 병원 평점 검색
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
end
