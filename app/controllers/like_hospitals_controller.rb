class LikeHospitalsController < ApplicationController
  def list

    @hospital = Hospital.find_by_sql("select a.* From hospitals a, like_hospitals b
                                            where a.id = b.hospital_id and b.user_id="+ current_user.id.to_s)
    #@hospital = Hospital.find_by(user_id: current_user.id)
  end
  
end
