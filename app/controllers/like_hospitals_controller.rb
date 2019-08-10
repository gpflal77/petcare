class LikeHospitalsController < ApplicationController
  def list
    String id     = current_user.id
    @hospital = Hospital.find_by_sql("select a.* From hospitals a, like_hospitals b
                                            where a.id = b.hospital_id and b.user_id=2")
    #@hospital = Hospital.find_by(user_id: current_user.id)
  end
  
end
