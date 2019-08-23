class LikeHospitalsController < ApplicationController
  include Pagy::Backend
  def list
   @hospital = Hospital.find_by_sql("select a.* From hospitals a, like_hospitals b where a.id = b.hospital_id and b.user_id="+ current_user.id.to_s)
    #@pagy, @hospital = pagy(, items:2)
  end
  
  def pagy_get_items(array, pagy)
    array[pagy.offset, pagy.items]
  end
end
