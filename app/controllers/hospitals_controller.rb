class HospitalsController < ApplicationController
    def list
        @medc_code = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn='MEDIC'
                                            and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code")
    end
    
    def view
    end
    
    def get_code
        String code_gubn = params[:code_gubn]
        @medc_detail = CommCode.find_by_sql("select * From comm_codes
                                            where code_gubn="+code_gubn+
                                            "and DATE_FORMAT(now(), '%Y%m%d') between sta_date and end_date
                                            and ifnull(del_yn, 'N') ='N'
                                            order by code")
    end
end
