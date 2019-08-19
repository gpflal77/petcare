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
        @search_cost = Hospital.find_by_sql("select   sum(ifnull(tot_cost, 0))/count(*) avg, 
                                                            sum(ifnull(tot_cost,0)) tot_cost, count(*) tot_cnt, 
                                                            sum(if(cost_id ='C01', ifnull(tot_cost,0), 0)) c01,
                                                            sum(if(cost_id ='C01', 1, 0)) c01_cnt,
                                                            (select max(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id
                                                                 where aa.medic_code = a.medic_code and aa.medic_detail = a.medic_detail and bb.kind = b.kind and bb.breed = b.breed and aa.cost_id='C01') max_c01,
                                                            (select min(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id 
                                                            	 where aa.medic_code = a.medic_code and aa.medic_detail = a.medic_detail and bb.kind = b.kind and bb.breed = b.breed and aa.cost_id='C01') min_c01,
                                                            sum(if(cost_id ='C03', ifnull(tot_cost,0), 0)) c03,
                                                            sum(if(cost_id ='C03', 1, 0)) c03_cnt,
                                                            (select max(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id
                                                                 where aa.medic_code = a.medic_code and aa.medic_detail = a.medic_detail and bb.kind = b.kind and bb.breed = b.breed and aa.cost_id='C03') max_c03,
                                                            (select min(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id 
                                                            	 where aa.medic_code = a.medic_code and aa.medic_detail = a.medic_detail and bb.kind = b.kind and bb.breed = b.breed and aa.cost_id='C03') min_c03,
                                                            sum(if(cost_id ='C04', ifnull(tot_cost,0), 0)) c04,
                                                            sum(if(cost_id ='C04', 1, 0)) c04_cnt,
                                                            (select max(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id
                                                                 where aa.medic_code = a.medic_code and aa.medic_detail = a.medic_detail and bb.kind = b.kind and bb.breed = b.breed and aa.cost_id='C04') max_c04,
                                                            (select min(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id 
                                                            	 where aa.medic_code = a.medic_code and aa.medic_detail = a.medic_detail and bb.kind = b.kind and bb.breed = b.breed and aa.cost_id='C04') min_c04,
                                                            sum(if(cost_id ='C05', ifnull(tot_cost,0), 0)) c05,
                                                            sum(if(cost_id ='C05', 1, 0)) c05_cnt,
                                                            (select max(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id
                                                                 where aa.medic_code = a.medic_code and aa.medic_detail = a.medic_detail and bb.kind = b.kind and bb.breed = b.breed and aa.cost_id='C05') max_c05,
                                                            (select min(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id 
                                                            	 where aa.medic_code = a.medic_code and aa.medic_detail = a.medic_detail and bb.kind = b.kind and bb.breed = b.breed and aa.cost_id='C05') min_c05,
                                                            sum(if(cost_id ='C06', ifnull(tot_cost,0), 0)) c06,
                                                            sum(if(cost_id ='C06', 1, 0)) c06_cnt,
                                                            (select max(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id
                                                                 where aa.medic_code = a.medic_code and aa.medic_detail = a.medic_detail and bb.kind = b.kind and bb.breed = b.breed and aa.cost_id='C06') max_c06,
                                                            (select min(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id 
                                                            	 where aa.medic_code = a.medic_code and aa.medic_detail = a.medic_detail and bb.kind = b.kind and bb.breed = b.breed and aa.cost_id='C06') min_c06,
                                                            sum(if(cost_id ='C99', ifnull(tot_cost,0), 0)) c99,
                                                            sum(if(cost_id ='C99', 1, 0)) c99_cnt,
                                                            (select max(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id
                                                                 where aa.medic_code = a.medic_code and aa.medic_detail = a.medic_detail and bb.kind = b.kind and bb.breed = b.breed and aa.cost_id='C99') max_c99,
                                                            (select min(ifnull(tot_cost, 0)) from reviews aa left outer join pets bb on aa.pet_id = bb.id 
                                                            	 where aa.medic_code = a.medic_code and aa.medic_detail = a.medic_detail and bb.kind = b.kind and bb.breed = b.breed and aa.cost_id='C99') min_c99,
                                                             sum(if(ifnull(heal_yn,'n') = 'y', 1, 0)) heal_y,     
                                                             sum(if(ifnull(heal_yn,'n') = 'n', 1, 0)) heal_n ,
                                                             sum(if(ifnull(heal_yn,'n') = 'y', 1, 0)) / count(*) * 100
                                                    from reviews a left outer join pets b
                                                        on a.pet_id = b.id
                                                    where a.medic_code='#{params[:medic_code]}' and medic_detail='#{params[:medic_detail]}' 
                                                      and b.kind='#{params[:kind]}' and b.breed='#{params[:breed]}'");
         respond_to do |format|
         format.json { render json: @search_cost } #routes.rb 에도 json 설정 
         end
    end
    
end
